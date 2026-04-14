

#ifndef VIDEO_H
#define VIDEO_H

#include <stdint.h>
#include <stddef.h>
#include "glcdfont.h"



// Le maschere restano identiche, il C non cambia
#define VIDEO_STORE_BIT    (1 << 0) 
#define VIDEO_ENABLE_BIT   (1 << 1) 
#define VIDEO_SCANLINE_OFF (1 << 2)

/* --- DEFINIZIONI INDIRIZZI REGISTRI (Nuova Mappatura Arbitro) --- */
// Nota: Uso uint8_t che è lo standard per SDCC (incluso in <stdint.h>)

#define VIDEO_REG_X_L      (*(volatile uint8_t *)(0xC000))
#define VIDEO_REG_X_H      (*(volatile uint8_t *)(0xC001))
#define VIDEO_REG_Y_L      (*(volatile uint8_t *)(0xC002))
#define VIDEO_REG_Y_H      (*(volatile uint8_t *)(0xC003))
#define VIDEO_REG_DATA_L   (*(volatile uint8_t *)(0xC004))
#define VIDEO_REG_DATA_H   (*(volatile uint8_t *)(0xC005))

/* --- REGISTRI DI CONTROLLO E STATO (Mappati in Memoria) --- */
#define VGA_REG_CTRL    (*(volatile uint8_t *)(0xC006)) // Era 0x18 IO
#define VGA_REG_STAT    (*(volatile uint8_t *)(0xC005)) // Era 0x08 IO

// Colori Base
// Formato binario: 0000000 RRRG GGBB B
// Colori Base (Intensità massima)
#define BLACK    0x0000
#define RED      0x0007  // Invertito: ora usa i bit 2-0 (000 000 111)
#define GREEN    0x0038  // Invariato: usa i bit 5-3 (000 111 000)
#define BLUE     0x01C0  // Invertito: ora usa i bit 8-6 (111 000 000)

// Colori Composti (DSO Style)
#define YELLOW   0x003F  // RED + GREEN (000 111 111)
#define CYAN     0x01F8  // GREEN + BLUE (111 111 000)
#define MAGENTA  0x01C7  // RED + BLUE   (111 000 111)
#define WHITE    0x01FF  // Tutto acceso (111 111 111)

// Colori Tenui (Grigio medio: 010 010 010 -> resta 0x0092 perché simmetrico)
#define GREY     0x0092  
#define DARKGREY 0x0049  // (001 001 001 -> resta 0x0049 perché simmetrico)

#define LOAD_FONT2
#define LOAD_GLCD

typedef struct {
    int16_t x;
    int16_t y;
} Point_t;

/* --- ROUTINE BASE --- */


/**
 * Configura la modalità di visualizzazione
 */
void video_config(uint8_t video_on, uint8_t scanline_off);

void vga_pixel_fast(uint16_t x, uint16_t y, uint16_t color);

void vga_drawFastHLine(int16_t x, int16_t y, int16_t w, uint16_t color);

void vga_drawFastVLine(int16_t x, int16_t y, int16_t h, uint16_t color);

void vga_fillCircle(uint16_t x0, uint16_t y0, uint16_t r, uint16_t color);

void vga_drawRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color);

void vga_drawLine(int16_t x1, int16_t y1, int16_t x2, int16_t y2, uint16_t color);

void vga_FillTriangle(Point_t p0, Point_t p1, Point_t p2, uint16_t color);

void vga_setTextFont(uint8_t f);

void vga_setTextSize(uint8_t s);

void vga_setTextColor(uint16_t c, uint16_t b);

void vga_set_cursor(int x, int y);

void vga_clear_screen(uint16_t color);

void vga_fillRect(uint16_t x, uint16_t y, uint16_t w, uint16_t h, uint16_t color);

int vga_drawChar(unsigned int uniCode, int x, int y, int font);

void vga_printAt(const char *str, int16_t x, int16_t y, uint16_t color, uint16_t bg, uint8_t font);

void vga_printCenteredX(const char *str, int16_t xStart, int16_t xEnd, int16_t y, uint16_t color, uint16_t bg, uint8_t font) ;

void vga_Print_int16(int16_t value);

void vga_print_float(float value, uint8_t decimals);

void vga_print_hex8(uint8_t value);

void vga_Print(const char *str);

size_t vga_write(uint8_t uniCode);

void vga_print_int(int32_t num);

void vga_drawLine_Clipped(uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2, uint16_t color, uint16_t y_min, uint16_t y_max);

void draw_rgb_bars();

void vga_print_int_safe(int32_t num);

#endif // VIDEO_H
