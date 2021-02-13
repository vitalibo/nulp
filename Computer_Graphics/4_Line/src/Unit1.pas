unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    GroupBox1: TGroupBox;
    StringGrid1: TStringGrid;
    Button1: TButton;
    SpeedButton1: TSpeedButton;
    StringGrid2: TStringGrid;
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure drawLine(Point1, Point2: TPoint);
    procedure drawPoint(X, Y: Integer);
    procedure drawAxis;
    procedure getGrid(i: Integer; X, Y: Real);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.drawAxis;
var
  Width, Height, Position: Integer;
  i: Integer;
begin
  Width := Form1.PaintBox1.Width - 30;
  Height := -Form1.PaintBox1.Height - 30;
  Position := 20;
  with Form1.PaintBox1.Canvas do
  begin
    Pen.Style := psDot;
    for i := 0 to Width div Position do
    begin
      MoveTo(i * Position, 0);
      LineTo(i * Position, Height);
      TextOut(i * Position + 5, 10, IntToStr(i));
    end;
    for i := 0 downto Height div Position do
    begin
      MoveTo(0, i * Position);
      LineTo(Width, i * Position);
      TextOut(-20, i * Position - 17, IntToStr(-i));
    end;
    Pen.Style := psSolid;
  end;
end;

procedure TForm1.drawLine(Point1, Point2: TPoint);
var
  X, Y, StepX, StepY: Real;
  rWidth, rHeight, Lenght, i: Integer;
begin
  // позиця = початок
  X := Point1.X;
  Y := Point1.Y;
  drawPoint(Round(X), Round(Y));
  // крок = збільшення
  rWidth := Abs(Point1.X - Point2.X);
  rHeight := Abs(Point1.Y - Point2.Y);
  if (rWidth > rHeight) then
    Lenght := rWidth
  else
    Lenght := rHeight;
  StepX := rWidth / Lenght;
  StepY := rHeight / Lenght;
  // початок основного циклу
  i := 1;
  getGrid(i, X, Y);
  while i <= Lenght do
  begin
    if Point1.X <= Point2.X then
      // позиція=позиція + крок
      X := X + StepX
    else
      X := X - StepX;
    if Point1.Y <= Point2.Y then
      Y := Y + StepY
    else
      // позиція=позиція - крок
      Y := Y - StepY;
    drawPoint(Round(X), Round(Y));
    Inc(i);
    getGrid(i, X, Y);
  end;
end;

procedure TForm1.drawPoint(X, Y: Integer);
begin
  with Form1.PaintBox1.Canvas do
  begin
    Brush.Color := clGreen;
    Pen.Color := clGreen;
    Rectangle(X * 20, -Y * 20 + 1, X * 20 + 21, -Y * 20 - 20);
    FloodFill(X * 20 + 2, -Y * 20 - 2, clGreen, fsBorder);
    Brush.Color := clBtnFace;
    Pen.Color := clBlack;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.SpeedButton1.Click;
end;

procedure TForm1.getGrid(i: Integer; X, Y: Real);
begin
  with Form1.StringGrid2 do
  begin
    Cells[0, i] := IntToStr(i);
    Cells[1, i] := '(' + IntToStr(Round(X)) + ',' + IntToStr(Round(X)) + ')';
    Cells[2, i] := Copy(FloatToStr(X), 0, 5);
    Cells[3, i] := Copy(FloatToStr(Y), 0, 5);
    RowCount := i + 1;
  end;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.StringGrid1.Cells[1, 1] := IntToStr(-(30 - X) div 20);
  Form1.StringGrid1.Cells[2, 1] := IntToStr((420 - Y) div 20);
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.StringGrid1.Cells[1, 2] := IntToStr(-(30 - X) div 20);
  Form1.StringGrid1.Cells[2, 2] := IntToStr((420 - Y) div 20);
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  Point1, Point2: TPoint;
begin
  SetViewportOrgEx(Form1.PaintBox1.Canvas.Handle, 30, Form1.PaintBox1.Height
    - 30, nil);
  with Form1.StringGrid1 do
  begin
    Point1.X := StrToInt(Cells[1, 1]);
    Point1.Y := StrToInt(Cells[2, 1]);
    Point2.X := StrToInt(Cells[1, 2]);
    Point2.Y := StrToInt(Cells[2, 2]);;
  end;
  getGrid(1, Point1.X, Point1.Y);
  if (Point1.X - Point2.X = 0) and (Point1.Y - Point2.Y = 0) then
    drawPoint(Point1.X, Point1.Y)
  else
    drawLine(Point1, Point2);
  drawAxis;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  i, j: Integer;
begin
  with Form1.StringGrid1 do
  begin
    Cells[1, 0] := 'X';
    Cells[2, 0] := 'Y';
    Cells[0, 1] := 'Точка A';
    Cells[0, 2] := 'Точка B';
    for i := 1 to 2 do
      for j := 1 to 2 do
        Cells[i, j] := IntToStr(Random(19));
  end;
  with Form1.StringGrid2 do
  begin
    Cells[0, 0] := 'i';
    Cells[1, 0] := 'Plot';
    Cells[2, 0] := 'x';
    Cells[3, 0] := 'y';
  end;
end;

end.
