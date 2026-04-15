;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module uart_t80
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _uart_init
	.globl _uart_putc
	.globl _uart_puts
	.globl _uart_available
	.globl _uart_getc
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;uart_t80.c:7: void uart_init(uint8_t ubrr_val) {
;	---------------------------------
; Function uart_init
; ---------------------------------
_uart_init::
;uart_t80.c:9: UART_UBRR = ubrr_val;
	ld	hl, #0xc033
	ld	(hl), a
;uart_t80.c:12: UART_UCR = UART_TXEN | UART_RXEN;
	ld	l, #0x32
	ld	(hl), #0x18
;uart_t80.c:13: }
	ret
;uart_t80.c:18: void uart_putc(char c) {
;	---------------------------------
; Function uart_putc
; ---------------------------------
_uart_putc::
;uart_t80.c:20: while (!(UART_USR & UART_UDRE));
00101$:
	ld	hl, #0xc031
	bit	5, (hl)
	jr	Z, 00101$
;uart_t80.c:23: UART_UDR = (uint8_t)c;
	ld	(#0xc030),a
;uart_t80.c:24: }
	ret
;uart_t80.c:29: void uart_puts(const char *s) {
;	---------------------------------
; Function uart_puts
; ---------------------------------
_uart_puts::
;uart_t80.c:30: while (*s) {
00101$:
	ld	a, (hl)
	or	a, a
	ret	Z
;uart_t80.c:31: uart_putc(*s++);
	inc	hl
	push	hl
	call	_uart_putc
	pop	hl
;uart_t80.c:33: }
	jr	00101$
;uart_t80.c:38: bool uart_available(void) {
;	---------------------------------
; Function uart_available
; ---------------------------------
_uart_available::
;uart_t80.c:39: return (UART_USR & UART_RXC);
	ld	a, (#0xc031)
	rlca
	and	a, #0x01
;uart_t80.c:40: }
	ret
;uart_t80.c:45: char uart_getc(void) {
;	---------------------------------
; Function uart_getc
; ---------------------------------
_uart_getc::
;uart_t80.c:47: while (!uart_available());
00101$:
	call	_uart_available
	bit	0,a
	jr	Z, 00101$
;uart_t80.c:50: return (char)UART_UDR;
	ld	a, (#0xc030)
;uart_t80.c:51: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
