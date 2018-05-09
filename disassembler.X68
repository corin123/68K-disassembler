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
i                   equ             $00

*A0: used by EASy68K
*A1: used by EASy68k
*A2: points to starting address
*A3: points to ending address
*A4: points to ascii/hex string table?

*D0: used by EASy68K
*D1: used by EASy68K
*D2: holds opcode currently being worked on
*D3: holds the next byte of the user starting address
*D3: holds length of user input
*D4: offset of string table value

start       org     start_addr
            * clear all data registers and address registers and set constant blocks to 0
            
            ; for testing
            lea     addr1,a2
            lea     addr2,a3
            lea     stack,sp                    ; sp is stack pointer in a7
            * load opcodes into memory
            move.w  #$2803,(a2)+                ; move.l    d3,d4
            move.w  #$DE46,(a2)+                ; add.w     d6,d7
            move.w  #$247C,(a2)+                ; movea.l   #$A000,a2
            move.l  #$0000A000,(a2)+            ; 
            
            lea     addr1,a2                    ; reset memory pointer
            move.w  (a2)+,d2                    ; move opcode into d2

* currently reads left to right, will need modification to read
* right to left
test_bit    cmp.b   #$F,d0                      ; for i < 16
            beq     next                        ; 
            btst.l  d0,d2                       ; test the bit at index i of d2
            beq     i_incr                      ; if not set, increment i
set_bit     bset    d0,d3                       ; if set, set bit of d3
i_incr      addi    #1,d0                       ; increment i
            bra     test_bit                    ; loop
next
            simhalt
            
            end     start



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
