section .data

    ; Constantes para as formulas
    const32 dq 32.0
    const9 dq 9.0
    const5 dq 5.0

    ; Mensagens de controle de sistema
    out_convert db 10, "Convertor de unidade de temperatura", 0
    out_esc db 10, "1-Fanrenheit para Celsius", 10, "2-Celsius para Fanrenheit", 10, "Digite a opção desejada: ", 0
    out_temp db 10, "Digite a temperatura: ", 0

    ;Mensagem de erro
    out_err db 10, "Opção inválida", 10, 0

    ;Mensagem de resultado
    out_result db 10, "A temperatura convertida é: %.1fº", 10, 10, 0

    ;Formatações
    for_int db "%d", 0
    for_float db "%lf",  0

section .bss
    temp resq 1
    esc resb 1

section .text
    global main
    extern scanf, printf

main:
    push rbp
    mov rbp, rsp

    ; Mensagem de entrada
    mov rdi, out_convert
    mov rax, 0
    call printf

    ; Mensagem de escolhas
    mov rdi, out_esc
    call printf

    ; Leitura da escolha
    mov rdi, for_int
    mov rsi, esc
    call scanf

    ; Verificação das escolha
    ; 1 - Fanrenheit para Celsius
    cmp byte [esc], 1
    je .celsius

    ; 2 - Celsius para Fanrenheit
    cmp byte [esc], 2
    je .fanrenheit

    ; Erro
    mov rdi, out_err
    mov rax, 0
    call printf

    leave
    ret

; Convertor para Celsius
.celsius:
    ; Mensagem para temperatura
    mov rdi, out_temp
    call printf

    ; Recebe temperatura
    mov rdi, for_float
    mov rsi, temp
    mov rax, 1
    call scanf

    movq xmm0, [temp]
    ;Formula: (F - 32) * 5/9 = C
    movq xmm1, [const32]
    movq xmm2, [const5]
    movq xmm3, [const9]
    subsd xmm0, xmm1
    mulsd xmm0, xmm2
    divsd xmm0, xmm3

    ; Chama impressão
    movq rsi, xmm0
    jmp fim

    leave
    ret

; Convertor para Fanrenheit
.fanrenheit:
    ; Mensagem para temperatura
    mov rdi, out_temp
    call printf

    ; Recebe temperatura    
    mov rdi, for_float
    mov rsi, temp
    mov rax, 1
    call scanf

    movq xmm0, [temp]
    ;Formula: (C *9/5) +32 = F
    movq xmm1, [const9]
    movq xmm2, [const5]
    movq xmm3, [const32]
    mulsd xmm0, xmm1
    divsd xmm0, xmm2
    addsd xmm0, xmm3

    ; Chama impressão
    movq rsi, xmm0
    jmp fim

    leave
    ret

; Impressão do resultado
fim:
    mov rdi, out_result
    call printf

    leave
    ret