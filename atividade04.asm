    processor 6502
    seg Code
    org $F000

Start:

    lda #100
    adc #5
    sbc #10

    jmp Start

    org $FFFC
    .word Start
    .word Start