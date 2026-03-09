    processor 6502
    
    org $F000               ; Define the code origin to $F000

Start:
;;;;;;;;;;;;;;;;;;;;;;;;;;
; clean memory
;;;;;;;;;;;;;;;;;;;;;;;;;;
    ldx #$FF               ; Loads X register with 255 (0xFF)
    txs                    ; Transfer X to Stack Pointer (SP)
    lda #0                  ; A = 0
    ldx #$FF                ; X = FF
    sta $FF                ; Ensure $FF is set to zero before the loop starts

CleanMem:
    dex                     ; X--
    sta $0,X                ; Stores the value of A into address $0,X ($0 + X)
    bne CleanMem             ; Loop until X equal to zero (z-flag is set)


Atividade:

    lda #$82
    ldx #82
    ldy $82

    jmp Atividade

    org $FFFC
    .word Start             ; Reset the vector at $FFFC (where program starts)
    .word Start             ; Interrupt vector at position $FFFE (unused in VCS)