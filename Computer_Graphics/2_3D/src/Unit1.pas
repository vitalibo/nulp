unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Math, Grids, StdCtrls, Spin;

type
  TPoint = Array [1 .. 4] of Real;
  TCube = Array ['A' .. 'H'] of TPoint;
  TMRow = Array [0 .. 3] of Real;
  TMatrix = Array [0 .. 3] of TMRow;

  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    TrackBar1: TTrackBar;
    StringGrid1: TStringGrid;
    Button1: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox5: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button3: TButton;
    GroupBox6: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar4: TTrackBar;
    TrackBar5: TTrackBar;
    TrackBar6: TTrackBar;
    TrackBar7: TTrackBar;
    TrackBar8: TTrackBar;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;

    procedure PaintBox1Paint(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
    procedure TrackBar7Change(Sender: TObject);
    procedure TrackBar8Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
  private
    procedure DrawAxisXYZ;
    procedure DrawCube(Cube: TCube);
    function TurningCube(Matrix: TMatrix): TCube;
    procedure DrawPoint(x, y: Integer; Name: String);
    function X2D(Point: TPoint): Integer;
    function Y2D(Point: TPoint): Integer;
  public
    { Public declarations }
  end;

const
  Cube: TCube = ((0, 0, 1, 1), (0, 1, 1, 1), (1, 1, 1, 1), (1, 0, 1, 1),
    (0, 0, 0, 1), (0, 1, 0, 1), (1, 1, 0, 1), (1, 0, 0, 1));

var
  Form1: TForm1;
  Cube1: TCube;
  Matrix1: TMatrix;

implementation

{$R *.dfm}
{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  i, j: Integer;
begin
  for i := 0 to 3 do
    for j := 0 to 3 do
      Matrix1[i][j] := StrToFloat(Form1.StringGrid1.Cells[j, i]);
  Cube1 := Form1.TurningCube(Matrix1);
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if StrToInt(Form1.Edit2.Text) <> 0 then
  begin
    Matrix1[1, 1] := Cos(DegToRad(StrToInt(Form1.Edit2.Text)));
    Matrix1[2, 2] := Cos(DegToRad(StrToInt(Form1.Edit2.Text)));
    Matrix1[2, 1] := -Sin(DegToRad(StrToInt(Form1.Edit2.Text)));
    Matrix1[1, 2] := Sin(DegToRad(StrToInt(Form1.Edit2.Text)));
    Cube1 := Form1.TurningCube(Matrix1);
  end;
  if StrToInt(Form1.Edit3.Text) <> 0 then
  begin
    Matrix1[0, 0] := Cos(DegToRad(StrToInt(Form1.Edit3.Text)));
    Matrix1[2, 2] := Cos(DegToRad(StrToInt(Form1.Edit3.Text)));
    Matrix1[2, 0] := Sin(DegToRad(StrToInt(Form1.Edit3.Text)));
    Matrix1[0, 2] := -Sin(DegToRad(StrToInt(Form1.Edit3.Text)));
    Cube1 := Form1.TurningCube(Matrix1);
  end;
  if StrToInt(Form1.Edit4.Text) <> 0 then
  begin
    Matrix1[0, 0] := Cos(DegToRad(StrToInt(Form1.Edit4.Text)));
    Matrix1[1, 1] := Cos(DegToRad(StrToInt(Form1.Edit4.Text)));
    Matrix1[1, 0] := Sin(DegToRad(StrToInt(Form1.Edit4.Text)));
    Matrix1[0, 1] := -Sin(DegToRad(StrToInt(Form1.Edit4.Text)));
    Cube1 := Form1.TurningCube(Matrix1);
  end;
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Matrix1[0, 0] := Matrix1[0, 0] * -1;
  Cube1 := Form1.TurningCube(Matrix1);
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  Matrix1[1, 1] := Matrix1[1, 1] * -1;
  Cube1 := Form1.TurningCube(Matrix1);
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  Matrix1[2, 2] := Matrix1[2, 2] * -1;
  Cube1 := Form1.TurningCube(Matrix1);
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.DrawAxisXYZ;
var
  Width, Height, Position: Integer;
  i: Integer;
begin
  Width := Form1.PaintBox1.Width div 2;
  Height := Form1.PaintBox1.Height div 2;
  Position := Form1.TrackBar1.Position;
  with Form1.PaintBox1.Canvas do
  begin
    // X
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
    TextOut(Width - 15, -15, 'X');
    // Y
    MoveTo(0, 0);
    LineTo(0, -Height);
    MoveTo(4, -Height + 7);
    LineTo(0, -Height);
    LineTo(-4, -Height + 8);
    for i := 0 to Height div Position do
    begin
      MoveTo(-1, -i * Position);
      LineTo(2, -i * Position);
    end;
    TextOut(5, -Height + 8, 'Y');
    // Z
    MoveTo(0, 0);
    LineTo(-Height + 50, Height - 50);
    MoveTo(-Height + 54, Height - 60);
    LineTo(-Height + 50, Height - 50);
    LineTo(-Height + 60, Height - 54);
    i := Round(Position / 2.9);
    while i < Height - 50 do
    begin
      MoveTo(-i - 1, i - 1);
      LineTo(-i + 2, i + 2);
      i := Round(i + Position / 2.9);
    end;
    TextOut(-Height + 65, Height - 60, 'Z');
  end;
end;

procedure TForm1.DrawCube(Cube: TCube);
begin
  with Form1.PaintBox1.Canvas do
  begin
    Pen.Color := clBlue;
    Font.Color := clBlue;
    // Line
    MoveTo(X2D(Cube['A']), Y2D(Cube['A']));
    LineTo(X2D(Cube['B']), Y2D(Cube['B']));
    LineTo(X2D(Cube['C']), Y2D(Cube['C']));
    LineTo(X2D(Cube['D']), Y2D(Cube['D']));
    LineTo(X2D(Cube['A']), Y2D(Cube['A']));
    MoveTo(X2D(Cube['E']), Y2D(Cube['E']));
    LineTo(X2D(Cube['F']), Y2D(Cube['F']));
    LineTo(X2D(Cube['G']), Y2D(Cube['G']));
    LineTo(X2D(Cube['H']), Y2D(Cube['H']));
    LineTo(X2D(Cube['E']), Y2D(Cube['E']));
    MoveTo(X2D(Cube['A']), Y2D(Cube['A']));
    LineTo(X2D(Cube['E']), Y2D(Cube['E']));
    MoveTo(X2D(Cube['B']), Y2D(Cube['B']));
    LineTo(X2D(Cube['F']), Y2D(Cube['F']));
    MoveTo(X2D(Cube['C']), Y2D(Cube['C']));
    LineTo(X2D(Cube['G']), Y2D(Cube['G']));
    MoveTo(X2D(Cube['D']), Y2D(Cube['D']));
    LineTo(X2D(Cube['H']), Y2D(Cube['H']));
    // Point
    DrawPoint(X2D(Cube['A']), Y2D(Cube['A']), 'A');
    DrawPoint(X2D(Cube['B']), Y2D(Cube['B']), 'B');
    DrawPoint(X2D(Cube['C']), Y2D(Cube['C']), 'C');
    DrawPoint(X2D(Cube['D']), Y2D(Cube['D']), 'D');
    DrawPoint(X2D(Cube['E']), Y2D(Cube['E']), 'E');
    DrawPoint(X2D(Cube['F']), Y2D(Cube['F']), 'F');
    DrawPoint(X2D(Cube['G']), Y2D(Cube['G']), 'G');
    DrawPoint(X2D(Cube['H']), Y2D(Cube['H']), 'H');
    Font.Color := clBlack;
    Pen.Color := clBlack;
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
var
  i, j: Integer;
begin
  for i := 0 to 3 do
    for j := 0 to 3 do
      if i = j then
        Form1.StringGrid1.Cells[i, j] := '1'
      else
        Form1.StringGrid1.Cells[i, j] := '0';
  Form1.Button1.Click;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  SetViewportOrgEx(Form1.PaintBox1.Canvas.Handle, Form1.PaintBox1.Width div 2,
    Form1.PaintBox1.Height div 2, nil);
  Form1.DrawAxisXYZ;
  Form1.DrawCube(Cube1);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  Form1.Label10.Caption := IntToStr(Form1.TrackBar2.Position);
  Matrix1[3, 0] := Form1.TrackBar2.Position;
  Cube1 := Form1.TurningCube(Matrix1);
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.TrackBar3Change(Sender: TObject);
begin
  Form1.Label11.Caption := IntToStr(Form1.TrackBar3.Position);
  Matrix1[3, 1] := Form1.TrackBar3.Position;
  Cube1 := Form1.TurningCube(Matrix1);
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.TrackBar4Change(Sender: TObject);
begin
  Form1.Label12.Caption := IntToStr(Form1.TrackBar4.Position);
  Matrix1[3, 2] := Form1.TrackBar4.Position;
  Cube1 := Form1.TurningCube(Matrix1);
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.TrackBar5Change(Sender: TObject);
begin
  Form1.Label17.Caption := IntToStr(Form1.TrackBar5.Position * 10) + '%';
  Matrix1[0, 0] := Form1.TrackBar5.Position / 10;
  Cube1 := Form1.TurningCube(Matrix1);
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.TrackBar6Change(Sender: TObject);
begin
  Form1.Label19.Caption := IntToStr(Form1.TrackBar6.Position * 10) + '%';
  Matrix1[1, 1] := Form1.TrackBar6.Position / 10;
  Cube1 := Form1.TurningCube(Matrix1);
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.TrackBar7Change(Sender: TObject);
begin
  Form1.Label18.Caption := IntToStr(Form1.TrackBar7.Position * 10) + '%';
  Matrix1[2, 2] := Form1.TrackBar7.Position / 10;
  Cube1 := Form1.TurningCube(Matrix1);
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.TrackBar8Change(Sender: TObject);
begin
  Form1.Label20.Caption := IntToStr(Form1.TrackBar8.Position * 10) + '%';
  Matrix1[3, 3] := Form1.TrackBar8.Position / 10;
  Cube1 := Form1.TurningCube(Matrix1);
  Form1.PaintBox1.Repaint;
end;

function TForm1.TurningCube(Matrix: TMatrix): TCube;
var
  i: AnsiChar;
  j, k: Integer;
begin
  for i := 'A' to 'H' do
    for j := 0 to 3 do
    begin
      Result[i, j + 1] := 0;
      for k := 0 to 3 do
        Result[i, j + 1] := Result[i, j + 1] + Cube[i, k + 1] * Matrix[k, j];
      Result[i, j + 1] := Result[i, j + 1] * Matrix[3, 3];
    end;
end;

function TForm1.X2D(Point: TPoint): Integer;
begin
  X2D := Round(Point[1] * Form1.TrackBar1.Position - Point[3] / 2 *
    Form1.TrackBar1.Position * Cos(DegToRad(45)));
end;

function TForm1.Y2D(Point: TPoint): Integer;
begin
  Y2D := Round(-Point[2] * Form1.TrackBar1.Position + Point[3] / 2 *
    Form1.TrackBar1.Position * Sin(DegToRad(45)));
end;

end.
