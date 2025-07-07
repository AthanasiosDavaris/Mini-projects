; Not currently debugged
; Assembly doesnt run on my computer
; Prob will debug it on a friend's computer
; DONT run it
.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc
INCLUDE macros.inc

.data
a_factor REAL8 ?
b_factor REAL8 ?
c_factor REAL8 ?
D_factor REAL8 ?
Root1 REAL8 ?
Root2 REAL8 ?
two REAL8 2.0
four REAL8 4.0
zero REAL8 0.0

msgA BYTE "Enter coefficient a: ", 0
msgB BYTE "Enter coefficient b: ", 0
msgC BYTE "Enter coefficient c: ", 0
msgDisc BYTE "Discriminant D = ", 0
msgTwoReal BYTE "Two real roots: ", 0
msgOneReal BYTE "One real root (double): ", 0
msgComplex BYTE "Complex roots: ", 0
msgError BYTE "Error: Coefficient a cannot be zero.", 0
plusSign BYTE " + ", 0
minusSign BYTE " - ", 0
i_suffix BYTE "i", 0
space BYTE " ", 0
and_msg BYTE " and ", 0

.code
main PROC
  finit

  push 3
  call SetPrecision

  mov edx, OFFSET msgA
  call WriteString
  call ReadFloat
  fstp a_factor

  fld a_factor
  ftst
  ftstsw ax
  sahf
  jz error_a_zero

  mov edx, OFFSET msgB
  call WriteString
  call ReadFloat
  fstp b_factor

  mov edx, OFFSET msgC
  call WriteString
  call ReadFloat
  fstp c_factor

  fld b_factor
  fmul ST(0), ST(0)

  fld a_factor
  fld, c_factor
  fmulp

  fld four
  fmulp

  fsubp ST(1), ST(0)
  fst D_factor

  mov edx, OFFSET msgDisc
  call WriteString
  call WriteFloat
  call CrLf
  fstp ST(0)

  fld D_factor
  ftst
  ftstsw ax
  test ah, 41h
  jz d_zero
  jc d_negative

  fld b_factor
  fchs
  fld D_factor
  fsqrt

  fld a_factor
  fmul two

  fld ST(2)
  fadd ST(0), ST(2)
  fdiv ST(0), ST(1)
  fstp Root1

  fld ST(2)
  fsub ST(0), ST(2)
  fdiv ST(0), ST(1)
  fstp Root2

  fstp ST(0)
  fstp ST(0)
  fstp ST(0)

  mov edx, OFFSET msgTwoReal
  call WriteString
  fld Root1
  call WriteFloat
  mov edx, OFFSET space
  call WriteString
  mov edx, OFFSET and_msg
  call WriteString
  mov edx, OFFSET space
  call WriteString
  fld Root2
  call WriteFloat
  call CrLf
  jmp exit_program

d_zero:
  fstp ST(0)
  fld b_factor
  fchs
  fld a_factor
  fmul two
  fdivp
  fstp Root1

  mov edx, OFFSET msgOneReal
  call WriteString
  fld Root1
  call WriteFloat
  call CrLf
  jmp exit_program

d_negative:
  fstp ST(0)
  fld b_factor
  fchs
  fld a_factor
  fmul two
  fdiv
  fst Root1

  fld D_factor
  fchs
  fsqrt
  fld a_factor
  fmul two
  fdiv
  fst Root2

  mov edx, OFFSET msgComplex
  call WriteString

  fld Root1
  call WriteFloat
  mov edx, OFFSET plusSign
  call WriteString
  fld Root2 
  call WriteFloat
  mov edx, OFFSET i_suffix
  call WriteString

  mov edx, OFFSET and_msg
  call WriteString

  fld Root1
  call WriteFloat
  mov edx, OFFSET minusSign
  call WriteString
  fld Root2 
  call WriteFloat
  mov edx, OFFSET i_suffix
  call WriteString
  call CrLf

  fstp ST(0)
  fstp ST(0)
  jmp exit_program

error_a_zero:
  mov edx, OFFSET msgError
  call WriteString
  call CrLf

exit_program:
  exit
main ENDP
END main