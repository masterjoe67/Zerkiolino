
#include "video.h"
#include "sdcard.h"
#include "zerkiolino_alu.h"
#include "uart_t80.h"

typedef struct {
    int16_t x, y, z;
} Point3D;

typedef struct {
    uint8_t x, y;
} Point2D;

const Point3D cube_vertices[8] = {
    {-32, -32,  32}, {32, -32,  32}, {32,  32,  32}, {-32,  32,  32},
    {-32, -32, -32}, {32, -32, -32}, {32,  32, -32}, {-32,  32, -32}
};

const uint8_t edges[12][2] = {
    {0,1}, {1,2}, {2,3}, {3,0}, // Faccia frontale
    {4,5}, {5,6}, {6,7}, {7,4}, // Faccia posteriore
    {0,4}, {1,5}, {2,6}, {3,7}  // Collegamenti
};

// Tabella del seno in Q8.8 (0 a 255 rappresentano 0-360 gradi)
const int16_t sin_lut[256] = {
    0, 6, 13, 19, 25, 31, 38, 44, 50, 56, 62, 68, 74, 80, 86, 92, 98, 103, 109, 115, 120, 126, 131, 136, 142, 147, 152, 157, 162, 167, 171, 176, 180, 185, 189, 193, 197, 201, 205, 208, 212, 215, 219, 222, 225, 228, 231, 233, 236, 238, 240, 242, 244, 246, 247, 249, 250, 251, 252, 253, 254, 254, 255, 255, 256, 255, 255, 254, 254, 253, 252, 251, 250, 249, 247, 246, 244, 242, 240, 238, 236, 233, 231, 228, 225, 222, 219, 215, 212, 208, 205, 201, 197, 193, 189, 185, 180, 176, 171, 167, 162, 157, 152, 147, 142, 136, 131, 126, 120, 115, 109, 103, 98, 92, 86, 80, 74, 68, 62, 56, 50, 44, 38, 31, 25, 19, 13, 6, 0, -6, -13, -19, -25, -31, -38, -44, -50, -56, -62, -68, -74, -80, -86, -92, -98, -103, -109, -115, -120, -126, -131, -136, -142, -147, -152, -157, -162, -167, -171, -176, -180, -185, -189, -193, -197, -201, -205, -208, -212, -215, -219, -222, -225, -228, -231, -233, -236, -238, -240, -242, -244, -246, -247, -249, -250, -251, -252, -253, -254, -254, -255, -255, -256, -255, -255, -254, -254, -253, -252, -251, -250, -249, -247, -246, -244, -242, -240, -238, -236, -233, -231, -228, -225, -222, -219, -215, -212, -208, -205, -201, -197, -193, -189, -185, -180, -176, -171, -167, -162, -157, -152, -147, -142, -136, -131, -126, -120, -115, -109, -103, -98, -92, -86, -80, -74, -68, -62, -56, -50, -44, -38, -31, -25, -19, -13, -6
};

// Funzioni per l'accesso veloce alla LUT
int16_t get_sin(uint8_t a) { return sin_lut[a]; }
int16_t get_cos(uint8_t a) { return sin_lut[(uint8_t)(a + 64)]; }


// Array per salvare le coordinate proiettate del frame precedente
Point2D old_projected[8];
uint8_t first_frame = 1;

