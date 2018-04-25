*-----------------------------------------------------------
* Title      : Disassembler
* Written by : Corin Ennis, Terence Ho, Antony Mbugua
* Date       : Spring 2018
* Description: A disassembler for the EASy68K Assembler
*-----------------------------------------------------------
lf                  equ             $0a
cr                  equ             $0d
start_addr          equ             $400
stack               equ             $7000
addr1               equ             $8000       ; for testing; starting address of memory to read
addr2               equ             $A000       ; for testing; ending address of memory to read

*A0: used by EASy68K
*A1: used by EASy68k
*A2: points to starting address
*A3: points to ending address
*A4: points to ascii/hex string table?

*D0: used by EASy68K
*D1: used by EASy68K
*D2: used by EASy68K
*D3: holds the next byte of the user starting address
*D3: holds length of user input
*D4: offset of string table value

start       org     start_addr

            lea     addr1,a2
            lea     addr2,a3
            lea     stack,sp                    ; sp is stack pointer in a7


            end     start




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
