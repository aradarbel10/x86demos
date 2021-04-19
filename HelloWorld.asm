 ; template for programs
.model small
.stack 100h
.data


.code

mov ax,@data
mov ds, ax

; here your program starts

mov ah, 2
mov dl, 72
int 21h		;H
mov ah, 2
mov dl, 101
int 21h		;e
mov ah, 2
mov dl, 108
int 21h		;l
mov ah, 2
mov dl, 108
int 21h		;l
mov ah, 2
mov dl, 111
int 21h		;o
mov ah, 2
mov dl, 44
int 21h		;,

mov ah, 2
mov dl, 32
int 21h		;space

mov ah, 2
mov dl, 87
int 21h		;W
mov ah, 2
mov dl, 111
int 21h		;o
mov ah, 2
mov dl, 114
int 21h		;r
mov ah, 2
mov dl, 108
int 21h		;l
mov ah, 2
mov dl, 100
int 21h		;d
mov ah, 2
mov dl, 33
int 21h		;!


; here your program ends

mov ah,4ch
mov al,0
int 21h

; here your sub-programs start

; here your sub-programs end
end




