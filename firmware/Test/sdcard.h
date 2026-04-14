#ifndef SD_CARD_H
#define SD_CARD_H

#include <stdint.h>

// Nuova Mappatura Registri SD (Base 0xC010 nell'Arbiter)
#define SD_BASE_ADDR 0xC010

#define SDDATA      (*(volatile uint8_t*)(SD_BASE_ADDR + 0)) // 0xC010: R/W Dati
#define SDSTATUS    (*(volatile uint8_t*)(SD_BASE_ADDR + 1)) // 0xC011: Read Only (Stato)
#define SDCONTROL   (*(volatile uint8_t*)(SD_BASE_ADDR + 1)) // 0xC011: Write Only (Comandi)

// Registri Indirizzo LBA (Linear Block Address)
#define SDLBA0      (*(volatile uint8_t*)(SD_BASE_ADDR + 2)) // 0xC012: LSB (A7..A0)
#define SDLBA1      (*(volatile uint8_t*)(SD_BASE_ADDR + 3)) // 0xC013:      (A15..A8)
#define SDLBA2      (*(volatile uint8_t*)(SD_BASE_ADDR + 4)) // 0xC014:      (A23..A16)
#define SDLBA3      (*(volatile uint8_t*)(SD_BASE_ADDR + 5)) // 0xC015: MSB (A31..A24)

// Maschere Status (dal tuo VHDL)
// Bit 7: TX Empty (1 = Pronto a scrivere nuovo byte in SDDATA)
// Bit 6: RX Ready (1 = Un byte è pronto per essere letto da SDDATA)
// Bit 5: Block Busy (1 = Operazione lettura/scrittura blocco in corso)
// Bit 4: Init Busy  (1 = Inizializzazione SD in corso)
#define SD_STAT_TX_EMPTY (1 << 7)
#define SD_STAT_RX_READY (1 << 6)
#define SD_STAT_BLK_BUSY (1 << 5)
#define SD_STAT_INI_BUSY (1 << 4)

#define SD_BUSY_FLAGS    (SD_STAT_BLK_BUSY | SD_STAT_INI_BUSY)

// Comandi per SDCONTROL
#define SD_CMD_READ_BLOCK  0x00
#define SD_CMD_WRITE_BLOCK 0x01

// Funzioni pubbliche
uint8_t sd_wait_ready(void);
uint8_t sd_write_sector(uint32_t lba, const uint8_t *buf);
uint8_t sd_read_sector(uint32_t lba, uint8_t *buf);
void vga_load_rgb333_full(uint32_t start_lba);

#endif