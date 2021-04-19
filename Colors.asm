 ; template for programs
.model small
.stack 100h
.data

square_size db 5
grid_width db 36
grid_height db 7

.code

mov ax,@data
mov ds, ax

; here your program starts

mov ah, 0
mov al, 19
int 10h ; switch to 320x200 graphic mode

mov cl, grid_width
l_outerColorLoop:
	push cx
	mov cl, grid_height
	l_innerColorLoop:
		push cx
		; contents of the nested loops
		call _drawSquare

		pop cx
	loop l_innerColorLoop
	pop cx
loop l_outerColorLoop

; here your program ends

mov ah,4Ch
mov al,0
int 21h

; here your sub-programs start

_drawSquare PROC
; subroutine opening convension
push bp
mov bp, sp
sub sp, 0 ; no local variables so no need to move stack pointer
push ax ; push all used registers to the stack
push bx
push cx
push dx
	; contents of the subroutine go here

	mov bl, square_size
	l_outerSquareLoop:
		mov bh, square_size
		l_innerSquareLoop:
			; get call parameter
			mov dx, [bp + 4] ; y coordinate, first parameter
			mov cx, [bp + 6] ; x coordinate, second parameter

			; choose color from palette
			push bx
			mov	ax, dx
			mov bl, grid_width
			imul bl
			add al, cl
			sub al, 25
			pop bx

			; adjust coordinates
			xchg ax, cx
			dec ax
			imul square_size
			xchg cx, ax
			add cl, bl

			xchg ax, dx
			dec ax
			imul square_size
			xchg ax, dx
			add dl, bh

			; draw pixel
			mov ah, 12
			int 10h
		dec bh
		jnz l_innerSquareLoop
	dec bl
	jnz l_outerSquareLoop

; subroutine closing convension
pop dx ; pop back used registers in reverse order
pop cx
pop bx
pop ax
mov sp, bp
pop bp
ret
_drawSquare ENDP

; here your sub-programs end
end