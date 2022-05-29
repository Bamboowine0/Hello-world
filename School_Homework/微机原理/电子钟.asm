DATA SEGMENT
    CHAR0 DB "/$"
    CHAR1 DB ":$"
DATA ENDS

CODE SEGMENT
START:

 
MOV CX,1;
TIME:
MOV AX,3;清除屏幕
INT 10h
 
;设置光标居中
MOV DH,10;
MOV DL,35;
MOV BH,0;
MOV AH,2;
INT 10H;

mov cx,2000h
mov ah,01h
int 10h ;设置光标类型,隐藏光标

;读取打印年份
MOV AH,2AH;
INT 21H;
MOV AX,CX;
CALL PRINT;
CALL PRINT_\

;读取打印月份
MOV AL,DH;
MOV AH,0;
CALL PRINT;
CALL PRINT_\;

;读取打印日期
MOV AL,DL;
MOV AH,0;
CALL PRINT;
CALL CRLF;

MOV DH,11;
MOV DL,35;
MOV BH,0;
MOV AH,2;
INT 10H;

;读取打印小时
MOV AH,2CH;
INT 21H;
MOV AL,CH;
MOV AH,0;
CALL PRINT;
CALL PRINT_;

;读取打印分钟
MOV AL,CL;
MOV AH,0;
CALL PRINT;
CALL PRINT_;

;读取打印秒
MOV AH,2CH;
INT 21H;
MOV AL,DH;
MOV AH,0;
CALL PRINT;


INC CX;
LOOP TIME
          
          
PRINT:    ;俩函数
        PUSH AX
        PUSH CX
        PUSH DX
        MOV CX,0
        MOV BX,10
    DISP1:
        MOV DX,0
        DIV BX
        PUSH DX
        INC CX
        OR AX,AX
        JNE DISP1
    DISP2:
        MOV AH,2
        POP DX
        ADD DL,30H
        INT 21H
    LOOP DISP2
        POP DX;
        POP CX
        POP AX
        RET  
        
PRINT_\:
        PUSH AX;
        PUSH DX;
        PUSH DS;
        
        MOV AX, DATA;
        MOV DS,AX;
        MOV DX,OFFSET CHAR0;
        MOV AH,09H;
        INT 21H;
        
        POP DS;
        POP DX;
        POP AX;
        RET;
        
PRINT_:
        PUSH AX;
        PUSH DX;
        PUSH DS;
        
        MOV AX, DATA;
        MOV DS,AX;
        MOV DX,OFFSET CHAR1;
        MOV AH,09H;
        INT 21H;
        
        POP DS;
        POP DX;
        POP AX;
        RET;         
CRLF:
        PUSH AX
        PUSH DX
        MOV DL,0AH
        MOV AH,2H
        INT 21H
        MOV DL,0DH
        MOV AH,2H
        INT 21H
        POP DX
        POP AX
        RET

ENDS
END START
