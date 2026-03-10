    processor 6502

    include "vcs.h"
    include "macro.h"

    seg Code
    org $F000

Start:
    CLEAN_START

PaintBK:
    lda #$1E
    sta COLUBK
    jmp PaintBK

    org $FFFC
    .word Start
    .word Start