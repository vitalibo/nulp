unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Math, StdCtrls, Buttons, Grids, ComCtrls;

type
  TPoint = Array [1 .. 4] of Real;

  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    RadioGroup1: TRadioGroup;
    StringGrid1: TStringGrid;
    Button1: TButton;
    SpeedButton1: TSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    StringGrid2: TStringGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    TrackBar1: TTrackBar;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure GroupBox2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    procedure DrawAxisXYZ;
    procedure DrawPoint(x, y: Integer; Name: String);
    procedure Parallel;
    procedure Oblique;
    function X2D(Point: TPoint): Integer;
    function Y2D(Point: TPoint): Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Point1: TPoint;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  with Form1.StringGrid1 do
  begin
    Point1[1] := StrToFloat(Cells[1, 1]);
    Point1[2] := StrToFloat(Cells[2, 1]);
    Point1[3] := StrToFloat(Cells[3, 1]);
  end;
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.DrawAxisXYZ;
var
  Width, Height, Position: Integer;
  i: Integer;
begin
  Width := Form1.PaintBox1.Width div 3 * 2;
  Height := -Form1.PaintBox1.Height div 2;
  Position := Form1.TrackBar1.Position;
  with Form1.PaintBox1.Canvas do
  begin
    // Z
    MoveTo(0, 0);
    LineTo(Width, 0);
    MoveTo(Width - 7, 4);
    LineTo(Width, 0);
    LineTo(Width - 8, -4);
    for i := 0 to Width div Position do
    begin
      MoveTo(i * Position, -1);
      LineTo(i * Position, 2);
    end;
    TextOut(Width - 15, -15, 'Z');
    // Y
    MoveTo(0, 0);
    LineTo(0, Height);
    MoveTo(4, Height + 7);
    LineTo(0, Height);
    LineTo(-4, Height + 8);
    for i := 0 downto Height div Position do
    begin
      MoveTo(-1, i * Position);
      LineTo(2, i * Position);
    end;
    TextOut(5, Height + 8, 'Y');
    // X
    MoveTo(0, 0);
    LineTo(Height + 50, -Height - 50);
    MoveTo(Height + 54, -Height - 60);
    LineTo(Height + 50, -Height - 50);
    LineTo(Height + 60, -Height - 54);
    i := Round(Position / 2.9);
    while i < -Height + -60 do
    begin
      MoveTo(-i - 1, i - 1);
      LineTo(-i + 2, i + 2);
      i := Round(i + Position / 2.9);
    end;
    TextOut(Height + 65, -Height - 60, 'X');
  end;
end;

procedure TForm1.DrawPoint(x, y: Integer; Name: String);
begin
  with Form1.PaintBox1.Canvas do
  begin
    Ellipse(x + 2, y + 2, x - 2, y - 2);
    TextOut(x - 10, y - 15, Name);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  with Form1.StringGrid1 do
  begin
    Cells[1, 0] := 'X';
    Cells[2, 0] := 'Y';
    Cells[3, 0] := 'Z';
    Cells[0, 1] := 'Точка P';
  end;
  Form1.StringGrid2.Cells[0, 0] := 'Точка P''';
  Form1.SpeedButton1.Click;
  Form1.Button1.Click;
end;

procedure TForm1.GroupBox2Click(Sender: TObject);
begin
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.Oblique;
var
  Point, Point2: TPoint;
  l, a, b: Real;
  i: Integer;
