; game.asm
; Copyright (c) 2011 by Боярський Віталій

.586
.model flat,stdcall
option casemap:none
	include game.inc
.code
start:
	invoke GetModuleHandle,NULL
	mov hInstance,eax
	
	invoke GetCommandLine
	mov CommandLine,eax
	
	invoke WinMain, hInstance,NULL,CommandLine,SW_SHOWDEFAULT
	invoke ExitProcess,eax

WinMain proc hInst:HINSTANCE, hPrevInst:HINSTANCE, CmdLine:LPSTR, CmdShow:DWORD
	LOCAL wc:WNDCLASSEX
	LOCAL hwnd:HWND
	LOCAL msg:MSG
	
	mov   wc.cbSize,SIZEOF WNDCLASSEX
	mov   wc.style, CS_HREDRAW or CS_VREDRAW
	mov   wc.lpfnWndProc, offset WndProc
	mov   wc.cbClsExtra,NULL
	mov   wc.cbWndExtra,NULL
	push  hInstance
	pop   wc.hInstance
	mov   wc.hbrBackground,COLOR_BTNFACE+1
	mov   wc.lpszMenuName,NULL
	mov   wc.lpszClassName,offset ClassName
	
	invoke LoadIcon,hInstance,501
	mov   wc.hIcon,eax
	mov   wc.hIconSm,eax
	
	invoke LoadCursor,NULL,IDC_ARROW
	mov   wc.hCursor,eax
	
	invoke RegisterClassEx, addr wc
	invoke CreateWindowEx,NULL,ADDR ClassName,ADDR AppName,\
           WS_SIZEBOX xor WS_EX_CONTROLPARENT xor WS_OVERLAPPEDWINDOW,CW_USEDEFAULT,\
           CW_USEDEFAULT,796,515,NULL,NULL,\
           hInst,NULL
	mov hwnd,eax
	
	invoke ShowWindow, hwnd,SW_SHOWNORMAL
	invoke UpdateWindow,hwnd
	
	.WHILE TRUE
		invoke GetMessage, ADDR msg,NULL,0,0
		.BREAK .IF (!eax)
		invoke TranslateMessage, ADDR msg
		invoke DispatchMessage, ADDR msg
	.ENDW
	
	mov     eax,msg.wParam
	ret
WinMain endp

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
	LOCAL rc:RECT
	.IF uMsg==WM_DESTROY
		invoke KillTimer,hWnd,1
		invoke PostQuitMessage,NULL
	.ELSEIF uMsg==WM_CREATE
		invoke OnCreateMenu,hWnd
		invoke RegisterHotKey,hWnd,90000,0,VK_LEFT
		invoke RegisterHotKey,hWnd,90001,0,VK_RIGHT
		invoke SetTimer,hWnd,1,speed_time,NULL
	.ELSEIF uMsg==WM_COMMAND
		.if wParam==IDM_NEW_GAME
			invoke KillTimer,hWnd,1
			mov speed_time,500
			invoke SetTimer,hWnd,1,speed_time,NULL
			mov point,0
			mov game_over,3
			mov speed,0
			call RandomPos
			mov x_cub,eax
			mov y_cub,5
			inc n_game
		.elseif wParam==IDM_PAUSE
			invoke KillTimer,hWnd,1
			invoke MessageBox,hWnd,addr str_pausa,addr str_pausa,MB_OK
			invoke SetTimer,hWnd,1,speed_time,NULL
		.elseif wParam==IDM_EXIT
			invoke DestroyWindow,hWnd
		.elseif wParam==IDM_STAT
			invoke wsprintf,addr lpstat,addr format_s,n_game,max
			invoke MessageBox,hWnd,addr lpstat,addr str_stat,MB_OK
		.endif
	.ELSEIF uMsg==WM_HOTKEY
		.IF wParam==90000
			.if x_sl>12
				sub x_sl,24
				invoke InvalidateRect,hWnd,0,TRUE
			.endif
		.ELSEIF wParam==90001
			.if x_sl<548
				add x_sl,24
				invoke InvalidateRect,hWnd,0,TRUE
			.endif
		.ENDIF
	.ELSEIF uMsg==WM_PAINT
		invoke OnPaint,hWnd
	.ELSEIF uMsg==WM_TIMER
		.if y_cub<400
			add y_cub,24
			invoke InvalidateRect,hWnd,0,TRUE
		.else
			call RandomPos
			mov x_cub,eax
			mov y_cub,5
		.endif
		mov eax,x_cub
		mov ebx,x_sl
		add ebx,120
		.if y_cub>400 && eax>x_sl && eax<ebx
			add point,10
			mov eax,point
			.if eax>max
				mov max,eax
			.endif
		.elseif y_cub>400
			dec game_over
		.endif
		mov eax,speed
		mov ebx,50
		mul ebx
		.if point>=eax && speed<7
			invoke KillTimer,hWnd,1
			sub speed_time,50
			inc speed
			invoke SetTimer,hWnd,1,speed_time,NULL
		.endif
	.ELSE
		invoke DefWindowProc,hWnd,uMsg,wParam,lParam		
		ret
	.ENDIF
	xor eax,eax
	ret
