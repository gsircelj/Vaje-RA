extern scanf          ; funkcija scanf iz libc (ukaz  ld -lc)
extern printf         ; funkcija printf prav tako iz libc

section .data         ; konstantni podatki
poziv db "Vnesite n: ", 0 ; pozivno besedilo za vnos
vpis db "%ld", 0      ; oblika za vpis podatkov (za scanf)
odziv db "f(%ld) = %ld", 10, 0 ; izpis za rezultat

section .bss          ; sekcija za neinicializirane podatke
N: resq 1             ; vrednost N

section .text         ; programska koda (zbirnik)
global main           ; funkcija main bo vidna izven te kode

main:                 ; funkcija "main" je klicana iz libc
push rbp              ; shranimo register rbp

mov rdi, poziv        ; besedilo, ki ga izpiše printf
mov rax, 0            ; rax na 0 za printf
call printf           ; pokličemo funkcijo printf

mov rdi, vpis         ; oblika vpisa je prvi parameter scanf
mov rsi, N            ; naslov za število je drugi parameter
mov rax, 0            ; rax na 0 za scanf
call scanf            ; preberemo N (klic scanf)

; pripravimo klic funkcije recursion: ta vrne rezultat v rax,
; parameter N prejme v rdi 

mov rdi, [N]
call recursion        ; klic recursion, ki shrani rezultat v rax

mov rdi, odziv        ; nastavimo obliko izpisa za printf
mov rsi, [N]          ; drugi parameter za printf: n
mov rdx, rax          ; tretji parameter za printf: rezultat
mov rax, 0            ; rax na 0 za printf
call printf           ; pokličemo funkcijo printf

pop rbp               ; povrnemo register rbp
mov rax, 0            ; program se uspešno zaključi (koda 0)
ret                   ; izhod iz programa (glavne funkcije)


; f(n) = f(n-3) + f(n-2), n > 2, f(0) = 1, f(1)=1, f(2) = 7
recursion:            ; funkcija recursion - izračuna f(n)

cmp rdi, 0            ; n=0?
je .fJeEna
cmp rdi, 1
je .fJeEna
cmp rdi, 2
je .fJeSedem


; sicer, izračunamo f(n-3) ter f(n-2):
; f(n-3):             ; izračun za f(n-3)
push rdi              ; naredimo rezervno kopijo za n na sklad
sub rdi, 3            ; zmanjšamo n za 3 (n hranimo v rdi)
call recursion
pop rdi

; f(n-2):             ; izračun za f(n-2)
push rax              ; shranimo rax iz f(n-3) na sklad

push rdi              ; naredimo rezervno kopijo za n na sklad
sub rdi, 2            ; zmanjšamo n za 2 (n hranimo v rdi)
call recursion        ; klic recursion, ki shrani rezultat v rax
pop rdi               ; povrnemo n (iz rdi)


; seštejemo f(n-3) in f(n-2)
pop rsi               ; povrnemo prejšnji rax, iz f(n-3), v rsi
add rax, rsi          ; seštejemo rax iz f(n-2) inf(n-3)
ret                   ; vrnemo ta rezultat


.fJeEna:              ; vrednost rezultata funkcije je enak 1
mov rax, 1            ; shranimo rezultat v rax
ret                   ; vrnitev iz funkcije

.fJeSedem:            ; vrednost rezultata funkcije je enak 7
mov rax, 7            ; shranimo rezultat v rax
ret                   ; vrnitev iz funkcije
