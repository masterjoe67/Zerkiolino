;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module video
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _vga_fillRect_fast
	.globl _vga_drawCharGL
	.globl _test_fill
	.globl _swap_int16
	.globl _strlen
	.globl _abs
	.globl _textwrap
	.globl __rotation
	.globl __height
	.globl __width
	.globl _rotation
	.globl _textdatum
	.globl _textsize
	.globl _textfont
	.globl _padX
	.globl _win_ye
	.globl _win_xe
	.globl _cursor_y
	.globl _cursor_x
	.globl _addr_col
	.globl _addr_row
	.globl _fontsloaded
	.globl _textbgcolor
	.globl _textcolor
	.globl _chrtbl_f16
	.globl _widtbl_f16
	.globl _chr_f16_7F
	.globl _chr_f16_7E
	.globl _chr_f16_7D
	.globl _chr_f16_7C
	.globl _chr_f16_7B
	.globl _chr_f16_7A
	.globl _chr_f16_79
	.globl _chr_f16_78
	.globl _chr_f16_77
	.globl _chr_f16_76
	.globl _chr_f16_75
	.globl _chr_f16_74
	.globl _chr_f16_73
	.globl _chr_f16_72
	.globl _chr_f16_71
	.globl _chr_f16_70
	.globl _chr_f16_6F
	.globl _chr_f16_6E
	.globl _chr_f16_6D
	.globl _chr_f16_6C
	.globl _chr_f16_6B
	.globl _chr_f16_6A
	.globl _chr_f16_69
	.globl _chr_f16_68
	.globl _chr_f16_67
	.globl _chr_f16_66
	.globl _chr_f16_65
	.globl _chr_f16_64
	.globl _chr_f16_63
	.globl _chr_f16_62
	.globl _chr_f16_61
	.globl _chr_f16_60
	.globl _chr_f16_5F
	.globl _chr_f16_5E
	.globl _chr_f16_5D
	.globl _chr_f16_5C
	.globl _chr_f16_5B
	.globl _chr_f16_5A
	.globl _chr_f16_59
	.globl _chr_f16_58
	.globl _chr_f16_57
	.globl _chr_f16_56
	.globl _chr_f16_55
	.globl _chr_f16_54
	.globl _chr_f16_53
	.globl _chr_f16_52
	.globl _chr_f16_51
	.globl _chr_f16_50
	.globl _chr_f16_4F
	.globl _chr_f16_4E
	.globl _chr_f16_4D
	.globl _chr_f16_4C
	.globl _chr_f16_4B
	.globl _chr_f16_4A
	.globl _chr_f16_49
	.globl _chr_f16_48
	.globl _chr_f16_47
	.globl _chr_f16_46
	.globl _chr_f16_45
	.globl _chr_f16_44
	.globl _chr_f16_43
	.globl _chr_f16_42
	.globl _chr_f16_41
	.globl _chr_f16_40
	.globl _chr_f16_3F
	.globl _chr_f16_3E
	.globl _chr_f16_3D
	.globl _chr_f16_3C
	.globl _chr_f16_3B
	.globl _chr_f16_3A
	.globl _chr_f16_39
	.globl _chr_f16_38
	.globl _chr_f16_37
	.globl _chr_f16_36
	.globl _chr_f16_35
	.globl _chr_f16_34
	.globl _chr_f16_33
	.globl _chr_f16_32
	.globl _chr_f16_31
	.globl _chr_f16_30
	.globl _chr_f16_2F
	.globl _chr_f16_2E
	.globl _chr_f16_2D
	.globl _chr_f16_2C
	.globl _chr_f16_2B
	.globl _chr_f16_2A
	.globl _chr_f16_29
	.globl _chr_f16_28
	.globl _chr_f16_27
	.globl _chr_f16_26
	.globl _chr_f16_25
	.globl _chr_f16_24
	.globl _chr_f16_23
	.globl _chr_f16_22
	.globl _chr_f16_21
	.globl _chr_f16_20
	.globl _video_config
	.globl _vga_set_cursor
	.globl _vga_setTextFont
	.globl _vga_setTextSize
	.globl _vga_setTextColor
	.globl _vga_pixel_fast
	.globl _vga_clear_screen
	.globl _vga_fillRect
	.globl _vga_drawChar
	.globl _vga_printAt
	.globl _vga_drawFastHLine
	.globl _vga_drawFastVLine
	.globl _vga_drawRect
	.globl _vga_fillCircle
	.globl _vga_drawLine
	.globl _vga_printCenteredX
	.globl _vga_FillTriangle
	.globl _vga_Print
	.globl _vga_Print_int16
	.globl _vga_print_float
	.globl _vga_print_hex8
	.globl _vga_print_int
	.globl _vga_print_int_safe
	.globl _vga_write
	.globl _vga_drawLine_Clipped
	.globl _draw_rgb_bars
	.globl _vga_set_display_page
	.globl _vga_set_work_page
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_textcolor::
	.ds 2
_textbgcolor::
	.ds 2
_fontsloaded::
	.ds 2
_addr_row::
	.ds 2
_addr_col::
	.ds 2
_cursor_x::
	.ds 2
_cursor_y::
	.ds 2
_win_xe::
	.ds 2
_win_ye::
	.ds 2
_padX::
	.ds 2
_textfont::
	.ds 1
_textsize::
	.ds 1
_textdatum::
	.ds 1
_rotation::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
__width::
	.ds 2
__height::
	.ds 2
__rotation::
	.ds 1
_textwrap::
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
_chr_f16_20:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_21:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_22:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0xa0	; 160
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_23:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0xff	; 255
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0xff	; 255
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_24:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x70	; 112	'p'
	.db #0x40	; 64
	.db #0x70	; 112	'p'
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_25:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x61	; 97	'a'
	.db #0x91	; 145
	.db #0x92	; 146
	.db #0x64	; 100	'd'
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x26	; 38
	.db #0x49	; 73	'I'
	.db #0x89	; 137
	.db #0x86	; 134
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_26:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x52	; 82	'R'
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x73	; 115	's'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_27:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_28:
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x0c	; 12
_chr_f16_29:
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0xc0	; 192
_chr_f16_2A:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x92	; 146
	.db #0x54	; 84	'T'
	.db #0x38	; 56	'8'
	.db #0x54	; 84	'T'
	.db #0x92	; 146
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_2B:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xf8	; 248
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_2C:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x00	; 0
_chr_f16_2D:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_2E:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_2F:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_30:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_31:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x30	; 48	'0'
	.db #0x50	; 80	'P'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_32:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x82	; 130
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x18	; 24
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_33:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x84	; 132
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x38	; 56	'8'
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x84	; 132
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_34:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x14	; 20
	.db #0x24	; 36
	.db #0x44	; 68	'D'
	.db #0x84	; 132
	.db #0xfe	; 254
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_35:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x84	; 132
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_36:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xb8	; 184
	.db #0xc4	; 196
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_37:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_38:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_39:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x46	; 70	'F'
	.db #0x3a	; 58
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_3A:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_3B:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_3C:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_3D:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_3E:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_3F:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x82	; 130
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_40:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x99	; 153
	.db #0xa5	; 165
	.db #0xa5	; 165
	.db #0xa5	; 165
	.db #0xa5	; 165
	.db #0x9e	; 158
	.db #0x40	; 64
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_41:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_42:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x84	; 132
	.db #0x82	; 130
	.db #0x84	; 132
	.db #0xf8	; 248
	.db #0x84	; 132
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x84	; 132
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_43:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_44:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x84	; 132
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x84	; 132
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_45:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xfc	; 252
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_46:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xf8	; 248
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_47:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x9c	; 156
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_48:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0xfc	; 252
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_49:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_4A:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_4B:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x88	; 136
	.db #0x90	; 144
	.db #0xa0	; 160
	.db #0xc0	; 192
	.db #0xa0	; 160
	.db #0x90	; 144
	.db #0x88	; 136
	.db #0x84	; 132
	.db #0x82	; 130
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_4C:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_4D:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0x80	; 128
	.db #0xc1	; 193
	.db #0x80	; 128
	.db #0xa2	; 162
	.db #0x80	; 128
	.db #0xa2	; 162
	.db #0x80	; 128
	.db #0x94	; 148
	.db #0x80	; 128
	.db #0x94	; 148
	.db #0x80	; 128
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_4E:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc2	; 194
	.db #0xc2	; 194
	.db #0xa2	; 162
	.db #0xa2	; 162
	.db #0x92	; 146
	.db #0x92	; 146
	.db #0x8a	; 138
	.db #0x8a	; 138
	.db #0x86	; 134
	.db #0x86	; 134
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_4F:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_50:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x84	; 132
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x84	; 132
	.db #0xf8	; 248
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_51:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x08	; 8
	.db #0x06	; 6
	.db #0x00	; 0
_chr_f16_52:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x84	; 132
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x84	; 132
	.db #0xf8	; 248
	.db #0x90	; 144
	.db #0x88	; 136
	.db #0x84	; 132
	.db #0x82	; 130
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_53:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x82	; 130
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0x1c	; 28
	.db #0x02	; 2
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_54:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_55:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_56:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_57:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0x49	; 73	'I'
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_58:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x28	; 40
	.db #0x44	; 68	'D'
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_59:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_5A:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_5B:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_5C:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_5D:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_5E:
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x28	; 40
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
_chr_f16_5F:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
_chr_f16_60:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_61:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x74	; 116	't'
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x74	; 116	't'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_62:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xb0	; 176
	.db #0xc8	; 200
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0xc8	; 200
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_63:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_64:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x34	; 52	'4'
	.db #0x4c	; 76	'L'
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x4c	; 76	'L'
	.db #0x34	; 52	'4'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_65:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x84	; 132
	.db #0xf8	; 248
	.db #0x80	; 128
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_66:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x48	; 72	'H'
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xe0	; 224
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_67:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x4c	; 76	'L'
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x4c	; 76	'L'
	.db #0x34	; 52	'4'
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x70	; 112	'p'
_chr_f16_68:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xb0	; 176
	.db #0xc8	; 200
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_69:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_6A:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x90	; 144
	.db #0x60	; 96
_chr_f16_6B:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x88	; 136
	.db #0x90	; 144
	.db #0xa0	; 160
	.db #0xc0	; 192
	.db #0xa0	; 160
	.db #0x90	; 144
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_6C:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_6D:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xac	; 172
	.db #0xd2	; 210
	.db #0x92	; 146
	.db #0x92	; 146
	.db #0x92	; 146
	.db #0x92	; 146
	.db #0x92	; 146
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_6E:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0xc8	; 200
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_6F:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_70:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0xc8	; 200
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0xc8	; 200
	.db #0xb0	; 176
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
_chr_f16_71:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x34	; 52	'4'
	.db #0x4c	; 76	'L'
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x4c	; 76	'L'
	.db #0x34	; 52	'4'
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x06	; 6
_chr_f16_72:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0xc8	; 200
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_73:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0x70	; 112	'p'
	.db #0x08	; 8
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_74:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xe0	; 224
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_75:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x4c	; 76	'L'
	.db #0x34	; 52	'4'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_76:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x44	; 68	'D'
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_77:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x92	; 146
	.db #0x92	; 146
	.db #0xaa	; 170
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_78:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x50	; 80	'P'
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_79:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x4c	; 76	'L'
	.db #0x34	; 52	'4'
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x70	; 112	'p'
_chr_f16_7A:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x30	; 48	'0'
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_7B:
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x10	; 16
_chr_f16_7C:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
_chr_f16_7D:
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
_chr_f16_7E:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x32	; 50	'2'
	.db #0x4c	; 76	'L'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_chr_f16_7F:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_widtbl_f16:
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x09	; 9
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x0a	; 10
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x0a	; 10
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x09	; 9
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x05	; 5
	.db #0x08	; 8
	.db #0x06	; 6
_chrtbl_f16:
	.dw _chr_f16_20
	.dw _chr_f16_21
	.dw _chr_f16_22
	.dw _chr_f16_23
	.dw _chr_f16_24
	.dw _chr_f16_25
	.dw _chr_f16_26
	.dw _chr_f16_27
	.dw _chr_f16_28
	.dw _chr_f16_29
	.dw _chr_f16_2A
	.dw _chr_f16_2B
	.dw _chr_f16_2C
	.dw _chr_f16_2D
	.dw _chr_f16_2E
	.dw _chr_f16_2F
	.dw _chr_f16_30
	.dw _chr_f16_31
	.dw _chr_f16_32
	.dw _chr_f16_33
	.dw _chr_f16_34
	.dw _chr_f16_35
	.dw _chr_f16_36
	.dw _chr_f16_37
	.dw _chr_f16_38
	.dw _chr_f16_39
	.dw _chr_f16_3A
	.dw _chr_f16_3B
	.dw _chr_f16_3C
	.dw _chr_f16_3D
	.dw _chr_f16_3E
	.dw _chr_f16_3F
	.dw _chr_f16_40
	.dw _chr_f16_41
	.dw _chr_f16_42
	.dw _chr_f16_43
	.dw _chr_f16_44
	.dw _chr_f16_45
	.dw _chr_f16_46
	.dw _chr_f16_47
	.dw _chr_f16_48
	.dw _chr_f16_49
	.dw _chr_f16_4A
	.dw _chr_f16_4B
	.dw _chr_f16_4C
	.dw _chr_f16_4D
	.dw _chr_f16_4E
	.dw _chr_f16_4F
	.dw _chr_f16_50
	.dw _chr_f16_51
	.dw _chr_f16_52
	.dw _chr_f16_53
	.dw _chr_f16_54
	.dw _chr_f16_55
	.dw _chr_f16_56
	.dw _chr_f16_57
	.dw _chr_f16_58
	.dw _chr_f16_59
	.dw _chr_f16_5A
	.dw _chr_f16_5B
	.dw _chr_f16_5C
	.dw _chr_f16_5D
	.dw _chr_f16_5E
	.dw _chr_f16_5F
	.dw _chr_f16_60
	.dw _chr_f16_61
	.dw _chr_f16_62
	.dw _chr_f16_63
	.dw _chr_f16_64
	.dw _chr_f16_65
	.dw _chr_f16_66
	.dw _chr_f16_67
	.dw _chr_f16_68
	.dw _chr_f16_69
	.dw _chr_f16_6A
	.dw _chr_f16_6B
	.dw _chr_f16_6C
	.dw _chr_f16_6D
	.dw _chr_f16_6E
	.dw _chr_f16_6F
	.dw _chr_f16_70
	.dw _chr_f16_71
	.dw _chr_f16_72
	.dw _chr_f16_73
	.dw _chr_f16_74
	.dw _chr_f16_75
	.dw _chr_f16_76
	.dw _chr_f16_77
	.dw _chr_f16_78
	.dw _chr_f16_79
	.dw _chr_f16_7A
	.dw _chr_f16_7B
	.dw _chr_f16_7C
	.dw _chr_f16_7D
	.dw _chr_f16_7E
	.dw _chr_f16_7F
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
;video.c:22: void swap_int16(int16_t *a, int16_t *b) {
;	---------------------------------
; Function swap_int16
; ---------------------------------
_swap_int16::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	ld	c, l
	ld	b, h
;video.c:23: int16_t temp = *a;
	ld	a, (bc)
	ld	-2 (ix), a
	inc	bc
	ld	a, (bc)
	ld	-1 (ix), a
	dec	bc
;video.c:24: *a = *b;
	ld	l, e
	ld	h, d
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
;video.c:25: *b = temp;
	ld	a, -2 (ix)
	ld	(de), a
	inc	de
	ld	a, -1 (ix)
	ld	(de), a
;video.c:26: }
	ld	sp, ix
	pop	ix
	ret
;video.c:30: void video_config(uint8_t video_on, uint8_t scanline_off) {
;	---------------------------------
; Function video_config
; ---------------------------------
_video_config::
;video.c:31: uint8_t ctrl = 0;
	ld	c, #0x00
;video.c:34: if (video_on)     ctrl |= VIDEO_ENABLE_BIT;   // (1 << 1)
	or	a, a
	jr	Z, 00102$
	ld	c, #0x02
00102$:
;video.c:37: if (scanline_off) ctrl |= VIDEO_SCANLINE_OFF; // (1 << 2)
	ld	a, l
	or	a, a
	jr	Z, 00104$
	set	2, c
00104$:
;video.c:41: VGA_REG_CTRL = ctrl;
	ld	hl, #0xc006
	ld	(hl), c
;video.c:42: }
	ret
;video.c:44: void vga_set_cursor(int x, int y) {
;	---------------------------------
; Function vga_set_cursor
; ---------------------------------
_vga_set_cursor::
;video.c:45: cursor_x = x;
	ld	(_cursor_x), hl
;video.c:46: cursor_y = y;
	ld	(_cursor_y), de
;video.c:47: }
	ret
