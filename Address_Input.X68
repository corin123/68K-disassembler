*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------

*Limit the range the address can be within
*   D2: Current index position
*   D3: Ending index position value
*   D4: Stores the ASCII value data from the memory
*   D5: Stores the value

    ORG    $1000
START:                  ; first instruction of program

* Put program code here

   JSR GET_INPUT
    
  MOVE.L D5, D1
  MOVE.B #15, D0
  MOVE.B #16,D2
  TRAP #15
    SIMHALT             ; halt simulator

* Put variables and constants here

INPUT_ADDRESS EQU $0000                         *Memory location where we want to store the ASCII numbers to convert into HEX


*Function That gets the input; Does not notify te user that input is required.
*That is up to the function calling it.
GET_INPUT       
    LEA INPUT_ADDRESS,A1    *Load the memory address where we want to store the ASCII values           
    MOVE.B #2, D0           *Get input
    TRAP #15                *Get Input
    
    
    CMP.W #4,D1             *Make sure the data is a word
    BNE INVALID_DATA        *Invalid Data if size is not word

    LEA INPUT_ADDRESS,A5    *Store starting address location
    LEA INPUT_ADDRESS,A6    *Store starting address location to add +4 later
    ADDA #3,A6              * Add 4 to know when to stop looping (+3 because we start at 0)
    BRA READ_INPUT          *Move into the function that reads the data
    
    
INVALID_DATA
    LEA INVALID_MESSAGE,A1  *Get address of message and put it onto A1
    MOVE.B #14, D0          *Display Message
    TRAP #15                *Display Message
    BRA GET_INPUT           *Loop Back into the input function to try and get a valid input
    
CR EQU $0D
LF EQU $0A

INVALID_MESSAGE DC.B 'Invalid Data.Try Again: ',CR,LF
                DC.B 'Try Again: ',0
READ_INPUT    
    CMPA.L A5, A6           *Check if we have gotten all 4 digits
        BLT READ_DONE       *branch into the function that handles the data once its done
       MOVE.B (A5)+,D4
        ROL.L #8, D4        *rotate the data so you can populate more data
       BRA READ_INPUT       *branch back
       
READ_DONE 
    *Shift the data back by 8 bits to compensate for the shift on the last digit
    ROR.L #8, D4

    *Set counters
    MOVE.L #0, D2
    MOVE.L #3, D3
    
    BRA READ_DATA_REGISTER  *go to function that converts the ASCII into HEX
    RTS
    
READ_DATA_REGISTER
    
    CMP D2,D3                       *get only four bytes of data (XXXX)
        BLT READ_DATA_REGISTER_DONE *go to function that handles the data once its done getting read.
    ADD #1, D2                      *add 1 to loop counter
    BRA ASCII_TABLE
    
READ_DATA_REGISTER_DONE
    ROL.L #4, D5                    *Rotate by 4-bits to compensate for the last hex value inserted
    RTS

ASCII_TABLE
    CMP.B #48,D4
        BEQ ZERO
        
    CMP.B #49,D4
        BEQ ONE
        
    CMP.B #50,D4
        BEQ TWO
    
    CMP.B #51,D4
        BEQ THREE
        
    CMP.B #52,D4
        BEQ FOUR
        
    CMP.B #53,D4
        BEQ FIVE
        
    CMP.B #54,D4
        BEQ SIX
        
    CMP.B #55,D4
        BEQ SEVEN
        
    CMP.B #56,D4
        BEQ EIGHT
        
    CMP.B #57,D4
        BEQ NINE
        
    CMP.B #65, D4
        BEQ TEN
        
    CMP.B #97, D4
        BEQ TEN
        
    CMP.B #66, D4
        BEQ ELEVEN
        
    CMP.B #98, D4
        BEQ ELEVEN
        
    CMP.B #67, D4
        BEQ TWELVE
        
    CMP.B #99, D4
        BEQ TWELVE
        
    CMP.B #68, D4
        BEQ THIRTEEN
        
    CMP.B #100, D4
        BEQ THIRTEEN
   
    CMP.B #69, D4
        BEQ FOURTEEN
        
    CMP.B #101, D4
        BEQ FOURTEEN
        
    CMP.B #70, D4
        BEQ FIFTEEN
        
    CMP.B #102, D4
        BEQ FIFTEEN

    BRA INVALID_DATA            *The data is not valid, restart.
        
        
ZERO
    BCLR #15, D5
    BCLR #14, D5
    BCLR #13, D5
    BCLR #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
ONE
    BCLR #15, D5
    BCLR #14, D5
    BCLR #13, D5
    BSET #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
TWO
    BCLR #15, D5
    BCLR #14, D5
    BSET #13, D5
    BCLR #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
THREE
    BCLR #15, D5
    BCLR #14, D5
    BSET #13, D5
    BSET #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
FOUR
    BCLR #15, D5
    BSET #14, D5
    BCLR #13, D5
    BCLR #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
FIVE
    BCLR #15, D5
    BSET #14, D5
    BCLR #13, D5
    BSET #12, D5

    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
SIX
    BCLR #15, D5
    BSET #14, D5
    BSET #13, D5
    BCLR #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
SEVEN
    BCLR #15, D5
    BSET #14, D5
    BSET #13, D5
    BSET #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
EIGHT
    BSET #15, D5
    BCLR #14, D5
    BCLR #13, D5
    BCLR #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
NINE
    BSET #15, D5
    BCLR #14, D5
    BCLR #13, D5
    BSET #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
TEN
    BSET #15, D5
    BCLR #14, D5
    BSET #13, D5
    BCLR #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
ELEVEN
    BSET #15, D5
    BCLR #14, D5
    BSET #13, D5
    BSET #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
TWELVE
    BSET #15, D5
    BSET #14, D5
    BCLR #13, D5
    BCLR #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
THIRTEEN
    BSET #15, D5
    BSET #14, D5
    BCLR #13, D5
    BSET #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
FOURTEEN
    BSET #15, D5
    BSET #14, D5
    BSET #13, D5
    BCLR #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
FIFTEEN
    BSET #15, D5
    BSET #14, D5
    BSET #13, D5
    BSET #12, D5
    
    ROR.L #4, D5
    ROR.L #8, D4
    BRA READ_DATA_REGISTER
    
    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~8~
*~Tab type~1~
*~Tab size~4~
