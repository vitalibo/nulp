#include <stdio.h>
#include <graphics.h>
#include <math.h>
#include <conio.h>
#define X 0
#define Y 1
#define Z 2
#define dB 10
#define dL 10
#define l 0.08
#define ALFA 0.017955

void carrx (double arr[][360/dL][3],int k);

void carry (double arr[][360/dL][3],int k);

void dwcul (double arr[][360/dL][3]);

void cul (void) {
	int i,j,h;
	double x,y,z,tx,ty;
	double arr[180/dB+1][360/dL][3];
	int driver=DETECT,mode;
	initgraph(&driver,&mode,"");
	for (i=-90; i<=90; i+=dB)
		for (j=0; j<360; j+=dL){
			arr[(i+90)/dB][j/dL][X]=100*cos(i*ALFA)*sin(j*ALFA);
			arr[(i+90)/dB][j/dL][Y]=100*cos(i*ALFA)*cos(j*ALFA);
			arr[(i+90)/dB][j/dL][Z]=100*sin(i*ALFA);
		}
	carrx(arr,8);
	dwcul(arr);
	while ((h=getch())!=27) {
		cleardevice();
		switch (h) {
			case 'H':carrx(arr,1); break;
			case 'P':carrx(arr,-1); break;
			case 'K':carry(arr,1); break;
			case 'M':carry(arr,-1); break;
		}
		dwcul(arr);
	}
	closegraph();
	textmode(C40);
}

void carrx (double arr[][360/dL][3],int k) {
	double x,y,z,i,j;
	for (i=-90; i<=90; i+=dB)
		for (j=0; j<360; j+=dL){
			y=arr[(i+90)/dB][j/dL][Y]*cos(l*k)-arr[(i+90)/dB][j/dL][Z]*sin(l*k);
			z=arr[(i+90)/dB][j/dL][Y]*sin(l*k)+arr[(i+90)/dB][j/dL][Z]*cos(l*k);
			arr[(i+90)/dB][j/dL][Y]=y; arr[(i+90)/dB][j/dL][Z]=z;
	}
}

void carry (double arr[][360/dL][3],int k) {
	double x,y,z,i,j;
	for (i=-90; i<=90; i+=dB)
		for (j=0; j<360; j+=dL){
			x=arr[(i+90)/dB][j/dL][X]*cos(l*k)-arr[(i+90)/dB][j/dL][Z]*sin(l*k);
			z=arr[(i+90)/dB][j/dL][X]*sin(l*k)+arr[(i+90)/dB][j/dL][Z]*cos(l*k);
			arr[(i+90)/dB][j/dL][X]=x; arr[(i+90)/dB][j/dL][Z]=z;
	}
}

void dwcul (double arr[][360/dL][3]) {
	int i,j;
	double x,y;
	for (j=0; j<360; j+=dL) {
		moveto(arr[0/dB][j/dL][X]+320,arr[0/dB][j/dL][Y]+240);
		for (i=-90; i<=90; i+=dB)
			if (arr[(i+90)/dB][j/dL][Z]>=0)
			lineto(arr[(i+90)/dB][j/dL][X]+320,arr[(i+90)/dB][j/dL][Y]+240);
			else
			moveto(arr[(i+90)/dB][j/dL][X]+320,arr[(i+90)/dB][j/dL][Y]+240);
		}
	for (i=-90; i<=90; i+=dB) {
		moveto(arr[(i+90)/dB][0/dL][X]+320,arr[(i+90)/dB][0/dL][Y]+240);
		for (j=0; j<360; j+=dL)
			if (arr[(i+90)/dB][j/dL][Z]>=0)
			lineto(arr[(i+90)/dB][j/dL][X]+320,arr[(i+90)/dB][j/dL][Y]+240);
			else
			moveto(arr[(i+90)/dB][j/dL][X]+320,arr[(i+90)/dB][j/dL][Y]+240);
		}
}
