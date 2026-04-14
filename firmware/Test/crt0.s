;;; crt0.s - Startup corretto per SDCC / Z80
    .module crt0
    
    ;; Dichiariamo i simboli esterni
    .globl  _main
    .globl  l__INITIALIZER
    .globl  s__INITIALIZED
    .globl  s__DATA
    
    ;; Definizione Aree (L'ordine qui conta per il Linker!)
    .area   _HEADER (ABS)
    .org    0x0000

    ;; 1. Punto di ingresso al Reset
    di                      ; Disabilita interrupt
    im      1               ; Interrupt mode 1
    ld      sp, #0xC000     ; Stack alla fine della RAM (16KB da 0x8000)
    
    ;; 2. Inizializzazione variabili globali
    ;; Questo blocco copia i dati pre-inizializzati dalla ROM alla RAM
    call    gsinit
    
    ;; 3. Salto al main in C
    call    _main           ; Il compilatore C aggiunge sempre un _ davanti ai nomi
    
    ;; 4. Protezione
    halt

    ;; --- SEZIONE INIZIALIZZAZIONE ---
    .area   _GSINIT
gsinit:
    ld      bc, #l__INITIALIZER
    ld      a, b
    or      a, c
    jr      z, gsinit_next  ; Se non ci sono dati da copiare, salta
    ld      de, #s__INITIALIZED
    ld      hl, #s__DATA
    ldir                    ; Copia HL -> DE per BC volte
gsinit_next:

    .area   _GSFINAL
    ret

    ;; Definizione delle altre aree necessarie a SDCC
    .area   _CODE
    .area   _DATA
    .area   _INITIALIZED
    .area   _BSS
    .area   _HEAP