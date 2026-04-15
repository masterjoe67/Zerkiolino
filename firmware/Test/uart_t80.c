#include "uart_t80.h"

/**
 * Inizializza la UART
 * @param ubrr_val Valore per il baud rate generator
 */
void uart_init(uint8_t ubrr_val) {
    // 1. Imposta il baud rate
    UART_UBRR = ubrr_val;
    
    // 2. Abilita Trasmettitore e Ricevitore
    UART_UCR = UART_TXEN | UART_RXEN;
}

/**
 * Invia un singolo carattere (Polling)
 */
void uart_putc(char c) {
    // Aspetta finché il buffer di trasmissione non è vuoto (UDRE = 1)
    while (!(UART_USR & UART_UDRE));
    
    // Scrive il dato nel registro
    UART_UDR = (uint8_t)c;
}

/**
 * Invia una stringa
 */
void uart_puts(const char *s) {
    while (*s) {
        uart_putc(*s++);
    }
}

/**
 * Verifica se è arrivato un carattere
 */
bool uart_available(void) {
    return (UART_USR & UART_RXC);
}

/**
 * Riceve un carattere (Bloccante)
 */
char uart_getc(void) {
    // Aspetta finché il dato non è ricevuto (RXC = 1)
    while (!uart_available());
    
    // Ritorna il dato letto
    return (char)UART_UDR;
}