; Not currently debugged
; Assembly doesnt run on my computer
; Prob will debug it on a friend's computer
; DONT run it
.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc

.data
  array WORD 3, 5, 7, 9, 11, 13, 15, 17
  COUNT EQU ($ - array) / TYPE array
  msgSum BYTE "Sum of squares = ", 0
  msgMean BYTE "Mean square = ", 0
  newLine BYTE 0Dh, 0Ah, 0

.code
main PROC

  call Clrscr

  push OFFSET array
  push COUNT
  call CalculateSumOfSquares
  add esp, 8

  mov edx, OFFSET msgSum
  call WriteString
  call WriteDec
  mov edx, OFFSET newLine
  call WriteString

  push OFFSET array
  push COUNT
  call CalculateMeanOfSquares
  add esp, 8

  push edx, OFFSET msgMean
  call WriteString
  call WriteDec
  mov edx, OFFSET newLine
  call WriteString

  INVOKE ExitProcess, 0
main ENDP

CalculateSumOfSquares PROC
  push ebp
  mov ebp, esp
  push ebx
  push ecx

  mov ebx, [ebp+12]
  mov ecx, [ebp+8]
  xor eax, eax

  L1:
  movzx edx, WORD PTR [ebx]
  imul edx, edx
  add, eax, edx
  add ebx, TYPE array
  loop L1

  pop ecx
  pop ebx
  pop ebp
  ret
CalculateSumOfSquares ENDP

CalculateMeanOfSquares PROC
  push ebp
  mov ebp, esp

  push [ebp+12]
  push [ebp+8]
  call CalculateSumOfSquares
  add esp, 8

  mov ecx, [ebp+8]
  xor edx, edx
  div ecx

  pop ebp
  ret
CalculateMeanOfSquares ENDP

END main