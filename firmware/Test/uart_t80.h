#ifndef UART_T80_H
#define UART_T80_H

#include <stdint.h>
#include <stdbool.h>

// Base address definito nell'Arbiter
#define UART_BASE 0xC030

// Offset dei registri
#define UART_UDR   (*(volatile uint8_t *)(UART_BASE + 0)) // Data Register
#define UART_USR   (*(volatile uint8_t *)(UART_BASE + 1)) // Status Register
#define UART_UCR   (*(volatile uint8_t *)(UART_BASE + 2)) // Control Register
#define UART_UBRR  (*(volatile uint8_t *)(UART_BASE + 3)) // Baud Rate Register

// Bit del registro di Stato (USR)
#define UART_RXC   0x80  // Receive Complete
#define UART_TXC   0x40  // Transmit Complete
#define UART_UDRE  0x20  // Data Register Empty (Pronto per inviare)
#define UART_FE    0x10  // Frame Error
#define UART_DOR   0x08  // Data OverRun

// Bit del registro di Controllo (UCR)
#define UART_RXEN  0x10  // Enable Receiver
#define UART_TXEN  0x08  // Enable Transmitter

// Valore per 115200 baud con clock 80MHz (80MHz / (16 * 115200)) - 1 = 42.4
#define B_115200_80MHZ 42 

// Prototipi
void uart_init(uint8_t ubrr_val);
void uart_putc(char c);
void uart_puts(const char *s);
char uart_getc(void);
bool uart_available(void);

#endif