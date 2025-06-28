TITLE Array Element Calculator
INCLUDE Irvine32.inc

.data
  msg1  BYTE "The value of the element a[2,2] is : ", 0
  msg2  BYTE "The sum a[2,2]+z = : ", 0
  msg3  BYTE "The sum a[2,2]-z = : ", 0
  msg4  BYTE "Press any key to continue...", 0

  a     SDWORD 00d, 10d, 20d, 30d
        SDWORD 01d, 11d, 21d, 31d
        SDWORD 02d, 12d, 22d, 32d
        SDWORD 03d, 13d, 23d, 33d

  x     BYTE 2
  y     BYTE 2
  z     SWORD -30

.code
main PROC
  movzx eax, x
  mov ebx, 4
  mul ebx
  movzx ecx, y
  add eax, ecx
  shl eax, 2

  mov ebx, [a + eax]

  mov edx, OFFSET msg1
  call WriteString
  mov eax, ebx
  call WriteInt
  call Crlf

  movsx ecx, z
  add eax, ecx
  mov edx, OFFSET msg2
  call WriteString
  call WriteInt
  call Crlf

  mov eax, ebx
  sub eax, ecx
  mov edx, OFFSET msg3
  call WriteString
  call WriteInt
  call Crlf

  mov edx, OFFSET msg4
  call WriteString
  call ReadChar

  exit
main ENDP
END main