void update_cube(uint8_t angle_x, uint8_t angle_y) {
    Point2D new_projected[8];
    
    // USA GLI ARGOMENTI QUI!
    int16_t s_x = get_sin(angle_x);
    int16_t c_x = get_cos(angle_x);
    int16_t s_y = get_sin(angle_y);
    int16_t c_y = get_cos(angle_y);

    for(uint8_t i = 0; i < 8; i++) {
        // Rotazione sull'asse X
        int16_t y_rot = (cube_vertices[i].y * c_x - cube_vertices[i].z * s_x) >> 8;
        int16_t z_tmp = (cube_vertices[i].y * s_x + cube_vertices[i].z * c_x) >> 8;
        
        // Rotazione sull'asse Y
        int16_t x_rot = (cube_vertices[i].x * c_y + z_tmp * s_y) >> 8;
        int16_t z_rot = (-cube_vertices[i].x * s_y + z_tmp * c_y) >> 8;

        // Proiezione (con Z offset per non finire "dentro" lo schermo)
        z_rot += 128; 
        new_projected[i].x = 80 + (x_rot * 64 / z_rot);
        new_projected[i].y = 60 + (y_rot * 64 / z_rot);
    }
    // --- 2. CANCELLAZIONE (Solo se non è il primo frame) ---
    if (!first_frame) {
        for(uint8_t i=0; i<12; i++) {
            vga_drawLine(
                old_projected[edges[i][0]].x, old_projected[edges[i][0]].y,
                old_projected[edges[i][1]].x, old_projected[edges[i][1]].y,
                BLACK // COLORE NERO (Cancella)
            );
        }
    }

    // --- 3. DISEGNO NUOVO CUBE ---
    for(uint8_t i=0; i<12; i++) {
        vga_drawLine(
            new_projected[edges[i][0]].x, new_projected[edges[i][0]].y,
            new_projected[edges[i][1]].x, new_projected[edges[i][1]].y,
            WHITE // COLORE BIANCO (Disegna)
        );
    }

    // --- 4. MEMORIZZAZIONE ---
    for(uint8_t i=0; i<8; i++) {
        old_projected[i] = new_projected[i];
    }
    first_frame = 0;
}

// Buffer locale nell'AVR (512 byte, uno degli 8KB della tua BRAM)
uint8_t sector_buffer[512];

void test_sd_card(void) {
    // 1. Aspetta che l'hardware finisca l'inizializzazione (CMD0, CMD8, ACMD41...)
    vga_set_cursor(20, 10);
    vga_Print("Inizializzazione SD in corso...\n");
    
    if (!sd_wait_ready()) {
        vga_Print("ERRORE: SD non risponde o timeout!\n");
        vga_print_int(SDSTATUS); // Stampa lo stato per debug
        vga_Print("\n");
        return;
    }
    vga_Print("SD Pronta!\n");
vga_setTextColor(BLUE, 0x0000);
    vga_Print("Invio comando...\n");


// Debug: stampa lo stato subito dopo il comando
uint8_t s = SDSTATUS;
vga_Print("Stato post-comando: ");
vga_print_hex8(s);

    // 2. Leggiamo il settore 0 (MBR)
    vga_Print("Lettura settore 0...\n");
    if (sd_read_sector(3600, sector_buffer)) {
        vga_Print("Settore letto con successo. Primi 16 byte:\n");
        
        for (int i = 0; i < 16; i++) {
            //printf("%02X ", sector_buffer[i]);
            uint8_t byte = sector_buffer[i];
            vga_print_hex8(byte);
            vga_Print(", ");
        }
        vga_Print("\n");
    } else {
        vga_Print("ERRORE durante la lettura!\n");
        return;
    }

    // 3. Modifichiamo un byte (esempio: firma di test)
    sector_buffer[0] = 0xD1;
    sector_buffer[1] = 0x0C;
    sector_buffer[2] = 0xA7;
    sector_buffer[3] = 0xE0;
    sector_buffer[4] = 0x10;
    sector_buffer[5] = 0x20;
    sector_buffer[6] = 0x40;
    sector_buffer[7] = 0x80;
    sector_buffer[8] = 0xFF;

    // 4. Scriviamo il settore modificato su un blocco di test (es. blocco 100)
    // ATTENZIONE: Non sovrascrivere il settore 0 se hai dati veri!
    vga_Print("Scrittura settore 100 per test...\n");
    if (sd_write_sector(100, sector_buffer)) {
        vga_Print("Scrittura completata!\n");
    } else {
        vga_Print("ERRORE durante la scrittura!\n");
    }
}

// Parametri del frattale
#define MAX_ITER 32
#define WIDTH  320
#define HEIGHT 240
#define F_SHIFT 12
#define TO_FIX(x) ((int16_t)((x) * 4096.0f))

