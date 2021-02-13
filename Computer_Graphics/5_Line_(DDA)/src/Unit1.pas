unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    StringGrid1: TStringGrid;
    Button1: TButton;
    SpeedButton1: TSpeedButton;
    StringGrid2: TStringGrid;
    PaintBox1: TPaintBox;
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
    function Sign(d: Real): Integer;
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
  Width := Form1.PaintBox1.Width div 2;
  Height := -Form1.PaintBox1.Height div 2;
  Position := 20;
  with Form1.PaintBox1.Canvas do
  begin
    Pen.Style := psDot;
    for i := 0 to Width div Position do
    begin
      MoveTo(i * Position, -Height - 20);
      LineTo(i * Position, Height);
      if i <> Width div Position then
      begin
        MoveTo(-i * Position, -Height - 20);
        LineTo(-i * Position, Height);
        TextOut(-i * Position + 3, -Height - 12, IntToStr(-i));
      end;
      TextOut(i * Position + 3, -Height - 12, IntToStr(i));
    end;
    for i := 0 downto Height div Position do
    begin
      MoveTo(-Width + 20, i * Position);
      LineTo(Width, i * Position);
      if i <> Height div Position then
      begin
        MoveTo(-Width + 20, -i * Position);
        LineTo(Width, -i * Position);
        TextOut(-Width, -i * Position - 17, IntToStr(i));
      end;
      TextOut(-Width, i * Position - 17, IntToStr(-i));
    end;
    Pen.Style := psSolid;
  end;
end;

procedure TForm1.drawLine(Point1, Point2: TPoint);
var
  Point: TPoint;
  X, Y, Width, Height, PosX, PosY: Double;
  Lenght, i: Integer;
begin
  // апроксимуємо довжину відрізка
  if Abs(Point2.X - Point1.X) >= Abs(Point2.Y - Point1.Y) then
    Lenght := Abs(Point2.X - Point1.X)
  else
    Lenght := Abs(Point2.Y - Point1.Y);
  // назаначаємо більше із збільшень dx і dy рівним одиниці растра
  Width := (Point2.X - Point1.X) / Lenght;
  Height := (Point2.Y - Point1.Y) / Lenght;
  // заокруглюємо величини, а не відкидаємо дробову частину
  X := Point1.X + 0.5 * Sign(Width);
  Y := Point1.Y + 0.5 * Sign(Height);
  // початок основного циклу
  i := 1;
  drawPoint(Trunc(Point1.X), Trunc(Point1.Y));
  getGrid(i + 1, X, Y);
  while i <= Lenght do
  begin
    drawPoint(Trunc(X), Trunc(Y));
    getGrid(i + 1, X, Y);
    X := X + Width;
    Y := Y + Height;
    Inc(i);
  end;
  drawPoint(Trunc(Point2.X), Trunc(Point2.Y));
  getGrid(i + 1, X, Y);
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
    Cells[1, i] := '(' + IntToStr(Trunc(X)) + ',' + IntToStr(Trunc(Y)) + ')';
    Cells[2, i] := Copy(FloatToStr(X), 0, 5);
    Cells[3, i] := Copy(FloatToStr(Y), 0, 5);
    RowCount := i + 1;
  end;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pX, pY: Integer;
begin
  pX := (X - Form1.PaintBox1.Width div 2) div 20;
  pY := (Y - Form1.PaintBox1.Height div 2) div 20;
  if (X > Form1.PaintBox1.Width div 2) then
    Inc(pX);
  if (Y > Form1.PaintBox1.Height div 2) then
    Inc(pY);
  Form1.StringGrid1.Cells[1, 1] := IntToStr(pX - 1);
  Form1.StringGrid1.Cells[2, 1] := IntToStr(-pY);
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pX, pY: Integer;
begin
  pX := (X - Form1.PaintBox1.Width div 2) div 20;
  pY := (Y - Form1.PaintBox1.Height div 2) div 20;
  if (X > Form1.PaintBox1.Width div 2) then
    Inc(pX);
  if (Y > Form1.PaintBox1.Height div 2) then
    Inc(pY);
  Form1.StringGrid1.Cells[1, 2] := IntToStr(pX - 1);
  Form1.StringGrid1.Cells[2, 2] := IntToStr(-pY);
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  Point1, Point2: TPoint;
begin
  SetViewportOrgEx(Form1.PaintBox1.Canvas.Handle, Form1.PaintBox1.Width div 2,
    Form1.PaintBox1.Height div 2, nil);
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

function TForm1.Sign(d: Real): Integer;
begin
  if d < 0 then
    Sign := -1
  else
    Sign := 1;
  if d = 0 then
    Sign := 0;
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
        Cells[i, j] := IntToStr(Random(20) - 10);
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
