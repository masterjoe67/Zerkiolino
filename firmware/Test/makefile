# Configurazione Percorsi e Nomi
CC = sdcc
AS = sdasz80
IHX2MIF = srec_cat

# Parametri Z80
FAMILY = -mz80
# Spostiamo il codice C a 0x0100 per lasciare spazio al crt0 (Reset Vector)
CODE_LOC = 0x0100
DATA_LOC = 0x8000

# File del progetto
# crt0.rel DEVE essere il primo della lista
REL_FILES = crt0.rel main.rel video.rel glcdfont.rel sdcard.rel uart_t80.rel
TARGET = firmware

# Regola principale
all: $(TARGET).mif

# Trasforma l'IHX in MIF
# Nota: rimosso -exclude che cancellava il codice! 
# Usiamo solo -fill per riempire i buchi rimasti vuoti.
$(TARGET).mif: $(TARGET).ihx
	$(IHX2MIF) $(TARGET).ihx -intel -fill 0x00 0x0000 0x8000 -o $(TARGET).mif -Memory_Initialization_File 8
	@echo "### COMPILAZIONE COMPLETATA: $(TARGET).mif PRONTO ###"

# Linker
$(TARGET).ihx: $(REL_FILES)
	$(CC) $(FAMILY) --code-loc $(CODE_LOC) --data-loc $(DATA_LOC) --no-std-crt0 $(REL_FILES) -o $(TARGET).ihx

# Compilazione .c
%.rel: %.c
	$(CC) $(FAMILY) -c $< -o $@

# Assemblaggio crt0.s
crt0.rel: crt0.s
	$(AS) -o crt0.rel crt0.s

# Pulizia
clean:
	rm -f *.rel *.ihx *.mif *.lst *.map *.sym *.asm *.lk *.noi