    processor 6502
    
    seg code
    org $F000               ; Define the code origin to $F000
    
Start:
    sei                    ; Disable interrupts
    cld                    ; Clear decimal mode
    ldx #$FF               ; Loads X register with 255 (0xFF)
    txs                    ; Transfer X to Stack Pointer (SP)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CLEAR THE PAGE ZERO region ($00 to $ff)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    lda #0                  ; A = 0
    ldx #$FF                ; X = FF
    sta $FF                ; Ensure $FF is set to zero before the loop starts

MemLoop:
    dex                     ; X--
    sta $0,X                ; Stores the value of A into address $0,X ($0 + X)
    bne MemLoop             ; Loop until X equal to zero (z-flag is set)

    org $FFFC
    .word Start             ; Reset the vector at $FFFC (where program starts)
    .word Start             ; Interrupt vecot at position $FFFE (unused in VCS)
