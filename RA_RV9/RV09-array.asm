extern scanf          ; funkcija scanf iz libc (ukaz  ld -lc)
extern printf         ; funkcija printf prav tako iz libc

section .data         ; konstantni podatki
poziv db "Vnesite besedilo: ", 0 ; pozivno besedilo za vnos
vpis db "%s", 0      ; oblika za vpis podatkov (za scanf)
odziv db "Obrnjeno: %s", 10, 0 ; izpis za rezultat

section .bss          ; sekcija za neinicializirane podatke
besedilo: resb 1024   ; vmesnik za hrambo besedila v pomnilniku

section .text         ; programska koda (zbirnik)
global main           ; funkcija main bo vidna izven te kode

main:                 ; funkcija "main" je klicana iz libc
push rbp              ; shranimo register rbp

mov rdi, poziv        ; besedilo, ki ga izpiše printf
mov rax, 0            ; rax na 0 za printf
call printf           ; pokličemo funkcijo printf

mov rdi, vpis         ; oblika vpisa je prvi parameter scanf
mov rsi, besedilo     ; naslov za število je drugi parameter
mov rax, 0            ; rax na 0 za scanf
call scanf            ; preberemo besedilo (klic scanf)

; pripravimo klic funkcije obrni: ta obrne podan niz,
; parameter za kazalec na niz prejme v rdi 

mov rdi, besedilo
call obrni            ; klic funkcije obrni

mov rdi, odziv        ; nastavimo obliko izpisa za printf
mov rsi, besedilo     ; drugi parameter za printf: besedilo
mov rax, 0            ; rax na 0 za printf
call printf           ; pokličemo funkcijo printf

pop rbp               ; povrnemo register rbp
mov rax, 0            ; program se uspešno zaključi (koda 0)
ret                   ; izhod iz programa (glavne funkcije)


obrni:                ; funkcija za obračanje niza na mestu
; kazalec na besedilo prejmemo v rdi
mov rsi, rdi          ; rdi in rsi damo oba na začetek besedila
cld                   ; z lodsb se bomo pomikali naprej
.stejDolzinoBesedila: ; rsi bomo pomikali proti koncu besedila
lodsb                 ; preberemo črko v besedilu (nizu), rsi++
cmp al, 0             ; črka (bajt) je shranjena iz [rsi] v ax
jnz .stejDolzinoBesedila ; besedilo je zaključeno z ničlo

; tukaj je trenutno rsi en znak po ničelnem znaku: premik -2
sub rsi, 2            ; zamenjevali bomo črke od zadnje naprej

obracaj:
cmp rsi, rdi          ; preverimo lokaciji branja/pisanja: če
jle .konecObracanja   ; se križata (rsi <= rdi), zaključimo

mov byte dl, [rdi]    ; začasno shranimo znak iz začetka v dl
std                   ; ob branju (lodsb) bomo zmanjševali rsi
lodsb                 ; naložimo pri koncu
mov byte [rsi+1], dl  ; prepišemo znak na koncu (rsi+1), bajt
cld                   ; stosb bo povečeval rdi (pomik naprej)
stosb                 ; prepišemo znak na začetku

jmp obracaj          ; ponovimo za naslenja znaka

.konecObracanja:
ret                   ; konec funkcije obrni
