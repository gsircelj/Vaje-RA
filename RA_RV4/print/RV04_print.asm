extern _printf
global _main

section .data
msg: db "Gasper Sircelj", 10, "Vpisna stevilka: E1109188", 0

section .text
_main:
    push msg ;doda vrednost na stack
    call _printf
    add esp,4 ;izbriše 4 bajte iz stacka
    ret