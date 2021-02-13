unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ExtDlgs;

const
  c = 1024 * 16;
  d = 2;
  da = pi / 2;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    ComboBox1: TComboBox;
    procedure ComboBox1Change(Sender: TObject);
  private
    procedure Dragon;
    procedure Gosper(x, y, l, u: Real; t, q: Integer);
    procedure Koch(startx: Real; endx: Real; starty: Real; endy: Real;
      level: Integer);
    function opra(n: Integer): Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  i: Integer;
  a, x, y: Real;

implementation

{$R *.dfm}
{ TForm1 }

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  case Form1.ComboBox1.ItemIndex of
    0:
      begin
        Form1.PaintBox1.Refresh;
        Form1.Dragon;
      end;
    1:
      begin
        Form1.PaintBox1.Refresh;
        Form1.PaintBox1.Canvas.MoveTo(0, 250);
        Form1.Koch(0, 500, 250, 250, 6);
      end;
    2:
      begin
        Form1.PaintBox1.Refresh;
        Form1.Gosper(50, 355, 400, 0, 4, 0);
      end;
  end;
end;

procedure TForm1.Dragon;
begin
  x := 150;
  y := 150;
  a := pi / 2;
  Form1.PaintBox1.Canvas.MoveTo(Round(x), Round(y));
  For i := 1 to c + 1 do
  Begin
    Form1.PaintBox1.Canvas.LineTo(Round(x), Round(y));
    Form1.PaintBox1.Canvas.LineTo(Round(x + d * cos(a)), Round(y - d * sin(a)));
    x := x + d * cos(a);
    y := y - d * sin(a);
    a := a - da * opra(i);
  End;
end;

procedure TForm1.Gosper(x, y, l, u: Real; t, q: Integer);
  procedure Draw2(Var x, y: Real; l, u: Real; t, q: Integer);
  begin
    Gosper(x, y, l, u, t, q);
    x := x + l * cos(u);
    y := y - l * sin(u)
  end;

begin
  if t > 0 then
  begin
    if q = 1 then
    begin
      x := x + l * cos(u);
      y := y - l * sin(u);
      u := u + pi;
    end;
    u := u - 2 * pi / 19;
    l := l / sqrt(7);
    Draw2(x, y, l, u, t - 1, 0);
    Draw2(x, y, l, u + pi / 3, t - 1, 1);
    Draw2(x, y, l, u + pi, t - 1, 1);
    Draw2(x, y, l, u + 2 * pi / 3, t - 1, 0);
    Draw2(x, y, l, u, t - 1, 0);
    Draw2(x, y, l, u, t - 1, 0);
    Draw2(x, y, l, u - pi / 3, t - 1, 1)
  end
  else
  begin
    Form1.PaintBox1.Canvas.MoveTo(Round(x), Round(y));
    Form1.PaintBox1.Canvas.LineTo(Round(x + cos(u) * l), Round(y - sin(u) * l))
  end;
end;

procedure TForm1.Koch(startx, endx, starty, endy: Real; level: Integer);
var
  x1, x2, x3, y1, y2, y3, l, cosa, sina, h: Real;
begin
  if level = 1 then
  begin
    Form1.PaintBox1.Canvas.LineTo(trunc(startx), trunc(starty));
    Form1.PaintBox1.Canvas.LineTo(trunc(endx), trunc(endy));
  end
  else
  begin
    l := sqrt((endx - startx) * (endx - startx) + (endy - starty) *
      (endy - starty));
    h := l / (2 * sqrt(3));
    sina := (endy - starty) / l;
    cosa := (endx - startx) / l;
    x1 := startx + (endx - startx) / 3;
    x2 := (endx + startx) / 2 + h * sina;
    x3 := startx + 2 * (endx - startx) / 3;

    y1 := starty + (endy - starty) / 3;
    y2 := (endy + starty) / 2 - h * cosa;
    y3 := starty + 2 * (endy - starty) / 3;

    Koch(startx, x1, starty, y1, level - 1);
    Koch(x1, x2, y1, y2, level - 1);
    Koch(x2, x3, y2, y3, level - 1);
    Koch(x3, endx, y3, endy, level - 1);
  end;
end;

function TForm1.opra(n: Integer): Integer;
Label nach;
Var
  j: Integer;
Begin
  j := n;
nach:
  if (j - 1) mod 4 = 0 then
    opra := -1
  else if (j - 3) mod 4 = 0 then
    opra := 1
  else
  Begin
    j := j div 2;
    goto nach;
  End;
end;

end.
