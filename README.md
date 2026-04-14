Zerkiolino 🚀
Zerkiolino è un sistema computer-on-a-chip (SoC) custom basato su FPGA, evoluzione del progetto Tiny_DSO_VGA. Il cuore del sistema è un soft-core T80 (Z80 compatible) spinto all'estremo, interfacciato con un controller video VGA ad alta fedeltà e un sottosistema di archiviazione su SD Card.

🛠 Caratteristiche Tecniche
Core CPU: T80 (Z80 Compatible) implementato in VHDL.

Clock di Sistema: 80 MHz (un incremento prestazionale enorme rispetto ai 2-4 MHz originali del ferro degli anni '80).

Sottosistema Video:

Risoluzione: 640x480 VGA.

Profondità Colore: RGB565 (16-bit) tramite ladder di resistenze custom.

Interfaccia: 18 GPIO (16 per i colori + 2 per i sincronismi), ottimizzati recuperando i pin dall'ADC integrato della DE0-Nano.

Storage: Interfaccia SD Card via SPI con clock a 20 MHz, ottimizzata per il caricamento rapido di asset e dati.

Hardware Target: Terasic DE0-Nano (Altera/Intel Cyclone IV).

⚡ Highlights del Progetto
Extreme Overclocking: Il core T80 gira con una stabilità impeccabile a 80MHz, garantendo una fluidità di calcolo senza precedenti per applicazioni 8-bit.

Pin-Stripping: Ottimizzazione estrema degli I/O della DE0-Nano tramite la rimozione fisica dell'ADC di serie per liberare linee SPI necessarie alla massima profondità di colore.

Flessibilità di Clock: Implementazione di un divisore di clock dinamico in VHDL per gestire diverse velocità SPI (Inizializzazione a 250kHz / High-Speed a 20MHz).

🎯 Obiettivi Futuri
Il progetto punta a implementare un sistema operativo in stile CP/M 80, sfruttando la velocità del T80 e la capienza della SD Card per creare una workstation retro-computing moderna, potente e compatta.

Note sull'Hardware
Per replicare il progetto è necessaria una modifica hardware sulla DE0-Nano per mappare i pin dell'ADC verso l'header a 26 pin, permettendo così il collegamento del bus video a 16 bit.