void draw_mandelbrot() {
    vga_clear_screen(BLACK);

    // Costanti in Q16.16
    const int32_t FP_4 = 262144; // 4.0 << 16

    int32_t min_re = -131072; // -2.0 << 16
    int32_t max_re = 65536;   //  1.0 << 16
    int32_t min_im = -78643;  // -1.2 << 16
    int32_t max_im = 78643;   //  1.2 << 16

    // Calcolo step con ALU hardware
    int32_t re_step = alu_div(alu_sub(max_re, min_re), WIDTH);
    int32_t im_step = alu_div(alu_sub(max_im, min_im), HEIGHT);

    int32_t ci = min_im;
    for (uint16_t y = 0; y < HEIGHT; y++) {
        int32_t cr = min_re;
        for (uint16_t x = 0; x < WIDTH; x++) {
            int32_t zr = 0;
            int32_t zi = 0;
            uint16_t iter = 0;

            while (iter < 32) {
                // Calcoliamo zr^2 e zi^2 in Q16.16 usando il moltiplicatore hardware
                int32_t zr2 = alu_mul_fp(zr, zr);
                int32_t zi2 = alu_mul_fp(zi, zi);

                // Escape check: zr^2 + zi^2 > 4.0
                if (alu_add(zr2, zi2) > FP_4) break;

                // Calcolo zi = 2*zr*zi + ci
                // Usiamo alu_shl per fare il *2 in hardware (veloce e sicuro)
                // zrzi = (zr * zi) >> 16
                int32_t zrzi = alu_mul_fp(zr, zi);
                // zi = (zrzi << 1) + ci
                zi = alu_add(alu_shl(zrzi, 1), ci);
                
                // Calcolo zr = zr^2 - zi^2 + cr
                zr = alu_add(alu_sub(zr2, zi2), cr);
                
                iter++;
            }

            // Disegno solo se il punto è "scappato" (iter < MAX)
            if (iter < 32) {
                // Cambia i colori per vedere meglio le fasce di iterazione
                uint8_t color = (iter < 8) ? BLUE : (iter < 16) ? CYAN : YELLOW;
                vga_pixel_fast(x, y, color);
            }
            
            cr = alu_add(cr, re_step);
        }
        ci = alu_add(ci, im_step);
    }
}

void run_vga_terminal(void) {
    char c;

    // Messaggio di benvenuto sulla UART per conferma
    uart_puts("Terminale VGA Attivo. Digita sul PC...\r\n");
    vga_set_cursor(0, 10);
    while(1) {
        // Se arriva un carattere dal PC (UART)
        if (uart_available()) {
            c = uart_getc();
            
            // 1. Lo spedisci alla VGA
            // La vga_Print gestirà internamente \n, \r e wrap
            vga_write(c);
            
            // 2. Eco locale opzionale (rimanda al PC quello che hai ricevuto)
            // Utile per vedere cosa stai scrivendo nel terminale del PC
            uart_putc(c); 
            
            // 3. Gestione speciale (opzionale)
            // Se vuoi che il tasto 'Esc' pulisca la VGA, puoi aggiungere un controllo qui
            if (c == 27) { // Codice ASCII per ESC
                // vga_ClearScreen(); // Se hai una funzione CLS
            }
        }
        
        // --- Qui puoi aggiungere altre task del DSO ---
        // Ad esempio: aggiorna i buffer dei campioni o controlla i tasti fisici
    }
}

int main(void) {
    uint8_t ang_x = 0;
    uint8_t ang_y = 0;
    video_config(0, 1);

    uart_init(B_115200_80MHZ);
    uart_puts("Zoe UART System Ready...\r\n");
    uart_puts("T80 Soft-Core Online.\r\n");

    vga_clear_screen(BLACK); // Nero

    vga_setTextFont(2);
    vga_setTextSize(1);
    vga_setTextColor(YELLOW, 0x0000);

    vga_set_cursor(0, 10);


    vga_set_display_page(0);
    vga_set_work_page(0);
    vga_load_rgb333_full(1000);
    vga_set_work_page(1);
    vga_clear_screen(RED); // Nero
    vga_load_rgb333_full(3400);
    vga_set_display_page(1);

//test_sd_card();


for(volatile int i=0; i<10000; i++);
vga_clear_screen(BLACK); // Nero

vga_Print("VGA Terminal Test:\n");
run_vga_terminal();

    while (1)
    {
        /* code */
    }
    


    

    
}