    processor 6502

    include "vcs.h"
    include "macro.h"

    seg Code
    org $F000

Start:
    CLEAN_START                 ; Macro para limpar a memoria page zero

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Inicia um novo frame ligando o VBLANK e o VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NextFrame:
    lda #2                      ; Equivalente a 0000 0010
    sta VBLANK                  ; Salva o valor de A no endereço do VBLANK para ligar ele
    sta VSYNC                   ; Salva o valor de A no endereço do VBLANK para ligar ele
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Insere o boilerplate necessario para o VSYNC
; são necessário 3 VSYNCs antes de começar as linhas visiveis
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    sta WSYNC
    sta WSYNC
    sta WSYNC

    lda #0
    sta VSYNC                    ; Desliga o VSYNC


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Insere o boilerplate necessario para o VBLANK
; são necessário 37 VBLANKs antes de começar as linhas visiveis
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ldx #37
LoopVblank:
    sta WSYNC
    dex
    bne LoopVblank

    lda #0
    sta VBLANK

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Desenha 192 scanlines visiveis (kernel)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ldx #192
LoopVisible:
    stx COLUBK
    stx WSYNC                       ; Wait for next scanline
    dex
    bne LoopVisible



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Desenha as linhas verticais do overscan 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #2
    sta VBLANK

    ldx #30
LoopOverScan:
    sta WSYNC
    dex
    bne LoopOverScan


    jmp NextFrame
    org $FFFC
    .word Start
    .word Start