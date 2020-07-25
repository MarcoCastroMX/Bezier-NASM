;     nasm -felf64 Bezier.asm &&  gcc -no-pie Bezier.o && ./a.out

		extern printf
		extern scanf
		global main

		section .text

main:
		push 	RBX
		xor 	RBX,RBX
		xor 	RBP,RBP

	Bucle:
			mov 	RDI,ValorX
			call 	printf

			mov 	RDI,FormatoFloatScanf
			mov 	RSI,Numero
			call 	scanf

			unpcklps	xmm0, xmm0 
			cvtps2pd	xmm0, xmm0

			movsd 	qword[rel VectorX+RBX],xmm0

			mov 	RDI,ValorY
			call 	printf

			mov 	RDI,FormatoFloatScanf
			mov 	RSI,Numero
			call 	scanf

			unpcklps	xmm0, xmm0 
			cvtps2pd	xmm0, xmm0

			movsd 	qword[rel VectorY+RBX],xmm0

			cmp 	RBP,3
			je 		Preparacion
			add 	RBX,8
			add 	RBP,1
			jmp 	Bucle

		Preparacion:
				mov 	RDI,ValorT
				call 	printf

				mov 	RDI,FormatoFloatScanf
				mov 	RSI,Numero
				call 	scanf

				unpcklps	xmm0, xmm0 
				cvtps2pd	xmm0, xmm0

				movsd 	qword[rel NumeroT],xmm0

				fld 	qword[rel NumeroT]
				fld 	qword[rel Uno]
				fcomip 	ST0,ST1
				jc 		Salida
				fld 	qword[rel Cero]
				fcomip 	ST0,ST1
				jnc 	Salida
				fstp 	qword[rel NumeroT]

				jmp 	Formula

			Formula:
					fld 	qword[rel NumeroT]
					fld  	qword[rel Uno]
					fsub 	ST0,ST1
					fstp 	qword[rel Resta]
					fld 	qword[rel Resta]
					fmul 	ST0,ST0
					fld 	qword[rel Resta]
					fmul 	ST0,ST1
					fld  	qword[rel VectorX]
					fmul
					fstp 	qword[rel Parte1]

					fld 	qword[rel Resta]
					fmul 	ST0,ST0
					fld 	qword[rel NumeroT]
					fmul 	ST0,ST1
					fld 	qword[rel VectorX+8]
					fmul 	ST0,ST1
					fld  	qword[rel Tres]
					fmul 	ST0,ST1
					fstp 	qword[rel Parte2]

					fld 	qword[rel Resta]
					fld 	qword[rel NumeroT]
					fmul 	ST0,ST0
					fmul 	ST0,ST1
					fld 	qword[rel Tres]
					fmul 	
					fld 	qword[rel VectorX+16]
					fmul
					fstp 	qword[rel Parte3]

					fld 	qword[rel NumeroT]
					fmul 	ST0,ST0
					fld 	qword[rel NumeroT]
					fmul
					fld 	qword[rel VectorX+24]
					fmul
					fstp 	qword[rel Parte4]

					fld 	qword[rel Parte1]
					fld 	qword[rel Parte2]
					fadd 	
					fld 	qword[rel Parte3]
					fadd 	
					fld 	qword[rel Parte4]
					fadd  	
					fstp 	qword[rel ResultadoX]

					fld 	qword[rel Resta]
					fmul 	ST0,ST0
					fld 	qword[rel Resta]
					fmul 	
					fld  	qword[rel VectorY]
					fmul
					fstp 	qword[rel Parte1]

					fld 	qword[rel Resta]
					fmul 	ST0,ST0
					fld 	qword[rel NumeroT]
					fmul 	
					fld 	qword[rel VectorY+8]
					fmul 	
					fld  	qword[rel Tres]
					fmul 	
					fstp 	qword[rel Parte2]

					fld 	qword[rel Resta]
					fld 	qword[rel NumeroT]
					fmul 	ST0,ST0
					fmul 
					fld 	qword[rel Tres]
					fmul 	
					fld 	qword[rel VectorY+16]
					fmul
					fstp 	qword[rel Parte3]

					fld 	qword[rel NumeroT]
					fmul 	ST0,ST0
					fld 	qword[rel NumeroT]
					fmul
					fld 	qword[rel VectorY+24]
					fmul
					fstp 	qword[rel Parte4]

					fld 	qword[rel Parte1]
					fld 	qword[rel Parte2]
					fadd 	
					fld 	qword[rel Parte3]
					fadd 	
					fld 	qword[rel Parte4]
					fadd  	
					fstp 	qword[rel ResultadoY]

					mov 	RAX,1
					mov 	RDI,ImprimirResultadoX
					movsd 	xmm0,qword[rel ResultadoX]
					call 	printf

					mov 	RAX,1
					mov 	RDI,ImprimirResultadoY
					movsd 	xmm0,qword[rel ResultadoY]
					call 	printf


	Salida:
			pop     RBX                     
			ret

	section .data
ValorX:
		db	"Ingrese X: ",0
ValorY:
		db	"Ingrese Y: ",0
ValorT:
		db	"Ingrese T: ",0
ImprimirNumero:
		db  "Numero: %d",10, 0
ImprimirFlotante:
		db  "%f",10, 0
ImprimirResultadoX:
		db  "Resultado X: %3.3f",10, 0
ImprimirResultadoY:
		db  "Resultado Y: %3.3f",10, 0
FormatoScanf:
		db  "%d", 0
FormatoFloatScanf:
		db  "%f", 0
Uno:
		dq 	1.0
Cero:
		dq 	0.0
Tres:
		dq 	3.0

	section .bss
VectorX:
		resq 4
VectorY:
		resq 4
Numero:
		resq 1
NumeroT:
		resq 1
Parte1:
		resq 1
Parte2:
		resq 1
Parte3:
		resq 1
Parte4:
		resq 1
ResultadoX:
		resq 1
ResultadoY:
		resq 1
Resta:
		resq 1