section .data

    fib db 10, "-------Sequencia de Fibonacci-------", 10, 10, 0

    out_pos db 10, "Escolha a posição da sequencia a ser calculada: ", 0
    out_fib db 10, "O valor da posição é: %d", 0

    for_int db "%d", 0

section .bss
    pos resq 1
    total resq 1

section .text
    global main
    extern printf, scanf

main:
    push rbp
    mov rbp, rsp

    ; Imprime o titulo
    mov rdi, fib
    mov rax, 0
    call printf

    jmp fibonnaci
    leave
    ret

fibonnaci:
    ; Imprime a mensagem de entrada
    mov rdi, out_pos
    mov rax, 0
    call printf

    ; Lê a posição
    mov rdi, for_int
    mov rsi, pos
    call scanf

    mov rdx, [pos]

    ; Chama a função recursiva
    mov rdi, [pos]
    call rfunc

    leave
    ret


rfunc:
    pushq %rbx
    movq %rdi, %rbx
    movl $1, %eax
    cmpq $1, %rdi
    jle .L35
    leaq -1(%rdi), %rdi
    call rfunc
    iaddq %rbx, %rax

.L35:
    pop %rbx
    retq

fim:

    ; Imprime o resultado
    mov rdi, out_fib
    mov rsi, [total]
    mov rax, 0
    call printf

    leave
    ret

