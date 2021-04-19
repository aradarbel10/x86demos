 ; template for programs
.model small
.stack 100h
.data

rect_x dw 30
rect_y dw 50
rect_w dw 70
rect_h dw 35

.code

mov ax,@data
mov ds, ax

; here your program starts

mov ah, 0
mov al, 19
int 10h ; switch to 320x200 graphic mode

; push arguments and call
push rect_x
push rect_y
push rect_w
push rect_h
call _drawRectangle

; here your program ends

mov ah,4Ch
mov al,0
int 21h

; here your sub-programs start

_drawRectangle PROC ; draw a white rectangle given position and size
; subroutine opening convension
push bp
mov bp, sp
sub sp, 0 ; no local variables so no need to move stack pointer
push ax ; push all used registers to the stack
push bx
push cx
push dx
; contents of the subroutine go here
	mov bx, [bp + 6] ; width, second parameter
	l_outerRectLoop:
		mov ax, [bp + 4] ; height, first parameter
		mov bh, al
		l_innerRectLoop:
			; choose color
			mov al, 0 ; white

			; set coordinate of pixel
			mov cx, [bp + 10] ; x coordinate, forth parameter
			add cl, bl

			mov dx, [bp + 8] ; y coordinate, third parameter
			add dl, bh

			; draw pixel
			mov ah, 12
			int 10h
		dec bh
		jnz l_innerRectLoop
	dec bl
	jnz l_outerRectLoop

; subroutine closing convension
pop dx ; pop back used registers in reverse order
pop cx
pop bx
pop ax
mov sp, bp
pop bp
ret
_drawRectangle ENDP

; here your sub-programs end
end