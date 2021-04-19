 ; template for programs
.model small
.stack 100h
.data


.code

mov ax,@data
mov ds, ax

; here your program starts

mov cx, 10 ; call mySubroutine 10 times
l_myLoop:
	call _mySubroutine
loop l_myLoop

; here your program ends

mov ah,4Ch
mov al,0
int 21h

; here your sub-programs start

_mySubroutine PROC ; a simple subroutine to print the ascii character 97 == 61h == 'a'
	; subroutine opening convension
	push bp
	mov bp, sp
	;sub sp 0 ; no local variables so no need to move stack pointer
	push ax ; push all used registers to the stack
	push dx

	; print the letter 'a' (61h ascii)
	mov ah, 2
	mov dl, 61h
	int 21h

	; subroutine closing convension
	pop dx
	pop ax
	mov sp, bp
	pop bp
	ret
_mySubroutine ENDP

; here your sub-programs end
end




