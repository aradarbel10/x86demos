 ; template for programs
.model small
.stack 100h
.data

grid_x db 0
grid_y db 0

piece_x db 0
piece_y db 0
piece_type db 0 ; I=0,O,J,L,S,T,Z

piece_shape dw 0000000011110000b ; I
			dw 0000011001100000b ; O
			dw 0000111000100000b ; J
			dw 0000111010000000b ; K
			dw 0000011011000000b ; S
			dw 0000111001000000b ; T
			dw 0000110001100000b ; Z

piece_color	db 1011b, 1110b, 0001b, 0110b, 0010b, 0101b, 0100b
; I, light blue
; O, yellow
; J, blue
; K, orange
; S, green
; T, magenta
; Z, red


.code

mov ax,@data
mov ds, ax

; here your program starts

; push arguments and call
push 5 ; color red
push 0 ; y coordinate
push 0 ; x coordinate
call _drawPiece
add sp, 6

; here your program ends

mov ah,4Ch
mov al,0
int 21h

; here your sub-programs start

_drawTile PROC ; draw one tile on the grid given position and color (x, y, color)
; subroutine opening convension
push bp
mov bp, sp
sub sp, 0 ; no local variables so no need to move stack pointer
push ax ; push all used registers to the stack
push bx
push cx
push dx
; contents of the subroutine go here
	mov ah, 2
	mov dx, [bp + 6] ; y position, second parameter
	shl dh, 8
	mov bx, [bp + 4] ; x position, first parameter
	mov dl, bl
	int 10h ; set position of cursor
	
	mov ah, 9
	mov al, 32 ; character to draw (space)
	mov bl, [bp + 8] ; tile color, third parameter
	shl bl, 4
	mov cx, 1 ; times to repeat (twice, to make a square)
	int 10h ; draw tile at location of cursor

; subroutine closing convension
pop dx ; pop back used registers in reverse order
pop cx
pop bx
pop ax
mov sp, bp
pop bp
ret
_drawTile ENDP

_drawPiece PROC ; draw piece with given index (x, y, type)
; subroutine opening convension
push bp
mov bp, sp
sub sp, 0 ; no local variables so no need to move stack pointer
push ax ; push all used registers to the stack
push bx
push cx
push dx
; contents of the subroutine go here
	mov bx, [bp + 8] ; type of piece, third parameter
	mov al, piece_color[bx * 2]
	push ax ; push piece color once onto the stack
	mov ax, piece_shape[bx * 2] ; store piece shape in ax

	mov cl, 4 ; cl = y
	l_drawPiece_outerLoop:
		mov ch, 4 ; ch = x
		l_drawPiece_innerLoop:
			rcr ax, 1
			jnc l_drawPiece_loopEnd

			; draw tile
			mov bl, cl
			add bx, [bp + 6] ; y position, second parameter
			push bx

			mov bl, ch
			add bx, [bp + 4] ; x position, first parameter
			push bx

			call _drawTile
			add sp, 4

			l_drawPiece_loopEnd:
		dec ch
		jnz l_drawPiece_innerLoop
	dec cl
	jnz l_drawPiece_outerLoop

; subroutine closing convension
pop dx ; pop back used registers in reverse order
pop cx
pop bx
pop ax
mov sp, bp
pop bp
ret
_drawPiece ENDP

; here your sub-programs end
end