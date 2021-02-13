unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, Buttons;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    GroupBox1: TGroupBox;
    StringGrid1: TStringGrid;
    Button1: TButton;
    StringGrid2: TStringGrid;
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    buttonClick: Boolean;
    Stack: Array [0 .. 100000] of TPoint;
    nStack: Integer;
    procedure DrawAxis;
    procedure DrawLine(Point1, Point2: TPoint);
    procedure DrawPoint(Point: TPoint);
    function toPoint(X, Y: Integer): TPoint;
    function Pix(Point: TPoint): TColor;
    // стек
    procedure Push(Point: TPoint);
    function Pop: TPoint;
    function Eof: Boolean;
    procedure ClearStack;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  buttonClick := True;
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.ClearStack;
begin
  nStack := 0;
end;

procedure TForm1.DrawAxis;
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

procedure TForm1.DrawLine(Point1, Point2: TPoint);
var
  X, Y, StepX, StepY: Real;
  rWidth, rHeight, Lenght, i: Integer;
begin
  X := Point1.X;
  Y := Point1.Y;
  DrawPoint(toPoint(Round(X), Round(Y)));
  rWidth := Abs(Point1.X - Point2.X);
  rHeight := Abs(Point1.Y - Point2.Y);
  if (rWidth > rHeight) then
    Lenght := rWidth
  else
    Lenght := rHeight;
  StepX := rWidth / Lenght;
  StepY := rHeight / Lenght;
  i := 1;
  while i <= Lenght do
  begin
    if Point1.X <= Point2.X then
      X := X + StepX
    else
      X := X - StepX;
    if Point1.Y <= Point2.Y then
      Y := Y + StepY
    else
      Y := Y - StepY;
    DrawPoint(toPoint(Round(X), Round(Y)));
    inc(i);
  end;
end;

procedure TForm1.DrawPoint(Point: TPoint);
begin
  with Form1.PaintBox1.Canvas do
  begin
    Rectangle(Point.X * 20, -Point.Y * 20 + 1, Point.X * 20 + 21,
      -Point.Y * 20 - 20);
    FloodFill(Point.X * 20 + 2, -Point.Y * 20 - 2, clGreen, fsBorder);
  end;
end;

function TForm1.Eof: Boolean;
begin
  if nStack = 0 then
    Result := True
  else
    Result := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.StringGrid1.Cells[1, 0] := 'X';
  Form1.StringGrid1.Cells[2, 0] := 'Y';
  Form1.StringGrid2.Cells[0, 0] := 'O';
  Form1.StringGrid2.Cells[1, 0] := '0';
  Form1.StringGrid2.Cells[2, 0] := '0';
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  xClick, yClick: Integer;
begin
  xClick := (X - Form1.PaintBox1.Width div 2) div 20;
  yClick := (Y - Form1.PaintBox1.Height div 2) div 20;
  if (X > Form1.PaintBox1.Width div 2) then
    inc(xClick);
  if (Y > Form1.PaintBox1.Height div 2) then
    inc(yClick);
  Form1.StringGrid1.Cells[0, Form1.StringGrid1.RowCount - 1] :=
    Chr(63 + Form1.StringGrid1.RowCount);
  Form1.StringGrid1.Cells[1, Form1.StringGrid1.RowCount - 1] :=
    IntToStr(xClick - 1);
  Form1.StringGrid1.Cells[2, Form1.StringGrid1.RowCount - 1] :=
    IntToStr(-yClick);
  Form1.StringGrid1.RowCount := Form1.StringGrid1.RowCount + 1;
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  Point1, Point2: TPoint;
  i: Integer;
  cl: TColor;
begin
  SetViewportOrgEx(Form1.PaintBox1.Canvas.Handle, Form1.PaintBox1.Width div 2,
    Form1.PaintBox1.Height div 2, nil);
  with Form1.StringGrid1 do
  begin
    Form1.PaintBox1.Canvas.Brush.Color := clGreen;
    Form1.PaintBox1.Canvas.Pen.Color := clGreen;
    if RowCount = 3 then
      Form1.DrawPoint(toPoint(StrToInt(Cells[1, 1]), StrToInt(Cells[2, 1])));
    if RowCount > 3 then
    begin
      for i := 2 to RowCount - 2 do
      begin
        Point1.X := StrToInt(Form1.StringGrid1.Cells[1, i]);
        Point1.Y := StrToInt(Form1.StringGrid1.Cells[2, i]);
        Point2.X := StrToInt(Form1.StringGrid1.Cells[1, i - 1]);
        Point2.Y := StrToInt(Form1.StringGrid1.Cells[2, i - 1]);
        Form1.DrawLine(Point1, Point2);
      end;
      Point2.X := StrToInt(Form1.StringGrid1.Cells[1, 1]);
      Point2.Y := StrToInt(Form1.StringGrid1.Cells[2, 1]);
      Form1.DrawLine(Point1, Point2);
    end;
    Form1.PaintBox1.Canvas.Brush.Color := clBtnFace;
    Form1.PaintBox1.Canvas.Pen.Color := clBlack;
  end;
  if buttonClick then
  begin
    Form1.PaintBox1.Canvas.Brush.Color := clBlue;
    Form1.PaintBox1.Canvas.Pen.Color := clGreen;
    Push(toPoint(StrToInt(StringGrid2.Cells[1, 0]),
      StrToInt(StringGrid2.Cells[2, 0])));
    while not Eof do
    begin
      Point1 := Pop;
      if Pix(Point1) = 15790320 then
        Form1.DrawPoint(Point1);
      if Pix(toPoint(Point1.X, Point1.Y - 1)) = 15790320 then
        Push(toPoint(Point1.X, Point1.Y - 1));
      if Pix(toPoint(Point1.X - 1, Point1.Y)) = 15790320 then
        Push(toPoint(Point1.X - 1, Point1.Y));
      if Pix(toPoint(Point1.X, Point1.Y + 1)) = 15790320 then
        Push(toPoint(Point1.X, Point1.Y + 1));
      if Pix(toPoint(Point1.X + 1, Point1.Y)) = 15790320 then
        Push(toPoint(Point1.X + 1, Point1.Y));
      // Sleep(100);
    end;
    buttonClick := False;
    Form1.PaintBox1.Canvas.Brush.Color := clBtnFace;
    Form1.PaintBox1.Canvas.Pen.Color := clBlack;
    Form1.ClearStack;
  end;
  Form1.DrawAxis;
end;

function TForm1.Pix(Point: TPoint): TColor;
var
  X, Y: Integer;
begin
  X := Point.X * 20 + 11;
  Y := -Point.Y * 20 - 11;
  Result := Form1.PaintBox1.Canvas.Pixels[X, Y];
end;

function TForm1.Pop: TPoint;
var
  i: Integer;
begin
  Result := Stack[0];
  for i := 1 to nStack do
    Stack[i - 1] := Stack[i];
  dec(nStack);
end;

procedure TForm1.Push(Point: TPoint);
var
  i: Integer;
begin
  for i := 0 to nStack do
    Stack[i + 1] := Stack[i];
  inc(nStack);
  Stack[0] := Point;
end;

function TForm1.toPoint(X, Y: Integer): TPoint;
var
  Point: TPoint;
begin
  Point.X := X;
  Point.Y := Y;
  Result := Point;
end;

end.
