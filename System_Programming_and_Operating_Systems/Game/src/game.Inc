; game.inc
; Copyright (c) 2011 by Боярський Віталій

	include windows.inc
	include user32.inc
	include kernel32.inc
	include gdi32.inc
	include shell32.inc

	includelib user32.lib
	includelib kernel32.lib
	includelib gdi32.lib
	includelib shell32.lib

	WinMain proto :DWORD,:DWORD,:DWORD,:DWORD
	OnPaint proto :HWND
	OnCreateMenu proto :HWND
	
	IDM_NEW_GAME equ 1011
	IDM_EXIT equ 1012
	IDM_PAUSE equ 1013
	IDM_MAIN equ 1010
	IDM_STAT equ 1014
.data
	AppName  db "Main Window",0,0
	ClassName db "MainWinClass",0
	bm BITMAP <0>
	
	str_new_game db 'Нова ігра',0
	str_pausa db 'Пауза',0
	str_exit db 'Вихід',0
	str_main db 'Ігра',0
	str_stat db 'Статистика',0
	x_sl dd 292
	y_sl dd 412
	x_cub dd 197
	y_cub dd 5
	point dd 0
	max dd 0
	n_game dd 0
	str_point db 255 dup (0)
	format db '%d',0
	game_over dd 3
	str_life db 255 dup (0)
	str_speed db 255 dup (0)
	lpstat db 255 dup (0)
	format_s db 'Курсова робота',10,13,'ІКНІ КН-20',10,13,'Андреїв Андрій',10,13,10,'Проведено ігр: %d',10,13,'Максимальний результат : %d',0
	speed dd 0
	szfont db 'Arial',0
	hfont dd 0
	speed_time dd 500
.data?
	CommandLine LPSTR ?
	hInstance HINSTANCE ?
	hdcMem HDC ?
	hOldBitmap HBITMAP ?
	hBitmap HBITMAP ?
