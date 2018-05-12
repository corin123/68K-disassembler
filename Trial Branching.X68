*-----------------------------------------------------------
* Title      : Trial Branching (Read Data)
* Written by : Terence Ho
* Date       : 05/02/18
* Description:
*-----------------------------------------------------------
        ORG    $1000
addr1               equ             $8000       ; for testing; starting address of memory to read

START:
        LEA         addr1,A2
        MOVE.W      #$4E71,(A2)+    ;load test data into memory
 
        LEA         addr1,A2
        MOVE.W      (A2)+,D2         ; copy current address memory into D3

        BTST #0,D2 ;Testing the LSB bit in data register 0


read_msb            
            MOVE.L  D2,D5                       ; copy data to temporary register
            CLR.W   D5                          ; clear 4 digits to 0000
            SWAP    D5
            ;read 4 bits

read_lsb
            MOVE.L  D2,D5                       ; copy data to temporary register
            ;read 4 bits
            CMP.W   #$0000,D5                   ; if last 4 bits are equal to 0000
            BEQ     switch_msb1                 ; switch msbs
            CMP.W   #$FFFF,D5                   ; if last 4 bits are equal to FFFF
            BEQ     switch_msb1                 ; switch msbs
            BRA     test_bit                    ; skip switch most significant bit
switch_msb1
            SWAP    D5

*--- read_4bit to test (Corin's code still needs to be modified)
* maybe read opcodes into a stack and push everything out to trace 
*   from the most significant bit?
test_bit    CMP.B   #$F,D0                      ; for i < 16
            BEQ     next                        ;             
            BTST.l  d0,d2                       ; test the bit at index i of d2
            BEQ     i_incr                      ; if not set, increment i
set_bit     bset    d0,d3                       ; if set, set bit of d3
i_incr      addi    #1,d0                       ; increment i
            bra     test_bit                    ; loop
next        

*--- convert hex to binary 
* still working on it, not sure how I should do this
        CMP.B       #$1,D3
        
    ;      BNE         NOT_01
    ;    JMP         COMPARE_00
        
        MOVE.B      $8002,D3         ; copy address memory into D3
        CMP.B       #$00,D3

COMPARE_00
        CMP.B       #$00,D3
  ;      BNE         NOT_00
  ;      JMP         COMPARE_10
COMPARE_11
        
        CMP.B       #$11,D3
   ;     BNE         NOT_11
    ;    JMP         INVALID
        

        END    START        ; last line of source
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
