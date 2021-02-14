#include <stdio.h>
#include <graphics.h>
#include <math.h>
#include <conio.h>
#define X 0
#define Y 1
#define Z 2
#define A 0
#define B 1
#define C 2
#define D 3
#define A1 4
#define B1 5
#define C1 6
#define D1 7
#define Q 1
#define l 0.1
#define DIS_X 320
#define DIS_Y 240

void initgr (void);

double ser (double a[3],double b[3]);

void dwtr (double a[3],double b[3],double c[3],double d[3]);

void flcub (double a[3],double b[3],int i,int q);

void dwcub (double arr[][3],int q);

void arrx (double arr[][3],int k);

void arry (double arr[][3],int k);

void arrz (double arr[][3],int k);

void arrs (double arr[][3], double k);

void cub (int q) {
	char m;
	double arr[][3]={{-50,50,50},{-50,50,-50},{50,50,-50},{50,50,50},
		 {-50,-50,50},{-50,-50,-50},{50,-50,-50},{50,-50,50}};
	initgr();
	arrx(arr,-6);
	arry(arr,6);
	dwcub(arr,q);
	while ((m=getch())!=27) {
		cleardevice();
		switch (m) {
			case 'H': arrx(arr,1); break;
			case 'P': arrx(arr,-1); break;
			case 'K': arry(arr,1); break;
			case 'M': arry(arr,-1); break;
			case '-': arrs(arr,0.95); break;
			case '+': arrs(arr,1.05); break;
		}
		dwcub(arr,q);
	}
	closegraph();
}

void initgr (void) {
	int driver=DETECT,mode;
	initgraph(&driver,&mode,"");
}

double ser (double a[3],double b[3]) {
	return (a[Z]+b[Z])/2;
}

void flcub (double a[3],double b[3],int i,int q) {
	int x,y;
	if (q) {
		setfillstyle(SOLID_FILL,i);
		x=(a[X]+b[X])/2;
		y=(a[Y]+b[Y])/2;
		floodfill(x+320,y+240,15);
	}
}

void dwtr (double a[3],double b[3],double c[3],double d[3]) {
	line(a[X]+320,a[Y]+240,b[X]+320,b[Y]+240);
	line(b[X]+320,b[Y]+240,c[X]+320,c[Y]+240);
	line(c[X]+320,c[Y]+240,d[X]+320,d[Y]+240);
	line(d[X]+320,d[Y]+240,a[X]+320,a[Y]+240);
}

void dwcub (double arr[][3],int q) {
	if (ser(arr[A],arr[D1])>ser(arr[B],arr[C1])) {
		dwtr(arr[A],arr[A1],arr[D1],arr[D]);
		flcub(arr[A],arr[D1],1,q);
	} else {
		dwtr(arr[B],arr[B1],arr[C1],arr[C]);
		flcub(arr[B],arr[C1],2,q);
	}
	if (ser(arr[A],arr[B1])>ser(arr[D],arr[C1])) {
		dwtr(arr[A],arr[A1],arr[B1],arr[B]);
		flcub(arr[A],arr[B1],4,q);
	} else {
		dwtr(arr[D],arr[D1],arr[C1],arr[C]);
		flcub(arr[D],arr[C1],14,q);
	}
	if (ser(arr[A],arr[C])>ser(arr[A1],arr[C1])) {
		dwtr(arr[A],arr[B],arr[C],arr[D]);
		flcub(arr[A],arr[C],9,q);
	} else {
		dwtr(arr[A1],arr[B1],arr[C1],arr[D1]);
		flcub(arr[A1],arr[C1],13,q);
	}
}

void arrx (double arr[][3],int k) {
	double x,y,z,i;
	for (i=0; i<8; i++) {
		y=arr[i][Y]*cos(l*k)-arr[i][Z]*sin(l*k);
		z=arr[i][Y]*sin(l*k)+arr[i][Z]*cos(l*k);
		arr[i][Y]=y; arr[i][Z]=z;
	}
}
void arry (double arr[][3],int k) {
	double x,y,z,i;
	for (i=0; i<8; i++) {
		x=arr[i][X]*cos(l*k)-arr[i][Z]*sin(l*k);
		z=arr[i][X]*sin(l*k)+arr[i][Z]*cos(l*k);
		arr[i][X]=x; arr[i][Z]=z;
	}
}
void arrz (double arr[][3],int k) {
	double x,y,z,i;
	for (i=0; i<8; i++) {
		x=arr[i][X]*cos(l*k)-arr[i][Y]*sin(l*k);
		y=arr[i][X]*sin(l*k)+arr[i][Y]*cos(l*k);
		arr[i][X]=x; arr[i][Y]=y;
	}
}

void arrs (double arr[][3], double k) {
	double i;
	for (i=0; i<8; i++)  {
		arr[i][X]*=k;
		arr[i][Y]*=k;
		arr[i][Z]*=k;
	}
}