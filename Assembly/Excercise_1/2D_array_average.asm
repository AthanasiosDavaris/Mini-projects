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
  matrix  SDWORD 10, 20, 30, 40
          SDWORD 50, 60, 70, 80
          SDWORD 90, 100, 110, 120
          SDWORD 130, 140, 150, 160
  
  totalSum SQWORD 0
  average SDWORD ?

  rows  DWORD 4
  cols  DWORD 4
  element_size DWORD 4

  msg_sum BYTE "Sum: ", 0
  msg_avg BYTE "Average: ", 0
  msg_overflow BYTE "(High: ", 0
  msg_hex BYTE "H) ", 0

.code 
main PROC
  mov edx, 0
  OuterLoop:
    cmp edx, rows
    jge EndOuterLoop

    mov esi, 0
    InnerLoop:
      cmp esi, cols
      jge EndInnerLoop

      mov eax, OFFSET matrix
      mov ebx, cols
      mov ecx, element_size

      call CalculateOffset2D_Registers

      mov ebx, [eax]
      movsx eax, ebx
      cdq

      add dword ptr [totalSum], eax
      adc dword ptr [totalSum+4], edx

      inc esi
      jmp InnerLoop

    EndInnerLoop:
    inc edx
    jmp OuterLoop

  EndOuterLoop:

  mov eax, dword ptr [totalSum]
  shr eax, 4
  mov average, eax

  mov edx, OFFSET msg_sum
  call WriteString

  cmp dword ptr [totalSum+4], 0
  jne Display_Sum_Hex
  mov eax, dword ptr [totalSum]
  call WriteInt
  jmp Display_Average

Display_Sum_Hex:
  mov eax, dword ptr [totalSum]
  call WriteHex
  mov edx, OFFSET msg_overflow
  call WriteString
  mov eax, dword ptr [totalSum+4]
  call WriteHex
  mov edx, OFFSET msg_hex
  call WriteString

Display_Average:
  call Crlf
  mov edx, OFFSET msg_avg
  call WriteString
  mov eax, average
  call WriteInt
  call Crlf

  INVOKE ExitProcess, 0
main ENDP

CalculateOffset2D_Registers PROC

  mov edi, edx
  imul edi, ebx
  add edi, esi
  imul edi, ecx
  add eax, edi

  ret
CalculateOffset2D_Registers ENDP

END main