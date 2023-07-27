section .data

    ; titulo
    calc db 10, "---------------------------------------------Calculadora---------------------------------------------", 10, 0

    ; Controle de Sistema
    out_num1 db 10, "Digite o primeiro numero: ", 0
    out_num2 db "Digite o segundo numero: ", 0
    out_ope db 10,"Escolha a operação, 1 para soma 2 para subtração, 3 para multiplicação, 4 para divisao: ", 0
    out_err db "Codigo inválido", 10, 0
    out_result db 10, "O resultado é: %.2f",10, 0
    out_fim db 10, "Deseja fazer outra operação? 1 para sim: ", 0

    ; Formatação
    for_int db "%d", 0
    for_float db "%lf", 0

section .bss
    num1 resq 1
    num2 resb 10
    ope resb 2

section .text
    global main
    extern printf, scanf

main:
    push rbp
    mov rbp, rsp

    ; Imprime o titulo
    mov rdi, calc
    mov rax, 0
    call printf

    jmp calculadora
    leave
    ret

calculadora:
    ; output de escolha
    mov rdi, out_ope
    mov rax, 0
    call printf

    ; input de escolha
    mov rdi, for_int
    mov rsi, ope
    call scanf

    ;Imprime out do primeiro numero
    mov rdi, out_num1
    mov rax, 0
    call printf

    ; Recebe primeiro numero
    mov rdi, for_float
    mov rsi, num1
    mov rax, 1
    call scanf

    ;Imprime out do segundo numero
    mov rdi, out_num2
    mov rax, 0
    call printf

    ; Recebe segundo numero
    mov rdi, for_float
    mov rsi, num2
    mov rax, 1
    call scanf

    ; verifica escolha
    cmp byte [ope], 1
    je soma
    cmp byte [ope], 2
    je subtracao
    cmp byte [ope], 3
    je multiplicacao
    cmp byte [ope], 4
    je divisao

    ; se não for nenhum dos 3, imprime erro
    mov rdi, out_err
    mov rax, 0
    call printf

    ;recomeça a operação caso o usuario queira
    mov rdi, out_fim
    mov rax, 0
    call printf

    mov rdi, for_int
    mov rsi, ope
    call scanf

    cmp byte [ope], 1
    je calculadora


    leave
    ret


soma:
    ; soma os dois numeros
    movq xmm0, [num2]
    movq xmm1, [num1]
    addsd xmm0, xmm1

    movq rsi, xmm0

    jmp fim

    leave
    ret


subtracao:
    ; subtrai os dois numeros
    movq xmm0, [num1]
    movq xmm1, [num2]
    subsd xmm0, xmm1

    movq rsi, xmm0

    jmp fim

    leave
    ret

multiplicacao:
    ; multiplica os dois numeros
    movq xmm0, [num2]
    movq xmm1, [num1]
    mulsd xmm0, xmm1

    movq rsi, xmm0

    jmp fim

    leave 
    ret

divisao:
    ; divide os dois numeros
    movq xmm0, [num1]
    movq xmm1, [num2]
    divsd xmm0, xmm1

    movq rsi, xmm0

    jmp fim

    leave
    ret


fim:
    ; imprime o resultado
    mov rdi, out_result
    call printf

    ;recomeça a operação caso o usuario queira
    mov rdi, out_fim
    mov rax, 0
    call printf

    mov rdi, for_int
    mov rsi, ope
    call scanf

    cmp byte [ope], 1
    je calculadora


    leave
    ret

