%include "util.asm"                     ; bring in helper functions (printstr, readint, printint, etc.)

global _start                           ; define program entry point

section .text
    _start:
        mov rdi, num1_text              ; load address of num1_text into rdi
        call printstr                   ; print the num1_text
        call readint                    ; read an integer from user, return in rax
        mov [num_1], rax                ; store the first number in variable num_1

        mov rdi, math_ops_text          ; load address of math_ops_text into rdi
        call printstr                   ; print the math_ops_text
        mov rdi, math_ops               ; rdi = buffer where operator will be stored       
        mov rsi, 2                      ; rsi = max length (1 char + null terminator)
        call readstr                    ; read operator string into math_ops

        mov rbx, [math_ops]             ; load operator character(s) into rbx
        cmp rbx, 113                    ; compare with ASCII 'q' (113 decimal)
        je quit                         ; if operator == 'q', jump to quit
        
        mov rdi, num2_text              ; load "Enter 2nd number:" prompt
        call printstr                   ; print it
        call readint                    ; read second integer into rax
        mov [num_2], rax                ; store second number in variable num_2

        jmp compare_operations          ; jump to compare operator and decide what to do

    re_enter_math_ops:
        mov rdi, math_ops               ; rdi = operator buffer
        mov rsi, 2                      ; allow 1 char + null
        call readstr                    ; re-read operator (used after invalid input)

    compare_operations:
        mov rbx, [math_ops]             ; load operator
        cmp rbx, 113                    ; compare with 'q'
        je quit                         ; if 'q', exit

        mov rbx, [math_ops]             ; load operator again
        cmp rbx, 43                     ; '+' (43 decimal, 0x2B hex)
        je addition                     ; jump to addition if matched

        mov rbx, [math_ops]     
        cmp rbx, 45                     ; '-' (45 decimal, 0x2D hex)
        je subtraction                  ; jump to subtraction

        mov rbx, [math_ops]     
        cmp rbx, 42                     ; '*' (42 decimal, 0x2A hex)
        je multiplication               ; jump to multiplication

        mov rbx, [math_ops]     
        cmp rbx, 47                     ; '/' (47 decimal, 0x2F hex)
        je division                     ; jump to division

        jmp exception                   ; if none matched, go to error handler
    
    exception:
        mov rdi, error_text             ; load error message
        call printstr                   ; print error
        jmp re_enter_math_ops           ; ask again for operator
        
    addition:
        mov rdi, [num_1]                ; load num_1 into rdi
        add rdi, [num_2]                ; rdi = num_1 + num_2
        call result                     ; print result

    subtraction:
        mov rdi, [num_1]                ; load num_1
        sub rdi, [num_2]                ; rdi = num_1 - num_2
        call result                     ; print result

    multiplication:
        mov rdi, [num_1]                ; load num_1
        imul rdi, [num_2]               ; rdi = num_1 * num_2 (signed multiply)
        call result                     ; print result  

    division:
        mov rdx, 0                      ; clear rdx (needed for idiv, since it divides rdx:rax)
        mov rax, [num_1]                ; load num_1 into rax
        mov rbx, [num_2]                ; load num_2 into rbx
        idiv rbx                        ; divide rax by rbx by, value is retured in rax
        mov rdi, rax                    ; move rax into rdi
        call result                     ; print result      

    result:
        call printint                   ; print integer in rdi
        call endl                       ; print newline
        call exit0                      ; exit program

    quit:
        mov rdi, quit_text      ; load quit message
        call printstr           ; print it
        call endl               ; print newline
        call exit0              ; exit program


section .data
    num1_text: db 'Enter 1st number: ', 0
    num2_text: db 'Enter 2nd number: ', 0
    quit_text: db 'Exit Calculator: ', 0
    math_ops_text: db 'Enter a Math Operation(+, -, *, /) or q = quit: ', 0
    error_text: db 'Please Enter The Following Math Operation(+, -, *, /) or q = quit: ', 0

section .bss
    num_1: resq 1                       ; reserve 8 bytes for first number
    num_2: resq 1                       ; reserve 8 bytes for second number
    math_ops: resb 2                    ; reserve 2 bytes (operator char + null terminator)



; Dec       Hex    Value
; 43        2B      +  
; 45        2D      -  
; 42        2A      *  
; 47        2F      /  
