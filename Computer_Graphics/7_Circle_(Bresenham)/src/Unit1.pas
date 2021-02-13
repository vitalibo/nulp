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
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Edit1: TEdit;
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure drawCircle(Point1: TPoint; R: Integer);
    procedure drawPoint(X, Y: Integer);
    procedure drawAxis;
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

procedure TForm1.drawCircle(Point1: TPoint; R: Integer);
var
  X, Y, mh, md, mv: Integer;
begin
  X := Point1.X;
  Y := Point1.Y;
  drawPoint(X, Y);
  drawPoint(X + R, Y);
  drawPoint(X - R, Y);
  X := R;
  Y := 0;
  while X <> 0 do
  begin
    mh := abs(sqr(X - 1) + sqr(Y) - sqr(R));
    md := abs(sqr(X - 1) + sqr(Y + 1) - sqr(R));
    mv := abs(sqr(X) + sqr(Y + 1) - sqr(R));
    if (mh < mv) and (mh <= md) then // mh
    begin
      drawPoint(X - 1 + Point1.X, Y + Point1.Y);
      drawPoint(-X + 1 + Point1.X, Y + Point1.Y);
      drawPoint(X - 1 + Point1.X, -Y + Point1.Y);
      drawPoint(-X + 1 + Point1.X, -Y + Point1.Y);
      X := X - 1;
    end;
    if (md < mh) and (md < mv) then // md
    begin
      drawPoint(X - 1 + Point1.X, Y + 1 + Point1.Y);
      drawPoint(X - 1 + Point1.X, -Y - 1 + Point1.Y);
      drawPoint(-X + 1 + Point1.X, Y + 1 + Point1.Y);
      drawPoint(-X + 1 + Point1.X, -Y - 1 + Point1.Y);
      X := X - 1;
      Y := Y + 1;
    end;
    if (mv < mh) and (mv <= md) then // mv
    begin
      drawPoint(X + Point1.X, Y + 1 + Point1.Y);
      drawPoint(X + Point1.X, -Y - 1 + Point1.Y);
      drawPoint(-X + Point1.X, Y + 1 + Point1.Y);
      drawPoint(-X + Point1.X, -Y - 1 + Point1.Y);
      Y := Y + 1;
    end;
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

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pX, pY: Integer;
begin
  pX := (X - Form1.PaintBox1.Width div 2) div 20;
  pY := (Y - Form1.PaintBox1.Height div 2) div 20;
  if (X > Form1.PaintBox1.Width div 2) then
    inc(pX);
  if (Y > Form1.PaintBox1.Height div 2) then
    inc(pY);
  Form1.StringGrid1.Cells[1, 1] := IntToStr(pX - 1);
  Form1.StringGrid1.Cells[2, 1] := IntToStr(-pY);
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
  end;
  drawPoint(Point1.X, Point1.Y);
  drawCircle(Point1, StrToInt(Form1.Edit1.Text));
  drawAxis;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  i, j: Integer;
begin
  with Form1.StringGrid1 do
  begin
    Form1.Edit1.Text := IntToStr(Random(9) + 1);
    Cells[1, 0] := 'X';
    Cells[2, 0] := 'Y';
    Cells[0, 1] := 'Точка O';
    for i := 1 to 2 do
      for j := 1 to 2 do
        Cells[i, j] := IntToStr(Random(20) - 10);
  end;
end;

end.
