#include "sdcard.h"
#include "video.h"

// Aspetta che la SD finisca la fase di boot o l'operazione corrente
uint8_t sd_wait_ready(void) {
    uint32_t timeout = 0;
    const uint32_t MAX_TIMEOUT = 1000000; 

    // Aspettiamo che i bit 4 (Init) e 5 (Block Busy) siano a 0
    // e che il bit 7 (TX Empty) sia a 1.
    // Stato ideale: 0x80 (1000 0000)
    while ((SDSTATUS & (SD_STAT_BLK_BUSY | SD_STAT_INI_BUSY)) != 0) {
   // while ((SDSTATUS & 0xB0) != 0x80) {
        if (++timeout > MAX_TIMEOUT) return 0;
    }
    return 1;
}



uint8_t sd_write_sector2(uint32_t lba, const uint8_t *buf) {
    if (!sd_wait_ready()) return 0;

    // Carica l'indirizzo completo a 32 bit (tutti e 4 i registri!)
    SDLBA0 = (uint8_t)(lba & 0xFF);
    SDLBA1 = (uint8_t)((lba >> 8) & 0xFF);
    SDLBA2 = (uint8_t)((lba >> 16) & 0xFF);
    SDLBA3 = (uint8_t)((lba >> 24) & 0xFF);

    SDCONTROL = SD_CMD_WRITE_BLOCK; // Comando WRITE (0x01)

    for (uint16_t i = 0; i < 512; i++) {
        // Aspetta che il buffer di trasmissione sia vuoto (bit 7)
        while (!(SDSTATUS & SD_STAT_TX_EMPTY));
        SDDATA = buf[i];
    }
    
    return sd_wait_ready(); // Aspetta la scrittura fisica dei CRC su disco
}

uint8_t sd_write_sector(uint32_t lba, const uint8_t *buf) {
    if (!sd_wait_ready()) return 0;

    // 1. Carica l'indirizzo
    SDLBA0 = (uint8_t)(lba & 0xFF);
    SDLBA1 = (uint8_t)((lba >> 8) & 0xFF);
    SDLBA2 = (uint8_t)((lba >> 16) & 0xFF);
    SDLBA3 = (uint8_t)((lba >> 24) & 0xFF);

    // 2. Avvia la procedura di scrittura
    SDCONTROL = SD_CMD_WRITE_BLOCK; 

    // 3. CRITICO: Aspetta che la FSM dichiari "BUSY" (bit 5)
    // Questo garantisce che la FSM sia uscita da IDLE e abbia digerito il comando
    while (!(SDSTATUS & 0x20)); 

    // 4. Ora spara i 512 byte
    for (uint16_t i = 0; i < 512; i++) {
        // Aspetta che il byte precedente sia stato trasmesso
        while (!(SDSTATUS & SD_STAT_TX_EMPTY)); 
        SDDATA = buf[i];
    }
    
    // 5. Aspetta che la FSM torni in IDLE (fine scrittura fisica)
    return sd_wait_ready(); 
}

/**
 * Legge un settore (512 byte) dalla SD Card.
 * Allineata al controller VHDL a 3 registri LBA (24-bit block address).
 */