begin
  l := StrToFloat(Form1.Edit2.Text);
  a := DegToRad(StrToFloat(Form1.Edit3.Text));
  b := DegToRad(StrToFloat(Form1.Edit4.Text));
  with Form1.PaintBox1.Canvas do
  begin
    Point2[1] := Point1[1] + Point1[3] * l * cos(a);
    Point2[2] := Point1[2] + Point1[3] * l * sin(a);
    Point2[3] := 0;
    Pen.Color := clBlue;
    MoveTo(X2D(Point1), Y2D(Point1));
    LineTo(X2D(Point2), Y2D(Point2));
    Pen.Color := clBlack;
    LineTo(0, 0);
    Pen.Color := clRed;
    DrawPoint(X2D(Point1), Y2D(Point1), 'P');
    DrawPoint(X2D(Point2), Y2D(Point2), 'P''');
    Pen.Color := clBlack;
    for i := 1 to 3 do
      Form1.StringGrid2.Cells[i, 0] := Copy(FloatToStr(Point2[i]), 1, 5);
    Pen.Style := psDot;
    Point := Point2;
    Point[2] := 0;
    MoveTo(X2D(Point), Y2D(Point));
    LineTo(X2D(Point2), Y2D(Point2));
    Point := Point2;
    Point[1] := 0;
    MoveTo(X2D(Point), Y2D(Point));
    LineTo(X2D(Point2), Y2D(Point2));
    Pen.Style := psSolid;
  end;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  SetViewportOrgEx(Form1.PaintBox1.Canvas.Handle, Form1.PaintBox1.Width div 3,
    Form1.PaintBox1.Height div 2, nil);
  Form1.DrawAxisXYZ;
  if Form1.RadioGroup1.ItemIndex = 0 then
    Form1.Parallel
  else
    Form1.Oblique;
end;

procedure TForm1.Parallel;
var
  Point, Point2: TPoint;
  d: Real;
  i: Integer;
begin
  d := StrToFloat(Form1.Edit1.Text);
  with Form1.PaintBox1.Canvas do
  begin
    Pen.Color := clBlue;
    Point2[1] := Point1[1] / (Point1[3] / d);
    Point2[2] := Point1[2] / (Point1[3] / d);
    Point2[3] := d;
    for i := 1 to 3 do
      Form1.StringGrid2.Cells[i, 0] := Copy(FloatToStr(Point2[i]), 1, 5);
    MoveTo(0, 0);
    if (Sqr(X2D(Point1)) + Sqr(Y2D(Point1))) >
      (Sqr(X2D(Point2)) + Sqr(Y2D(Point2))) then
      LineTo(X2D(Point1), Y2D(Point1))
    else
      LineTo(X2D(Point2), Y2D(Point2));
    Pen.Color := clRed;
    DrawPoint(X2D(Point1), Y2D(Point1), 'P');
    DrawPoint(X2D(Point2), Y2D(Point2), 'P''');
    Pen.Color := clBlack;
    Point[1] := 0;
    Point[2] := 0;
    Point[3] := Point2[3];
    Pen.Style := psDot;
    MoveTo(X2D(Point), Y2D(Point));
    Point[2] := Point2[2] + 1;
    LineTo(X2D(Point), Y2D(Point));
    Point[1] := Point2[1] + 2;
    LineTo(X2D(Point), Y2D(Point));
    Point[2] := 0;
    LineTo(X2D(Point), Y2D(Point));
    Point[1] := 0;
    LineTo(X2D(Point), Y2D(Point));
    Pen.Style := psSolid;
  end;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  Form1.PaintBox1.Repaint;
  if Form1.RadioGroup1.ItemIndex = 0 then
  begin
    Form1.GroupBox3.Visible := True;
    Form1.GroupBox4.Visible := False;
  end
  else
  begin
    Form1.GroupBox3.Visible := False;
    Form1.GroupBox4.Visible := True;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  with Form1.StringGrid1 do
  begin
    Cells[1, 1] := FloatToStr(Random(60) / 10);
    Cells[2, 1] := FloatToStr(Random(30) / 10);
    Cells[3, 1] := FloatToStr(Random(55) / 10 + 0.1);
  end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Form1.PaintBox1.Repaint;
end;

function TForm1.X2D(Point: TPoint): Integer;
begin
  X2D := Round(Point[3] * Form1.TrackBar1.Position - Point[1] / 2 *
    Form1.TrackBar1.Position * cos(DegToRad(45)));
end;

function TForm1.Y2D(Point: TPoint): Integer;
begin
  Y2D := Round(-Point[2] * Form1.TrackBar1.Position + Point[1] / 2 *
    Form1.TrackBar1.Position * sin(DegToRad(45)));
end;

end.