;video.c:53: void vga_setTextFont(uint8_t f)
;	---------------------------------
; Function vga_setTextFont
; ---------------------------------
_vga_setTextFont::
;video.c:55: textfont = (f > 0) ? f : 1; // Don't allow font 0
	or	a, a
	jr	NZ, 00104$
	ld	a, #0x01
00104$:
	ld	(_textfont+0), a
;video.c:56: }
	ret
;video.c:62: void vga_setTextSize(uint8_t s)
;	---------------------------------
; Function vga_setTextSize
; ---------------------------------
_vga_setTextSize::
;video.c:64: if (s>7) s = 7; // Limit the maximum size multiplier so byte variables can be used for rendering
	cp	a, #0x08
	jr	C, 00102$
	ld	a, #0x07
00102$:
;video.c:65: textsize = (s > 0) ? s : 1; // Don't allow font size 0
	or	a, a
	jr	NZ, 00106$
	ld	a, #0x01
00106$:
	ld	(_textsize+0), a
;video.c:66: }
	ret
;video.c:72: void vga_setTextColor(uint16_t c, uint16_t b)
;	---------------------------------
; Function vga_setTextColor
; ---------------------------------
_vga_setTextColor::
	ld	(_textcolor), hl
	ld	(_textbgcolor), de
;video.c:75: textbgcolor = b;
;video.c:76: }
	ret
