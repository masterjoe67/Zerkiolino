#ifndef ZERKIOLINO_ALU_H
#define ZERKIOLINO_ALU_H

#include <stdint.h>
#define ALU_BASE 0xC020

// Scrittura parametri A e B
static void alu_set_params(int32_t a, int32_t b) {
    volatile uint8_t *p = (uint8_t *)ALU_BASE;
    p[0] = (uint8_t)(a & 0xFF); p[1] = (uint8_t)((a >> 8) & 0xFF);
    p[2] = (uint8_t)((a >> 16) & 0xFF); p[3] = (uint8_t)((a >> 24) & 0xFF);
    p[4] = (uint8_t)(b & 0xFF); p[5] = (uint8_t)((b >> 8) & 0xFF);
    p[6] = (uint8_t)((b >> 16) & 0xFF); p[7] = (uint8_t)((b >> 24) & 0xFF);
}

// Lettura a 32 bit da offset specifico
static int32_t alu_get_32(uint8_t offset) {
    volatile uint8_t *p = (uint8_t *)(ALU_BASE + offset);
    uint32_t r = (uint32_t)p[0];
    r |= (uint32_t)p[1] << 8;
    r |= (uint32_t)p[2] << 16;
    r |= (uint32_t)p[3] << 24;
    return (int32_t)r;
}

// --- FUNZIONI ---

static int32_t alu_add(int32_t a, int32_t b) {
    alu_set_params(a, b);
    *(volatile uint8_t *)(ALU_BASE + 8) = 1;
    return alu_get_32(0x0A);
}

static int32_t alu_sub(int32_t a, int32_t b) {
    alu_set_params(a, b);
    *(volatile uint8_t *)(ALU_BASE + 8) = 2;
    return alu_get_32(0x0A);
}

static int32_t alu_mul_fp(int32_t a, int32_t b) {
    alu_set_params(a, b);
    *(volatile uint8_t *)(ALU_BASE + 8) = 3;
    // Q16.16: Bit 16..47 mappati su Addr 0x0C, 0x0D, 0x0E, 0x0F
    return alu_get_32(0x0C);
}

static int32_t alu_div(int32_t a, int32_t b) {
    if (b == 0) return 0;
    alu_set_params(a, b);
    *(volatile uint8_t *)(ALU_BASE + 8) = 4;
    while(*(volatile uint8_t *)(ALU_BASE + 9) & 0x01); // Wait Busy
    return alu_get_32(0x0A);
}

static int16_t alu_get_mod() {
    volatile uint8_t *p = (uint8_t *)ALU_BASE;
    uint16_t r = (uint16_t)p[0]; // Resto mappato su 0x0 e 0x1 in lettura
    r |= (uint16_t)p[1] << 8;
    return (int16_t)r;
}

static int32_t alu_shl(int32_t a, uint8_t sh) {
    alu_set_params(a, (int32_t)sh);
    *(volatile uint8_t *)(ALU_BASE + 8) = 5;
    return alu_get_32(0x0A);
}

static int32_t alu_shr(int32_t a, uint8_t sh) {
    alu_set_params(a, (int32_t)sh);
    *(volatile uint8_t *)(ALU_BASE + 8) = 6;
    return alu_get_32(0x0A);
}

#endif // ZERKIOLINO_ALU_H