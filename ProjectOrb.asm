[org 0x7c00]
[bits 16]
; Start of code
jmp Clear

Begin: ; Set cursor to full block and set video mode to 80x25 text
mov ah, 0x0
mov al, 0x03
int 0x10
mov ah, 0x01
mov cx, 0x0007
int 0x10

Print: ; Print character from keyboard to the screen, and check if keys up arrow, down arrow, left arrow, right arrow, del, backspace or enter are pressed
mov ah, 0x0
int 0x16
cmp ah, 0x0e
jz Del
cmp ah, 0x53
jz Clear
cmp ah, 0x4b
jz Left
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

Clear: ; Clear screen
mov ah, 0x0
mov al, 0x03
int 0x10
jmp Begin

Left: ; Move cursor left unless already at the most left of screen
mov ah, 0x03
int 0x10
cmp dl, 0
jz Print
sub dl, 1
mov ah, 0x02
int 0x10
jmp Print

Del: ; Remove character to the left of the cursor, then move the cursor to where that character was
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

Down: ; Move cursor down unless already at bottom of screen
mov ah, 0x03
int 0x10
cmp dh, 24
jz Print
add dh, 1
mov ah, 0x02
int 0x10
jmp Print

Up: ; Move cursor up unless already at top of screen
mov ah, 0x03
int 0x10
cmp dh, 0
jz Print
sub dh, 1
mov ah, 0x02
int 0x10
jmp Print

Right: ; Move cursor right unless already at top of screen
mov ah, 0x03
int 0x10
cmp dl, 79
jz Print
add dl, 1
mov ah, 0x02
int 0x10
jmp Print

KeyboardFail: ; If keyboard not connected or found, print K to screen meaning Keyboard error, could also be broken connection or other keyboard error
mov ah, 0x0e
mov al, 'K'
int 0x10

Enter: ; Go to start of next line
mov ah, 0x03
int 0x10
cmp dh, 24
jz Print
add dh, 1
mov dl, 0
mov ah, 0x02
int 0x10
jmp Print
; End of code
times 510 - ($ - $$) db 0
dw 0xaa55