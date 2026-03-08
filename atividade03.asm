    processor 6502
    seg Code
    org $F000

Start:

    lda #15

    tax
    tay
    txa
    tya

    ldx #6
    txa
    tay

    jmp Start
    
    org $FFFC
    .word Start
    .word Start