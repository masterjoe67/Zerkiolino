;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module sdcard
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sd_write_sector2
	.globl _vga_pixel_fast
	.globl _sd_wait_ready
	.globl _sd_write_sector
	.globl _sd_read_sector
	.globl _vga_load_rgb333_full
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
;sdcard.c:5: uint8_t sd_wait_ready(void) {
;	---------------------------------
; Function sd_wait_ready
; ---------------------------------
_sd_wait_ready::
;sdcard.c:12: while ((SDSTATUS & (SD_STAT_BLK_BUSY | SD_STAT_INI_BUSY)) != 0) {
	ld	bc, #0x0000
	ld	d, b
	ld	e, c
00103$:
	ld	a, (#0xc011)
	and	a, #0x30
	jr	Z, 00105$
;sdcard.c:14: if (++timeout > MAX_TIMEOUT) return 0;
	inc	c
	jr	NZ, 00130$
	inc	b
	jr	NZ, 00130$
	inc	de
00130$:
	ld	a, #0x40
	cp	a, c
	ld	a, #0x42
	sbc	a, b
	ld	hl, #0x000f
	sbc	hl, de
	jr	NC, 00103$
	xor	a, a
	ret
00105$:
;sdcard.c:16: return 1;
	ld	a, #0x01
;sdcard.c:17: }
	ret
;sdcard.c:21: uint8_t sd_write_sector2(uint32_t lba, const uint8_t *buf) {
;	---------------------------------
; Function sd_write_sector2
; ---------------------------------
_sd_write_sector2::
	push	af
	push	de
	push	hl
	ld	a, l
	ld	iy, #2
	add	iy, sp
	ld	2 (iy), a
	pop	hl
	ld	3 (iy), h
;sdcard.c:22: if (!sd_wait_ready()) return 0;
	call	_sd_wait_ready
	or	a, a
	jr	NZ, 00102$
	xor	a, a
	jr	00110$
00102$:
;sdcard.c:25: SDLBA0 = (uint8_t)(lba & 0xFF);
	ld	iy, #0
	add	iy, sp
	ld	a, 0 (iy)
	ld	hl, #0xc012
	ld	(hl), a
;sdcard.c:26: SDLBA1 = (uint8_t)((lba >> 8) & 0xFF);
	ld	a, 1 (iy)
	ld	l, #0x13
	ld	(hl), a
;sdcard.c:27: SDLBA2 = (uint8_t)((lba >> 16) & 0xFF);
	ld	a, 2 (iy)
	ld	l, #0x14
	ld	(hl), a
;sdcard.c:28: SDLBA3 = (uint8_t)((lba >> 24) & 0xFF);
	ld	a, 3 (iy)
	ld	l, #0x15
	ld	(hl), a
;sdcard.c:30: SDCONTROL = SD_CMD_WRITE_BLOCK; // Comando WRITE (0x01)
	ld	l, #0x11
	ld	(hl), #0x01
;sdcard.c:32: for (uint16_t i = 0; i < 512; i++) {
	ld	bc, #0x0000
00108$:
	ld	a, b
	sub	a, #0x02
	jr	NC, 00106$
;sdcard.c:34: while (!(SDSTATUS & SD_STAT_TX_EMPTY));
00103$:
	ld	a, (#0xc011)
	rlca
	jr	NC, 00103$
;sdcard.c:35: SDDATA = buf[i];
	ld	hl, #6
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	a, (hl)
	ld	(#0xc010),a
;sdcard.c:32: for (uint16_t i = 0; i < 512; i++) {
	inc	bc
	jr	00108$
00106$:
;sdcard.c:38: return sd_wait_ready(); // Aspetta la scrittura fisica dei CRC su disco
	call	_sd_wait_ready
00110$:
;sdcard.c:39: }
	pop	bc
	pop	bc
	pop	hl
	pop	bc
	jp	(hl)
;sdcard.c:41: uint8_t sd_write_sector(uint32_t lba, const uint8_t *buf) {
;	---------------------------------
; Function sd_write_sector
; ---------------------------------
_sd_write_sector::
	push	af
	push	de
	push	hl
	ld	a, l
	ld	iy, #2
	add	iy, sp
	ld	2 (iy), a
	pop	hl
	ld	3 (iy), h
;sdcard.c:42: if (!sd_wait_ready()) return 0;
	call	_sd_wait_ready
	or	a, a
	jr	NZ, 00102$
	xor	a, a
	jr	00113$
00102$:
;sdcard.c:45: SDLBA0 = (uint8_t)(lba & 0xFF);
	ld	iy, #0
	add	iy, sp
	ld	a, 0 (iy)
	ld	hl, #0xc012
	ld	(hl), a
;sdcard.c:46: SDLBA1 = (uint8_t)((lba >> 8) & 0xFF);
	ld	a, 1 (iy)
	ld	l, #0x13
	ld	(hl), a
;sdcard.c:47: SDLBA2 = (uint8_t)((lba >> 16) & 0xFF);
	ld	a, 2 (iy)
	ld	l, #0x14
	ld	(hl), a
;sdcard.c:48: SDLBA3 = (uint8_t)((lba >> 24) & 0xFF);
	ld	a, 3 (iy)
	ld	l, #0x15
	ld	(hl), a
;sdcard.c:51: SDCONTROL = SD_CMD_WRITE_BLOCK; 
	ld	l, #0x11
	ld	(hl), #0x01
;sdcard.c:55: while (!(SDSTATUS & 0x20)); 
00103$:
	ld	a, (#0xc011)
	bit	5, a
	jr	Z, 00103$
;sdcard.c:58: for (uint16_t i = 0; i < 512; i++) {
	ld	bc, #0x0000
00111$:
	ld	a, b
	sub	a, #0x02
	jr	NC, 00109$
;sdcard.c:60: while (!(SDSTATUS & SD_STAT_TX_EMPTY)); 
00106$:
	ld	a, (#0xc011)
	rlca
	jr	NC, 00106$
;sdcard.c:61: SDDATA = buf[i];
	ld	hl, #6
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	a, (hl)
	ld	(#0xc010),a
;sdcard.c:58: for (uint16_t i = 0; i < 512; i++) {
	inc	bc
	jr	00111$
00109$:
;sdcard.c:65: return sd_wait_ready(); 
	call	_sd_wait_ready
00113$:
;sdcard.c:66: }
	pop	bc
	pop	bc
	pop	hl
	pop	bc
	jp	(hl)
;sdcard.c:127: uint8_t sd_read_sector(uint32_t sector, uint8_t *buffer) {
;	---------------------------------
; Function sd_read_sector
; ---------------------------------
_sd_read_sector::
	push	af
	push	af
	ld	c, l
	ld	a, h
;sdcard.c:129: SDLBA0 = (sector & 0xFF);
	ld	b, e
	ld	hl, #0xc012
	ld	(hl), b
;sdcard.c:130: SDLBA1 = (sector >> 8) & 0xFF;
	ld	b, d
	ld	l, #0x13
	ld	(hl), b
;sdcard.c:131: SDLBA2 = (sector >> 16) & 0xFF;
	ld	b, c
	ld	l, #0x14
	ld	(hl), b
;sdcard.c:132: SDLBA3 = (sector >> 24) & 0xFF;
	ld	l, #0x15
	ld	(hl), a
;sdcard.c:135: SDCONTROL = 0x00;
	ld	l, #0x11
	ld	(hl), #0x00
;sdcard.c:140: while (!(SDSTATUS & 0x40)) { // Aspetta RX_READY (Bit 6)
	ld	iy, #0
	add	iy, sp
	ld	0 (iy), #0x40
	ld	1 (iy), #0x42
	ld	2 (iy), #0x0f
	ld	3 (iy), #0
00103$:
	ld	a, (#0xc011)
	bit	6, a
	jr	NZ, 00120$
;sdcard.c:141: if (--timeout == 0) return 0; // Fallito per timeout
	ld	hl, #0
	add	hl, sp
	ld	a, (hl)
	add	a, #0xff
	ld	(hl), a
	inc	hl
	ld	a, (hl)
	adc	a, #0xff
	ld	(hl), a
	inc	hl
	ld	a, (hl)
	adc	a, #0xff
	ld	(hl), a
	inc	hl
	ld	a, (hl)
	adc	a, #0xff
	ld	(hl), a
	ld	iy, #0
	add	iy, sp
	ld	a, 3 (iy)
	or	a, 2 (iy)
	or	a, 1 (iy)
	or	a, 0 (iy)
	jr	NZ, 00103$
	xor	a, a
	jr	00113$
;sdcard.c:145: for (int i = 0; i < 512; i++) {
00120$:
	ld	bc, #0x0000
00111$:
	ld	a, b
	xor	a, #0x80
	sub	a, #0x82
	jr	NC, 00109$
;sdcard.c:146: while (!(SDSTATUS & 0x40)); // Aspetta che ogni singolo byte sia pronto
00106$:
	ld	a, (#0xc011)
	bit	6, a
	jr	Z, 00106$
;sdcard.c:147: buffer[i] = SDDATA;
	ld	iy, #6
	add	iy, sp
	ld	a, 0 (iy)
	add	a, c
	ld	e, a
	ld	a, 1 (iy)
	adc	a, b
	ld	d, a
	ld	a, (#0xc010)
	ld	(de), a
;sdcard.c:145: for (int i = 0; i < 512; i++) {
	inc	bc
	jr	00111$
00109$:
;sdcard.c:149: return 1;
	ld	a, #0x01
00113$:
;sdcard.c:150: }
	pop	bc
	pop	bc
	pop	hl
	pop	bc
	jp	(hl)
;sdcard.c:153: void vga_load_rgb333_full(uint32_t start_lba) {
;	---------------------------------
; Function vga_load_rgb333_full
; ---------------------------------
_vga_load_rgb333_full::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-526
	add	iy, sp
	ld	sp, iy
	ld	-10 (ix), e
	ld	-9 (ix), d
	ld	-8 (ix), l
	ld	-7 (ix), h
;sdcard.c:156: uint16_t x = 0;
	xor	a, a
	ld	-6 (ix), a
	ld	-5 (ix), a
;sdcard.c:157: uint16_t y = 0;
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
;sdcard.c:160: for (uint16_t s = 0; s < 1200; s++) {
	xor	a, a
	ld	-4 (ix), a
	ld	-3 (ix), a
00111$:
	ld	a, -4 (ix)
	ld	b, -3 (ix)
	sub	a, #0xb0
	ld	a, b
	sbc	a, #0x04
	jp	NC, 00113$
;sdcard.c:161: if (!sd_read_sector(current_lba, buffer)) {
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	call	_sd_read_sector
	or	a, a
	jp	Z, 00113$
;sdcard.c:167: for (uint16_t i = 0; i < 512; i += 2) {
	xor	a, a
	ld	-14 (ix), a
	ld	-13 (ix), a
00108$:
	ld	a, -14 (ix)
	ld	-12 (ix), a
	ld	a, -13 (ix)
	ld	-11 (ix), a
	sub	a, #0x02
	jr	NC, 00121$
;sdcard.c:169: uint8_t byte_alto = buffer[i+1];
	ld	c, -12 (ix)
	ld	b, -11 (ix)
	inc	bc
	ld	hl, #0
	add	hl, sp
	add	hl, bc
	ld	c, (hl)
;sdcard.c:170: uint8_t byte_basso = buffer[i];
	ld	e, -14 (ix)
	ld	d, -13 (ix)
	ld	hl, #0
	add	hl, sp
	add	hl, de
	ld	e, (hl)
;sdcard.c:173: uint16_t color = ((uint16_t)byte_alto << 8) | byte_basso;
	ld	b, c
	ld	c, e
;sdcard.c:174: vga_pixel_fast(x, y, color);
	push	bc
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	call	_vga_pixel_fast
;sdcard.c:177: x++;
	inc	-6 (ix)
	jr	NZ, 00159$
	inc	-5 (ix)
00159$:
;sdcard.c:178: if (x >= 640) {
	ld	a, -6 (ix)
	ld	b, -5 (ix)
	sub	a, #0x80
	ld	a, b
	sbc	a, #0x02
	jr	C, 00109$
;sdcard.c:179: x = 0;
	xor	a, a
	ld	-6 (ix), a
	ld	-5 (ix), a
;sdcard.c:180: y++;
	inc	-2 (ix)
	jr	NZ, 00160$
	inc	-1 (ix)
00160$:
00109$:
;sdcard.c:167: for (uint16_t i = 0; i < 512; i += 2) {
	ld	c, -12 (ix)
	ld	b, -11 (ix)
	inc	bc
	inc	bc
	ld	-14 (ix), c
	ld	-13 (ix), b
	jr	00108$
00121$:
;sdcard.c:184: current_lba++; // Prossimo settore
	inc	-10 (ix)
	jr	NZ, 00161$
	inc	-9 (ix)
	jr	NZ, 00161$
	inc	-8 (ix)
	jr	NZ, 00161$
	inc	-7 (ix)
00161$:
;sdcard.c:160: for (uint16_t s = 0; s < 1200; s++) {
	inc	-4 (ix)
	jp	NZ, 00111$
	inc	-3 (ix)
	jp	00111$
00113$:
;sdcard.c:186: }
	ld	sp, ix
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
