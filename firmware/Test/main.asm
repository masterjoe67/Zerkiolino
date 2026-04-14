;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module main
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _draw_mandelbrot
	.globl _test_sd_card
	.globl _update_cube
	.globl _get_cos
	.globl _get_sin
	.globl _vga_load_rgb333_full
	.globl _sd_read_sector
	.globl _sd_write_sector
	.globl _sd_wait_ready
	.globl _vga_print_int
	.globl _vga_Print
	.globl _vga_print_hex8
	.globl _vga_clear_screen
	.globl _vga_set_cursor
	.globl _vga_setTextColor
	.globl _vga_setTextSize
	.globl _vga_setTextFont
	.globl _vga_drawLine
	.globl _vga_pixel_fast
	.globl _video_config
	.globl _first_frame
	.globl _sector_buffer
	.globl _old_projected
	.globl _sin_lut
	.globl _edges
	.globl _cube_vertices
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_old_projected::
	.ds 16
_sector_buffer::
	.ds 512
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_first_frame::
	.ds 1
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
;zerkiolino_alu.h:8: static void alu_set_params(int32_t a, int32_t b) {
;	---------------------------------
; Function alu_set_params
; ---------------------------------
_alu_set_params:
	ld	a, l
	ld	c, h
;zerkiolino_alu.h:10: p[0] = (uint8_t)(a & 0xFF); p[1] = (uint8_t)((a >> 8) & 0xFF);
	ld	b, e
	ld	hl, #0xc020
	ld	(hl), b
	ld	b, d
	ld	l, #0x21
	ld	(hl), b
;zerkiolino_alu.h:11: p[2] = (uint8_t)((a >> 16) & 0xFF); p[3] = (uint8_t)((a >> 24) & 0xFF);
	ld	b, a
	ld	l, #0x22
	ld	(hl), b
	ld	l, #0x23
	ld	(hl), c
;zerkiolino_alu.h:12: p[4] = (uint8_t)(b & 0xFF); p[5] = (uint8_t)((b >> 8) & 0xFF);
	ld	iy, #2
	add	iy, sp
	ld	a, 0 (iy)
	ld	l, #0x24
	ld	(hl), a
	ld	a, 1 (iy)
	ld	l, #0x25
	ld	(hl), a
;zerkiolino_alu.h:13: p[6] = (uint8_t)((b >> 16) & 0xFF); p[7] = (uint8_t)((b >> 24) & 0xFF);
	ld	a, 2 (iy)
	ld	l, #0x26
	ld	(hl), a
	ld	a, 3 (iy)
	ld	l, #0x27
	ld	(hl), a
;zerkiolino_alu.h:14: }
	pop	hl
	pop	af
	pop	af
	jp	(hl)
;zerkiolino_alu.h:17: static int32_t alu_get_32(uint8_t offset) {
;	---------------------------------
; Function alu_get_32
; ---------------------------------
_alu_get_32:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-8
	add	hl, sp
	ld	sp, hl
;zerkiolino_alu.h:18: volatile uint8_t *p = (uint8_t *)(ALU_BASE + offset);
	ld	c, a
	ld	b, #0x00
	ld	hl, #0xc020
	add	hl, bc
	ex	de, hl
;zerkiolino_alu.h:19: uint32_t r = (uint32_t)p[0];
	ld	a, (de)
	ld	-8 (ix), a
	xor	a, a
	ld	-7 (ix), a
	ld	-6 (ix), a
	ld	-5 (ix), a
;zerkiolino_alu.h:20: r |= (uint32_t)p[1] << 8;
	ld	l, e
	ld	h, d
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x0000
	ld	h, l
	ld	l, b
	ld	b, c
	ld	a, -8 (ix)
	ld	-4 (ix), a
	ld	-3 (ix), b
	ld	-2 (ix), l
	ld	-1 (ix), h
;zerkiolino_alu.h:21: r |= (uint32_t)p[2] << 16;
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	ld	c, -4 (ix)
	ld	b, -3 (ix)
	push	hl
	pop	iy
;zerkiolino_alu.h:22: r |= (uint32_t)p[3] << 24;
	ld	hl, #3
	add	hl, de
	ld	h, (hl)
	push	iy
	ld	l, -10 (ix)
	pop	iy
;zerkiolino_alu.h:23: return (int32_t)r;
	ld	e, c
	ld	d, b
;zerkiolino_alu.h:24: }
	ld	sp, ix
	pop	ix
	ret
;zerkiolino_alu.h:28: static int32_t alu_add(int32_t a, int32_t b) {
;	---------------------------------
; Function alu_add
; ---------------------------------
_alu_add:
	ld	c, l
	ld	b, h
;zerkiolino_alu.h:29: alu_set_params(a, b);
	ld	iy, #2
	add	iy, sp
	ld	l, 2 (iy)
	ld	h, 3 (iy)
	push	hl
	ld	l, 0 (iy)
	ld	h, 1 (iy)
	push	hl
	ld	l, c
	ld	h, b
	call	_alu_set_params
;zerkiolino_alu.h:30: *(volatile uint8_t *)(ALU_BASE + 8) = 1;
	ld	hl, #0xc028
	ld	(hl), #0x01
;zerkiolino_alu.h:31: return alu_get_32(0x0A);
	ld	a, #0x0a
;zerkiolino_alu.h:32: }
	jp	_alu_get_32