;video.c:79: void vga_pixel_fast(uint16_t x, uint16_t y, uint16_t color) {
;	---------------------------------
; Function vga_pixel_fast
; ---------------------------------
_vga_pixel_fast::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	hl
;video.c:82: while((VGA_REG_STAT & 0x01) && --timeout); 
	ld	bc, #0x2710
00102$:
	ld	a, (#0xc005)
	rrca
	jr	NC, 00104$
	dec	bc
	ld	a, b
	or	a, c
	jr	NZ, 00102$
00104$:
;video.c:84: VIDEO_REG_X_L = (uint8_t)(x & 0xFF);
	ld	a, -2 (ix)
	ld	hl, #0xc000
	ld	(hl), a
;video.c:85: VIDEO_REG_X_H = (uint8_t)((x >> 8) & 0x03);
	ld	a, -1 (ix)
	and	a, #0x03
	ld	l, #0x01
	ld	(hl), a
;video.c:86: VIDEO_REG_Y_L = (uint8_t)(y & 0xFF);
	ld	a, e
	ld	l, #0x02
	ld	(hl), a
;video.c:87: VIDEO_REG_Y_H = (uint8_t)((y >> 8) & 0x03);
	ld	a, d
	and	a, #0x03
	ld	l, #0x03
	ld	(hl), a
;video.c:89: VIDEO_REG_DATA_L = (uint8_t)(color & 0xFF);
	ld	a, 4 (ix)
	ld	l, #0x04
	ld	(hl), a
;video.c:91: VIDEO_REG_DATA_H = (uint8_t)(color >> 8); 
	ld	a, 5 (ix)
	ld	l, #0x05
	ld	(hl), a
;video.c:94: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	jp	(hl)
;video.c:97: void test_fill(void) {
;	---------------------------------
; Function test_fill
; ---------------------------------
_test_fill::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-6
	add	hl, sp
	ld	sp, hl
;video.c:98: for(uint16_t i=0; i<200; i++) {
	ld	bc, #0x0000
00107$:
	inc	sp
	inc	sp
	push	bc
	ld	a, -6 (ix)
	sub	a, #0xc8
	ld	a, -5 (ix)
	sbc	a, #0x00
	jr	NC, 00109$
;video.c:99: for(uint16_t j=0; j<200; j++) {
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
00104$:
	ld	a, -2 (ix)
	ld	-4 (ix), a
	ld	a, -1 (ix)
	ld	-3 (ix), a
	ld	a, -4 (ix)
	sub	a, #0xc8
	ld	a, -3 (ix)
	sbc	a, #0x00
	jr	NC, 00108$
;video.c:100: vga_pixel_fast(i + 300, j + 100, YELLOW); // Un bel quadrato rosso
	pop	de
	pop	hl
	push	hl
	push	de
	ld	de, #0x0064
	add	hl, de
	ex	de, hl
	ld	a, -6 (ix)
	add	a, #0x2c
	ld	l, a
	ld	a, #0x00
	adc	a, #0x01
	push	bc
	ld	bc, #0x003f
	push	bc
	ld	h, a
	call	_vga_pixel_fast
	pop	bc
;video.c:99: for(uint16_t j=0; j<200; j++) {
	inc	-2 (ix)
	jr	NZ, 00104$
	inc	-1 (ix)
	jr	00104$
00108$:
;video.c:98: for(uint16_t i=0; i<200; i++) {
	inc	bc
	jr	00107$
00109$:
;video.c:103: }
	ld	sp, ix
	pop	ix
	ret
;video.c:105: void vga_clear_screen(uint16_t color) {
;	---------------------------------
; Function vga_clear_screen
; ---------------------------------
_vga_clear_screen::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;video.c:107: uint16_t timeout = 1000;
	ld	bc, #0x03e8
;video.c:109: uint8_t color_l = (uint8_t)(color & 0xFF);
	ld	-4 (ix), l
;video.c:110: uint8_t color_h = (uint8_t)(color >> 8);
	ld	-3 (ix), h
;video.c:112: for (y = 0; y < 480; y++) {
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
00109$:
;video.c:114: VIDEO_REG_Y_L = (uint8_t)(y & 0xFF);
	ld	a, -2 (ix)
	ld	hl, #0xc002
	ld	(hl), a
;video.c:115: VIDEO_REG_Y_H = (uint8_t)((y >> 8) & 0x03);
	ld	a, -1 (ix)
	and	a, #0x03
	ld	l, #0x03
	ld	(hl), a
;video.c:117: for (x = 0; x < 640; x++) {
	ld	de, #0x0000
00107$:
;video.c:119: VIDEO_REG_X_L = (uint8_t)(x & 0xFF);
	ld	a, e
	ld	hl, #0xc000
	ld	(hl), a
;video.c:120: VIDEO_REG_X_H = (uint8_t)((x >> 8) & 0x03);
	ld	a, d
	and	a, #0x03
	ld	l, #0x01
	ld	(hl), a
;video.c:125: VIDEO_REG_DATA_L = color_l;
	ld	l, #0x04
	ld	a, -4 (ix)
	ld	(hl), a
;video.c:126: VIDEO_REG_DATA_H = color_h; 
	ld	l, #0x05
	ld	a, -3 (ix)
	ld	(hl), a
;video.c:128: while((VGA_REG_STAT & 0x01) && --timeout); 
00102$:
	ld	a, (#0xc005)
	rrca
	jr	NC, 00118$
	dec	bc
	ld	a, b
	or	a, c
	jr	NZ, 00102$
00118$:
;video.c:117: for (x = 0; x < 640; x++) {
	inc	de
	ld	l, e
	ld	h, d
	ld	a, l
	sub	a, #0x80
	ld	a, h
	sbc	a, #0x02
	jr	C, 00107$
;video.c:112: for (y = 0; y < 480; y++) {
	inc	-2 (ix)
	jr	NZ, 00152$
	inc	-1 (ix)
00152$:
	pop	hl
	pop	de
	push	de
	push	hl
	ld	a, e
	sub	a, #0xe0
	ld	a, d
	sbc	a, #0x01
	jr	C, 00109$
;video.c:131: }
	ld	sp, ix
	pop	ix
	ret
;video.c:133: void vga_fillRect(uint16_t x, uint16_t y, uint16_t w, uint16_t h, uint16_t color) {
;	---------------------------------
; Function vga_fillRect
; ---------------------------------
_vga_fillRect::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-14
	add	iy, sp
	ld	sp, iy
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-6 (ix), e
	ld	-5 (ix), d
;video.c:134: uint16_t x_end = x + w;
	ld	a, 4 (ix)
	add	a, -4 (ix)
	ld	-14 (ix), a
	ld	a, 5 (ix)
	adc	a, -3 (ix)
	ld	-13 (ix), a
;video.c:135: uint16_t y_end = y + h;
	ld	a, 6 (ix)
	add	a, -6 (ix)
	ld	-12 (ix), a
	ld	a, 7 (ix)
	adc	a, -5 (ix)
	ld	-11 (ix), a
;video.c:136: uint16_t timeout = 1000;
	ld	-10 (ix), #0xe8
	ld	-9 (ix), #0x03
;video.c:138: uint8_t color_lo = (uint8_t)(color & 0xFF);
	ld	a, 8 (ix)
	ld	-8 (ix), a
;video.c:139: uint8_t color_hi = (uint8_t)(color >> 8);
	ld	a, 9 (ix)
	ld	-7 (ix), a
;video.c:141: for (uint16_t i = y; i < y_end; i++) {
	ld	a, -6 (ix)
	ld	-2 (ix), a
	ld	a, -5 (ix)
	ld	-1 (ix), a
00117$:
	ld	a, -2 (ix)
	sub	a, -12 (ix)
	ld	a, -1 (ix)
	sbc	a, -11 (ix)
	jr	NC, 00119$
;video.c:143: while(VGA_REG_STAT & 0x01); // Attesa ACK se necessario
00101$:
	ld	a, (#0xc005)
	rrca
	jr	C, 00101$
;video.c:144: VIDEO_REG_Y_L = (uint8_t)(i & 0xFF);
	ld	a, -2 (ix)
	ld	hl, #0xc002
	ld	(hl), a
;video.c:145: VIDEO_REG_Y_H = (uint8_t)((i >> 8) & 0x03);
	ld	a, -1 (ix)
	and	a, #0x03
	ld	l, #0x03
	ld	(hl), a
;video.c:147: for (uint16_t j = x; j < x_end; j++) {
	ld	c, -4 (ix)
	ld	b, -3 (ix)
00114$:
	ld	a, c
	sub	a, -14 (ix)
	ld	a, b
	sbc	a, -13 (ix)
	jr	NC, 00118$
;video.c:150: while(VGA_REG_STAT & 0x01); 
00104$:
	ld	a, (#0xc005)
	rrca
	jr	C, 00104$
;video.c:153: VIDEO_REG_X_L = (uint8_t)(j & 0xFF);
	ld	a, c
	ld	hl, #0xc000
	ld	(hl), a
;video.c:154: VIDEO_REG_X_H = (uint8_t)((j >> 8) & 0x03);
	ld	a, b
	and	a, #0x03
	ld	l, #0x01
	ld	(hl), a
;video.c:157: VIDEO_REG_DATA_L = color_lo;
	ld	l, #0x04
	ld	a, -8 (ix)
	ld	(hl), a
;video.c:158: VIDEO_REG_DATA_H = color_hi; 
	ld	l, #0x05
	ld	a, -7 (ix)
	ld	(hl), a
;video.c:159: while((VGA_REG_STAT & 0x01) && --timeout);
	ld	e, -10 (ix)
	ld	d, -9 (ix)
00108$:
	ld	a, (#0xc005)
	rrca
	jr	NC, 00129$
	dec	de
	ld	a, d
	or	a, e
	jr	NZ, 00108$
00129$:
	ld	-10 (ix), e
	ld	-9 (ix), d
;video.c:147: for (uint16_t j = x; j < x_end; j++) {
	inc	bc
	jr	00114$
00118$:
;video.c:141: for (uint16_t i = y; i < y_end; i++) {
	inc	-2 (ix)
	jr	NZ, 00117$
	inc	-1 (ix)
	jr	00117$
00119$:
;video.c:162: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	pop	af
	jp	(hl)
;video.c:168: void vga_drawCharGL(int16_t x, int16_t y, unsigned char c, uint16_t color, uint16_t bg, uint8_t size)
;	---------------------------------
; Function vga_drawCharGL
; ---------------------------------
_vga_drawCharGL::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-28
	add	iy, sp
	ld	sp, iy
	ld	-5 (ix), e
	ld	-4 (ix), d
;video.c:172: if ((x >= 640) || (y >= 480) || ((x + 6 * size - 1) < 0) || ((y + 8 * size - 1) < 0)) return;
	ld	-26 (ix), l
	ld	-25 (ix), h
	ld	a, -26 (ix)
	sub	a, #0x80
	ld	a, -25 (ix)
	rla
	ccf
	rra
	sbc	a, #0x82
	jp	NC, 00128$
	ld	a, -5 (ix)
	ld	-24 (ix), a
	ld	a, -4 (ix)
	ld	-23 (ix), a
	ld	a, -24 (ix)
	sub	a, #0xe0
	ld	a, -23 (ix)
	rla
	ccf
	rra
	sbc	a, #0x81
	jp	NC, 00128$
	ld	c, 9 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	e, -26 (ix)
	ld	d, -25 (ix)
	add	hl, de
	dec	hl
	bit	7, h
	jp	NZ, 00128$
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	e, -24 (ix)
	ld	d, -23 (ix)
	add	hl, de
	dec	hl
	bit	7, h
	jp	NZ, 00128$
;video.c:174: bool fillbg = (bg != color);
	ld	a, 7 (ix)
	sub	a, 5 (ix)
	jr	NZ, 00216$
	ld	a, 8 (ix)
	sub	a, 6 (ix)
	ld	a, #0x01
	jr	Z, 00217$
00216$:
	xor	a, a
00217$:
	xor	a, #0x01
	ld	-22 (ix), a
;video.c:177: for (int8_t i = 0; i < 6; i++) {
	ld	a, 9 (ix)
	dec	a
	ld	a, #0x01
	jr	Z, 00219$
	xor	a, a
00219$:
	ld	-21 (ix), a
	ld	-20 (ix), a
	ld	-3 (ix), #0x00
00126$:
	ld	a, -3 (ix)
	sub	a, #0x06
	jp	NC, 00128$
;video.c:180: else        line = font[(c * 5) + i];
	ld	a, -3 (ix)
	ld	-19 (ix), a
	rlca
	sbc	a, a
	ld	-18 (ix), a
;video.c:179: if (i == 5) line = 0x0; // Spazio tra i caratteri
	ld	a, -3 (ix)
	sub	a, #0x05
	jr	NZ, 00107$
	ld	-2 (ix), #0x00
	jr	00140$
00107$:
;video.c:180: else        line = font[(c * 5) + i];
	ld	a, 4 (ix)
	ld	-2 (ix), a
	ld	-1 (ix), #0x00
	ld	c, a
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	e, -19 (ix)
	ld	d, #0x00
	add	hl, de
	ld	a, #<(_font)
	add	a, l
	ld	c, a
	ld	a, #>(_font)
	adc	a, h
	ld	b, a
	ld	a, (bc)
	ld	-2 (ix), a
;video.c:183: for (int8_t j = 0; j < 8; j++) {
00140$:
	ld	l, 9 (ix)
	ld	a, -3 (ix)
	call	__muluschar
	ld	a, e
	add	a, -26 (ix)
	ld	-17 (ix), a
	ld	a, d
	adc	a, -25 (ix)
	ld	-16 (ix), a
	ld	a, -17 (ix)
	ld	-15 (ix), a
	ld	a, -16 (ix)
	ld	-14 (ix), a
	ld	-1 (ix), #0x00
00123$:
	ld	a, -1 (ix)
	sub	a, #0x08
	jp	NC, 00127$
;video.c:187: vga_pixel_fast(x + i, y + j, color);
	ld	a, -1 (ix)
	ld	-7 (ix), a
	rlca
	sbc	a, a
	ld	-6 (ix), a
;video.c:190: vga_fillRect(x + (i * size), y + (j * size), size, size, color);
	ld	a, 9 (ix)
	ld	-13 (ix), a
	ld	-12 (ix), #0x00
	ld	l, 9 (ix)
	ld	a, -1 (ix)
;video.c:187: vga_pixel_fast(x + i, y + j, color);
	call	__muluschar
	inc	sp
	inc	sp
	push	de
	ld	a, -7 (ix)
	add	a, -24 (ix)
	ld	-11 (ix), a
	ld	a, #0x00
	adc	a, -23 (ix)
	ld	-10 (ix), a
	ld	a, -26 (ix)
	add	a, -19 (ix)
	ld	-9 (ix), a
	ld	a, -25 (ix)
	adc	a, -18 (ix)
	ld	-8 (ix), a
;video.c:190: vga_fillRect(x + (i * size), y + (j * size), size, size, color);
	ld	a, -28 (ix)
	add	a, -24 (ix)
	ld	-7 (ix), a
	ld	a, -27 (ix)
	adc	a, -23 (ix)
	ld	-6 (ix), a
;video.c:187: vga_pixel_fast(x + i, y + j, color);
;video.c:190: vga_fillRect(x + (i * size), y + (j * size), size, size, color);
;video.c:184: if (line & 0x1) {
	bit	0, -2 (ix)
	jr	Z, 00118$
;video.c:186: if (size == 1) {
	ld	a, -21 (ix)
	or	a, a
	jr	Z, 00110$
;video.c:187: vga_pixel_fast(x + i, y + j, color);
	ld	l, 5 (ix)
	ld	h, 6 (ix)
	push	hl
	ld	e, -11 (ix)
	ld	d, -10 (ix)
	ld	l, -9 (ix)
	ld	h, -8 (ix)
	call	_vga_pixel_fast
	jr	00119$
00110$:
;video.c:190: vga_fillRect(x + (i * size), y + (j * size), size, size, color);
	ld	l, -15 (ix)
	ld	h, -14 (ix)
	ld	e, 5 (ix)
	ld	d, 6 (ix)
	push	de
	ld	e, -13 (ix)
	ld	d, #0x00
	push	de
	ld	e, -13 (ix)
	ld	d, #0x00
	push	de
	ld	e, -7 (ix)
	ld	d, -6 (ix)
	call	_vga_fillRect
	jr	00119$
00118$:
;video.c:193: else if (fillbg) {
	bit	0, -22 (ix)
	jr	Z, 00119$
;video.c:195: if (size == 1) {
	ld	a, -20 (ix)
	or	a, a
	jr	Z, 00113$
;video.c:196: vga_pixel_fast(x + i, y + j, bg);
	ld	l, 7 (ix)
	ld	h, 8 (ix)
	push	hl
	ld	e, -11 (ix)
	ld	d, -10 (ix)
	ld	l, -9 (ix)
	ld	h, -8 (ix)
	call	_vga_pixel_fast
	jr	00119$
00113$:
;video.c:198: vga_fillRect(x + (i * size), y + (j * size), size, size, bg);
	ld	l, -17 (ix)
	ld	h, -16 (ix)
	ld	e, 7 (ix)
	ld	d, 8 (ix)
	push	de
	ld	e, -13 (ix)
	ld	d, #0x00
	push	de
	ld	e, -13 (ix)
	ld	d, #0x00
	push	de
	ld	e, -7 (ix)
	ld	d, -6 (ix)
	call	_vga_fillRect
00119$:
;video.c:201: line >>= 1; // Scorri al bit successivo della colonna
	srl	-2 (ix)
;video.c:183: for (int8_t j = 0; j < 8; j++) {
	inc	-1 (ix)
	jp	00123$
00127$:
;video.c:177: for (int8_t i = 0; i < 6; i++) {
	inc	-3 (ix)
	jp	00126$
00128$:
;video.c:205: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	pop	af
	jp	(hl)
;video.c:208: void vga_fillRect_fast(int16_t x, int16_t y, uint8_t w, uint8_t h, uint16_t color) {
;	---------------------------------
; Function vga_fillRect_fast
; ---------------------------------
_vga_fillRect_fast::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	push	af
	ld	-4 (ix), l
	ld	-3 (ix), h
	ex	de, hl
;video.c:209: for (int16_t i = 0; i < w; i++) {
	ld	bc, #0x0000
00107$:
	ld	e, 4 (ix)
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	a, b
	sbc	a, d
	jp	PO, 00141$
	xor	a, #0x80
00141$:
	jp	P, 00109$
;video.c:210: for (int16_t j = 0; j < h; j++) {
	ld	a, c
	add	a, -4 (ix)
	ld	-6 (ix), a
	ld	a, b
	adc	a, -3 (ix)
	ld	-5 (ix), a
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
00104$:
	ld	e, 5 (ix)
	ld	d, #0x00
	ld	a, -2 (ix)
	sub	a, e
	ld	a, -1 (ix)
	sbc	a, d
	jp	PO, 00142$
	xor	a, #0x80
00142$:
	jp	P, 00108$
;video.c:211: vga_pixel_fast(x + i, y + j, color);
	ld	a, -2 (ix)
	add	a, l
	ld	e, a
	ld	a, -1 (ix)
	adc	a, h
	ld	d, a
	push	hl
	push	bc
	push	hl
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	ex	(sp), hl
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	call	_vga_pixel_fast
	pop	bc
	pop	hl
;video.c:210: for (int16_t j = 0; j < h; j++) {
	inc	-2 (ix)
	jr	NZ, 00104$
	inc	-1 (ix)
	jr	00104$
00108$:
;video.c:209: for (int16_t i = 0; i < w; i++) {
	inc	bc
	jr	00107$
00109$:
;video.c:214: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	jp	(hl)
;video.c:220: int vga_drawChar(unsigned int uniCode, int x, int y, int font) {
;	---------------------------------
; Function vga_drawChar
; ---------------------------------
_vga_drawChar::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-30
	add	iy, sp
	ld	sp, iy
	ld	c, l
	ld	b, h
	ld	-8 (ix), e
	ld	-7 (ix), d
;video.c:223: int width = 0;
	xor	a, a
	ld	-26 (ix), a
	ld	-25 (ix), a
;video.c:224: int height = 0;
	xor	a, a
	ld	-24 (ix), a
	ld	-23 (ix), a
;video.c:225: unsigned int flash_address = 0; 
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
;video.c:233: if (font == 1) {
	ld	a, 6 (ix)
	dec	a
	or	a, 7 (ix)
	jr	NZ, 00102$
;video.c:235: vga_drawCharGL(x, y, uniCode, textcolor, textbgcolor, textsize);
	ld	b, c
	ld	e, 4 (ix)
	ld	d, 5 (ix)
	ld	a, -8 (ix)
	ld	c, -7 (ix)
	ld	iy, #_textsize
	ld	h, 0 (iy)
	push	hl
	inc	sp
	ld	hl, (_textbgcolor)
	push	hl
	ld	hl, (_textcolor)
	push	hl
	push	bc
	inc	sp
	ld	l, a
	ld	h, c
	call	_vga_drawCharGL
;video.c:236: return 6 * textsize;
	ld	a, (_textsize)
	ld	c, a
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ex	de, hl
	jp	00150$
00102$:
;video.c:242: if (uniCode < 32) return 0;
	ld	a, c
	sub	a, #0x20
	ld	a, b
	sbc	a, #0x00
	jr	NC, 00104$
	ld	de, #0x0000
	jp	00150$
00104$:
;video.c:243: uniCode -= 32;
	ld	a, c
	add	a, #0xe0
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;video.c:246: if (font == 2) {
	ld	a, 6 (ix)
	sub	a, #0x02
	or	a, 7 (ix)
	jr	NZ, 00106$
;video.c:247: flash_address = (unsigned int)chrtbl_f16[uniCode];
	ld	de, #_chrtbl_f16+0
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, de
	ld	a, (hl)
	inc	hl
	ld	e, (hl)
	ld	-2 (ix), a
	ld	-1 (ix), e
;video.c:248: width = (int)widtbl_f16[uniCode];
	ld	hl, #_widtbl_f16+0
	add	hl, bc
	ld	a, (hl)
	ld	-26 (ix), a
	ld	-25 (ix), #0x00
;video.c:249: height = (int)chr_hgt_f16;
	ld	-24 (ix), #0x10
	ld	-23 (ix), #0
00106$:
;video.c:253: w_bytes = (width + 7) / 8;
	ld	l, -26 (ix)
	ld	h, #0x00
	ld	de, #0x0007
	add	hl, de
	ld	-22 (ix), l
	ld	-21 (ix), h
	sra	-21 (ix)
	rr	-22 (ix)
	sra	-21 (ix)
	rr	-22 (ix)
	sra	-21 (ix)
	rr	-22 (ix)
;video.c:255: ptr_font = (const unsigned char *)flash_address;
	ld	a, -2 (ix)
	ld	-20 (ix), a
	ld	a, -1 (ix)
	ld	-19 (ix), a
;video.c:258: if (textcolor == textbgcolor || textsize != 1) {
	ld	a, (_textcolor+0)
	ld	iy, #_textbgcolor
	sub	a, 0 (iy)
	jr	NZ, 00335$
	ld	a, (_textcolor+1)
	sub	a, 1 (iy)
	jr	Z, 00168$
00335$:
	ld	a, (_textsize+0)
	dec	a
	jp	Z, 00179$
;video.c:259: for (i = 0; i < height; i++) {
00168$:
	xor	a, a
	ld	-6 (ix), a
	ld	-5 (ix), a
00140$:
	ld	a, -6 (ix)
	sub	a, -24 (ix)
	ld	a, -5 (ix)
	sbc	a, -23 (ix)
	jp	PO, 00337$
	xor	a, #0x80
00337$:
	jp	P, 00132$
;video.c:260: if (textcolor != textbgcolor) {
	ld	a, (_textcolor+0)
	ld	iy, #_textbgcolor
	sub	a, 0 (iy)
	jr	NZ, 00338$
	ld	a, (_textcolor+1)
	sub	a, 1 (iy)
	jr	Z, 00167$
00338$:
;video.c:261: vga_fillRect(x, y + (i * textsize), width * textsize, textsize, textbgcolor);
	ld	a, (_textsize+0)
	ld	-2 (ix), a
	ld	-1 (ix), #0x00
	ld	a, (_textsize)
	ld	e, a
	ld	d, #0x00
	push	de
	ld	l, -26 (ix)
	ld	h, #0x00
	call	__mulint
	push	de
	pop	iy
	pop	de
	push	iy
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	call	__mulint
	pop	iy
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	add	hl, de
	ex	de, hl
	ld	a, -8 (ix)
	ld	c, -7 (ix)
	ld	hl, (_textbgcolor)
	push	hl
	ld	l, -2 (ix)
	ld	h, #0x00
	push	hl
	push	iy
	ld	l, a
	ld	h, c
	call	_vga_fillRect
;video.c:264: for (k = 0; k < w_bytes; k++) {
00167$:
	ld	a, 4 (ix)
	add	a, -6 (ix)
	ld	-17 (ix), a
	ld	a, 5 (ix)
	adc	a, -5 (ix)
	ld	-16 (ix), a
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	ld	l, -22 (ix)
	ld	h, #0x00
	call	__mulint
	ld	-15 (ix), e
	ld	-14 (ix), d
	xor	a, a
	ld	-4 (ix), a
	ld	-3 (ix), a
00137$:
	ld	a, -4 (ix)
	sub	a, -22 (ix)
	ld	a, -3 (ix)
	sbc	a, -21 (ix)
	jp	PO, 00339$
	xor	a, #0x80
00339$:
	jp	P, 00141$
;video.c:266: line = ptr_font[w_bytes * i + k];
	ld	a, -15 (ix)
	add	a, -4 (ix)
	ld	c, a
	ld	a, -14 (ix)
	adc	a, -3 (ix)
	ld	b, a
	ld	l, -20 (ix)
	ld	h, -19 (ix)
	add	hl, bc
	ld	a, (hl)
;video.c:268: if (line) {
	ld	-13 (ix), a
	or	a, a
	jp	Z, 00138$
;video.c:269: pX = x + (k * 8 * textsize);
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, (_textsize)
	ld	d, #0x00
	ld	e, a
	call	__mulint
	ld	a, e
	add	a, -8 (ix)
	ld	-12 (ix), a
	ld	a, d
	adc	a, -7 (ix)
	ld	-11 (ix), a
;video.c:270: for (bit = 0; bit < 8; bit++) {
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
00134$:
;video.c:271: if (line & (0x80 >> bit)) {
	ld	b, -2 (ix)
	ld	de, #0x0080
	inc	b
	jr	00341$
00340$:
	sra	d
	rr	e
00341$:
	djnz	00340$
	ld	a, -13 (ix)
	and	a, e
	jr	Z, 00135$
;video.c:272: if (textsize == 1) {
	ld	a, (_textsize+0)
	dec	a
	jr	NZ, 00110$
;video.c:273: vga_pixel_fast(pX + bit, y + i, textcolor);
	ld	e, -17 (ix)
	ld	d, -16 (ix)
	ld	a, -12 (ix)
	add	a, -2 (ix)
	ld	c, a
	ld	a, -11 (ix)
	adc	a, -1 (ix)
	ld	hl, (_textcolor)
	push	hl
	ld	l, c
	ld	h, a
	call	_vga_pixel_fast
	jr	00135$
00110$:
;video.c:275: vga_fillRect(pX + bit * textsize, y + i * textsize, textsize, textsize, textcolor);
	ld	a, (_textsize+0)
	ld	-10 (ix), a
	ld	-9 (ix), #0x00
	ld	a, (_textsize)
	ld	e, a
	ld	d, #0x00
	push	de
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	call	__mulint
	ld	c, e
	ld	b, d
	pop	de
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	add	hl, bc
	push	hl
	ld	l, -2 (ix)
	ld	h, #0x00
	call	__mulint
	pop	bc
	ld	l, -12 (ix)
	ld	h, -11 (ix)
	add	hl, de
	push	hl
	pop	iy
	ld	hl, (_textcolor)
	push	hl
	ld	l, -10 (ix)
	ld	h, #0x00
	push	hl
	ld	l, -10 (ix)
	ld	h, #0x00
	push	hl
	ld	e, c
	ld	d, b
	push	iy
	pop	hl
	call	_vga_fillRect
00135$:
;video.c:270: for (bit = 0; bit < 8; bit++) {
	inc	-2 (ix)
	ld	a, -2 (ix)
	sub	a, #0x08
	jp	C, 00134$
00138$:
;video.c:264: for (k = 0; k < w_bytes; k++) {
	inc	-4 (ix)
	jp	NZ, 00137$
	inc	-3 (ix)
	jp	00137$
00141$:
;video.c:259: for (i = 0; i < height; i++) {
	inc	-6 (ix)
	jp	NZ, 00140$
	inc	-5 (ix)
	jp	00140$
;video.c:285: for (i = 0; i < height; i++) {
00179$:
	xor	a, a
	ld	-6 (ix), a
	ld	-5 (ix), a
00148$:
	ld	a, -6 (ix)
	sub	a, -24 (ix)
	ld	a, -5 (ix)
	sbc	a, -23 (ix)
	jp	PO, 00347$
	xor	a, #0x80
00347$:
	jp	P, 00132$
;video.c:286: current_y = y + i;
	ld	a, 4 (ix)
	add	a, -6 (ix)
	ld	e, a
	ld	a, 5 (ix)
	adc	a, -5 (ix)
	ld	d, a
;video.c:288: while(VGA_REG_STAT & 0x01);
00119$:
	ld	a, (#0xc005)
	rrca
	jr	C, 00119$
;video.c:289: VIDEO_REG_Y_L = (uint8_t)(current_y & 0xFF);
	ld	a, e
	ld	hl, #0xc002
	ld	(hl), a
;video.c:290: VIDEO_REG_Y_H = (uint8_t)((current_y >> 8) & 0x03);
	ld	a, d
	and	a, #0x03
	ld	l, #0x03
	ld	(hl), a
;video.c:292: for (k = 0; k < w_bytes; k++) {
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	ld	l, -22 (ix)
	ld	h, #0x00
	call	__mulint
	ld	-18 (ix), e
	ld	-17 (ix), d
	xor	a, a
	ld	-4 (ix), a
	ld	-3 (ix), a
00145$:
	ld	a, -4 (ix)
	sub	a, -22 (ix)
	ld	a, -3 (ix)
	sbc	a, -21 (ix)
	jp	PO, 00350$
	xor	a, #0x80
00350$:
	jp	P, 00149$
;video.c:294: line = ptr_font[w_bytes * i + k];
	ld	a, -4 (ix)
	add	a, -18 (ix)
	ld	-10 (ix), a
	ld	a, -3 (ix)
	adc	a, -17 (ix)
	ld	-9 (ix), a
	ld	a, -10 (ix)
	add	a, -20 (ix)
	ld	-2 (ix), a
	ld	a, -9 (ix)
	adc	a, -19 (ix)
	ld	-1 (ix), a
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	ld	-16 (ix), a
;video.c:295: base_x = x + (k * 8);
	ld	a, -4 (ix)
	ld	-2 (ix), a
	ld	a, -3 (ix)
	ld	-1 (ix), a
	ld	b, #0x03
00351$:
	sla	-2 (ix)
	rl	-1 (ix)
	djnz	00351$
	ld	a, -8 (ix)
	add	a, -2 (ix)
	ld	-15 (ix), a
	ld	a, -7 (ix)
	adc	a, -1 (ix)
	ld	-14 (ix), a
;video.c:297: for (bit = 0; bit < 8; bit++) {
	ld	a, -2 (ix)
	ld	-13 (ix), a
	ld	a, -1 (ix)
	ld	-12 (ix), a
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
00142$:
;video.c:298: if ((k * 8) + bit >= width) break;
	ld	a, -13 (ix)
	add	a, -2 (ix)
	ld	-10 (ix), a
	ld	a, -12 (ix)
	adc	a, -1 (ix)
	ld	-9 (ix), a
	ld	a, -10 (ix)
	sub	a, -26 (ix)
	ld	a, -9 (ix)
	sbc	a, -25 (ix)
	jp	PO, 00352$
	xor	a, #0x80
00352$:
	jp	P, 00146$
;video.c:300: current_x = base_x + bit;
	ld	a, -15 (ix)
	add	a, -2 (ix)
	ld	-28 (ix), a
	ld	a, -14 (ix)
	adc	a, -1 (ix)
	ld	-27 (ix), a
;video.c:301: color = (line & (0x80 >> bit)) ? textcolor : textbgcolor;
	ld	b, -2 (ix)
	ld	de, #0x0080
	inc	b
	jr	00354$
00353$:
	sra	d
	rr	e
00354$:
	djnz	00353$
	ld	a, -16 (ix)
	and	a, e
	ld	-10 (ix), a
	ld	-9 (ix), #0x00
	xor	a, a
	or	a, -10 (ix)
	jr	Z, 00153$
	ld	hl, (_textcolor)
	ex	(sp), hl
	jr	00154$
00153$:
	ld	hl, (_textbgcolor)
	ex	(sp), hl
00154$:
	ld	a, -30 (ix)
	ld	-11 (ix), a
	ld	a, -29 (ix)
	ld	-10 (ix), a
;video.c:303: while(VGA_REG_STAT & 0x01);
00124$:
	ld	a, (#0xc005)
	rrca
	jr	C, 00124$
;video.c:304: VIDEO_REG_X_L = (uint8_t)(current_x & 0xFF);
	ld	a, -28 (ix)
	ld	hl, #0xc000
	ld	(hl), a
;video.c:305: VIDEO_REG_X_H = (uint8_t)((current_x >> 8) & 0x03);
	ld	a, -27 (ix)
	ld	-9 (ix), a
	and	a, #0x03
	ld	-9 (ix), a
	ld	l, #0x01
	ld	a, -9 (ix)
	ld	(hl), a
;video.c:307: VIDEO_REG_DATA_L = (uint8_t)(color & 0xFF);
	ld	a, -11 (ix)
	ld	l, #0x04
	ld	(hl), a
;video.c:308: VIDEO_REG_DATA_H = (uint8_t)(color >> 8);
	ld	a, -10 (ix)
	ld	l, #0x05
	ld	(hl), a
;video.c:297: for (bit = 0; bit < 8; bit++) {
	inc	-2 (ix)
	ld	a, -2 (ix)
	sub	a, #0x08
	jp	C, 00142$
00146$:
;video.c:292: for (k = 0; k < w_bytes; k++) {
	inc	-4 (ix)
	jp	NZ, 00145$
	inc	-3 (ix)
	jp	00145$
00149$:
;video.c:285: for (i = 0; i < height; i++) {
	inc	-6 (ix)
	jp	NZ, 00148$
	inc	-5 (ix)
	jp	00148$
00132$:
;video.c:314: return width * textsize;
	ld	a, (_textsize)
	ld	d, #0x00
	ld	e, a
	ld	l, -26 (ix)
	ld	h, #0x00
	call	__mulint
00150$:
;video.c:315: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	jp	(hl)
;video.c:321: void vga_printAt(const char *str, int16_t x, int16_t y, uint16_t color, uint16_t bg, uint8_t font) {
;	---------------------------------
; Function vga_printAt
; ---------------------------------
_vga_printAt::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-12
	add	iy, sp
	ld	sp, iy
	ld	-2 (ix), l
	ld	-1 (ix), h
	inc	sp
	inc	sp
	push	de
;video.c:325: textcolor = color;
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	ld	(_textcolor), hl
;video.c:326: textbgcolor = bg;
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	ld	(_textbgcolor), hl
;video.c:330: while (*str) {
00106$:
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	ld	-3 (ix), a
	or	a, a
	jp	Z, 00109$
;video.c:333: int charWidth = vga_drawChar((unsigned int)*str, curX, y, font);
	ld	e, 10 (ix)
	ld	d, #0x00
	ld	c, 4 (ix)
	ld	b, 5 (ix)
	ld	a, -12 (ix)
	ld	-10 (ix), a
	ld	a, -11 (ix)
	ld	-9 (ix), a
	ld	l, -3 (ix)
	ld	h, #0x00
	push	de
	push	bc
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	call	_vga_drawChar
	ld	-8 (ix), e
	ld	-7 (ix), d
	ld	a, -8 (ix)
	ld	-6 (ix), a
	ld	a, -7 (ix)
	ld	-5 (ix), a
;video.c:337: str++;
	ld	a, -2 (ix)
	add	a, #0x01
	ld	-4 (ix), a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	-3 (ix), a
;video.c:336: if (charWidth == 0 && *str != ' ') {
	ld	a, -7 (ix)
	or	a, -8 (ix)
	jr	NZ, 00102$
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	sub	a, #0x20
	jr	Z, 00102$
;video.c:337: str++;
	ld	a, -4 (ix)
	ld	-2 (ix), a
	ld	a, -3 (ix)
	ld	-1 (ix), a
;video.c:338: continue;
	jr	00106$
00102$:
;video.c:341: curX += charWidth;
	ld	a, -6 (ix)
	add	a, -10 (ix)
	ld	c, a
	ld	a, -5 (ix)
	adc	a, -9 (ix)
	ld	-12 (ix), c
	ld	-11 (ix), a
;video.c:342: str++;
	ld	a, -4 (ix)
	ld	-2 (ix), a
	ld	a, -3 (ix)
	ld	-1 (ix), a
;video.c:346: if (curX > 635) break; 
	pop	bc
	push	bc
	ld	a, #0x7b
	cp	a, c
	ld	a, #0x02
	sbc	a, b
	jp	PO, 00140$
	xor	a, #0x80
00140$:
	jp	P, 00106$
00109$:
;video.c:348: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	pop	af
	inc	sp
	jp	(hl)
;video.c:350: void vga_drawFastHLine(int16_t x, int16_t y, int16_t w, uint16_t color) {
;	---------------------------------
; Function vga_drawFastHLine
; ---------------------------------
_vga_drawFastHLine::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-8
	add	iy, sp
	ld	sp, iy
	ld	-4 (ix), l
	ld	-3 (ix), h
;video.c:351: if (w < 0) { x += w; w = -w; }
	ld	c, 4 (ix)
	ld	b, 5 (ix)
	bit	7, b
	jr	Z, 00103$
	ld	a, -4 (ix)
	add	a, 4 (ix)
	ld	-4 (ix), a
	ld	a, -3 (ix)
	adc	a, 5 (ix)
	ld	-3 (ix), a
	xor	a, a
	sub	a, 4 (ix)
	ld	4 (ix), a
	sbc	a, a
	sub	a, 5 (ix)
	ld	5 (ix), a
;video.c:354: while(VGA_REG_STAT & 0x01);
00103$:
	ld	a, (#0xc005)
	rrca
	jr	C, 00103$
;video.c:355: VIDEO_REG_Y_L = (uint8_t)(y & 0xFF);
	ld	a, e
	ld	hl, #0xc002
	ld	(hl), a
;video.c:356: VIDEO_REG_Y_H = (uint8_t)((y >> 8) & 0x03);
	ld	a, d
	and	a, #0x03
	ld	l, #0x03
	ld	(hl), a
;video.c:358: uint8_t color_lo = (uint8_t)(color & 0xFF);
	ld	a, 6 (ix)
	ld	-8 (ix), a
;video.c:359: uint8_t color_hi = (uint8_t)(color >> 8);
	ld	a, 7 (ix)
	ld	-7 (ix), a
;video.c:361: for (int16_t i = 0; i < w; i++) {
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
00115$:
	ld	a, -2 (ix)
	sub	a, 4 (ix)
	ld	a, -1 (ix)
	sbc	a, 5 (ix)
	jp	PO, 00177$
	xor	a, #0x80
00177$:
	jp	P, 00116$
;video.c:362: int16_t curX = x + i;
	ld	a, -4 (ix)
	add	a, -2 (ix)
	ld	-6 (ix), a
	ld	a, -3 (ix)
	adc	a, -1 (ix)
	ld	-5 (ix), a
;video.c:363: if (curX < 0 || curX >= 640) continue; // Clipping base
	pop	hl
	pop	bc
	push	bc
	push	hl
	bit	7, b
	jr	NZ, 00112$
	ld	a, c
	sub	a, #0x80
	ld	a, b
	sbc	a, #0x02
	jr	NC, 00112$
;video.c:365: while(VGA_REG_STAT & 0x01);
00109$:
	ld	a, (#0xc005)
	rrca
	jr	C, 00109$
;video.c:366: VIDEO_REG_X_L = (uint8_t)(curX & 0xFF);
	ld	a, -6 (ix)
	ld	hl, #0xc000
	ld	(hl), a
;video.c:367: VIDEO_REG_X_H = (uint8_t)((curX >> 8) & 0x03);
	ld	a, -5 (ix)
	and	a, #0x03
	ld	l, #0x01
	ld	(hl), a
;video.c:369: VIDEO_REG_DATA_L = color_lo;
	ld	l, #0x04
	ld	a, -8 (ix)
	ld	(hl), a
;video.c:370: VIDEO_REG_DATA_H = color_hi;
	ld	l, #0x05
	ld	a, -7 (ix)
	ld	(hl), a
00112$:
;video.c:361: for (int16_t i = 0; i < w; i++) {
	inc	-2 (ix)
	jr	NZ, 00115$
	inc	-1 (ix)
	jr	00115$
00116$:
;video.c:372: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	jp	(hl)
;video.c:374: void vga_drawFastVLine(int16_t x, int16_t y, int16_t h, uint16_t color) {
;	---------------------------------
; Function vga_drawFastVLine
; ---------------------------------
_vga_drawFastVLine::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	ld	c, l
	ld	b, h
	ld	-2 (ix), e
	ld	-1 (ix), d
;video.c:375: if (h <= 0) return;
	ld	e, 4 (ix)
	ld	d, 5 (ix)
	xor	a, a
	cp	a, e
	sbc	a, d
	jp	PO, 00185$
	xor	a, #0x80
00185$:
	jp	M, 00102$
	jr	00119$
00102$:
;video.c:376: if (x < 0 || x >= 640) return; // Clipping X
	ld	e, c
	ld	d, b
	bit	7, d
	jr	NZ, 00119$
	ld	a, e
	sub	a, #0x80
	ld	a, d
	sbc	a, #0x02
;video.c:379: while(VGA_REG_STAT & 0x01);
	jr	NC, 00119$
00106$:
	ld	a, (#0xc005)
	rrca
	jr	C, 00106$
;video.c:380: VIDEO_REG_X_L = (uint8_t)(x & 0xFF);
	ld	a, c
	ld	hl, #0xc000
	ld	(hl), a
;video.c:381: VIDEO_REG_X_H = (uint8_t)((x >> 8) & 0x03);
	ld	a, b
	and	a, #0x03
	ld	l, #0x01
	ld	(hl), a
;video.c:383: uint8_t color_lo = (uint8_t)(color & 0xFF);
	ld	a, 6 (ix)
	ld	-4 (ix), a
;video.c:384: uint8_t color_hi = (uint8_t)(color >> 8);
	ld	a, 7 (ix)
	ld	-3 (ix), a
;video.c:386: for (int16_t i = 0; i < h; i++) {
	ld	bc, #0x0000
00118$:
	ld	a, c
	sub	a, 4 (ix)
	ld	a, b
	sbc	a, 5 (ix)
	jp	PO, 00188$
	xor	a, #0x80
00188$:
	jp	P, 00119$
;video.c:387: int16_t curY = y + i;
	ld	a, -2 (ix)
	add	a, c
	ld	e, a
	ld	a, -1 (ix)
	adc	a, b
	ld	d, a
;video.c:388: if (curY < 0 || curY >= 480) continue; // Clipping Y
	ld	l, e
	ld	h, d
	bit	7, h
	jr	NZ, 00115$
	ld	a, l
	sub	a, #0xe0
	ld	a, h
	sbc	a, #0x01
	jr	NC, 00115$
;video.c:391: while(VGA_REG_STAT & 0x01);
00112$:
	ld	a, (#0xc005)
	rrca
	jr	C, 00112$
;video.c:394: VIDEO_REG_Y_L = (uint8_t)(curY & 0xFF);
	ld	a, e
	ld	hl, #0xc002
	ld	(hl), a
;video.c:395: VIDEO_REG_Y_H = (uint8_t)((curY >> 8) & 0x03);
	ld	a, d
	and	a, #0x03
	ld	l, #0x03
	ld	(hl), a
;video.c:398: VIDEO_REG_DATA_L = color_lo;
	ld	l, #0x04
	ld	a, -4 (ix)
	ld	(hl), a
;video.c:399: VIDEO_REG_DATA_H = color_hi;
	ld	l, #0x05
	ld	a, -3 (ix)
	ld	(hl), a
00115$:
;video.c:386: for (int16_t i = 0; i < h; i++) {
	inc	bc
	jr	00118$
00119$:
;video.c:401: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	jp	(hl)
;video.c:407: void vga_drawRect(int16_t x, int16_t y, int16_t w, int16_t h, uint16_t color) {
;	---------------------------------
; Function vga_drawRect
; ---------------------------------
_vga_drawRect::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	ld	c, l
	ld	b, h
	inc	sp
	inc	sp
	push	de
;video.c:408: if (w <= 0 || h <= 0) return;
	ld	e, 4 (ix)
	ld	d, 5 (ix)
	xor	a, a
	cp	a, e
	sbc	a, d
	jp	PO, 00113$
	xor	a, #0x80
00113$:
	jp	P, 00104$
	ld	e, 6 (ix)
	ld	d, 7 (ix)
	xor	a, a
	cp	a, e
	sbc	a, d
	jp	PO, 00114$
	xor	a, #0x80
00114$:
	jp	M, 00102$
	jr	00104$
00102$:
;video.c:411: vga_drawFastHLine(x, y, w, color);             // Lato superiore
	push	bc
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	ld	l, c
	ld	h, b
	call	_vga_drawFastHLine
	pop	bc
;video.c:412: vga_drawFastHLine(x, y + h - 1, w, color);     // Lato inferiore
	ld	a, 6 (ix)
	add	a, -2 (ix)
	ld	e, a
	ld	a, 7 (ix)
	adc	a, -1 (ix)
	ld	d, a
	dec	de
	push	bc
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	push	hl
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	ld	l, c
	ld	h, b
	call	_vga_drawFastHLine
	pop	bc
;video.c:413: vga_drawFastVLine(x, y, h, color);             // Lato sinistro
	push	bc
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	push	hl
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	push	hl
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	ld	l, c
	ld	h, b
	call	_vga_drawFastVLine
	pop	bc
;video.c:414: vga_drawFastVLine(x + w - 1, y, h, color);     // Lato destro
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	add	hl, bc
	dec	hl
	ld	e, 8 (ix)
	ld	d, 9 (ix)
	push	de
	ld	e, 6 (ix)
	ld	d, 7 (ix)
	push	de
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	call	_vga_drawFastVLine
00104$:
;video.c:415: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	pop	af
	jp	(hl)
;video.c:421: void vga_fillCircle(uint16_t x0, uint16_t y0, uint16_t r, uint16_t color) {
;	---------------------------------
; Function vga_fillCircle
; ---------------------------------
_vga_fillCircle::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-16
	add	iy, sp
	ld	sp, iy
	ld	-8 (ix), l
	ld	-7 (ix), h
	ld	-10 (ix), e
	ld	-9 (ix), d
;video.c:423: vga_drawFastHLine(x0 - r, y0, 2 * r + 1, color);
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	add	hl, hl
	inc	hl
	ld	a, -8 (ix)
	sub	a, 4 (ix)
	ld	c, a
	ld	a, -7 (ix)
	sbc	a, 5 (ix)
	ld	e, 6 (ix)
	ld	d, 7 (ix)
	push	de
	push	hl
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	ld	l, c
	ld	h, a
	call	_vga_drawFastHLine
;video.c:425: int16_t f = 1 - r;
	ld	a, #0x01
	sub	a, 4 (ix)
	ld	-6 (ix), a
	sbc	a, a
	sub	a, 5 (ix)
	ld	-5 (ix), a
;video.c:426: int16_t ddF_x = 1;
	ld	hl, #0x0001
	ex	(sp), hl
;video.c:427: int16_t ddF_y = -2 * r;
	ld	c, 4 (ix)
	ld	b, 5 (ix)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	-14 (ix), l
	ld	-13 (ix), h
;video.c:429: int16_t y = r;
	ld	a, 4 (ix)
	ld	-4 (ix), a
	ld	a, 5 (ix)
	ld	-3 (ix), a
;video.c:431: while (x < y) {
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
00103$:
	ld	a, -2 (ix)
	sub	a, -4 (ix)
	ld	a, -1 (ix)
	sbc	a, -3 (ix)
	jp	PO, 00130$
	xor	a, #0x80
00130$:
	jp	P, 00106$
;video.c:432: if (f >= 0) {
	ld	b, -5 (ix)
	bit	7, b
	jr	NZ, 00102$
;video.c:433: y--;
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	dec	hl
	ld	-4 (ix), l
	ld	-3 (ix), h
;video.c:434: ddF_y += 2;
	pop	hl
	pop	bc
	push	bc
	push	hl
	inc	bc
	inc	bc
	ld	-14 (ix), c
	ld	-13 (ix), b
;video.c:435: f += ddF_y;
	ld	a, -6 (ix)
	add	a, -14 (ix)
	ld	-6 (ix), a
	ld	a, -5 (ix)
	adc	a, -13 (ix)
	ld	-5 (ix), a
00102$:
;video.c:437: x++;
	inc	-2 (ix)
	jr	NZ, 00131$
	inc	-1 (ix)
00131$:
;video.c:438: ddF_x += 2;
	pop	bc
	push	bc
	inc	bc
	inc	bc
	inc	sp
	inc	sp
	push	bc
;video.c:439: f += ddF_x;
	ld	a, -6 (ix)
	add	a, -16 (ix)
	ld	-6 (ix), a
	ld	a, -5 (ix)
	adc	a, -15 (ix)
	ld	-5 (ix), a
;video.c:443: vga_drawFastHLine(x0 - x, y0 + y, 2 * x + 1, color);
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	add	hl, hl
	inc	hl
	push	hl
	pop	iy
	ld	c, -4 (ix)
	ld	b, -3 (ix)
	ld	a, -10 (ix)
	add	a, c
	ld	e, a
	ld	a, -9 (ix)
	adc	a, b
	ld	d, a
	ld	a, -2 (ix)
	ld	-12 (ix), a
	ld	a, -1 (ix)
	ld	-11 (ix), a
	ld	a, -8 (ix)
	sub	a, -12 (ix)
	ld	l, a
	ld	a, -7 (ix)
	sbc	a, -11 (ix)
	ld	h, a
	push	hl
	push	bc
	push	iy
	push	hl
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	ex	(sp), hl
	push	iy
	call	_vga_drawFastHLine
	pop	iy
	pop	bc
	pop	hl
;video.c:444: vga_drawFastHLine(x0 - x, y0 - y, 2 * x + 1, color);
	ld	a, -10 (ix)
	sub	a, c
	ld	e, a
	ld	a, -9 (ix)
	sbc	a, b
	ld	d, a
	push	bc
	push	hl
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	ex	(sp), hl
	push	iy
	call	_vga_drawFastHLine
	pop	bc
;video.c:445: vga_drawFastHLine(x0 - y, y0 + x, 2 * y + 1, color);
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	add	hl, hl
	inc	hl
	ld	a, -10 (ix)
	add	a, -12 (ix)
	ld	e, a
	ld	a, -9 (ix)
	adc	a, -11 (ix)
	ld	d, a
	ld	a, -8 (ix)
	sub	a, c
	ld	c, a
	ld	a, -7 (ix)
	sbc	a, b
	ld	b, a
	push	hl
	push	bc
	push	hl
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	ex	(sp), hl
	push	hl
	ld	l, c
	ld	h, b
	call	_vga_drawFastHLine
	pop	bc
	pop	hl
;video.c:446: vga_drawFastHLine(x0 - y, y0 - x, 2 * y + 1, color);
	ld	a, -10 (ix)
	sub	a, -12 (ix)
	ld	e, a
	ld	a, -9 (ix)
	sbc	a, -11 (ix)
	ld	d, a
	push	hl
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	ex	(sp), hl
	push	hl
	ld	l, c
	ld	h, b
	call	_vga_drawFastHLine
	jp	00103$
00106$:
;video.c:448: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	jp	(hl)
;video.c:454: void vga_drawLine(int16_t x1, int16_t y1, int16_t x2, int16_t y2, uint16_t color) {
;	---------------------------------
; Function vga_drawLine
; ---------------------------------
_vga_drawLine::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-11
	add	iy, sp
	ld	sp, iy
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	c, e
	ld	b, d
;video.c:457: vga_drawFastVLine(x1, (y1 < y2 ? y1 : y2), abs(y2 - y1) + 1, color);
	ld	a, 6 (ix)
	sub	a, c
	ld	e, a
	ld	a, 7 (ix)
	sbc	a, b
	ld	d, a
	ld	a, 6 (ix)
	ld	-2 (ix), a
	ld	a, 7 (ix)
	ld	-1 (ix), a
	ld	-6 (ix), e
	ld	-5 (ix), d
;video.c:456: if (x1 == x2) {
	ld	a, 4 (ix)
	sub	a, -4 (ix)
	jr	NZ, 00102$
	ld	a, 5 (ix)
	sub	a, -3 (ix)
	jr	NZ, 00102$
;video.c:457: vga_drawFastVLine(x1, (y1 < y2 ? y1 : y2), abs(y2 - y1) + 1, color);
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	call	_abs
	inc	de
	ld	a, c
	sub	a, 6 (ix)
	ld	a, b
	sbc	a, 7 (ix)
	jp	PO, 00214$
	xor	a, #0x80
00214$:
	jp	P, 00120$
	jr	00121$
00120$:
	ld	c, -2 (ix)
	ld	b, -1 (ix)
00121$:
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	push	hl
	push	de
	ld	e, c
	ld	d, b
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	call	_vga_drawFastVLine
;video.c:458: return;
	jp	00118$
00102$:
;video.c:461: vga_drawFastHLine((x1 < x2 ? x1 : x2), y1, abs(x2 - x1) + 1, color);
	ld	a, 4 (ix)
	sub	a, -4 (ix)
	ld	l, a
	ld	a, 5 (ix)
	sbc	a, -3 (ix)
	ld	e, 4 (ix)
	ld	d, 5 (ix)
	ld	-8 (ix), l
	ld	-7 (ix), a
;video.c:460: if (y1 == y2) {
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	cp	a, a
	sbc	hl, bc
	jr	NZ, 00104$
;video.c:461: vga_drawFastHLine((x1 < x2 ? x1 : x2), y1, abs(x2 - x1) + 1, color);
	push	de
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	call	_abs
	ex	de, hl
	inc	hl
	pop	de
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	a, -4 (ix)
	sub	a, 4 (ix)
	ld	a, -3 (ix)
	sbc	a, 5 (ix)
	jp	PO, 00217$
	xor	a, #0x80
00217$:
	jp	P, 00122$
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	jr	00123$
00122$:
	ex	de, hl
00123$:
	ld	e, 8 (ix)
	ld	d, 9 (ix)
	push	de
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	push	de
	ld	e, c
	ld	d, b
	call	_vga_drawFastHLine
;video.c:462: return;
	jp	00118$
00104$:
;video.c:466: bool steep = abs(y2 - y1) > abs(x2 - x1);
	push	de
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	call	_abs
	ld	-6 (ix), e
	ld	-5 (ix), d
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	call	_abs
	ex	de, hl
	pop	de
	ld	a, l
	sub	a, -6 (ix)
	ld	a, h
	sbc	a, -5 (ix)
	jp	PO, 00218$
	xor	a, #0x80
00218$:
	rlca
	and	a,#0x01
	ld	l, a
	ld	-11 (ix), l
;video.c:467: if (steep) {
	bit	0, l
	jr	Z, 00106$
;video.c:469: int16_t t = x1; x1 = y1; y1 = t;
	ld	a, -4 (ix)
	ld	l, -3 (ix)
	ld	-4 (ix), c
	ld	-3 (ix), b
	ld	c, a
	ld	b, l
;video.c:471: t = x2; x2 = y2; y2 = t;
	ld	a, -2 (ix)
	ld	4 (ix), a
	ld	a, -1 (ix)
	ld	5 (ix), a
	ld	6 (ix), e
	ld	7 (ix), d
00106$:
;video.c:474: if (x1 > x2) {
	ld	a, 4 (ix)
	sub	a, -4 (ix)
	ld	a, 5 (ix)
	sbc	a, -3 (ix)
	jp	PO, 00219$
	xor	a, #0x80
00219$:
	jp	P, 00108$
;video.c:476: int16_t t = x1; x1 = x2; x2 = t;
	ld	e, -4 (ix)
	ld	d, -3 (ix)
	ld	a, 4 (ix)
	ld	-4 (ix), a
	ld	a, 5 (ix)
	ld	-3 (ix), a
	ld	4 (ix), e
	ld	5 (ix), d
;video.c:477: t = y1; y1 = y2; y2 = t;
	ld	a, c
	ld	e, b
	ld	c, 6 (ix)
	ld	b, 7 (ix)
	ld	6 (ix), a
	ld	7 (ix), e
00108$:
;video.c:480: int16_t dx = x2 - x1;
	ld	a, 4 (ix)
	sub	a, -4 (ix)
	ld	-10 (ix), a
	ld	a, 5 (ix)
	sbc	a, -3 (ix)
	ld	-9 (ix), a
;video.c:481: int16_t dy = abs(y2 - y1);
	ld	a, 6 (ix)
	sub	a, c
	ld	l, a
	ld	a, 7 (ix)
	sbc	a, b
	ld	h, a
	call	_abs
	ld	-8 (ix), e
	ld	-7 (ix), d
;video.c:482: int16_t err = dx / 2;
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	ld	l, e
	ld	h, d
	bit	7, d
	jr	Z, 00124$
	ex	de, hl
	inc	hl
00124$:
	sra	h
	rr	l
	ld	-2 (ix), l
	ld	-1 (ix), h
;video.c:483: int16_t ystep = (y1 < y2) ? 1 : -1;
	ld	a, c
	sub	a, 6 (ix)
	ld	a, b
	sbc	a, 7 (ix)
	jp	PO, 00220$
	xor	a, #0x80
00220$:
	jp	P, 00125$
	ld	a, #0x01
	jr	00126$
00125$:
	ld	a, #0xff
00126$:
	ld	-6 (ix), a
	rlca
	sbc	a, a
	ld	-5 (ix), a
	ld	l, -4 (ix)
	ld	h, -3 (ix)
00116$:
;video.c:487: for (; x1 <= x2; x1++) {
	ld	a, 4 (ix)
	sub	a, l
	ld	a, 5 (ix)
	sbc	a, h
	jp	PO, 00221$
	xor	a, #0x80
00221$:
	jp	M, 00118$
;video.c:488: if (steep) {
	bit	0, -11 (ix)
	jr	Z, 00110$
;video.c:489: vga_pixel_fast(y1, x1, color);
	push	hl
	push	bc
	ld	e, 8 (ix)
	ld	d, 9 (ix)
	ex	de, hl
	push	hl
	ld	l, c
	ld	h, b
	call	_vga_pixel_fast
	pop	bc
	pop	hl
	jr	00111$
00110$:
;video.c:491: vga_pixel_fast(x1, y1, color);
	push	hl
	push	bc
	ld	e, 8 (ix)
	ld	d, 9 (ix)
	push	de
	ld	e, c
	ld	d, b
	call	_vga_pixel_fast
	pop	bc
	pop	hl
00111$:
;video.c:494: err -= dy;
	ld	a, -2 (ix)
	sub	a, -8 (ix)
	ld	-2 (ix), a
	ld	a, -1 (ix)
	sbc	a, -7 (ix)
	ld	-1 (ix), a
;video.c:495: if (err < 0) {
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	bit	7, d
	jr	Z, 00117$
;video.c:496: y1 += ystep;
	ld	a, c
	add	a, -6 (ix)
	ld	c, a
	ld	a, b
	adc	a, -5 (ix)
	ld	b, a
;video.c:497: err += dx;
	ld	a, -2 (ix)
	add	a, -10 (ix)
	ld	-2 (ix), a
	ld	a, -1 (ix)
	adc	a, -9 (ix)
	ld	-1 (ix), a
00117$:
;video.c:487: for (; x1 <= x2; x1++) {
	inc	hl
	jr	00116$
00118$:
;video.c:500: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	pop	af
	jp	(hl)
;video.c:507: void vga_printCenteredX(const char *str, int16_t xStart, int16_t xEnd, int16_t y, uint16_t color, uint16_t bg, uint8_t font) {
;	---------------------------------
; Function vga_printCenteredX
; ---------------------------------
_vga_printCenteredX::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-10
	add	iy, sp
	ld	sp, iy
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	-4 (ix), e
	ld	-3 (ix), d
;video.c:508: uint16_t textWidth = 0;
	xor	a, a
	ld	-6 (ix), a
	ld	-5 (ix), a
;video.c:509: uint16_t len = strlen(str);
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	call	_strlen
	ld	-8 (ix), e
;video.c:511: if (len == 0) return; // Evitiamo calcoli inutili
	ld	-7 (ix), d
	ld	a, d
	or	a, -8 (ix)
	jp	Z, 00112$
;video.c:513: if (font == 2) {
	ld	a, 12 (ix)
	sub	a, #0x02
	jr	NZ, 00107$
;video.c:515: for (uint16_t i = 0; i < len; i++) {
	ld	bc, #0x0000
00110$:
	ld	a, c
	sub	a, -8 (ix)
	ld	a, b
	sbc	a, -7 (ix)
	jr	NC, 00105$
;video.c:516: uint8_t uniCode = (uint8_t)str[i];
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	add	hl, bc
	ld	a, (hl)
;video.c:519: if (uniCode < 32) uniCode = 32;
	cp	a, #0x20
	jr	NC, 00104$
	ld	a, #0x20
00104$:
;video.c:523: textWidth += widtbl_f16[uniCode - 32];
	add	a, #0xe0
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_widtbl_f16
	add	hl, de
	ld	e, (hl)
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	d, #0x00
	add	hl, de
	ld	-6 (ix), l
	ld	-5 (ix), h
;video.c:515: for (uint16_t i = 0; i < len; i++) {
	inc	bc
	jr	00110$
00105$:
;video.c:525: textWidth--; 
	ld	a, -6 (ix)
	add	a, #0xff
	ld	-10 (ix), a
	ld	a, -5 (ix)
	adc	a, #0xff
	ld	-9 (ix), a
	jr	00108$
00107$:
;video.c:529: textWidth = (len * 6 * font) - 1; 
	pop	hl
	pop	bc
	push	bc
	push	hl
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	e, 12 (ix)
	ld	d, #0x00
	call	__mulint
	ld	c, e
	ld	b, d
	dec	bc
	inc	sp
	inc	sp
	push	bc
00108$:
;video.c:532: int16_t areaWidth = xEnd - xStart;
	ld	a, 4 (ix)
	sub	a, -4 (ix)
	ld	-6 (ix), a
	ld	a, 5 (ix)
	sbc	a, -3 (ix)
	ld	-5 (ix), a
;video.c:533: int16_t centeredX = xStart + (areaWidth - textWidth) / 2;
	ld	a, -6 (ix)
	ld	-8 (ix), a
	ld	a, -5 (ix)
	ld	-7 (ix), a
	ld	a, -8 (ix)
	sub	a, -10 (ix)
	ld	-6 (ix), a
	ld	a, -7 (ix)
	sbc	a, -9 (ix)
	ld	-5 (ix), a
	ld	a, -6 (ix)
	ld	-10 (ix), a
	ld	a, -5 (ix)
	ld	-9 (ix), a
	srl	-9 (ix)
	rr	-10 (ix)
	ld	a, -4 (ix)
	ld	-8 (ix), a
	ld	a, -3 (ix)
	ld	-7 (ix), a
	ld	a, -10 (ix)
	add	a, -8 (ix)
	ld	-6 (ix), a
	ld	a, -9 (ix)
	adc	a, -7 (ix)
	ld	-5 (ix), a
;video.c:538: vga_printAt(str, centeredX, y, color, bg, font);
	ld	a, 12 (ix)
	push	af
	inc	sp
	ld	l, 10 (ix)
	ld	h, 11 (ix)
	push	hl
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	push	hl
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	push	hl
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	call	_vga_printAt
00112$:
;video.c:539: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	pop	af
	pop	af
	inc	sp
	jp	(hl)
;video.c:545: void vga_FillTriangle(Point_t p0, Point_t p1, Point_t p2, uint16_t color) {
;	---------------------------------
; Function vga_FillTriangle
; ---------------------------------
_vga_FillTriangle::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-17
	add	hl, sp
	ld	sp, hl
;video.c:547: if (p0.y > p1.y) { swap_int16(&p0.y, &p1.y); swap_int16(&p0.x, &p1.x); }
	ld	c, 6 (ix)
	ld	b, 7 (ix)
	ld	e, 10 (ix)
	ld	d, 11 (ix)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	PO, 00220$
	xor	a, #0x80
00220$:
	jp	P, 00102$
	ld	hl, #27
	add	hl, sp
	ex	de, hl
	ld	hl, #23
	add	hl, sp
	call	_swap_int16
	ld	hl, #25
	add	hl, sp
	ex	de, hl
	ld	hl, #21
	add	hl, sp
	call	_swap_int16
00102$:
;video.c:548: if (p1.y > p2.y) { swap_int16(&p1.y, &p2.y); swap_int16(&p1.x, &p2.x); }
	ld	c, 10 (ix)
	ld	b, 11 (ix)
	ld	e, 14 (ix)
	ld	d, 15 (ix)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	PO, 00221$
	xor	a, #0x80
00221$:
	jp	P, 00104$
	ld	hl, #31
	add	hl, sp
	ex	de, hl
	ld	hl, #27
	add	hl, sp
	call	_swap_int16
	ld	hl, #29
	add	hl, sp
	ex	de, hl
	ld	hl, #25
	add	hl, sp
	call	_swap_int16
00104$:
;video.c:549: if (p0.y > p1.y) { swap_int16(&p0.y, &p1.y); swap_int16(&p0.x, &p1.x); }
	ld	c, 6 (ix)
	ld	b, 7 (ix)
	ld	e, 10 (ix)
	ld	d, 11 (ix)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	PO, 00222$
	xor	a, #0x80
00222$:
	jp	P, 00106$
	ld	hl, #27
	add	hl, sp
	ex	de, hl
	ld	hl, #23
	add	hl, sp
	call	_swap_int16
	ld	hl, #25
	add	hl, sp
	ex	de, hl
	ld	hl, #21
	add	hl, sp
	call	_swap_int16
00106$:
;video.c:551: int16_t total_height = p2.y - p0.y;
	ld	c, 14 (ix)
	ld	b, 15 (ix)
	ld	a, 6 (ix)
	ld	-2 (ix), a
	ld	a, 7 (ix)
	ld	-1 (ix), a
	ld	a, c
	sub	a, -2 (ix)
	ld	c, a
	ld	a, b
	sbc	a, -1 (ix)
	ld	b, a
	ld	-13 (ix), c
	ld	-12 (ix), b
;video.c:552: if (total_height == 0) return; // Protezione: triangolo degenere
	ld	a, b
	or	a, c
	jp	Z, 00117$
;video.c:555: for (int16_t y = p0.y; y <= p2.y; y++) {
00116$:
;video.c:548: if (p1.y > p2.y) { swap_int16(&p1.y, &p2.y); swap_int16(&p1.x, &p2.x); }
	ld	c, 14 (ix)
	ld	b, 15 (ix)
;video.c:555: for (int16_t y = p0.y; y <= p2.y; y++) {
	ld	a, c
	sub	a, -2 (ix)
	ld	a, b
	sbc	a, -1 (ix)
	jp	PO, 00223$
	xor	a, #0x80
00223$:
	jp	M, 00117$
;video.c:547: if (p0.y > p1.y) { swap_int16(&p0.y, &p1.y); swap_int16(&p0.x, &p1.x); }
	ld	a, 10 (ix)
	ld	-11 (ix), a
	ld	a, 11 (ix)
	ld	-10 (ix), a
;video.c:557: bool second_half = (y > p1.y || p1.y == p0.y);
	ld	a, -11 (ix)
	sub	a, -2 (ix)
	ld	a, -10 (ix)
	sbc	a, -1 (ix)
	jp	PO, 00224$
	xor	a, #0x80
00224$:
	jp	M, 00120$
	ld	e, 6 (ix)
	ld	d, 7 (ix)
	ld	l, -11 (ix)
	ld	h, -10 (ix)
	cp	a, a
	sbc	hl, de
	jr	Z, 00120$
	ld	-3 (ix), #0x00
	jr	00121$
00120$:
	ld	-3 (ix), #0x01
00121$:
	ld	a, -3 (ix)
	ld	-9 (ix), a
;video.c:558: int16_t segment_height = second_half ? (p2.y - p1.y) : (p1.y - p0.y);
	bit	0, -9 (ix)
	jr	Z, 00122$
	ld	a, c
	sub	a, -11 (ix)
	ld	c, a
	ld	a, b
	sbc	a, -10 (ix)
	ld	b, a
	jr	00123$
00122$:
	ld	a, 6 (ix)
	ld	-4 (ix), a
	ld	a, 7 (ix)
	ld	-3 (ix), a
	ld	a, -11 (ix)
	sub	a, -4 (ix)
	ld	c, a
	ld	a, -10 (ix)
	sbc	a, -3 (ix)
	ld	b, a
00123$:
	ld	e, c
;video.c:560: if (segment_height == 0) continue; 
	ld	a,b
	ld	d,a
	or	a, c
	jp	Z, 00113$
;video.c:563: float alpha = (float)(y - p0.y) / total_height;
	ld	a, 6 (ix)
	ld	-8 (ix), a
	ld	a, 7 (ix)
	ld	-7 (ix), a
	ld	a, -2 (ix)
	sub	a, -8 (ix)
	ld	l, a
	ld	a, -1 (ix)
	sbc	a, -7 (ix)
	push	de
	ld	h, a
	call	___sint2fs
	ld	-6 (ix), e
	ld	-5 (ix), d
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	l, -13 (ix)
	ld	h, -12 (ix)
	call	___sint2fs
	ld	c, e
	ld	b, d
	push	hl
	push	bc
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
;video.c:564: float beta  = (float)(y - (second_half ? p1.y : p0.y)) / segment_height;
	call	___fsdiv
	ld	-6 (ix), e
	ld	-5 (ix), d
	ld	-4 (ix), l
	ld	-3 (ix), h
	pop	de
	bit	0, -9 (ix)
	jr	Z, 00124$
	ld	c, -11 (ix)
	ld	b, -10 (ix)
	jr	00125$
00124$:
	ld	c, -8 (ix)
	ld	b, -7 (ix)
00125$:
	ld	a, -2 (ix)
	sub	a, c
	ld	l, a
	ld	a, -1 (ix)
	sbc	a, b
	push	de
	ld	h, a
	call	___sint2fs
	ld	c, e
	ld	b, d
	pop	de
	push	hl
	push	bc
	ex	de, hl
	call	___sint2fs
	push	hl
	pop	iy
	pop	bc
	pop	hl
	push	iy
	push	de
	ld	e, c
	ld	d, b
;video.c:567: int16_t ax = p0.x + (int16_t)((p2.x - p0.x) * alpha);
	call	___fsdiv
	ld	c, e
	ld	b, d
	ex	de,hl
	ld	a, 4 (ix)
	ld	-8 (ix), a
	ld	a, 5 (ix)
	ld	-7 (ix), a
	ld	a, 12 (ix)
	ld	h, 13 (ix)
	sub	a, -8 (ix)
	ld	l, a
	ld	a, h
	sbc	a, -7 (ix)
	push	bc
	push	de
	ld	h, a
	call	___sint2fs
	push	de
	pop	iy
	push	hl
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ex	(sp), hl
	push	hl
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ex	(sp), hl
	push	iy
	pop	de
	call	___fsmul
	call	___fs2sint
	ex	de, hl
	pop	de
	pop	bc
	ld	a, -8 (ix)
	add	a, l
	ld	-17 (ix), a
	ld	a, -7 (ix)
	adc	a, h
	ld	-16 (ix), a
;video.c:568: int16_t bx = second_half
	ld	a, 8 (ix)
	ld	-4 (ix), a
	ld	a, 9 (ix)
	ld	-3 (ix), a
	bit	0, -9 (ix)
	jr	Z, 00126$
	ld	a, 12 (ix)
	ld	h, 13 (ix)
	sub	a, -4 (ix)
	ld	l, a
	ld	a, h
	sbc	a, -3 (ix)
	push	bc
	push	de
	ld	h, a
	call	___sint2fs
	push	de
	pop	iy
	pop	de
	pop	bc
	push	de
	push	bc
	push	iy
	pop	de
	call	___fsmul
	call	___fs2sint
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	add	hl, de
	jr	00127$
00126$:
	ld	a, 4 (ix)
	ld	-6 (ix), a
	ld	a, 5 (ix)
	ld	-5 (ix), a
	ld	a, -4 (ix)
	sub	a, -6 (ix)
	ld	l, a
	ld	a, -3 (ix)
	sbc	a, -5 (ix)
	push	bc
	push	de
	ld	h, a
	call	___sint2fs
	push	de
	pop	iy
	pop	de
	pop	bc
	push	de
	push	bc
	push	iy
	pop	de
	call	___fsmul
	call	___fs2sint
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	add	hl, de
00127$:
	ld	-15 (ix), l
	ld	-14 (ix), h
;video.c:573: if (ax > bx) swap_int16(&ax, &bx);
	ld	a, l
	sub	a, -17 (ix)
	ld	a, h
	sbc	a, -16 (ix)
	jp	PO, 00226$
	xor	a, #0x80
00226$:
	jp	P, 00112$
	ld	hl, #2
	add	hl, sp
	ex	de, hl
	ld	hl, #0
	add	hl, sp
	call	_swap_int16
00112$:
;video.c:576: vga_drawFastHLine(ax, y, (bx - ax + 1), color);
	ld	a, -15 (ix)
	sub	a, -17 (ix)
	ld	c, a
	ld	a, -14 (ix)
	sbc	a, -16 (ix)
	ld	b, a
	inc	bc
	ld	l, 16 (ix)
	ld	h, 17 (ix)
	push	hl
	push	bc
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	ld	l, -17 (ix)
	ld	h, -16 (ix)
	call	_vga_drawFastHLine
00113$:
;video.c:555: for (int16_t y = p0.y; y <= p2.y; y++) {
	inc	-2 (ix)
	jp	NZ, 00116$
	inc	-1 (ix)
	jp	00116$
00117$:
;video.c:578: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	pop	af
	pop	af
	pop	af
	pop	af
	pop	af
	jp	(hl)
;video.c:584: void vga_Print(const char *str) {
;	---------------------------------
; Function vga_Print
; ---------------------------------
_vga_Print::
;video.c:585: while(*str) {
00101$:
	ld	a, (hl)
	or	a, a
	ret	Z
;video.c:587: vga_write((uint8_t)*str++);
	inc	hl
	push	hl
	call	_vga_write
	pop	hl
;video.c:589: }
	jr	00101$
;video.c:595: void vga_Print_int16(int16_t value) {
;	---------------------------------
; Function vga_Print_int16
; ---------------------------------
_vga_Print_int16::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-10
	add	iy, sp
	ld	sp, iy
	ld	c, l
	ld	b, h
;video.c:597: if (value < 0) {
	ld	d, b
	bit	7, d
	jr	Z, 00102$
;video.c:598: vga_Print("-");
	push	bc
	ld	hl, #___str_0
	call	_vga_Print
	pop	bc
;video.c:599: value = -value;
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
00102$:
;video.c:603: if (value == 0) {
	ld	a, b
	or	a, c
	jr	NZ, 00116$
;video.c:604: vga_Print("0");
	ld	hl, #___str_1
	call	_vga_Print
;video.c:605: return;
	jr	00111$
;video.c:613: while (value > 0) {
00116$:
	ld	-1 (ix), #0x00
00105$:
	xor	a, a
	cp	a, c
	sbc	a, b
	jp	PO, 00157$
	xor	a, #0x80
00157$:
	jp	P, 00118$
;video.c:614: buffer[i++] = (value % 10) + '0';
	ld	e, -1 (ix)
	ld	d, #0x00
	ld	hl, #0
	add	hl, sp
	add	hl, de
	inc	-1 (ix)
	push	hl
	push	bc
	ld	de, #0x000a
	ld	l, c
	ld	h, b
	call	__modsint
	pop	bc
	pop	hl
	ld	a, e
	add	a, #0x30
	ld	(hl), a
;video.c:615: value /= 10;
	ld	de, #0x000a
	ld	l, c
	ld	h, b
	call	__divsint
	ld	c, e
	ld	b, d
	jr	00105$
;video.c:619: while (i > 0) {
00118$:
	ld	c, -1 (ix)
00108$:
	ld	a, c
	or	a, a
	jr	Z, 00111$
;video.c:620: char s[2] = {buffer[--i], '\0'};
	dec	c
	ld	e, c
	ld	d, #0x00
	ld	hl, #0
	add	hl, sp
	add	hl, de
	ld	a, (hl)
	ld	-3 (ix), a
	ld	-2 (ix), #0x00
;video.c:621: vga_Print(s);
	push	bc
	ld	hl, #9
	add	hl, sp
	call	_vga_Print
	pop	bc
	jr	00108$
00111$:
;video.c:623: }
	ld	sp, ix
	pop	ix
	ret
___str_0:
	.ascii "-"
	.db 0x00
___str_1:
	.ascii "0"
	.db 0x00
;video.c:625: void vga_print_float(float value, uint8_t decimals) {
;	---------------------------------
; Function vga_print_float
; ---------------------------------
_vga_print_float::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	ld	c, l
	ld	b, h
;video.c:627: if (value < 0) {
	push	bc
	push	de
	ld	hl, #0x0000
	push	hl
	push	hl
	ld	l, c
	ld	h, b
	call	___fslt
	pop	de
	pop	bc
	or	a, a
	jr	Z, 00102$
;video.c:628: vga_Print("-");
	push	bc
	push	de
	ld	hl, #___str_2
	call	_vga_Print
	pop	de
	pop	bc
;video.c:629: value = -value;
	ld	a, b
	xor	a,#0x80
	ld	b, a
00102$:
;video.c:633: uint32_t integral = (uint32_t)value;
	push	bc
	push	de
	ld	l, c
	ld	h, b
	call	___fs2ulong
	ld	-4 (ix), e
	ld	-3 (ix), d
	ld	-2 (ix), l
	ld	-1 (ix), h
;video.c:634: vga_print_int(integral); // Uso la tua funzione per gli interi
	ld	e, -4 (ix)
	ld	d, -3 (ix)
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	call	_vga_print_int
	pop	de
	pop	bc
;video.c:637: if (decimals > 0) {
	ld	a, 4 (ix)
	or	a, a
	jr	Z, 00109$
;video.c:638: vga_Print(".");
	push	bc
	push	de
	ld	hl, #___str_3
	call	_vga_Print
;video.c:641: float fraction = value - (float)integral;
	ld	e, -4 (ix)
	ld	d, -3 (ix)
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	call	___ulong2fs
	push	de
	pop	iy
	pop	de
	pop	bc
	push	hl
	push	iy
	ld	l, c
	ld	h, b
;video.c:642: for (uint8_t i = 0; i < decimals; i++) {
	call	___fssub
	ld	-1 (ix), #0x00
00107$:
	ld	a, -1 (ix)
	sub	a, 4 (ix)
	jr	NC, 00109$
;video.c:643: fraction *= 10.0f;
	push	hl
	push	de
	ld	de, #0x0000
	ld	hl, #0x4120
;video.c:644: uint8_t digit = (uint8_t)fraction;
	call	___fsmul
	push	hl
	push	de
	call	___fs2uchar
	ld	-2 (ix), a
	pop	de
	pop	hl
;video.c:645: vga_print_int(digit);
	ld	c, -2 (ix)
	ld	b, #0x00
	ld	iy, #0x0000
	push	hl
	push	de
	push	iy
	pop	hl
	ld	e, c
	ld	d, b
	call	_vga_print_int
;video.c:646: fraction -= (float)digit;
	ld	a, -2 (ix)
	call	___uchar2fs
	push	hl
	pop	iy
	ld	c, e
	ld	b, d
	pop	de
	pop	hl
	push	iy
	push	bc
;video.c:642: for (uint8_t i = 0; i < decimals; i++) {
	call	___fssub
	inc	-1 (ix)
	jr	00107$
00109$:
;video.c:649: }
	ld	sp, ix
	pop	ix
	pop	hl
	inc	sp
	jp	(hl)
___str_2:
	.ascii "-"
	.db 0x00
___str_3:
	.ascii "."
	.db 0x00
;video.c:651: void vga_print_hex8(uint8_t value) {
;	---------------------------------
; Function vga_print_hex8
; ---------------------------------
_vga_print_hex8::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-19
	add	hl, sp
	ld	sp, hl
	ld	c, a
;video.c:653: const char hex_chars[] = "0123456789ABCDEF";
	ld	-19 (ix), #0x30
	ld	-18 (ix), #0x31
	ld	-17 (ix), #0x32
	ld	-16 (ix), #0x33
	ld	-15 (ix), #0x34
	ld	-14 (ix), #0x35
	ld	-13 (ix), #0x36
	ld	-12 (ix), #0x37
	ld	-11 (ix), #0x38
	ld	-10 (ix), #0x39
	ld	-9 (ix), #0x41
	ld	-8 (ix), #0x42
	ld	-7 (ix), #0x43
	ld	-6 (ix), #0x44
	ld	-5 (ix), #0x45
	ld	-4 (ix), #0x46
	ld	-3 (ix), #0x00
;video.c:657: uint8_t high_nibble = (value >> 4) & 0x0F;
	ld	a, c
	rlca
	rlca
	rlca
	rlca
	and	a, #0xf
	ld	e, a
;video.c:661: uint8_t low_nibble = value & 0x0F;
	ld	a, c
	and	a, #0x0f
	ld	c, a
;video.c:665: char buf[2] = {0, 0}; 
	ld	-2 (ix), #0x00
	ld	-1 (ix), #0x00
;video.c:668: buf[0] = hex_chars[high_nibble];
	ld	d, #0x00
	ld	hl, #0
	add	hl, sp
	add	hl, de
	ld	a, (hl)
	ld	-2 (ix), a
;video.c:669: vga_Print(buf);
	push	bc
	ld	hl, #19
	add	hl, sp
	call	_vga_Print
	pop	bc
;video.c:672: buf[0] = hex_chars[low_nibble];
	ld	e, c
	ld	d, #0x00
	ld	hl, #0
	add	hl, sp
	add	hl, de
	ld	a, (hl)
	ld	-2 (ix), a
;video.c:673: vga_Print(buf);
	ld	hl, #17
	add	hl, sp
	call	_vga_Print
;video.c:674: }
	ld	sp, ix
	pop	ix
	ret
;video.c:705: void vga_print_int(int32_t num) {
;	---------------------------------
; Function vga_print_int
; ---------------------------------
_vga_print_int::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-15
	add	iy, sp
	ld	sp, iy
	ld	c, e
	ld	b, d
	ex	de,hl
;video.c:709: if (num == 0) {
	ld	a, d
	or	a, e
	or	a, b
	or	a, c
	jr	NZ, 00102$
;video.c:710: vga_Print("0");
	ld	hl, #___str_5
	call	_vga_Print
;video.c:711: return;
	jp	00113$
00102$:
;video.c:714: if (num < 0) {
	bit	7, d
	jr	Z, 00119$
;video.c:715: vga_Print("-");
	push	bc
	push	de
	ld	hl, #___str_6
	call	_vga_Print
	pop	de
	pop	bc
;video.c:716: if (num == -2147483648) {
	ld	a, c
	or	a, a
	or	a, b
	or	a, e
	jr	NZ, 00104$
	ld	a, d
	sub	a, #0x80
	jr	NZ, 00104$
;video.c:717: vga_Print("2147483648");
	ld	hl, #___str_7
	call	_vga_Print
;video.c:718: return;
	jr	00113$
00104$:
;video.c:720: num = -num;
	xor	a, a
	sub	a, c
	ld	c, a
	ld	a, #0x00
	sbc	a, b
	ld	b, a
	ld	hl, #0x0000
	sbc	hl, de
	ex	de, hl
;video.c:723: while (num > 0) {
00119$:
	ld	-1 (ix), #0x00
00107$:
	xor	a, a
	cp	a, c
	sbc	a, b
	ld	a, #0x00
	sbc	a, e
	ld	a, #0x00
	sbc	a, d
	jp	PO, 00168$
	xor	a, #0x80
00168$:
	jp	P, 00121$
;video.c:726: int32_t q = alu_div(num, 10);
	ld	hl, #0x0000
	push	hl
	ld	l, #0x0a
	ex	de, hl
	push	de
	ld	e, c
	ld	d, b
	call	_alu_div
	pop	af
	ex	(sp),hl
	pop	iy
;video.c:730: uint16_t r = alu_get_mod(); 
	push	de
	push	iy
	call	_alu_get_mod
	pop	iy
	pop	bc
;video.c:732: buffer[i++] = (uint8_t)r + '0';
	push	de
	ld	e, -1 (ix)
	ld	d, #0x00
	ld	hl, #2
	add	hl, sp
	add	hl, de
	pop	de
	inc	-1 (ix)
	ld	a, e
	add	a, #0x30
	ld	(hl), a
;video.c:735: num = q;
	push	iy
	pop	de
	jr	00107$
;video.c:739: while (i > 0) {
00121$:
	ld	c, -1 (ix)
00110$:
	ld	a, c
	or	a, a
	jr	Z, 00113$
;video.c:740: char c[2] = {buffer[--i], '\0'};
	dec	c
	ld	e, c
	ld	d, #0x00
	ld	hl, #0
	add	hl, sp
	add	hl, de
	ld	a, (hl)
	ld	-3 (ix), a
	ld	-2 (ix), #0x00
;video.c:741: vga_Print(c);
	push	bc
	ld	hl, #14
	add	hl, sp
	call	_vga_Print
	pop	bc
	jr	00110$
00113$:
;video.c:743: }
	ld	sp, ix
	pop	ix
	ret
___str_5:
	.ascii "0"
	.db 0x00
___str_6:
	.ascii "-"
	.db 0x00
___str_7:
	.ascii "2147483648"
	.db 0x00
;video.c:745: void vga_print_int_safe(int32_t num) {
;	---------------------------------
; Function vga_print_int_safe
; ---------------------------------
_vga_print_int_safe::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-9
	add	iy, sp
	ld	sp, iy
	ld	c, e
	ld	b, d
	ex	de,hl
;video.c:752: if (num == 0) {
	ld	a, d
	or	a, e
	or	a, b
	or	a, c
	jr	NZ, 00102$
;video.c:753: vga_Print("0");
	ld	hl, #___str_8
	call	_vga_Print
;video.c:754: return;
	jp	00118$
00102$:
;video.c:757: if (num < 0) {
	bit	7, d
	jr	Z, 00106$
;video.c:758: vga_Print("-");
	push	bc
	push	de
	ld	hl, #___str_9
	call	_vga_Print
	pop	de
	pop	bc
;video.c:760: if (num == -2147483648) {
	ld	a, c
	or	a, a
	or	a, b
	or	a, e
	jr	NZ, 00104$
	ld	a, d
	sub	a, #0x80
	jr	NZ, 00104$
;video.c:761: vga_Print("2147483648");
	ld	hl, #___str_10
	call	_vga_Print
;video.c:762: return;
	jp	00118$
00104$:
;video.c:764: num = -num;
	xor	a, a
	sub	a, c
	ld	c, a
	ld	a, #0x00
	sbc	a, b
	ld	b, a
	ld	hl, #0x0000
	sbc	hl, de
	ex	de, hl
00106$:
;video.c:768: uint8_t started = 0; // Per non stampare gli zeri iniziali (es: 0000032768)
	ld	-3 (ix), #0x00
;video.c:770: for (uint8_t i = 0; i < 10; i++) {
	ld	-1 (ix), #0x00
00116$:
	ld	a, -1 (ix)
	sub	a, #0x0a
	jp	NC, 00118$
;video.c:772: int32_t p = powers10[i];
	ld	l, -1 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	iy, #_vga_print_int_safe_powers10_10000_260
	push	bc
	ld	c, l
	ld	b, h
	add	iy, bc
	pop	bc
	ld	a, 0 (iy)
	ld	-9 (ix), a
	ld	a, 1 (iy)
	ld	-8 (ix), a
	ld	a, 2 (iy)
	ld	-7 (ix), a
	ld	a, 3 (iy)
	ld	-6 (ix), a
;video.c:776: while (num >= p) {
	ld	l, #0x00
00107$:
	ld	a, c
	sub	a, -9 (ix)
	ld	a, b
	sbc	a, -8 (ix)
	ld	a, e
	sbc	a, -7 (ix)
	ld	a, d
	sbc	a, -6 (ix)
	jp	PO, 00187$
	xor	a, #0x80
00187$:
	jp	M, 00129$
;video.c:777: num -= p;
	ld	a, c
	sub	a, -9 (ix)
	ld	c, a
	ld	a, b
	sbc	a, -8 (ix)
	ld	b, a
	ld	a, e
	sbc	a, -7 (ix)
	ld	e, a
	ld	a, d
	sbc	a, -6 (ix)
	ld	d, a
;video.c:778: digit++;
	inc	l
	jr	00107$
00129$:
	ld	-2 (ix), l
;video.c:781: if (digit > 0 || started || i == 9) {
	ld	a, l
	or	a, a
	jr	NZ, 00110$
	ld	a, -3 (ix)
	or	a, a
	jr	NZ, 00110$
	ld	a, -1 (ix)
	sub	a, #0x09
	jr	NZ, 00117$
00110$:
;video.c:783: c[0] = digit + '0';
	ld	hl, #4
	add	hl, sp
	ld	a, -2 (ix)
	add	a, #0x30
	ld	(hl), a
;video.c:784: c[1] = '\0';
	ld	-4 (ix), #0x00
;video.c:785: vga_Print(c);
	push	bc
	push	de
	call	_vga_Print
	pop	de
	pop	bc
;video.c:786: started = 1; // Da qui in poi stampiamo anche gli zeri (es: 102)
	ld	-3 (ix), #0x01
00117$:
;video.c:770: for (uint8_t i = 0; i < 10; i++) {
	inc	-1 (ix)
	jp	00116$
00118$:
;video.c:789: }
	ld	sp, ix
	pop	ix
	ret
_vga_print_int_safe_powers10_10000_260:
	.byte #0x00, #0xca, #0x9a, #0x3b	;  1000000000
	.byte #0x00, #0xe1, #0xf5, #0x05	;  100000000
	.byte #0x80, #0x96, #0x98, #0x00	;  10000000
	.byte #0x40, #0x42, #0x0f, #0x00	;  1000000
	.byte #0xa0, #0x86, #0x01, #0x00	;  100000
	.byte #0x10, #0x27, #0x00, #0x00	;  10000
	.byte #0xe8, #0x03, #0x00, #0x00	;  1000
	.byte #0x64, #0x00, #0x00, #0x00	;  100
	.byte #0x0a, #0x00, #0x00, #0x00	;  10
	.byte #0x01, #0x00, #0x00, #0x00	;  1
___str_8:
	.ascii "0"
	.db 0x00
___str_9:
	.ascii "-"
	.db 0x00
___str_10:
	.ascii "2147483648"
	.db 0x00
;video.c:795: size_t vga_write(uint8_t uniCode)
;	---------------------------------
; Function vga_write
; ---------------------------------
_vga_write::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-11
	add	hl, sp
	ld	sp, hl
;video.c:798: if (uniCode == '\r') return 1;
	ld	-1 (ix), a
	sub	a, #0x0d
	jr	NZ, 00102$
	ld	de, #0x0001
	jp	00113$
00102$:
;video.c:800: unsigned int width = 0;
	ld	hl, #0x0000
	ex	(sp), hl
;video.c:801: unsigned int height = 0;
	xor	a, a
	ld	-3 (ix), a
	ld	-2 (ix), a
;video.c:804: if (textfont == 2)
	ld	a, (_textfont+0)
	sub	a, #0x02
	jr	NZ, 00104$
;video.c:807: width = widtbl_f16[uniCode - 32];
	ld	a, -1 (ix)
	ld	-2 (ix), a
	add	a, #0xe0
	ld	-2 (ix), a
	ld	-5 (ix), a
	rlca
	sbc	a, a
	ld	-4 (ix), a
	ld	a, #<(_widtbl_f16)
	add	a, -5 (ix)
	ld	-3 (ix), a
	ld	a, #>(_widtbl_f16)
	adc	a, -4 (ix)
	ld	-2 (ix), a
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	ld	a, (hl)
	ld	-2 (ix), a
	ld	-7 (ix), a
	ld	-6 (ix), #0x00
;video.c:808: height = chr_hgt_f16;
	ld	-3 (ix), #0x10
	ld	-2 (ix), #0
;video.c:810: width = (width + 6) / 8;
	ld	a, -7 (ix)
	add	a, #0x06
	ld	-5 (ix), a
	ld	a, #0x00
	adc	a, #0x00
	ld	-4 (ix), a
	srl	-4 (ix)
	rr	-5 (ix)
	srl	-4 (ix)
	rr	-5 (ix)
	srl	-4 (ix)
	rr	-5 (ix)
;video.c:811: width = width * 8; 
	ld	a, -5 (ix)
	ld	-11 (ix), a
	ld	-10 (ix), #0x00
	ld	b, #0x03
00161$:
	sla	-11 (ix)
	rl	-10 (ix)
	djnz	00161$
00104$:
;video.c:827: if (textfont == 1)
	ld	a, (_textfont+0)
	dec	a
	jr	NZ, 00106$
;video.c:829: width = 6;
	ld	hl, #0x0006
	ex	(sp), hl
;video.c:830: height = 8;
	ld	-3 (ix), #0x08
	ld	-2 (ix), #0
00106$:
;video.c:837: height = height * textsize;
	ld	a, (_textsize+0)
	ld	-9 (ix), a
	ld	-8 (ix), #0x00
	pop	hl
	pop	de
	push	de
	push	hl
	ld	l, -3 (ix)
	ld	h, #0x00
;video.c:841: cursor_y += height;
	call	__mulint
	ld	-7 (ix), e
	ld	-6 (ix), d
	ld	hl, (_cursor_y)
	ld	-5 (ix), l
	ld	-4 (ix), h
	ld	a, -5 (ix)
	add	a, -7 (ix)
	ld	-3 (ix), a
	ld	a, -4 (ix)
	adc	a, -6 (ix)
	ld	-2 (ix), a
;video.c:840: if (uniCode == '\n') {
	ld	a, -1 (ix)
	sub	a, #0x0a
	jr	NZ, 00111$
;video.c:841: cursor_y += height;
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	ld	(_cursor_y), hl
;video.c:842: cursor_x  = 0;
	ld	hl, #0x0000
	ld	(_cursor_x), hl
	jp	00112$
00111$:
;video.c:848: if (textwrap && (cursor_x + width * textsize >= 640))
	ld	hl, #_textwrap
	bit	0, (hl)
	jr	Z, 00108$
	pop	hl
	pop	de
	push	de
	push	hl
	call	__mulint
	ld	-9 (ix), e
	ld	-8 (ix), d
	ld	hl, (_cursor_x)
	ld	-7 (ix), l
	ld	-6 (ix), h
	ld	a, -7 (ix)
	add	a, -9 (ix)
	ld	-5 (ix), a
	ld	a, -6 (ix)
	adc	a, -8 (ix)
	ld	-4 (ix), a
	ld	a, -5 (ix)
	sub	a, #0x80
	ld	a, -4 (ix)
	sbc	a, #0x02
	jr	C, 00108$
;video.c:850: cursor_y += height;
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	ld	(_cursor_y), hl
;video.c:851: cursor_x = 0;
	ld	hl, #0x0000
	ld	(_cursor_x), hl
00108$:
;video.c:857: cursor_x += vga_drawChar(uniCode, cursor_x, cursor_y, textfont);
	ld	a, (_textfont+0)
	ld	-9 (ix), a
	ld	-8 (ix), #0x00
	ld	hl, (_cursor_y)
	ld	-7 (ix), l
	ld	-6 (ix), h
	ld	hl, (_cursor_x)
	ld	-5 (ix), l
	ld	-4 (ix), h
	ld	a, -1 (ix)
	ld	-3 (ix), a
	ld	-2 (ix), #0x00
	pop	de
	pop	hl
	push	hl
	push	de
	push	hl
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	push	hl
	ld	e, -5 (ix)
	ld	d, -4 (ix)
	ld	l, -3 (ix)
	ld	h, #0x00
	call	_vga_drawChar
	ld	-7 (ix), e
	ld	-6 (ix), d
	ld	hl, (_cursor_x)
	ld	-5 (ix), l
	ld	-4 (ix), h
	ld	a, -5 (ix)
	add	a, -7 (ix)
	ld	-3 (ix), a
	ld	a, -4 (ix)
	adc	a, -6 (ix)
	ld	-2 (ix), a
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	ld	(_cursor_x), hl
00112$:
;video.c:860: return 1;
	ld	de, #0x0001
00113$:
;video.c:861: }
	ld	sp, ix
	pop	ix
	ret
;video.c:863: void vga_drawLine_Clipped(uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2, uint16_t color, uint16_t y_min, uint16_t y_max) {
;	---------------------------------
; Function vga_drawLine_Clipped
; ---------------------------------
_vga_drawLine_Clipped::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-23
	add	iy, sp
	ld	sp, iy
	ld	-8 (ix), l
	ld	-7 (ix), h
	ld	-10 (ix), e
	ld	-9 (ix), d
;video.c:867: int16_t startY = (y1 < y2 ? y1 : y2);
	ld	a, 6 (ix)
	ld	-18 (ix), a
	ld	a, 7 (ix)
	ld	-17 (ix), a
;video.c:865: if (x1 == x2) {
	ld	a, 4 (ix)
	sub	a, -8 (ix)
	jp	NZ, 00108$
	ld	a, 5 (ix)
	sub	a, -7 (ix)
	jp	NZ, 00108$
;video.c:867: int16_t startY = (y1 < y2 ? y1 : y2);
	ld	a, -10 (ix)
	sub	a, 6 (ix)
	ld	a, -9 (ix)
	sbc	a, 7 (ix)
	jr	NC, 00129$
	ld	a, -10 (ix)
	ld	-2 (ix), a
	ld	a, -9 (ix)
	ld	-1 (ix), a
	jr	00130$
00129$:
	ld	a, -18 (ix)
	ld	-2 (ix), a
	ld	a, -17 (ix)
	ld	-1 (ix), a
00130$:
	ld	a, -2 (ix)
	ld	-4 (ix), a
	ld	a, -1 (ix)
	ld	-3 (ix), a
;video.c:868: int16_t endY = (y1 > y2 ? y1 : y2);
	ld	a, 6 (ix)
	sub	a, -10 (ix)
	ld	a, 7 (ix)
	sbc	a, -9 (ix)
	jr	NC, 00131$
	ld	a, -10 (ix)
	ld	-2 (ix), a
	ld	a, -9 (ix)
	ld	-1 (ix), a
	jr	00132$
00131$:
	ld	a, -18 (ix)
	ld	-2 (ix), a
	ld	a, -17 (ix)
	ld	-1 (ix), a
00132$:
	ld	c, -2 (ix)
	ld	b, -1 (ix)
;video.c:870: if (startY < y_min) startY = y_min;
	ld	a, -4 (ix)
	ld	d, -3 (ix)
	sub	a, 10 (ix)
	ld	a, d
	sbc	a, 11 (ix)
	jr	NC, 00102$
	ld	a, 10 (ix)
	ld	-4 (ix), a
	ld	a, 11 (ix)
	ld	-3 (ix), a
00102$:
;video.c:871: if (endY > y_max)   endY = y_max;
	ld	e, c
	ld	d, b
	ld	a, 12 (ix)
	sub	a, e
	ld	a, 13 (ix)
	sbc	a, d
	jr	NC, 00104$
	ld	c, 12 (ix)
	ld	b, 13 (ix)
00104$:
;video.c:873: if (startY <= endY) {
	ld	a, c
	sub	a, -4 (ix)
	ld	a, b
	sbc	a, -3 (ix)
	jp	PO, 00292$
	xor	a, #0x80
00292$:
	jp	M, 00127$
;video.c:874: vga_drawFastVLine(x1, startY, (endY - startY) + 1, color);
	ld	a, c
	sub	a, -4 (ix)
	ld	c, a
	ld	a, b
	sbc	a, -3 (ix)
	ld	b, a
	inc	bc
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	push	hl
	push	bc
	ld	e, -4 (ix)
	ld	d, -3 (ix)
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	call	_vga_drawFastVLine
;video.c:876: return;
	jp	00127$
00108$:
;video.c:882: vga_drawFastHLine((x1 < x2 ? x1 : x2), y1, abs((int16_t)x2 - (int16_t)x1) + 1, color);
	ld	a, 4 (ix)
	ld	-16 (ix), a
	ld	a, 5 (ix)
	ld	-15 (ix), a
;video.c:879: if (y1 == y2) {
	ld	a, 6 (ix)
	sub	a, -10 (ix)
	jr	NZ, 00113$
	ld	a, 7 (ix)
	sub	a, -9 (ix)
	jr	NZ, 00113$
;video.c:881: if (y1 >= y_min && y1 <= y_max) {
	ld	a, -10 (ix)
	sub	a, 10 (ix)
	ld	a, -9 (ix)
	sbc	a, 11 (ix)
	jp	C, 00127$
	ld	a, 12 (ix)
	sub	a, -10 (ix)
	ld	a, 13 (ix)
	sbc	a, -9 (ix)
	jp	C, 00127$
;video.c:882: vga_drawFastHLine((x1 < x2 ? x1 : x2), y1, abs((int16_t)x2 - (int16_t)x1) + 1, color);
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	ld	c, -8 (ix)
	ld	b, -7 (ix)
	cp	a, a
	sbc	hl, bc
	call	_abs
	inc	de
	ld	a, -8 (ix)
	sub	a, 4 (ix)
	ld	a, -7 (ix)
	sbc	a, 5 (ix)
	jr	NC, 00133$
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	jr	00134$
00133$:
	ld	l, -16 (ix)
	ld	h, -15 (ix)
00134$:
	ld	c, 8 (ix)
	ld	b, 9 (ix)
	push	bc
	push	de
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	call	_vga_drawFastHLine
;video.c:884: return;
	jp	00127$
00113$:
;video.c:888: int16_t x = x1;
	ld	a, -8 (ix)
	ld	-2 (ix), a
	ld	a, -7 (ix)
	ld	-1 (ix), a
;video.c:889: int16_t y = y1;
	ld	a, -10 (ix)
	ld	-6 (ix), a
	ld	a, -9 (ix)
	ld	-5 (ix), a
;video.c:890: int16_t x_fine = x2;
	ld	a, -16 (ix)
	ld	-23 (ix), a
	ld	a, -15 (ix)
	ld	-22 (ix), a
;video.c:891: int16_t y_fine = y2;
	ld	a, -18 (ix)
	ld	-12 (ix), a
	ld	a, -17 (ix)
	ld	-11 (ix), a
;video.c:893: bool steep = abs(y_fine - y) > abs(x_fine - x);
	ld	a, -12 (ix)
	sub	a, -10 (ix)
	ld	-4 (ix), a
	ld	a, -11 (ix)
	sbc	a, -9 (ix)
	ld	-3 (ix), a
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	call	_abs
	ld	-14 (ix), e
	ld	-13 (ix), d
	ld	a, -23 (ix)
	sub	a, -8 (ix)
	ld	-4 (ix), a
	ld	a, -22 (ix)
	sbc	a, -7 (ix)
	ld	-3 (ix), a
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	call	_abs
	ld	-4 (ix), e
	ld	-3 (ix), d
	ld	a, -4 (ix)
	sub	a, -14 (ix)
	ld	a, -3 (ix)
	sbc	a, -13 (ix)
	jp	PO, 00295$
	xor	a, #0x80
00295$:
	rlca
	and	a,#0x01
	ld	-21 (ix), a
;video.c:894: if (steep) {
	bit	0, -21 (ix)
	jr	Z, 00115$
;video.c:896: tmp = x; x = y; y = tmp;
	ld	a, -10 (ix)
	ld	-2 (ix), a
	ld	a, -9 (ix)
	ld	-1 (ix), a
	ld	a, -8 (ix)
	ld	-6 (ix), a
	ld	a, -7 (ix)
	ld	-5 (ix), a
;video.c:897: tmp = x_fine; x_fine = y_fine; y_fine = tmp;
	ld	a, -16 (ix)
	ld	-12 (ix), a
	ld	a, -15 (ix)
	ld	-11 (ix), a
	ld	a, -18 (ix)
	ld	-23 (ix), a
	ld	a, -17 (ix)
	ld	-22 (ix), a
00115$:
;video.c:900: if (x > x_fine) {
	ld	a, -23 (ix)
	sub	a, -2 (ix)
	ld	a, -22 (ix)
	sbc	a, -1 (ix)
	jp	PO, 00296$
	xor	a, #0x80
00296$:
	jp	P, 00117$
;video.c:902: tmp = x; x = x_fine; x_fine = tmp;
	ld	a, -2 (ix)
	ld	-4 (ix), a
	ld	a, -1 (ix)
	ld	-3 (ix), a
	ld	a, -23 (ix)
	ld	-2 (ix), a
	ld	a, -22 (ix)
	ld	-1 (ix), a
	ld	a, -4 (ix)
	ld	-23 (ix), a
	ld	a, -3 (ix)
	ld	-22 (ix), a
;video.c:903: tmp = y; y = y_fine; y_fine = tmp;
	ld	a, -6 (ix)
	ld	-4 (ix), a
	ld	a, -5 (ix)
	ld	-3 (ix), a
	ld	a, -12 (ix)
	ld	-6 (ix), a
	ld	a, -11 (ix)
	ld	-5 (ix), a
	ld	a, -4 (ix)
	ld	-12 (ix), a
	ld	a, -3 (ix)
	ld	-11 (ix), a
00117$:
;video.c:906: int16_t dx = x_fine - x;
	ld	a, -23 (ix)
	sub	a, -2 (ix)
	ld	-20 (ix), a
	ld	a, -22 (ix)
	sbc	a, -1 (ix)
	ld	-19 (ix), a
;video.c:907: int16_t dy = abs(y_fine - y);
	ld	a, -12 (ix)
	sub	a, -6 (ix)
	ld	c, a
	ld	a, -11 (ix)
	sbc	a, -5 (ix)
	ld	-4 (ix), c
	ld	-3 (ix), a
	ld	l, c
	ld	h, a
	call	_abs
	ld	-4 (ix), e
	ld	-3 (ix), d
	ld	a, -4 (ix)
	ld	-18 (ix), a
	ld	a, -3 (ix)
	ld	-17 (ix), a
;video.c:908: int16_t err = dx / 2;
	ld	a, -20 (ix)
	ld	-14 (ix), a
	ld	a, -19 (ix)
	ld	-13 (ix), a
	ld	a, -14 (ix)
	ld	-4 (ix), a
	ld	a, -13 (ix)
	ld	-3 (ix), a
	bit	7, -13 (ix)
	jr	Z, 00135$
	ld	a, -14 (ix)
	add	a, #0x01
	ld	-4 (ix), a
	ld	a, -13 (ix)
	adc	a, #0x00
	ld	-3 (ix), a
00135$:
	ld	c, -4 (ix)
	ld	b, -3 (ix)
	sra	b
	rr	c
	ld	-4 (ix), c
	ld	-3 (ix), b
;video.c:909: int16_t ystep = (y < y_fine) ? 1 : -1;
	ld	a, -6 (ix)
	sub	a, -12 (ix)
	ld	a, -5 (ix)
	sbc	a, -11 (ix)
	jp	PO, 00297$
	xor	a, #0x80
00297$:
	jp	P, 00136$
	ld	-11 (ix), #0x01
	jr	00137$
00136$:
	ld	-11 (ix), #0xff
00137$:
	ld	a, -11 (ix)
	ld	-16 (ix), a
	rlca
	sbc	a, a
	ld	-15 (ix), a
00125$:
;video.c:912: for (; x <= x_fine; x++) {
	ld	a, -23 (ix)
	sub	a, -2 (ix)
	ld	a, -22 (ix)
	sbc	a, -1 (ix)
	jp	PO, 00298$
	xor	a, #0x80
00298$:
	jp	M, 00127$
;video.c:914: int16_t realX = steep ? y : x;
	bit	0, -21 (ix)
	jr	Z, 00138$
	ld	a, -6 (ix)
	ld	-12 (ix), a
	ld	a, -5 (ix)
	ld	-11 (ix), a
	jr	00139$
00138$:
	ld	a, -2 (ix)
	ld	-12 (ix), a
	ld	a, -1 (ix)
	ld	-11 (ix), a
00139$:
	ld	a, -12 (ix)
	ld	-14 (ix), a
	ld	a, -11 (ix)
	ld	-13 (ix), a
;video.c:915: int16_t realY = steep ? x : y;
	bit	0, -21 (ix)
	jr	Z, 00140$
	ld	a, -2 (ix)
	ld	-12 (ix), a
	ld	a, -1 (ix)
	ld	-11 (ix), a
	jr	00141$
00140$:
	ld	a, -6 (ix)
	ld	-12 (ix), a
	ld	a, -5 (ix)
	ld	-11 (ix), a
00141$:
;video.c:919: if (realY >= y_min && realY <= y_max) {
	ld	c, -12 (ix)
	ld	b, -11 (ix)
	ld	a, c
	sub	a, 10 (ix)
	ld	a, b
	sbc	a, 11 (ix)
	jr	C, 00119$
	ld	a, 12 (ix)
	sub	a, c
	ld	a, 13 (ix)
	sbc	a, b
	jr	C, 00119$
;video.c:920: vga_pixel_fast(realX, realY, color);
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	push	hl
	ld	e, -12 (ix)
	ld	d, -11 (ix)
	ld	l, -14 (ix)
	ld	h, -13 (ix)
	call	_vga_pixel_fast
00119$:
;video.c:923: err -= dy;
	ld	a, -4 (ix)
	sub	a, -18 (ix)
	ld	-4 (ix), a
	ld	a, -3 (ix)
	sbc	a, -17 (ix)
	ld	-3 (ix), a
;video.c:924: if (err < 0) {
	ld	c, -4 (ix)
	ld	b, -3 (ix)
	bit	7, b
	jr	Z, 00126$
;video.c:925: y += ystep;
	ld	a, -16 (ix)
	add	a, -6 (ix)
	ld	-6 (ix), a
	ld	a, -15 (ix)
	adc	a, -5 (ix)
	ld	-5 (ix), a
;video.c:926: err += dx;
	ld	a, -4 (ix)
	add	a, -20 (ix)
	ld	-4 (ix), a
	ld	a, -3 (ix)
	adc	a, -19 (ix)
	ld	-3 (ix), a
00126$:
;video.c:912: for (; x <= x_fine; x++) {
	inc	-2 (ix)
	jp	NZ, 00125$
	inc	-1 (ix)
	jp	00125$
00127$:
;video.c:929: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	pop	af
	pop	af
	pop	af
	jp	(hl)
;video.c:931: void draw_rgb_bars() {
;	---------------------------------
; Function draw_rgb_bars
; ---------------------------------
_draw_rgb_bars::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-13
	add	hl, sp
	ld	sp, hl
;video.c:939: uint16_t colors[3] = {0x0038, 0x01C0, 0x0007};
	ld	-13 (ix), #0x38
	ld	-12 (ix), #0
	ld	-11 (ix), #0xc0
	ld	-10 (ix), #0x01
	ld	-9 (ix), #0x07
	ld	-8 (ix), #0
;video.c:941: for (uint8_t i = 0; i < 3; i++) {
	ld	c, #0x00
00113$:
	ld	a, c
	sub	a, #0x03
	jp	NC, 00115$
;video.c:942: color = colors[i];
	ld	-7 (ix), c
	ld	-6 (ix), #0x00
	ld	l, -7 (ix)
	ld	h, #0x00
	add	hl, hl
	ld	iy, #0
	add	iy, sp
	ex	de, hl
	add	iy, de
	ld	a, 0 (iy)
	ld	-5 (ix), a
	ld	a, 1 (iy)
	ld	-4 (ix), a
;video.c:944: for (x = 100 + (i * 40); x < 100 + ((i + 1) * 40); x++) {
	ld	e, -7 (ix)
	ld	d, -6 (ix)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #0x0064
	add	hl, de
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	b, -4 (ix)
00110$:
	ld	e, -7 (ix)
	ld	d, #0x00
	inc	de
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #0x0064
	add	hl, de
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	ld	a, e
	sub	a, l
	ld	a, d
	sbc	a, h
	jr	NC, 00114$
;video.c:949: while (VGA_REG_STAT & 0x01); 
	ld	a, -1 (ix)
	ld	-3 (ix), a
	ld	de, #0x0032
00101$:
	ld	a, (#0xc005)
	rrca
	jr	C, 00101$
;video.c:952: VIDEO_REG_X_L = (uint8_t)x;
	ld	a, -2 (ix)
	ld	hl, #0xc000
	ld	(hl), a
;video.c:953: VIDEO_REG_X_H = (uint8_t)(x >> 8);
	ld	l, #0x01
	ld	a, -3 (ix)
	ld	(hl), a
;video.c:954: VIDEO_REG_Y_L = (uint8_t)y;
	ld	a, e
	ld	l, #0x02
	ld	(hl), a
;video.c:955: VIDEO_REG_Y_H = (uint8_t)(y >> 8);
	ld	a, d
	ld	l, #0x03
	ld	(hl), a
;video.c:958: VIDEO_REG_DATA_L = (uint8_t)color;
	ld	a, -5 (ix)
	ld	l, #0x04
	ld	(hl), a
;video.c:961: VIDEO_REG_DATA_H = (uint8_t)(color >> 8); 
	ld	l, #0x05
	ld	(hl), b
;video.c:945: for (y = 50; y < 200; y++) {
	inc	de
	ld	l, e
	ld	h, d
	ld	a, l
	sub	a, #0xc8
	ld	a, h
	sbc	a, #0x00
	jr	C, 00101$
;video.c:944: for (x = 100 + (i * 40); x < 100 + ((i + 1) * 40); x++) {
	inc	-2 (ix)
	jr	NZ, 00110$
	inc	-1 (ix)
	jr	00110$
00114$:
;video.c:941: for (uint8_t i = 0; i < 3; i++) {
	inc	c
	jp	00113$
00115$:
;video.c:965: }
	ld	sp, ix
	pop	ix
	ret
;video.c:971: void vga_set_display_page(uint8_t page) {
;	---------------------------------
; Function vga_set_display_page
; ---------------------------------
_vga_set_display_page::
;video.c:972: VIDEO_REG_READ_PAGE = (page & 0x1F);
	and	a, #0x1f
	ld	(#0xc007),a
;video.c:973: }
	ret
;video.c:979: void vga_set_work_page(uint8_t page) {
;	---------------------------------
; Function vga_set_work_page
; ---------------------------------
_vga_set_work_page::
;video.c:980: VIDEO_REG_WRITE_PAGE = (page & 0x1F);
	and	a, #0x1f
	ld	(#0xc008),a
;video.c:981: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit___width:
	.dw #0x0280
__xinit___height:
	.dw #0x01e0
__xinit___rotation:
	.db #0x00	; 0
__xinit__textwrap:
	.db #0x01	;  1
	.area _CABS (ABS)
