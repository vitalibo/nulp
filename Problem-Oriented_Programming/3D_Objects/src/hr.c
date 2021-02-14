#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <dos.h>
#include "cub.h"
#include "cul.h"
#define BK_COLOR BLUE

int v=0;

void winxy (int LEFT, int TOP, int WIN_X, int WIN_Y, char *main_str) {
    int x,y;
	textbackground(BK_COLOR); clrscr();
	window(LEFT,TOP,LEFT+WIN_X,TOP+WIN_Y);
	textbackground(BLACK); clrscr();
	textbackground(LIGHTGRAY); textcolor(WHITE);
	putch(201);
	for (x=2; x<(WIN_X-strlen(main_str))/2+1; x++)
		putch(205);
	cprintf("%s",main_str);
	for (x=x+strlen(main_str); x<WIN_X; x++)
		putch(205);
	putch(187);
	textbackground(BK_COLOR); putch(' ');
	textbackground(LIGHTGRAY);
	gotoxy(3,1); putch('[');
	textcolor(LIGHTGREEN); putch(254); textcolor(WHITE);
	putch(']');
	for (y=2; y<WIN_Y; y++) {
		gotoxy(1,y); putch(186);
		for (x=2; x<WIN_X; x++)
			putch(' ');
		putch(186);
	}
	gotoxy(1,WIN_Y); putch(200);
	for (x=2; x<WIN_X; x++)
		putch(205);
	putch(188);
	textbackground(BK_COLOR);
	gotoxy(1,WIN_Y+1); putch(' ');
}

int consol_main (int WIN_X, int WIN_Y, int N, char str[][8]) {
	int i,j,d=1;
	char h;
	while (1) {
		for (i=1; i<N; i++) {
			textbackground(GREEN);
			gotoxy((WIN_X/N*i)-3,WIN_Y-2);
			for (j=0; j<8; j++)
				putch(255);
			textcolor(BLACK);
			textbackground(LIGHTGRAY); putch(220);
			gotoxy((WIN_X/N*i)-2,WIN_Y-1);
			for (j=0; j<8; j++)
				putch(223);
			textbackground(GREEN);
			if (i==d)
				textcolor(WHITE);
			else
				textcolor(YELLOW);
			gotoxy((WIN_X/N*i)-strlen(str[i-1])/2+1,WIN_Y-2);
			cprintf("%s",str[i-1]);
		}
		switch (getch()) {
			case 27: return 'E';
			case 'M': if (d>=N-1) d=1;
				else d++;
				break;
			case 'K': if (d<=1) d=N-1;
				else d--;
				break;
			case 13: case ' ':
				textbackground(LIGHTGRAY);
				gotoxy((WIN_X/N*d)-3,WIN_Y-2);
				putch(255);
				textbackground(GREEN);
				for (j=0; j<8; j++)
					putch(255);
				textbackground(LIGHTGRAY);
				gotoxy((WIN_X/N*d)-3,WIN_Y-1);
				for (j=0; j<9; j++)
					putch(255);
				textbackground(GREEN);
				textcolor(BLUE);
				gotoxy((WIN_X/N*d)-strlen(str[d-1])/2+2,WIN_Y-2);
				cprintf("%s",str[d-1]);
				delay(600);
			return *str[d-1];
		}
	}
}

void about_main (void) {
	char str[][50]={
		"Курсова робота",
		"IKHI KH-10",
		"Боярський Вiталiй",
		"Володимирович"};
	char str_n[][50]={
		"Term Paper",
		"IKNI KN-10",
		"Boyarskij Vitalij"};
	int win_x=35, win_y=13,i;
	winxy((80-win_x)/2+1,(25-win_y)/2+1,win_x,win_y," About ");
	textbackground(LIGHTGRAY);
	textcolor(BLACK);
	if (v==0) {
		for (i=0; i<4; i++) {
			gotoxy((win_x-strlen(str[i]))/2+1,3+i*2);
			cprintf("%s",str[i]);
		}
	} else {
		for (i=0; i<3; i++) {
			gotoxy((win_x-strlen(str_n[i]))/2+1,3+i*2);
			cprintf("%s",str_n[i]);
		}
	}
	consol_main(win_x,win_y,2,"OK");
}

void exit_main (void) {
	int win_x=50, win_y=7,h;
	char str_c[][8]={"Yes","No"};
	char str[]="Ви бажаєте вийти?";
	char str_n[]="You wish to go exit ? ";
	winxy((80-win_x)/2+1,(25-win_y)/2+1,win_x,win_y," Exit ");
	textbackground(LIGHTGRAY);
	textcolor(BLACK);
	if (v==0) {
		gotoxy((win_x-strlen(str))/2+1,3);
		cprintf("%s",str);
	} else {
		gotoxy((win_x-strlen(str_n))/2+1,3);
		cprintf("%s",str_n);
	}
	h=consol_main(win_x,win_y,3,str_c);
	switch (h) {
		case 'Y': exit(0);
		case 'N': return;
		default: exit_main();
	}
}

int flcub_main (void) {
	int win_x=50, win_y=5,h;
	char str[][8]={"Yes","No"};
	winxy((80-win_x)/2+1,(25-win_y)/2+1,win_x,win_y," floodfill ");
	h=consol_main(win_x,win_y,3,str);
	switch (h) {
		case 'Y': return 1;
		case 'N': return 0;
	}
}
void main_main (void){
	unsigned maxdrives="C//BC//BIN//KEYUKR.COM";
	int win_x=75, win_y=15,h,m;
	char str[]="Побудова зображень тривимiрних поверхонь";
	char str_n[]="Construction of images of 3D surfaces";
	char str_c[][8]={"Cube","Ball","About","Exit"};
	_dos_setdrive(2,&maxdrives);
	textmode(3);
	window(1,1,80,25);
	textbackground(2);
	clrscr();
	winxy((80-win_x)/2+1,5,win_x,win_y," Main ");
	textbackground(LIGHTGRAY);
	textcolor(BLACK);
	if (v==0) {
		gotoxy(strlen(str)/2,5);
		cprintf("%s",str);
	} else {
		gotoxy(strlen(str_n)/2+3,5);
		cprintf("%s",str_n);
	}
	h=consol_main(win_x,win_y,5,str_c);
	switch (h) {
		case 'A': about_main(); main_main();
		case 'C': cub(flcub_main()); v=1; main_main();
		case 'B': cul(); v=1; main_main();
		case 'E': exit_main();
		default: main_main();
	}
}

void main (void) {
	about_main();
	main_main();
}