;zerkiolino_alu.h:34: static int32_t alu_sub(int32_t a, int32_t b) {
;	---------------------------------
; Function alu_sub
; ---------------------------------
_alu_sub:
	ld	c, l
	ld	b, h
;zerkiolino_alu.h:35: alu_set_params(a, b);
	ld	iy, #2
	add	iy, sp
	ld	l, 2 (iy)
	ld	h, 3 (iy)
	push	hl
	ld	l, 0 (iy)
	ld	h, 1 (iy)
	push	hl
	ld	l, c
	ld	h, b
	call	_alu_set_params
;zerkiolino_alu.h:36: *(volatile uint8_t *)(ALU_BASE + 8) = 2;
	ld	hl, #0xc028
	ld	(hl), #0x02
;zerkiolino_alu.h:37: return alu_get_32(0x0A);
	ld	a, #0x0a
;zerkiolino_alu.h:38: }
	jp	_alu_get_32
;zerkiolino_alu.h:40: static int32_t alu_mul_fp(int32_t a, int32_t b) {
;	---------------------------------
; Function alu_mul_fp
; ---------------------------------
_alu_mul_fp:
	ld	c, l
	ld	b, h
;zerkiolino_alu.h:41: alu_set_params(a, b);
	ld	iy, #2
	add	iy, sp
	ld	l, 2 (iy)
	ld	h, 3 (iy)
	push	hl
	ld	l, 0 (iy)
	ld	h, 1 (iy)
	push	hl
	ld	l, c
	ld	h, b
	call	_alu_set_params
;zerkiolino_alu.h:42: *(volatile uint8_t *)(ALU_BASE + 8) = 3;
	ld	hl, #0xc028
	ld	(hl), #0x03
;zerkiolino_alu.h:44: return alu_get_32(0x0C);
	ld	a, #0x0c
;zerkiolino_alu.h:45: }
	jp	_alu_get_32
