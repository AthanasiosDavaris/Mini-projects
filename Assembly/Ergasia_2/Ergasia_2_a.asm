TITLE Expression Calculator

INCLUDE Irvine32.inc

p EQU 8d;

.data
  x SDWORD 16d
  y SDWORD 154d
  z SDWORD -17d
  w SDWORD ?

main PROC
  mov eax, x
  add eax, y

  mov ebx, 50
  add ebx, x
  add ebx, y
  add ebx, z
  sub ebx, p

  sub eax, ebx
  mov w, eax

  call WriteInt
  call Crlf

  exit
main ENDP
END main