[org 0x7c00]
[bits 16]
jmp Clear
Begin:
mov ah, 0x0
mov al, 0x03
int 0x10
mov ah, 0x01
mov cx, 0x0007
int 0x10
Print:
mov ah, 0x0
int 0x16
cmp ah, 0x0e
jz Del
cmp ah, 0x53
jz Clear
cmp ah, 0x4b
jz Back
cmp ah, 0x50
jz Down
cmp ah, 0x48
jz Up
cmp ah, 0x4d
jz Right
cmp ah, 0xff
jz KeyboardFail
cmp ah, 0x1c
jz Enter
mov ah, 0x0e
int 0x10
PrintEnd:
jmp Print
Clear:
mov ah, 0x0
mov al, 0x03
int 0x10
jmp Begin
Back:
mov ah, 0x03
int 0x10
cmp dl, 0
jz Print
sub dl, 1
mov ah, 0x02
int 0x10
jmp Print
Del:
mov ah, 0x03
int 0x10
cmp dl, 0
jz Print
sub dl, 1
mov ah, 0x02
int 0x10
mov ah, 0x0a
mov al, ''
mov cx, 1
int 0x10
jmp Print
Down:
mov ah, 0x03
int 0x10
cmp dh, 24
jz Print
add dh, 1
mov ah, 0x02
int 0x10
jmp Print
Up:
mov ah, 0x03
int 0x10
cmp dh, 0
jz Print
sub dh, 1
mov ah, 0x02
int 0x10
jmp Print
Right:
mov ah, 0x03
int 0x10
cmp dl, 79
jz Print
add dl, 1
mov ah, 0x02
int 0x10
jmp Print
KeyboardFail:
mov ah, 0x0e
mov al, 'K'
int 0x10
Enter:
mov ah, 0x03
int 0x10
cmp dh, 24
jz Print
add dh, 1
mov dl, 0
mov ah, 0x02
int 0x10
jmp Print
times 510 - ($ - $$) db 0
dw 0xaa55