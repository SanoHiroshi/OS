[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_sprintf
	EXTERN	_io_hlt
	EXTERN	_hankaku
	EXTERN	_io_load_eflags
	EXTERN	_io_cli
	EXTERN	_io_out8
	EXTERN	_io_store_eflags
[FILE "bootpack.c"]
[SECTION .data]
LC0:
	DB	"(%d, %d)",0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	LEA	EBX,DWORD [-60+EBP]
	SUB	ESP,304
	CALL	_init_palette
	MOVSX	EAX,WORD [4086]
	PUSH	EAX
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_init_screen
	MOV	ECX,2
	MOVSX	EAX,WORD [4084]
	LEA	EDX,DWORD [-16+EAX]
	MOV	EAX,EDX
	CDQ
	IDIV	ECX
	MOVSX	EDX,WORD [4086]
	SUB	EDX,44
	MOV	EDI,EAX
	MOV	EAX,EDX
	CDQ
	IDIV	ECX
	PUSH	EAX
	MOV	ESI,EAX
	PUSH	EDI
	PUSH	LC0
	PUSH	EBX
	CALL	_sprintf
	PUSH	EBX
	PUSH	7
	LEA	EBX,DWORD [-316+EBP]
	PUSH	64
	PUSH	16
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfont8_asc
	ADD	ESP,52
	PUSH	14
	PUSH	EBX
	CALL	_init_mouse_cursor8
	PUSH	16
	PUSH	EBX
	PUSH	ESI
	PUSH	EDI
	PUSH	16
	PUSH	16
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putblock8_8
	ADD	ESP,40
L2:
	CALL	_io_hlt
	JMP	L2
[SECTION .data]
_table_rgb.0:
	DB	0
	DB	0
	DB	0
	DB	-1
	DB	0
	DB	0
	DB	0
	DB	-1
	DB	0
	DB	-1
	DB	-1
	DB	0
	DB	0
	DB	0
	DB	-1
	DB	-1
	DB	0
	DB	-1
	DB	0
	DB	-1
	DB	-1
	DB	-1
	DB	-1
	DB	-1
	DB	-58
	DB	-58
	DB	-58
	DB	-124
	DB	0
	DB	0
	DB	0
	DB	-124
	DB	0
	DB	-124
	DB	-124
	DB	0
	DB	0
	DB	0
	DB	-124
	DB	-124
	DB	0
	DB	-124
	DB	0
	DB	-124
	DB	-124
	DB	-124
	DB	-124
	DB	-124
[SECTION .text]
	GLOBAL	_init_palette
_init_palette:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	_table_rgb.0
	PUSH	15
	PUSH	0
	CALL	_set_palette
	LEAVE
	RET
	GLOBAL	_init_screen
_init_screen:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	SUB	ESP,12
	MOV	EAX,DWORD [16+EBP]
	MOV	EDI,DWORD [12+EBP]
	SUB	EAX,29
	DEC	EDI
	PUSH	EAX
	PUSH	EDI
	PUSH	0
	PUSH	0
	PUSH	14
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,28
	PUSH	EAX
	PUSH	EDI
	PUSH	EAX
	PUSH	0
	PUSH	8
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	MOV	EAX,DWORD [16+EBP]
	ADD	ESP,56
	SUB	EAX,27
	PUSH	EAX
	PUSH	EDI
	PUSH	EAX
	PUSH	0
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	MOV	EAX,DWORD [16+EBP]
	DEC	EAX
	PUSH	EAX
	MOV	EAX,DWORD [16+EBP]
	PUSH	EDI
	SUB	EAX,26
	PUSH	EAX
	PUSH	0
	PUSH	8
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	MOV	ESI,DWORD [16+EBP]
	ADD	ESP,56
	SUB	ESI,24
	PUSH	ESI
	PUSH	59
	PUSH	ESI
	PUSH	3
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,4
	PUSH	EAX
	MOV	DWORD [-16+EBP],EAX
	PUSH	2
	PUSH	ESI
	PUSH	2
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	ADD	ESP,56
	PUSH	DWORD [-16+EBP]
	PUSH	59
	PUSH	DWORD [-16+EBP]
	PUSH	3
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,5
	PUSH	EAX
	MOV	EAX,DWORD [16+EBP]
	PUSH	59
	SUB	EAX,23
	PUSH	EAX
	MOV	DWORD [-20+EBP],EAX
	PUSH	59
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	MOV	EAX,DWORD [16+EBP]
	ADD	ESP,56
	SUB	EAX,3
	MOV	DWORD [-24+EBP],EAX
	PUSH	EAX
	PUSH	59
	PUSH	EAX
	PUSH	2
	PUSH	0
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	PUSH	DWORD [-24+EBP]
	PUSH	60
	PUSH	ESI
	PUSH	60
	PUSH	0
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	MOV	EDI,DWORD [12+EBP]
	ADD	ESP,56
	MOV	EBX,DWORD [12+EBP]
	SUB	EBX,4
	SUB	EDI,47
	PUSH	ESI
	PUSH	EBX
	PUSH	ESI
	PUSH	EDI
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	PUSH	DWORD [-16+EBP]
	PUSH	EDI
	PUSH	DWORD [-20+EBP]
	PUSH	EDI
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	ADD	ESP,56
	PUSH	DWORD [-24+EBP]
	PUSH	EBX
	PUSH	DWORD [-24+EBP]
	PUSH	EDI
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	MOV	EAX,DWORD [12+EBP]
	PUSH	DWORD [-24+EBP]
	SUB	EAX,3
	PUSH	EAX
	PUSH	ESI
	PUSH	EAX
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_bookfill8
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
	GLOBAL	_bookfill8
_bookfill8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	PUSH	ECX
	PUSH	ECX
	MOV	AL,BYTE [16+EBP]
	MOV	ECX,DWORD [24+EBP]
	MOV	EDI,DWORD [28+EBP]
	MOV	BYTE [-13+EBP],AL
	CMP	ECX,DWORD [32+EBP]
	JG	L19
	MOV	EBX,DWORD [12+EBP]
	IMUL	EBX,ECX
L17:
	MOV	EDX,DWORD [20+EBP]
	CMP	EDX,EDI
	JG	L21
	MOV	ESI,DWORD [8+EBP]
	ADD	ESI,EBX
	ADD	ESI,EDX
	MOV	DWORD [-20+EBP],ESI
L16:
	MOV	ESI,DWORD [-20+EBP]
	MOV	AL,BYTE [-13+EBP]
	INC	EDX
	MOV	BYTE [ESI],AL
	INC	ESI
	MOV	DWORD [-20+EBP],ESI
	CMP	EDX,EDI
	JLE	L16
L21:
	INC	ECX
	ADD	EBX,DWORD [12+EBP]
	CMP	ECX,DWORD [32+EBP]
	JLE	L17
L19:
	POP	EAX
	POP	EDX
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
	GLOBAL	_putfont8
_putfont8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	XOR	ESI,ESI
	PUSH	EBX
	MOV	EDI,DWORD [28+EBP]
	MOV	BL,BYTE [24+EBP]
L35:
	MOV	EAX,DWORD [20+EBP]
	MOV	EDX,DWORD [16+EBP]
	ADD	EAX,ESI
	IMUL	EAX,DWORD [12+EBP]
	ADD	EAX,DWORD [8+EBP]
	LEA	ECX,DWORD [EDX+EAX*1]
	MOV	DL,BYTE [ESI+EDI*1]
	TEST	DL,DL
	JNS	L27
	MOV	BYTE [ECX],BL
L27:
	MOV	AL,DL
	AND	EAX,64
	TEST	AL,AL
	JE	L28
	MOV	BYTE [1+ECX],BL
L28:
	MOV	AL,DL
	AND	EAX,32
	TEST	AL,AL
	JE	L29
	MOV	BYTE [2+ECX],BL
L29:
	MOV	AL,DL
	AND	EAX,16
	TEST	AL,AL
	JE	L30
	MOV	BYTE [3+ECX],BL
L30:
	MOV	AL,DL
	AND	EAX,8
	TEST	AL,AL
	JE	L31
	MOV	BYTE [4+ECX],BL
L31:
	MOV	AL,DL
	AND	EAX,4
	TEST	AL,AL
	JE	L32
	MOV	BYTE [5+ECX],BL
L32:
	MOV	AL,DL
	AND	EAX,2
	TEST	AL,AL
	JE	L33
	MOV	BYTE [6+ECX],BL
L33:
	AND	EDX,1
	TEST	DL,DL
	JE	L25
	MOV	BYTE [7+ECX],BL
L25:
	INC	ESI
	CMP	ESI,15
	JLE	L35
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
	GLOBAL	_putfont8_asc
_putfont8_asc:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	PUSH	EBX
	MOV	EBX,DWORD [28+EBP]
	MOV	AL,BYTE [24+EBP]
	MOV	BYTE [-13+EBP],AL
	MOV	ESI,DWORD [16+EBP]
	MOV	EDI,DWORD [20+EBP]
	CMP	BYTE [EBX],0
	JNE	L43
L45:
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
L43:
	MOVSX	EAX,BYTE [EBX]
	SAL	EAX,4
	INC	EBX
	ADD	EAX,_hankaku
	PUSH	EAX
	MOVSX	EAX,BYTE [-13+EBP]
	PUSH	EAX
	PUSH	EDI
	PUSH	ESI
	ADD	ESI,8
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_putfont8
	ADD	ESP,24
	CMP	BYTE [EBX],0
	JNE	L43
	JMP	L45
	GLOBAL	_set_palette
_set_palette:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	PUSH	ECX
	MOV	EBX,DWORD [8+EBP]
	MOV	EDI,DWORD [12+EBP]
	MOV	ESI,DWORD [16+EBP]
	CALL	_io_load_eflags
	MOV	DWORD [-16+EBP],EAX
	CALL	_io_cli
	PUSH	EBX
	PUSH	968
	CALL	_io_out8
	CMP	EBX,EDI
	POP	EAX
	POP	EDX
	JLE	L51
L53:
	MOV	EAX,DWORD [-16+EBP]
	MOV	DWORD [8+EBP],EAX
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	JMP	_io_store_eflags
L51:
	MOV	AL,BYTE [ESI]
	INC	EBX
	SHR	AL,2
	MOVZX	EAX,AL
	PUSH	EAX
	PUSH	969
	CALL	_io_out8
	MOV	AL,BYTE [1+ESI]
	SHR	AL,2
	MOVZX	EAX,AL
	PUSH	EAX
	PUSH	969
	CALL	_io_out8
	MOV	AL,BYTE [2+ESI]
	SHR	AL,2
	ADD	ESI,3
	MOVZX	EAX,AL
	PUSH	EAX
	PUSH	969
	CALL	_io_out8
	ADD	ESP,24
	CMP	EBX,EDI
	JLE	L51
	JMP	L53
[SECTION .data]
_cursor.1:
	DB	"**************.."
	DB	"*oooooooooooo*.."
	DB	"*ooooooooooo*..."
	DB	"*oooooooooo*...."
	DB	"*ooooooooo*....."
	DB	"*oooooooo*......"
	DB	"*oooooooo*......"
	DB	"*ooooooooo*....."
	DB	"*oooo**oooo*...."
	DB	"*ooo*..*ooo*...."
	DB	"*oo*....*ooo*..."
	DB	"*o*......*ooo*.."
	DB	"**........*ooo*."
	DB	"*..........*ooo*"
	DB	"............*oo*"
	DB	".............***"
[SECTION .text]
	GLOBAL	_init_mouse_cursor8
_init_mouse_cursor8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	XOR	EDI,EDI
	PUSH	EBX
	PUSH	ESI
	XOR	EBX,EBX
	MOV	AL,BYTE [12+EBP]
	MOV	ESI,DWORD [8+EBP]
	MOV	BYTE [-13+EBP],AL
L67:
	XOR	EDX,EDX
L66:
	LEA	EAX,DWORD [EDX+EDI*1]
	CMP	BYTE [_cursor.1+EAX],42
	JE	L72
L63:
	CMP	BYTE [_cursor.1+EAX],111
	JE	L73
L64:
	CMP	BYTE [_cursor.1+EAX],46
	JE	L74
L61:
	INC	EDX
	CMP	EDX,15
	JLE	L66
	INC	EBX
	ADD	EDI,16
	CMP	EBX,15
	JLE	L67
	POP	EBX
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
L74:
	MOV	CL,BYTE [-13+EBP]
	MOV	BYTE [EAX+ESI*1],CL
	JMP	L61
L73:
	MOV	BYTE [EAX+ESI*1],7
	JMP	L64
L72:
	MOV	BYTE [EAX+ESI*1],0
	JMP	L63
	GLOBAL	_putblock8_8
_putblock8_8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	XOR	ESI,ESI
	PUSH	EBX
	SUB	ESP,12
	CMP	ESI,DWORD [20+EBP]
	JGE	L87
	XOR	EDI,EDI
L85:
	XOR	EBX,EBX
	CMP	EBX,DWORD [16+EBP]
	JGE	L89
	MOV	EAX,DWORD [32+EBP]
	ADD	EAX,EDI
	MOV	DWORD [-20+EBP],EAX
L84:
	MOV	EAX,DWORD [28+EBP]
	MOV	EDX,DWORD [24+EBP]
	ADD	EAX,ESI
	ADD	EDX,EBX
	IMUL	EAX,DWORD [12+EBP]
	ADD	EAX,EDX
	MOV	ECX,DWORD [8+EBP]
	MOV	EDX,DWORD [-20+EBP]
	INC	EBX
	MOV	DL,BYTE [EDX]
	MOV	BYTE [EAX+ECX*1],DL
	INC	DWORD [-20+EBP]
	CMP	EBX,DWORD [16+EBP]
	JL	L84
L89:
	INC	ESI
	ADD	EDI,DWORD [36+EBP]
	CMP	ESI,DWORD [20+EBP]
	JL	L85
L87:
	ADD	ESP,12
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
