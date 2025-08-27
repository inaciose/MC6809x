        ORG   $0100          ; endereço inicial do programa (ajusta conforme necessário)

;-----------------------------------
; Programa principal
;-----------------------------------
START   LDX   #$E000         ; X aponta para início da RAM
        LDY   #$1800         ; número de bytes = F7FF - E000 + 1 = 0x1800

CLEAR0  CLR   ,X+            ; escreve 0x00
        LEAY  -1,Y
        BNE   CLEAR0

        LDB   #2             ; espera 2 segundos
        JSR   DELAY

        LDX   #$E000
        LDY   #$1800

FILLFF  LDA  #$FF
        STA   ,X+
        LEAY  -1,Y
        BNE   FILLFF

        LDB   #2             ; espera 2 segundos
        JSR   DELAY

        BRA   START          ; repete para sempre


;-----------------------------------
; Rotina de atraso parametrizada
; Entrada: B = nº de segundos a esperar
;-----------------------------------
DELAY   PSHS  A,B,X,Y        ; guarda registos
NEXTSEC LDX   #500           ; ≈1 segundo a 1 MHz
                             ; Ajustar conforme clock:
                             ;   1 MHz → 500
                             ;   2 MHz → 1000
                             ;   4 MHz → 2000
                             ; Fórmula: 500 × (Clock em MHz)

DLY1    LDY   #255
DLY2    LEAY  -1,Y
        BNE   DLY2
        LEAX  -1,X
        BNE   DLY1

        DECB                 ; menos 1 segundo
        BNE   NEXTSEC

        PULS  A,B,X,Y,PC     ; restaura registos e retorna