;zerkiolino_alu.h:47: static int32_t alu_div(int32_t a, int32_t b) {
;	---------------------------------
; Function alu_div
; ---------------------------------
_alu_div:
	ld	c, l
	ld	b, h
;zerkiolino_alu.h:48: if (b == 0) return 0;
	ld	iy, #2
	add	iy, sp
	ld	a, 3 (iy)
	or	a, 2 (iy)
	or	a, 1 (iy)
	or	a, 0 (iy)
	jr	NZ, 00102$
	ld	de, #0x0000
	ld	l, e
	ld	h, e
	ret
00102$:
;zerkiolino_alu.h:49: alu_set_params(a, b);
	ld	iy, #2
	add	iy, sp
	ld	l, 2 (iy)
	ld	h, 3 (iy)
	push	hl
	ld	l, 0 (iy)
	ld	h, 1 (iy)
	push	hl
	ld	l, c
	ld	h, b
	call	_alu_set_params
;zerkiolino_alu.h:50: *(volatile uint8_t *)(ALU_BASE + 8) = 4;
	ld	hl, #0xc028
	ld	(hl), #0x04
;zerkiolino_alu.h:51: while(*(volatile uint8_t *)(ALU_BASE + 9) & 0x01); // Wait Busy
00103$:
	ld	a, (#0xc029)
	rrca
	jr	C, 00103$
;zerkiolino_alu.h:52: return alu_get_32(0x0A);
	ld	a, #0x0a
;zerkiolino_alu.h:53: }
	jp	_alu_get_32
;zerkiolino_alu.h:55: static int16_t alu_get_mod() {
;	---------------------------------
; Function alu_get_mod
; ---------------------------------
_alu_get_mod:
;zerkiolino_alu.h:57: uint16_t r = (uint16_t)p[0]; // Resto mappato su 0x0 e 0x1 in lettura
	ld	hl, #0xc020
	ld	c, (hl)
;zerkiolino_alu.h:58: r |= (uint16_t)p[1] << 8;
	ld	hl, #0xc021
	ld	d, (hl)
	ld	e, c
;zerkiolino_alu.h:59: return (int16_t)r;
;zerkiolino_alu.h:60: }
	ret
;zerkiolino_alu.h:62: static int32_t alu_shl(int32_t a, uint8_t sh) {
;	---------------------------------
; Function alu_shl
; ---------------------------------
_alu_shl:
	push	ix
	ld	ix,#0
	add	ix,sp
;zerkiolino_alu.h:63: alu_set_params(a, (int32_t)sh);
	ld	c, 4 (ix)
	ld	b, #0x00
	ld	iy, #0x0000
	push	iy
	push	bc
	call	_alu_set_params
;zerkiolino_alu.h:64: *(volatile uint8_t *)(ALU_BASE + 8) = 5;
	ld	hl, #0xc028
	ld	(hl), #0x05
;zerkiolino_alu.h:65: return alu_get_32(0x0A);
	ld	a, #0x0a
	call	_alu_get_32
;zerkiolino_alu.h:66: }
	pop	ix
	ret
;zerkiolino_alu.h:68: static int32_t alu_shr(int32_t a, uint8_t sh) {
;	---------------------------------
; Function alu_shr
; ---------------------------------
_alu_shr:
	push	ix
	ld	ix,#0
	add	ix,sp
;zerkiolino_alu.h:69: alu_set_params(a, (int32_t)sh);
	ld	c, 4 (ix)
	ld	b, #0x00
	ld	iy, #0x0000
	push	iy
	push	bc
	call	_alu_set_params
;zerkiolino_alu.h:70: *(volatile uint8_t *)(ALU_BASE + 8) = 6;
	ld	hl, #0xc028
	ld	(hl), #0x06
;zerkiolino_alu.h:71: return alu_get_32(0x0A);
	ld	a, #0x0a
	call	_alu_get_32
;zerkiolino_alu.h:72: }
	pop	ix
	ret
;main.c:31: int16_t get_sin(uint8_t a) { return sin_lut[a]; }
;	---------------------------------
; Function get_sin
; ---------------------------------
_get_sin::
	ld	l, a
	ld	bc, #_sin_lut+0
	ld	h, #0x00
	add	hl, hl
	add	hl, bc
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ret
_cube_vertices:
	.dw #0xffe0
	.dw #0xffe0
	.dw #0x0020
	.dw #0x0020
	.dw #0xffe0
	.dw #0x0020
	.dw #0x0020
	.dw #0x0020
	.dw #0x0020
	.dw #0xffe0
	.dw #0x0020
	.dw #0x0020
	.dw #0xffe0
	.dw #0xffe0
	.dw #0xffe0
	.dw #0x0020
	.dw #0xffe0
	.dw #0xffe0
	.dw #0x0020
	.dw #0x0020
	.dw #0xffe0
	.dw #0xffe0
	.dw #0x0020
	.dw #0xffe0
_edges:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x01	; 1
	.db #0x05	; 5
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x07	; 7
_sin_lut:
	.dw #0x0000
	.dw #0x0006
	.dw #0x000d
	.dw #0x0013
	.dw #0x0019
	.dw #0x001f
	.dw #0x0026
	.dw #0x002c
	.dw #0x0032
	.dw #0x0038
	.dw #0x003e
	.dw #0x0044
	.dw #0x004a
	.dw #0x0050
	.dw #0x0056
	.dw #0x005c
	.dw #0x0062
	.dw #0x0067
	.dw #0x006d
	.dw #0x0073
	.dw #0x0078
	.dw #0x007e
	.dw #0x0083
	.dw #0x0088
	.dw #0x008e
	.dw #0x0093
	.dw #0x0098
	.dw #0x009d
	.dw #0x00a2
	.dw #0x00a7
	.dw #0x00ab
	.dw #0x00b0
	.dw #0x00b4
	.dw #0x00b9
	.dw #0x00bd
	.dw #0x00c1
	.dw #0x00c5
	.dw #0x00c9
	.dw #0x00cd
	.dw #0x00d0
	.dw #0x00d4
	.dw #0x00d7
	.dw #0x00db
	.dw #0x00de
	.dw #0x00e1
	.dw #0x00e4
	.dw #0x00e7
	.dw #0x00e9
	.dw #0x00ec
	.dw #0x00ee
	.dw #0x00f0
	.dw #0x00f2
	.dw #0x00f4
	.dw #0x00f6
	.dw #0x00f7
	.dw #0x00f9
	.dw #0x00fa
	.dw #0x00fb
	.dw #0x00fc
	.dw #0x00fd
	.dw #0x00fe
	.dw #0x00fe
	.dw #0x00ff
	.dw #0x00ff
	.dw #0x0100
	.dw #0x00ff
	.dw #0x00ff
	.dw #0x00fe
	.dw #0x00fe
	.dw #0x00fd
	.dw #0x00fc
	.dw #0x00fb
	.dw #0x00fa
	.dw #0x00f9
	.dw #0x00f7
	.dw #0x00f6
	.dw #0x00f4
	.dw #0x00f2
	.dw #0x00f0
	.dw #0x00ee
	.dw #0x00ec
	.dw #0x00e9
	.dw #0x00e7
	.dw #0x00e4
	.dw #0x00e1
	.dw #0x00de
	.dw #0x00db
	.dw #0x00d7
	.dw #0x00d4
	.dw #0x00d0
	.dw #0x00cd
	.dw #0x00c9
	.dw #0x00c5
	.dw #0x00c1
	.dw #0x00bd
	.dw #0x00b9
	.dw #0x00b4
	.dw #0x00b0
	.dw #0x00ab
	.dw #0x00a7
	.dw #0x00a2
	.dw #0x009d
	.dw #0x0098
	.dw #0x0093
	.dw #0x008e
	.dw #0x0088
	.dw #0x0083
	.dw #0x007e
	.dw #0x0078
	.dw #0x0073
	.dw #0x006d
	.dw #0x0067
	.dw #0x0062
	.dw #0x005c
	.dw #0x0056
	.dw #0x0050
	.dw #0x004a
	.dw #0x0044
	.dw #0x003e
	.dw #0x0038
	.dw #0x0032
	.dw #0x002c
	.dw #0x0026
	.dw #0x001f
	.dw #0x0019
	.dw #0x0013
	.dw #0x000d
	.dw #0x0006
	.dw #0x0000
	.dw #0xfffa
	.dw #0xfff3
	.dw #0xffed
	.dw #0xffe7
	.dw #0xffe1
	.dw #0xffda
	.dw #0xffd4
	.dw #0xffce
	.dw #0xffc8
	.dw #0xffc2
	.dw #0xffbc
	.dw #0xffb6
	.dw #0xffb0
	.dw #0xffaa
	.dw #0xffa4
	.dw #0xff9e
	.dw #0xff99
	.dw #0xff93
	.dw #0xff8d
	.dw #0xff88
	.dw #0xff82
	.dw #0xff7d
	.dw #0xff78
	.dw #0xff72
	.dw #0xff6d
	.dw #0xff68
	.dw #0xff63
	.dw #0xff5e
	.dw #0xff59
	.dw #0xff55
	.dw #0xff50
	.dw #0xff4c
	.dw #0xff47
	.dw #0xff43
	.dw #0xff3f
	.dw #0xff3b
	.dw #0xff37
	.dw #0xff33
	.dw #0xff30
	.dw #0xff2c
	.dw #0xff29
	.dw #0xff25
	.dw #0xff22
	.dw #0xff1f
	.dw #0xff1c
	.dw #0xff19
	.dw #0xff17
	.dw #0xff14
	.dw #0xff12
	.dw #0xff10
	.dw #0xff0e
	.dw #0xff0c
	.dw #0xff0a
	.dw #0xff09
	.dw #0xff07
	.dw #0xff06
	.dw #0xff05
	.dw #0xff04
	.dw #0xff03
	.dw #0xff02
	.dw #0xff02
	.dw #0xff01
	.dw #0xff01
	.dw #0xff00
	.dw #0xff01
	.dw #0xff01
	.dw #0xff02
	.dw #0xff02
	.dw #0xff03
	.dw #0xff04
	.dw #0xff05
	.dw #0xff06
	.dw #0xff07
	.dw #0xff09
	.dw #0xff0a
	.dw #0xff0c
	.dw #0xff0e
	.dw #0xff10
	.dw #0xff12
	.dw #0xff14
	.dw #0xff17
	.dw #0xff19
	.dw #0xff1c
	.dw #0xff1f
	.dw #0xff22
	.dw #0xff25
	.dw #0xff29
	.dw #0xff2c
	.dw #0xff30
	.dw #0xff33
	.dw #0xff37
	.dw #0xff3b
	.dw #0xff3f
	.dw #0xff43
	.dw #0xff47
	.dw #0xff4c
	.dw #0xff50
	.dw #0xff55
	.dw #0xff59
	.dw #0xff5e
	.dw #0xff63
	.dw #0xff68
	.dw #0xff6d
	.dw #0xff72
	.dw #0xff78
	.dw #0xff7d
	.dw #0xff82
	.dw #0xff88
	.dw #0xff8d
	.dw #0xff93
	.dw #0xff99
	.dw #0xff9e
	.dw #0xffa4
	.dw #0xffaa
	.dw #0xffb0
	.dw #0xffb6
	.dw #0xffbc
	.dw #0xffc2
	.dw #0xffc8
	.dw #0xffce
	.dw #0xffd4
	.dw #0xffda
	.dw #0xffe1
	.dw #0xffe7
	.dw #0xffed
	.dw #0xfff3
	.dw #0xfffa
;main.c:32: int16_t get_cos(uint8_t a) { return sin_lut[(uint8_t)(a + 64)]; }
;	---------------------------------
; Function get_cos
; ---------------------------------
_get_cos::
	ld	bc, #_sin_lut+0
	add	a, #0x40
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, bc
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ret
;main.c:39: void update_cube(uint8_t angle_x, uint8_t angle_y) {
;	---------------------------------
; Function update_cube
; ---------------------------------
_update_cube::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-31
	add	iy, sp
	ld	sp, iy
	ld	h, a
;main.c:43: int16_t s_x = get_sin(angle_x);
	push	hl
	ld	a, h
	call	_get_sin
	ld	-15 (ix), e
	ld	-14 (ix), d
	pop	hl
;main.c:44: int16_t c_x = get_cos(angle_x);
	push	hl
	ld	a, h
	call	_get_cos
	ld	-13 (ix), e
	ld	-12 (ix), d
	pop	hl
;main.c:45: int16_t s_y = get_sin(angle_y);
	push	hl
	ld	a, l
	call	_get_sin
	ld	-11 (ix), e
	ld	-10 (ix), d
	pop	hl
;main.c:46: int16_t c_y = get_cos(angle_y);
	ld	a, l
	call	_get_cos
	ld	-9 (ix), e
	ld	-8 (ix), d
;main.c:48: for(uint8_t i = 0; i < 8; i++) {
	ld	-1 (ix), #0x00
00108$:
	ld	a, -1 (ix)
	sub	a, #0x08
	jp	NC, 00101$
;main.c:50: int16_t y_rot = (cube_vertices[i].y * c_x - cube_vertices[i].z * s_x) >> 8;
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	de, #_cube_vertices
	add	hl, de
	ld	-7 (ix), l
	ld	-6 (ix), h
	inc	hl
	inc	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ld	e, -13 (ix)
	ld	d, -12 (ix)
	ld	l, c
	ld	h, b
	call	__mulint
	ld	-3 (ix), e
	ld	-2 (ix), d
	pop	bc
	ld	e, -7 (ix)
	ld	d, -6 (ix)
	ld	hl, #4
	add	hl, de
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	ld	e, -15 (ix)
	ld	d, -14 (ix)
	call	__mulint
	pop	bc
	pop	hl
	ld	a, -3 (ix)
	sub	a, e
	ld	a, -2 (ix)
	sbc	a, d
	ld	d, a
	ld	-5 (ix), d
	ld	a, d
	rlca
	sbc	a, a
	ld	-4 (ix), a
;main.c:51: int16_t z_tmp = (cube_vertices[i].y * s_x + cube_vertices[i].z * c_x) >> 8;
	push	hl
	ld	e, -15 (ix)
	ld	d, -14 (ix)
	ld	l, c
	ld	h, b
	call	__mulint
	ld	c, e
	ld	b, d
	pop	hl
	push	bc
	ld	e, -13 (ix)
	ld	d, -12 (ix)
	call	__mulint
	pop	bc
	ex	de, hl
	add	hl, bc
	ld	-3 (ix), h
	ld	a, h
	rlca
	sbc	a, a
	ld	-2 (ix), a
;main.c:54: int16_t x_rot = (cube_vertices[i].x * c_y + z_tmp * s_y) >> 8;
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ld	e, -9 (ix)
	ld	d, -8 (ix)
	ld	l, c
	ld	h, b
	call	__mulint
	ex	de, hl
	pop	bc
	push	hl
	push	bc
	ld	e, -11 (ix)
	ld	d, -10 (ix)
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	call	__mulint
	pop	bc
	pop	hl
	add	hl, de
	ld	l, h
	ld	a, l
	rlca
	sbc	a, a
	ld	h, a
;main.c:55: int16_t z_rot = (-cube_vertices[i].x * s_y + z_tmp * c_y) >> 8;
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	push	hl
	ld	e, -11 (ix)
	ld	d, -10 (ix)
	ld	l, c
	ld	h, a
	call	__mulint
	push	de
	ld	e, -9 (ix)
	ld	d, -8 (ix)
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	call	__mulint
	pop	bc
	pop	hl
	ld	a, e
	add	a, c
	ld	a, d
	adc	a, b
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
;main.c:58: z_rot += 128; 
	ld	a, e
	add	a, #0x80
	ld	e, a
	jr	NC, 00188$
	inc	d
00188$:
;main.c:59: new_projected[i].x = 80 + (x_rot * 64 / z_rot);
	ld	c, -1 (ix)
	ld	b, #0x00
	sla	c
	rl	b
	ld	iy, #0
	add	iy, sp
	add	iy, bc
	push	iy
	pop	bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	push	de
	push	iy
	call	__divsint
	ex	de, hl
	pop	iy
	pop	de
	pop	bc
	ld	a, l
	add	a, #0x50
	ld	(bc), a
;main.c:60: new_projected[i].y = 60 + (y_rot * 64 / z_rot);
	push	iy
	pop	bc
	inc	bc
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	bc
	call	__divsint
	pop	bc
	ld	a, e
	add	a, #0x3c
	ld	(bc), a
;main.c:48: for(uint8_t i = 0; i < 8; i++) {
	inc	-1 (ix)
	jp	00108$
00101$:
;main.c:63: if (!first_frame) {
	ld	a, (_first_frame+0)
	or	a, a
	jr	NZ, 00127$
;main.c:64: for(uint8_t i=0; i<12; i++) {
	ld	-1 (ix), #0x00
00111$:
	ld	a, -1 (ix)
	sub	a, #0x0c
	jr	NC, 00127$
;main.c:67: old_projected[edges[i][1]].x, old_projected[edges[i][1]].y,
	ld	e, -1 (ix)
	ld	d, #0x00
	ex	de, hl
	add	hl, hl
	ld	de, #_edges
	add	hl, de
	ld	e, l
	ld	d, h
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	a, l
	add	a, #<(_old_projected)
	ld	c, a
	ld	a, h
	adc	a, #>(_old_projected)
	ld	b, a
	ld	l, c
	ld	h, b
	inc	hl
	ld	a, (hl)
	ld	-5 (ix), a
	ld	-4 (ix), #0x00
	ld	a, (bc)
	ld	-3 (ix), a
	ld	-2 (ix), #0x00
;main.c:66: old_projected[edges[i][0]].x, old_projected[edges[i][0]].y,
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl,#_old_projected + 1
	add	hl,bc
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #_old_projected
	add	hl, bc
	ld	l, (hl)
	ld	h, #0x00
	ld	bc, #0x0000
	push	bc
	ld	c, -5 (ix)
	ld	b, #0x00
	push	bc
	ld	c, -3 (ix)
	ld	b, #0x00
	push	bc
	call	_vga_drawLine
;main.c:64: for(uint8_t i=0; i<12; i++) {
	inc	-1 (ix)
	jr	00111$
;main.c:74: for(uint8_t i=0; i<12; i++) {
00127$:
	ld	-1 (ix), #0x00
00114$:
	ld	a, -1 (ix)
	sub	a, #0x0c
	jr	NC, 00105$
;main.c:77: new_projected[edges[i][1]].x, new_projected[edges[i][1]].y,
	ld	l, -1 (ix)
	ld	h, #0x00
	add	hl, hl
	ld	iy, #_edges
	ex	de, hl
	add	iy, de
	push	iy
	pop	hl
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #0
	add	hl, sp
	add	hl, bc
	ld	c,l
	ld	b,h
	inc	hl
	ld	e, (hl)
	ld	d, #0x00
	ld	a, (bc)
	ld	-3 (ix), a
	ld	-2 (ix), #0x00
;main.c:76: new_projected[edges[i][0]].x, new_projected[edges[i][0]].y,
	ld	l, 0 (iy)
	ld	h, #0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #0
	add	hl, sp
	add	hl, bc
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	ld	iy, #0
	add	iy, sp
	add	iy, bc
	ld	c, 0 (iy)
	xor	a, a
	ld	iy, #0x01ff
	push	iy
	push	de
	ld	e, -3 (ix)
	ld	d, #0x00
	ex	de, hl
	push	hl
	ld	l, c
	ld	h, a
	call	_vga_drawLine
;main.c:74: for(uint8_t i=0; i<12; i++) {
	inc	-1 (ix)
	jr	00114$
00105$:
;main.c:83: for(uint8_t i=0; i<8; i++) {
	ld	bc, #_old_projected+0
	ld	e, #0x00
00117$:
	ld	a, e
	sub	a, #0x08
	jr	NC, 00106$
;main.c:84: old_projected[i] = new_projected[i];
	ld	l, e
	ld	h, #0x00
	add	hl, hl
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	l, -4 (ix)
	ld	h, #0x00
	add	hl, bc
	ld	-2 (ix), l
	ld	-1 (ix), h
	push	de
	ld	e, -4 (ix)
	ld	d, #0x00
	ld	hl, #2
	add	hl, sp
	add	hl, de
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	ldi
	ld	a, (hl)
	ld	(de), a
	inc	bc
	pop	de
;main.c:83: for(uint8_t i=0; i<8; i++) {
	inc	e
	jr	00117$
00106$:
;main.c:86: first_frame = 0;
	xor	a, a
	ld	(_first_frame+0), a
;main.c:87: }
	ld	sp, ix
	pop	ix
	ret
;main.c:92: void test_sd_card(void) {
;	---------------------------------
; Function test_sd_card
; ---------------------------------
_test_sd_card::
;main.c:94: vga_set_cursor(20, 10);
	ld	de, #0x000a
	ld	hl, #0x0014
	call	_vga_set_cursor
;main.c:95: vga_Print("Inizializzazione SD in corso...\n");
	ld	hl, #___str_0
	call	_vga_Print
;main.c:97: if (!sd_wait_ready()) {
	call	_sd_wait_ready
	or	a, a
	jr	NZ, 00102$
;main.c:98: vga_Print("ERRORE: SD non risponde o timeout!\n");
	ld	hl, #___str_1
	call	_vga_Print
;main.c:99: vga_print_int(SDSTATUS); // Stampa lo stato per debug
	ld	hl, #0xc011
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #0x0000
	call	_vga_print_int
;main.c:100: vga_Print("\n");
;main.c:101: return;
	ld	hl, #___str_2
	jp	_vga_Print
00102$:
;main.c:103: vga_Print("SD Pronta!\n");
	ld	hl, #___str_3
	call	_vga_Print
;main.c:104: vga_setTextColor(BLUE, 0x0000);
	ld	de, #0x0000
	ld	hl, #0x01c0
	call	_vga_setTextColor
;main.c:105: vga_Print("Invio comando...\n");
	ld	hl, #___str_4
	call	_vga_Print
;main.c:109: uint8_t s = SDSTATUS;
	ld	hl, #0xc011
	ld	c, (hl)
;main.c:110: vga_Print("Stato post-comando: ");
	push	bc
	ld	hl, #___str_5
	call	_vga_Print
	pop	bc
;main.c:111: vga_print_hex8(s);
	ld	a, c
	call	_vga_print_hex8
;main.c:114: vga_Print("Lettura settore 0...\n");
	ld	hl, #___str_6
	call	_vga_Print
;main.c:115: if (sd_read_sector(3600, sector_buffer)) {
	ld	hl, #_sector_buffer
	push	hl
	ld	de, #0x0e10
	ld	hl, #0x0000
	call	_sd_read_sector
	or	a, a
	jr	Z, 00105$
;main.c:116: vga_Print("Settore letto con successo. Primi 16 byte:\n");
	ld	hl, #___str_7
	call	_vga_Print
;main.c:118: for (int i = 0; i < 16; i++) {
	ld	c, #0x00
00111$:
	ld	a, c
	sub	a, #0x10
	jr	NC, 00103$
;main.c:120: uint8_t byte = sector_buffer[i];
	ld	hl, #_sector_buffer
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
;main.c:121: vga_print_hex8(byte);
	push	bc
	call	_vga_print_hex8
;main.c:122: vga_Print(", ");
	ld	hl, #___str_8
	call	_vga_Print
	pop	bc
;main.c:118: for (int i = 0; i < 16; i++) {
	inc	c
	jr	00111$
00103$:
;main.c:124: vga_Print("\n");
	ld	hl, #___str_2
	call	_vga_Print
	jr	00106$
00105$:
;main.c:126: vga_Print("ERRORE durante la lettura!\n");
;main.c:127: return;
	ld	hl, #___str_9
	jp	_vga_Print
00106$:
;main.c:131: sector_buffer[0] = 0xD1;
	ld	hl, #_sector_buffer
	ld	(hl), #0xd1
;main.c:132: sector_buffer[1] = 0x0C;
	inc	hl
	ld	(hl), #0x0c
;main.c:133: sector_buffer[2] = 0xA7;
	ld	hl, #_sector_buffer + 2
	ld	(hl), #0xa7
;main.c:134: sector_buffer[3] = 0xE0;
	ld	hl, #_sector_buffer + 3
	ld	(hl), #0xe0
;main.c:135: sector_buffer[4] = 0x10;
	ld	hl, #_sector_buffer + 4
	ld	(hl), #0x10
;main.c:136: sector_buffer[5] = 0x20;
	ld	hl, #_sector_buffer + 5
	ld	(hl), #0x20
;main.c:137: sector_buffer[6] = 0x40;
	ld	hl, #_sector_buffer + 6
	ld	(hl), #0x40
;main.c:138: sector_buffer[7] = 0x80;
	ld	hl, #_sector_buffer + 7
	ld	(hl), #0x80
;main.c:139: sector_buffer[8] = 0xFF;
	ld	hl, #_sector_buffer + 8
	ld	(hl), #0xff
;main.c:143: vga_Print("Scrittura settore 100 per test...\n");
	ld	hl, #___str_10
	call	_vga_Print
;main.c:144: if (sd_write_sector(100, sector_buffer)) {
	ld	hl, #_sector_buffer
	push	hl
	ld	de, #0x0064
	ld	hl, #0x0000
	call	_sd_write_sector
	or	a, a
	jr	Z, 00108$
;main.c:145: vga_Print("Scrittura completata!\n");
	ld	hl, #___str_11
	jp	_vga_Print
00108$:
;main.c:147: vga_Print("ERRORE durante la scrittura!\n");
	ld	hl, #___str_12
;main.c:149: }
	jp	_vga_Print
___str_0:
	.ascii "Inizializzazione SD in corso..."
	.db 0x0a
	.db 0x00
___str_1:
	.ascii "ERRORE: SD non risponde o timeout!"
	.db 0x0a
	.db 0x00
___str_2:
	.db 0x0a
	.db 0x00
___str_3:
	.ascii "SD Pronta!"
	.db 0x0a
	.db 0x00
___str_4:
	.ascii "Invio comando..."
	.db 0x0a
	.db 0x00
___str_5:
	.ascii "Stato post-comando: "
	.db 0x00
___str_6:
	.ascii "Lettura settore 0..."
	.db 0x0a
	.db 0x00
___str_7:
	.ascii "Settore letto con successo. Primi 16 byte:"
	.db 0x0a
	.db 0x00
___str_8:
	.ascii ", "
	.db 0x00
___str_9:
	.ascii "ERRORE durante la lettura!"
	.db 0x0a
	.db 0x00
___str_10:
	.ascii "Scrittura settore 100 per test..."
	.db 0x0a
	.db 0x00
___str_11:
	.ascii "Scrittura completata!"
	.db 0x0a
	.db 0x00
___str_12:
	.ascii "ERRORE durante la scrittura!"
	.db 0x0a
	.db 0x00
;main.c:158: void draw_mandelbrot() {
;	---------------------------------
; Function draw_mandelbrot
; ---------------------------------
_draw_mandelbrot::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-41
	add	hl, sp
	ld	sp, hl
;main.c:159: vga_clear_screen(BLACK);
	ld	hl, #0x0000
	call	_vga_clear_screen
;main.c:170: int32_t re_step = alu_div(alu_sub(max_re, min_re), WIDTH);
	ld	hl, #0xfffe
	push	hl
	ld	hl, #0x0000
	push	hl
	ld	de, #0x0000
	ld	l, #0x01
	call	_alu_sub
	pop	af
	pop	af
	ld	bc, #0x0000
	push	bc
	ld	bc, #0x0140
	push	bc
	call	_alu_div
	pop	af
	pop	af
	inc	sp
	inc	sp
	push	de
	ld	-39 (ix), l
	ld	-38 (ix), h
;main.c:171: int32_t im_step = alu_div(alu_sub(max_im, min_im), HEIGHT);
	ld	hl, #0xfffe
	push	hl
	ld	hl, #0xcccd
	push	hl
	ld	de, #0x3333
	ld	hl, #0x0001
	call	_alu_sub
	pop	af
	pop	af
	ld	bc, #0x0000
	push	bc
	ld	c, #0xf0
	push	bc
	call	_alu_div
	pop	af
	pop	af
	ld	-37 (ix), e
	ld	-36 (ix), d
	ld	-35 (ix), l
	ld	-34 (ix), h
;main.c:173: int32_t ci = min_im;
	ld	-33 (ix), #0xcd
	ld	-32 (ix), #0xcc
	ld	-31 (ix), #0xfe
	ld	-30 (ix), #0xff
;main.c:174: for (uint16_t y = 0; y < HEIGHT; y++) {
	xor	a, a
	ld	-6 (ix), a
	ld	-5 (ix), a
00114$:
	ld	c, -6 (ix)
	ld	b, -5 (ix)
	ld	a, c
	sub	a, #0xf0
	ld	a, b
	sbc	a, #0x00
	jp	NC, 00116$
;main.c:175: int32_t cr = min_re;
	xor	a, a
	ld	-29 (ix), a
	ld	-28 (ix), a
	ld	-27 (ix), #0xfe
	ld	-26 (ix), #0xff
;main.c:176: for (uint16_t x = 0; x < WIDTH; x++) {
	xor	a, a
	ld	-4 (ix), a
	ld	-3 (ix), a
00111$:
	ld	a, -4 (ix)
	ld	-2 (ix), a
	ld	a, -3 (ix)
	ld	-1 (ix), a
	ld	a, -2 (ix)
	sub	a, #0x40
	ld	a, -1 (ix)
	sbc	a, #0x01
	jp	NC, 00108$
;main.c:177: int32_t zr = 0;
	xor	a, a
	ld	-25 (ix), a
	ld	-24 (ix), a
	ld	-23 (ix), a
	ld	-22 (ix), a
;main.c:178: int32_t zi = 0;
	xor	a, a
	ld	-21 (ix), a
	ld	-20 (ix), a
	ld	-19 (ix), a
	ld	-18 (ix), a
;main.c:181: while (iter < 32) {
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
00103$:
	ld	a, -2 (ix)
	ld	-17 (ix), a
	ld	a, -1 (ix)
	ld	-16 (ix), a
	ld	a, -17 (ix)
	sub	a, #0x20
	ld	a, -16 (ix)
	sbc	a, #0x00
	ld	a, #0x00
	rla
	ld	-15 (ix), a
	or	a, a
	jp	Z, 00105$
;main.c:183: int32_t zr2 = alu_mul_fp(zr, zr);
	ld	l, -23 (ix)
	ld	h, -22 (ix)
	push	hl
	ld	l, -25 (ix)
	ld	h, -24 (ix)
	push	hl
	ld	e, -25 (ix)
	ld	d, -24 (ix)
	ld	l, -23 (ix)
	ld	h, -22 (ix)
	call	_alu_mul_fp
	pop	af
	pop	af
	ld	-14 (ix), e
	ld	-13 (ix), d
	ld	-12 (ix), l
	ld	-11 (ix), h
;main.c:184: int32_t zi2 = alu_mul_fp(zi, zi);
	ld	l, -19 (ix)
	ld	h, -18 (ix)
	push	hl
	ld	l, -21 (ix)
	ld	h, -20 (ix)
	push	hl
	ld	e, -21 (ix)
	ld	d, -20 (ix)
	ld	l, -19 (ix)
	ld	h, -18 (ix)
	call	_alu_mul_fp
	pop	af
	pop	af
	ld	-10 (ix), e
	ld	-9 (ix), d
;main.c:187: if (alu_add(zr2, zi2) > FP_4) break;
	ld	-8 (ix), l
	ld	-7 (ix), h
	push	hl
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	push	hl
	ld	e, -14 (ix)
	ld	d, -13 (ix)
	ld	l, -12 (ix)
	ld	h, -11 (ix)
	call	_alu_add
	pop	af
	pop	af
	xor	a, a
	cp	a, e
	sbc	a, d
	ld	a, #0x04
	sbc	a, l
	ld	a, #0x00
	sbc	a, h
	jp	PO, 00195$
	xor	a, #0x80
00195$:
	jp	M, 00105$
;main.c:192: int32_t zrzi = alu_mul_fp(zr, zi);
	ld	l, -19 (ix)
	ld	h, -18 (ix)
	push	hl
	ld	l, -21 (ix)
	ld	h, -20 (ix)
	push	hl
	ld	e, -25 (ix)
	ld	d, -24 (ix)
	ld	l, -23 (ix)
	ld	h, -22 (ix)
	call	_alu_mul_fp
	pop	af
	pop	af
	ld	-18 (ix), e
	ld	-17 (ix), d
	ld	-16 (ix), l
	ld	-15 (ix), h
;main.c:194: zi = alu_add(alu_shl(zrzi, 1), ci);
	ld	a, #0x01
	push	af
	inc	sp
	ld	e, -18 (ix)
	ld	d, -17 (ix)
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	call	_alu_shl
	ld	-18 (ix), e
	ld	-17 (ix), d
	ld	-16 (ix), l
	ld	-15 (ix), h
	inc	sp
	ld	l, -31 (ix)
	ld	h, -30 (ix)
	push	hl
	ld	l, -33 (ix)
	ld	h, -32 (ix)
	push	hl
	ld	e, -18 (ix)
	ld	d, -17 (ix)
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	call	_alu_add
	pop	af
	pop	af
	ld	-21 (ix), e
	ld	-20 (ix), d
	ld	-19 (ix), l
	ld	-18 (ix), h
;main.c:197: zr = alu_add(alu_sub(zr2, zi2), cr);
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	push	hl
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	push	hl
	ld	e, -14 (ix)
	ld	d, -13 (ix)
	ld	l, -12 (ix)
	ld	h, -11 (ix)
	call	_alu_sub
	pop	af
	pop	af
	ld	-10 (ix), e
	ld	-9 (ix), d
	ld	-8 (ix), l
	ld	-7 (ix), h
	ld	l, -27 (ix)
	ld	h, -26 (ix)
	push	hl
	ld	l, -29 (ix)
	ld	h, -28 (ix)
	push	hl
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	call	_alu_add
	pop	af
	pop	af
	ld	-25 (ix), e
	ld	-24 (ix), d
	ld	-23 (ix), l
	ld	-22 (ix), h
;main.c:199: iter++;
	inc	-2 (ix)
	jp	NZ, 00103$
	inc	-1 (ix)
	jp	00103$
00105$:
;main.c:203: if (iter < 32) {
	ld	a, -15 (ix)
	or	a, a
	jr	Z, 00107$
;main.c:205: uint8_t color = (iter < 8) ? BLUE : (iter < 16) ? CYAN : YELLOW;
	ld	a, -17 (ix)
	sub	a, #0x08
	jr	NC, 00118$
	ld	-2 (ix), #0xc0
	ld	-1 (ix), #0x01
	jr	00119$
00118$:
	ld	a, -17 (ix)
	sub	a, #0x10
	jr	NC, 00120$
	ld	-2 (ix), #0xf8
	ld	-1 (ix), #0x01
	jr	00121$
00120$:
	ld	-2 (ix), #0x3f
	ld	-1 (ix), #0
00121$:
00119$:
	ld	a, -2 (ix)
;main.c:206: vga_pixel_fast(x, y, color);
	ld	-1 (ix), a
	ld	-2 (ix), a
	ld	-1 (ix), #0x00
	ld	l, -2 (ix)
	ld	h, #0x00
	push	hl
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	call	_vga_pixel_fast
00107$:
;main.c:209: cr = alu_add(cr, re_step);
	pop	de
	pop	hl
	ex	de, hl
	push	de
	push	hl
	push	de
	push	hl
	ld	e, -29 (ix)
	ld	d, -28 (ix)
	ld	l, -27 (ix)
	ld	h, -26 (ix)
	call	_alu_add
	pop	af
	pop	af
	ld	-29 (ix), e
	ld	-28 (ix), d
	ld	-27 (ix), l
	ld	-26 (ix), h
;main.c:176: for (uint16_t x = 0; x < WIDTH; x++) {
	inc	-4 (ix)
	jp	NZ, 00111$
	inc	-3 (ix)
	jp	00111$
00108$:
;main.c:211: ci = alu_add(ci, im_step);
	ld	l, -35 (ix)
	ld	h, -34 (ix)
	push	hl
	ld	l, -37 (ix)
	ld	h, -36 (ix)
	push	hl
	ld	e, -33 (ix)
	ld	d, -32 (ix)
	ld	l, -31 (ix)
	ld	h, -30 (ix)
	call	_alu_add
	pop	af
	pop	af
	ld	-33 (ix), e
	ld	-32 (ix), d
	ld	-31 (ix), l
	ld	-30 (ix), h
;main.c:174: for (uint16_t y = 0; y < HEIGHT; y++) {
	inc	-6 (ix)
	jp	NZ, 00114$
	inc	-5 (ix)
	jp	00114$
00116$:
;main.c:213: }
	ld	sp, ix
	pop	ix
	ret
;main.c:215: int main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	af
;main.c:218: video_config(0, 1);
	ld	l, #0x01
	xor	a, a
	call	_video_config
;main.c:219: vga_clear_screen(BLACK); // Nero
	ld	hl, #0x0000
	call	_vga_clear_screen
;main.c:221: vga_setTextFont(2);
	ld	a, #0x02
	call	_vga_setTextFont
;main.c:222: vga_setTextSize(1);
	ld	a, #0x01
	call	_vga_setTextSize
;main.c:223: vga_setTextColor(YELLOW, 0x0000);
	ld	de, #0x0000
	ld	hl, #0x003f
	call	_vga_setTextColor
;main.c:225: vga_set_cursor(0, 10);
	ld	de, #0x000a
	ld	hl, #0x0000
	call	_vga_set_cursor
;main.c:248: vga_load_rgb333_full(1000);
	ld	de, #0x03e8
	ld	hl, #0x0000
	call	_vga_load_rgb333_full
;main.c:267: while (1)
00102$:
	jr	00102$
;main.c:287: while (1)
;main.c:294: }
	pop	af
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__first_frame:
	.db #0x01	; 1
	.area _CABS (ABS)
