    processor 6502
    seg Code
    org $F000

Start:

    ldx #$FF               ; Loads X register with 255 (0xFF)
    txs                    ; Transfer X to Stack Pointer (SP)
    lda #0                  ; A = 0
    ldx #$FF                ; X = FF
    sta $FF                ; Ensure $FF is set to zero before the loop starts

CleanMem:
    dex                     ; X--
    sta $0,X                ; Stores the value of A into address $0,X ($0 + X)
    bne CleanMem             ; Loop until X equal to zero (z-flag is set)
    
    ldy #10
Atividade
    tya
    sta $80,Y
    dey
    bpl Atividade

    jmp Start
    org $FFFC
    .word Start
    .word Start