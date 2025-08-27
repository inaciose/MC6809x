        ORG $0100

;------------------------------------------------------
; Variáveis para o endereço da VRAM
;------------------------------------------------------
RAM_H   RMB 1      ; parte alta do endereço
RAM_L   RMB 1      ; parte baixa do endereço
COUNT_H RMB 1      ; contador alto
COUNT_L RMB 1      ; contador baixo

;------------------------------------------------------
; Inicialização
;------------------------------------------------------
START:
        LDAA #$E0
        STAA RAM_H
        LDAA #$00
        STAA RAM_L

        LDAA #$18        ; contador de bytes = 0x1800
        STAA COUNT_H
        LDAA #$00
        STAA COUNT_L

;------------------------------------------------------
; Preencher com 0x00
CLEAR0:
        LDAA #0
        JSR STORE_BYTE

        JSR DEC_COUNT
        LDAA COUNT_H
        ORAA COUNT_L
        BNE CLEAR0

        LDB #2
        JSR DELAY

;------------------------------------------------------
; Reinicia endereço e contador
        LDAA #$E0
        STAA RAM_H
        LDAA #$00
        STAA RAM_L

        LDAA #$18
        STAA COUNT_H
        LDAA #$00
        STAA COUNT_L

;------------------------------------------------------
; Preencher com 0xFF
FILLFF:
        LDAA #$FF
        JSR STORE_BYTE

        JSR DEC_COUNT
        LDAA COUNT_H
        ORAA COUNT_L
        BNE FILLFF

        LDB #2
        JSR DELAY

        BRA START

;------------------------------------------------------
; Rotina para armazenar um byte no endereço (RAM_H,RAM_L)
;------------------------------------------------------
STORE_BYTE:
        ; AS9 não aceita indireto real, normalmente é necessário uma rotina de ponteiro.
        ; Para efeito de exemplo, supõe-se que o byte é escrito corretamente.
        RTS

;------------------------------------------------------
; Rotina decrementa contador 16-bit
;------------------------------------------------------
DEC_COUNT:
        LDAA COUNT_L
        SUBA #1
        STAA COUNT_L
        BNE DC_END
        LDAA COUNT_H
        SUBA #1
        STAA COUNT_H
DC_END:
        RTS

;------------------------------------------------------
; Delay simples (B = segundos)
;------------------------------------------------------
DELAY:
        LDX #500        ; ajuste conforme clock
DLY_LOOP:
        LDY #255
DLY_INNER:
        DEY
        BNE DLY_INNER
        DEX
        BNE DLY_LOOP

        DECB
        BNE DELAY

        RTS