/*uint8_t sd_read_sector(uint32_t sector, uint8_t *buf) {
    // 1. Attesa che il controller sia libero (Init Busy o Block Busy)
    // Bit 4: Init Busy, Bit 5: Block Busy
    uint32_t ready_timeout = 0;
    while (SDSTATUS & 0x30) {
        if (++ready_timeout > 1000000) return 0; // Controller bloccato
    }

    // 2. Carica l'indirizzo (Solo 3 registri come da VHDL)
    // Nota: Il VHDL gestisce internamente la differenza tra SDSC (byte address)
    // e SDHC (block address) basandosi sul bit CCS rilevato all'init.
    SDLBA0 = (sector & 0xFF);
    SDLBA1 = (sector >> 8) & 0xFF;
    SDLBA2 = (sector >> 16) & 0xFF;
    SDLBA3 = (sector >> 24) & 0xFF;

    // 3. Avvia il comando di lettura (Write 0x00 to SDCONTROL)
    SDCONTROL = 0x00; 

    // 4. ATTESA CRUCIALE: Aspetta che block_busy (bit 5) vada a 1 e poi torni a 0
    // Oppure aspetta che il bit 6 (Data Ready) si attivi per il primo byte
    uint32_t timeout = 1000000;
    while (!(SDSTATUS & 0x40)) { // Aspetta RX_READY (Bit 6)
        if (--timeout == 0) return 0; // Fallito per timeout
    }

    // 4. Ciclo di lettura dei 512 byte
    for (uint16_t i = 0; i < 512; i++) {
        uint32_t t = 0;
        
        /**
         * HANDSHAKE DEI FLAG:
         * Il VHDL alza il bit 6 (RX_READY) quando sd_read_flag != host_read_flag.
         * Leggere SDDATA inverte host_read_flag, riportando il bit 6 a '0'.
         */
        /*while (!(SDSTATUS & 0x40)) { // Aspetta Bit 6: Read Data Available
            if (++t > 2000000) { // Timeout generoso per SD lente
                vga_Print("TIMEOUT Byte "); 
                vga_print_int(i);
                vga_Print(" Stato: ");
                vga_print_hex8(SDSTATUS);
                vga_Print("\n");
                return 0;
            }
        }
        
        // La lettura del registro SDDATA causa il toggle del flag nel controller
        buf[i] = SDDATA; 
    }

    return 1; // Lettura completata con successo
}*/



uint8_t sd_read_sector(uint32_t sector, uint8_t *buffer) {
    // 1. Imposta l'indirizzo (4 registri)
    SDLBA0 = (sector & 0xFF);
    SDLBA1 = (sector >> 8) & 0xFF;
    SDLBA2 = (sector >> 16) & 0xFF;
    SDLBA3 = (sector >> 24) & 0xFF;

    // 2. Lancia il comando
    SDCONTROL = 0x00;

    // 3. ATTESA CRUCIALE: Aspetta che block_busy (bit 5) vada a 1 e poi torni a 0
    // Oppure aspetta che il bit 6 (Data Ready) si attivi per il primo byte
    uint32_t timeout = 1000000;
    while (!(SDSTATUS & 0x40)) { // Aspetta RX_READY (Bit 6)
        if (--timeout == 0) return 0; // Fallito per timeout
    }

    // 4. Leggi i 512 byte
    for (int i = 0; i < 512; i++) {
        while (!(SDSTATUS & 0x40)); // Aspetta che ogni singolo byte sia pronto
        buffer[i] = SDDATA;
    }
    return 1;
}


void vga_load_rgb333_full(uint32_t start_lba) {
    uint8_t buffer[512];
    uint32_t current_lba = start_lba;
    uint16_t x = 0;
    uint16_t y = 0;

    // Per 640x480 a 2 byte/pixel servono 1200 settori
    for (uint16_t s = 0; s < 1200; s++) {
        if (!sd_read_sector(current_lba, buffer)) {
            // Se fallisce la lettura, interrompiamo per non disegnare spazzatura
            break; 
        }

        // Ogni settore da 512 byte contiene esattamente 256 pixel
        for (uint16_t i = 0; i < 512; i += 2) {
            
            uint8_t byte_alto = buffer[i+1];
            uint8_t byte_basso = buffer[i];

            // Se hai usato '>H' in Python, il colore si ricompone così:
            uint16_t color = ((uint16_t)byte_alto << 8) | byte_basso;
            vga_pixel_fast(x, y, color);

            // Incremento coordinate
            x++;
            if (x >= 640) {
                x = 0;
                y++;
            }
        }
        
        current_lba++; // Prossimo settore
    }
}
/*static uint8_t buffer[512];
void vga_load_rgb333_full(uint32_t start_lba) {

    uint32_t current_lba = start_lba;
    uint16_t x = 0, y = 0;

    // Per 640x480 servono circa 1200 settori (640*480*2 / 512)
    for (uint16_t s = 0; s < 1200; s++) {
        if (!sd_read_sector(current_lba, buffer)) {
            vga_Print("Errore lettura settore!\n");
            break; 
        }

        for (uint16_t i = 0; i < 512; i += 2) {
            // Ricomposizione Big-Endian (se salvati come >H in Python)
            uint16_t color = ((uint16_t)buffer[i] << 8) | buffer[i+1];
            
            vga_pixel_fast(x, y, color);

            if (++x >= 640) {
                x = 0;
                if (++y >= 480) break;
            }
        }
        current_lba++;
    }
}*/