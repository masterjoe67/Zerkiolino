# **************************************************************
# Time Information
# **************************************************************
set_time_format -unit ns -decimal_places 3

# **************************************************************
# Create Clock
# **************************************************************
# Sostituisci 'CLOCK_50' con il nome esatto del pin di clock nel tuo Top Level
create_clock -name clk_50 -period 20.000 [get_ports {CLOCK_50}]

# **************************************************************
# Create Generated Clocks (PLLs)
# **************************************************************
# Questo comando istruisce Quartus a guardare dentro i tuoi moduli PLL_SYS e PLL_VGA
# e creare automaticamente i clock per la CPU (60MHz), SDRAM e VGA (25.175MHz)
derive_pll_clocks

# **************************************************************
# Set Clock Uncertainty (RISOLVE I CRITICAL WARNING)
# **************************************************************
# Questo aggiunge i margini di sicurezza per il jitter e il rumore.
# È l'antidoto alla riga tratteggiata che appare "a caso" dopo la compilazione.
derive_clock_uncertainty

# **************************************************************
# Set Clock Groups
# **************************************************************
# Gestione del clock JTAG di Signal Tap per evitare warning inutili
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 

# **************************************************************
# Set False Path
# **************************************************************
# Indica a Quartus di non impazzire a sincronizzare i segnali JTAG
set_false_path -from [get_ports {altera_reserved_tck}]
set_false_path -to [get_ports {altera_reserved_tck}]

# Comunica a Quartus di non analizzare i tempi d'uscita verso la SDRAM 
# (perché la SDRAM è governata dallo sfasamento del PLL)
set_false_path -to [get_ports {DRAM_ADDR[*]}]
set_false_path -to [get_ports {DRAM_BA[*]}]
set_false_path -to [get_ports {DRAM_CAS_N}]
set_false_path -to [get_ports {DRAM_RAS_N}]
set_false_path -to [get_ports {DRAM_WE_N}]
set_false_path -to [get_ports {DRAM_CS_N}]
set_false_path -to [get_ports {DRAM_CKE}]


# Se hai dei pin di reset o switch che sono asincroni, puoi aggiungerli qui
# set_false_path -from [get_ports {reset_n}]