WndProc endp

OnPaint proc hWnd:HWND
	LOCAL hdc:HDC
	LOCAL ps:PAINTSTRUCT
	.IF game_over>0 && game_over<5
		invoke LoadImage,hInstance,400,IMAGE_BITMAP,0,0,NULL
		mov hBitmap,eax
		invoke GetObject,hBitmap,sizeof BITMAP,addr bm
		invoke GetDC,hWnd
		mov hdc,eax
		invoke CreateCompatibleDC,hdc
		mov hdcMem,eax
		invoke SelectObject,hdcMem,hBitmap
		mov hOldBitmap,eax
		invoke ReleaseDC,hWnd,hdc
	
		invoke BeginPaint,hWnd,addr ps
		mov hdc,eax
		invoke BitBlt,hdc,0,0,bm.bmWidth,bm.bmHeight,hdcMem,0,0,SRCCOPY
		invoke wsprintf,addr str_point,addr format,point
		invoke TextOut,hdc,720,50,addr str_point,5
		invoke wsprintf,addr str_life,addr format,game_over
		invoke TextOut,hdc,735,150,addr str_life,1
		invoke wsprintf,addr str_speed,addr format,speed
		invoke TextOut,hdc,735,250,addr str_speed,1
		invoke EndPaint,hWnd,addr ps
	
		invoke LoadImage,hInstance,402,IMAGE_BITMAP,0,0,NULL
		mov hBitmap,eax
		invoke GetObject,hBitmap,sizeof BITMAP,addr bm
		invoke GetDC,hWnd
		mov hdc,eax
		invoke CreateCompatibleDC,hdc
		mov hdcMem,eax
		invoke SelectObject,hdcMem,hBitmap
		mov hOldBitmap,eax
		invoke BitBlt,hdc,x_cub,y_cub,bm.bmWidth,bm.bmHeight,hdcMem,0,0,SRCCOPY
		invoke ReleaseDC,hWnd,hdc
	
		invoke LoadImage,hInstance,401,IMAGE_BITMAP,0,0,NULL
		mov hBitmap,eax
		invoke GetObject,hBitmap,sizeof BITMAP,addr bm
		invoke GetDC,hWnd
		mov hdc,eax
		invoke CreateCompatibleDC,hdc
		mov hdcMem,eax
		invoke SelectObject,hdcMem,hBitmap
		mov hOldBitmap,eax
		invoke BitBlt,hdc,x_sl,y_sl,bm.bmWidth,bm.bmHeight,hdcMem,0,0,SRCCOPY
		invoke ReleaseDC,hWnd,hdc
	.else
		invoke LoadImage,hInstance,403,IMAGE_BITMAP,0,0,NULL
		mov hBitmap,eax
		invoke GetObject,hBitmap,sizeof BITMAP,addr bm
		invoke GetDC,hWnd
		mov hdc,eax
		invoke CreateCompatibleDC,hdc
		mov hdcMem,eax
		invoke SelectObject,hdcMem,hBitmap
		mov hOldBitmap,eax
		invoke ReleaseDC,hWnd,hdc
	
		invoke BeginPaint,hWnd,addr ps
		mov hdc,eax
		invoke BitBlt,hdc,0,0,bm.bmWidth,bm.bmHeight,hdcMem,0,0,SRCCOPY
		invoke wsprintf,addr str_point,addr format,point
		invoke TextOut,hdc,705,15,addr str_point,5
		invoke EndPaint,hWnd,addr ps
		invoke KillTimer,hWnd,1
	.endif
	
	ret
OnPaint endp

OnCreateMenu proc hWnd:HWND
	LOCAL hMenu:HMENU
	LOCAL hPopupMenu:HMENU
	invoke CreateMenu
	mov hMenu,eax
	invoke CreatePopupMenu
	mov hPopupMenu,eax
	invoke AppendMenu,hPopupMenu,MF_STRING,IDM_NEW_GAME,addr str_new_game
	invoke AppendMenu,hPopupMenu,MF_STRING,IDM_PAUSE,addr str_pausa
	invoke AppendMenu,hPopupMenu,MF_SEPARATOR,NULL,NULL
	invoke AppendMenu,hPopupMenu,MF_STRING,IDM_STAT,addr str_stat
	invoke AppendMenu,hPopupMenu,MF_SEPARATOR,NULL,NULL
	invoke AppendMenu,hPopupMenu,MF_STRING,IDM_EXIT,addr str_exit
	invoke AppendMenu,hMenu,MF_POPUP,hPopupMenu,addr str_main
	invoke SetMenu,hWnd,hMenu
	ret
OnCreateMenu endp

RandomPos proc
	LOCAL stm:SYSTEMTIME
	LOCAL rn:WORD
	invoke GetSystemTime,addr stm
	mov ax,stm.wMilliseconds
	mov rn,ax
	.while rn>27
		sub rn,27
	.endw
	mov eax,0
	mov ax,rn
	mov bx,24
	mul bx
	add eax,5
	ret
RandomPos endp

end start
