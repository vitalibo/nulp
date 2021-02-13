unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    GroupBox1: TGroupBox;
    TrackBar1: TTrackBar;
    RadioGroup1: TRadioGroup;
    GroupBox2: TGroupBox;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Label2: TLabel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    procedure PaintBox1Paint(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
  private
    procedure DrawAxisXY;
    procedure DrawPoint(pX, pY: Integer; pName: String);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
begin
  with Form1.StringGrid2 do
  begin
    Cells[1, 1] := '1';
    Cells[1, 2] := '0';
    Cells[1, 3] := '0';
    Cells[2, 1] := '0';
    Cells[2, 2] := '1';
    Cells[2, 3] := '0';
    case Form1.RadioGroup1.ItemIndex of
      0 .. 1:
        case Form1.ComboBox1.ItemIndex of
          1:
            Cells[1, 1] := '2';
          2:
            begin
              Cells[1, 1] := '2';
              Cells[2, 2] := '2';
            end;
          3:
            Cells[1, 1] := '-1';
          4:
            begin
              Cells[1, 1] := '-1';
              Cells[2, 2] := '-1';
            end;
          5:
            Cells[2, 1] := '2';
        end;
      2:
        case Form1.ComboBox1.ItemIndex of
          1:
            begin
              Cells[1, 1] := '0';
              Cells[2, 1] := '1';
              Cells[1, 2] := '-1';
              Cells[2, 2] := '0';
            end;
          2:
            begin
              Cells[1, 1] := '-1';
              Cells[2, 2] := '-1';
            end;
          3:
            begin
              Cells[1, 1] := '0';
              Cells[2, 1] := '-1';
              Cells[1, 2] := '1';
              Cells[2, 2] := '0';
            end;
          4:
            begin
              Cells[1, 1] := '0';
              Cells[1, 2] := '1';
              Cells[2, 1] := '1';
              Cells[2, 2] := '0';
            end;
          5:
            begin
              Cells[1, 1] := '1';
              Cells[2, 2] := '-1';
            end;
          6:
            begin
              Cells[1, 1] := '2';
              Cells[2, 2] := '2';
            end;
          7:
            begin
              Cells[1, 3] := '2';
              Cells[2, 3] := '2';
            end;
        end;
    end;
  end;
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.DrawAxisXY;
var
  i, d: Integer;
begin
  d := Form1.TrackBar1.Position;
  with Form1.PaintBox1 do
  begin
    Canvas.MoveTo(0 - Width div 2, 0);
    Canvas.LineTo(Width div 2, 0);
    Canvas.MoveTo(0, 0 - Height div 2);
    Canvas.LineTo(0, Height div 2);
    Canvas.TextOut(5, 2, '0,0');
    Canvas.TextOut(Width div 2 - 12, -15, 'X');
    Canvas.TextOut(5, -Height div 2 + 5, 'Y');
    Canvas.MoveTo(Width div 2 - 5, -5);
    Canvas.LineTo(Width div 2, 0);
    Canvas.LineTo(Width div 2 - 6, 6);
    Canvas.MoveTo(-5, -Height div 2 + 5);
    Canvas.LineTo(0, -Height div 2);
    Canvas.LineTo(6, -Height div 2 + 6);
    if d <> 1 then
      for i := 0 to (Width div 2) div d do
      begin
        Canvas.MoveTo(i * d, -2);
        Canvas.LineTo(i * d, 3);
        Canvas.MoveTo(-i * d, -2);
        Canvas.LineTo(-i * d, 3);
        Canvas.MoveTo(-2, i * d);
        Canvas.LineTo(3, i * d);
        Canvas.MoveTo(-2, -i * d);
        Canvas.LineTo(3, -i * d);
      end;
  end;
end;

procedure TForm1.DrawPoint(pX, pY: Integer; pName: String);
begin
  with Form1.PaintBox1.Canvas do
  begin
    Ellipse(pX + 2, pY + 2, pX - 2, pY - 2);
    TextOut(pX + 5, pY - 15, pName);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.RadioGroup1Click(nil);
  Form1.ComboBox1Select(nil);
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  i: Integer;
  p, np: array [1 .. 3, 1 .. 3] of Integer;
  c: array [1 .. 3, 1 .. 3] of Real;
begin
  SetViewportOrgEx(Form1.PaintBox1.Canvas.Handle, Form1.PaintBox1.Width div 2,
    Form1.PaintBox1.Height div 2, nil);
  SetGraphicsMode(Form1.PaintBox1.Canvas.Handle, GM_ADVANCED);
  Form1.DrawAxisXY;
  with Form1.StringGrid1 do
    for i := 1 to RowCount - 1 do
    begin
      p[i, 1] := StrToInt(Cells[1, i]) * Form1.TrackBar1.Position;
      p[i, 2] := -StrToInt(Cells[2, i]) * Form1.TrackBar1.Position;
    end;
  with Form1.StringGrid2 do
    for i := 1 to RowCount - 1 do
    begin
      c[i, 1] := StrToFloat(Cells[1, i]);
      c[i, 2] := StrToFloat(Cells[2, i]);
    end;
  c[1, 2] := -c[1, 2];
  c[2, 1] := -c[2, 1];
  for i := 1 to Form1.StringGrid1.RowCount - 1 do
  begin
    np[i, 1] := Round(p[i, 1] * c[1, 1] + p[i, 2] * c[2, 1]);
    np[i, 2] := Round(p[i, 1] * c[1, 2] + p[i, 2] * c[2, 2]);
  end;
  with Form1.PaintBox1.Canvas do
    case Form1.RadioGroup1.ItemIndex of
      0:
        begin
          Pen.Style := psDash;
          Pen.color := clRed;
          MoveTo(p[1, 1], p[1, 2]);
          LineTo(np[1, 1], np[1, 2]);
          Pen.color := clBlack;
          Pen.Style := psSolid;
          DrawPoint(np[1, 1], np[1, 2], 'A''');
          DrawPoint(p[1, 1], p[1, 2], 'A');
        end;
      1:
        begin
          Pen.Style := psDash;
          Pen.color := clRed;
          MoveTo(p[1, 1], p[1, 2]);
          LineTo(np[1, 1], np[1, 2]);
          MoveTo(p[2, 1], p[2, 2]);
          LineTo(np[2, 1], np[2, 2]);
          Pen.color := clBlack;
          Pen.Style := psSolid;
          MoveTo(np[1, 1], np[1, 2]);
          LineTo(np[2, 1], np[2, 2]);
          DrawPoint(np[1, 1], np[1, 2], 'A''');
          DrawPoint(np[2, 1], np[2, 2], 'B''');
          MoveTo(p[1, 1], p[1, 2]);
          LineTo(p[2, 1], p[2, 2]);
          DrawPoint(p[1, 1], p[1, 2], 'A');
          DrawPoint(p[2, 1], p[2, 2], 'B');
        end;
      2:
        begin
          for i := 1 to Form1.StringGrid1.RowCount - 1 do
          begin
            np[i, 1] := Round(np[i, 1] + c[3, 1] * Form1.TrackBar1.Position);
            np[i, 2] := Round(np[i, 2] - c[3, 2] * Form1.TrackBar1.Position);
          end;
          Pen.Style := psDash;
          Pen.color := clRed;
          MoveTo(p[1, 1], p[1, 2]);
          LineTo(np[1, 1], np[1, 2]);
          MoveTo(p[2, 1], p[2, 2]);
          LineTo(np[2, 1], np[2, 2]);
          MoveTo(p[3, 1], p[3, 2]);
          LineTo(np[3, 1], np[3, 2]);
          Pen.color := clBlack;
          Pen.Style := psSolid;
          MoveTo(np[1, 1], np[1, 2]);
          LineTo(np[2, 1], np[2, 2]);
          LineTo(np[3, 1], np[3, 2]);
          LineTo(np[1, 1], np[1, 2]);
          DrawPoint(np[1, 1], np[1, 2], 'A''');
          DrawPoint(np[2, 1], np[2, 2], 'B''');
          DrawPoint(np[3, 1], np[3, 2], 'C''');
          MoveTo(p[1, 1], p[1, 2]);
          LineTo(p[2, 1], p[2, 2]);
          LineTo(p[3, 1], p[3, 2]);
          LineTo(p[1, 1], p[1, 2]);
          DrawPoint(p[1, 1], p[1, 2], 'A');
          DrawPoint(p[2, 1], p[2, 2], 'B');
          DrawPoint(p[3, 1], p[3, 2], 'C');
        end;
    end;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
var
  i, j: Integer;
begin
  case Form1.RadioGroup1.ItemIndex of
    0:
      begin
        with Form1.StringGrid1 do
        begin
          RowCount := 2;
          Cells[0, 1] := 'Точка A';
          Cells[1, 0] := 'X';
          Cells[2, 0] := 'Y';
        end;
        Form1.StringGrid2.RowCount := 3;
      end;
    1:
      begin
        with Form1.StringGrid1 do
        begin
          RowCount := 3;
          Cells[0, 1] := 'Точка A';
          Cells[0, 2] := 'Точка B';
          Cells[1, 0] := 'X';
          Cells[2, 0] := 'Y';
        end;
        Form1.StringGrid2.RowCount := 3;
      end;
    2:
      begin
        with Form1.StringGrid1 do
        begin
          RowCount := 4;
          Cells[0, 1] := 'Точка A';
          Cells[0, 2] := 'Точка B';
          Cells[0, 3] := 'Точка C';
          Cells[1, 0] := 'X';
          Cells[2, 0] := 'Y';
        end;
        Form1.StringGrid2.RowCount := 4;
        Form1.StringGrid2.Cells[0, 3] := 'Зсув';
      end;
  end;
  case Form1.RadioGroup1.ItemIndex of
    0 .. 1:
      begin
        with Form1.ComboBox1.Items do
        begin
          Clear;
          Add('Змін не відбувається');
          Add('Зміна маштабу по осі X');
          Add('Зміна маштабу по осях X і Y');
          Add('Відображення координат відносно осі Y');
          Add('Відображення відносно початку координат');
          Add('Зсув');
        end;
        Form1.ComboBox1.ItemIndex := 0;
      end;
    2:
      begin
        with Form1.ComboBox1.Items do
        begin
          Clear;
          Add('Змін не відбувається');
          Add('Поворот на 90°');
          Add('Поворот на 180°');
          Add('Поворот на 270°');
          Add('Обертання навколо прямої Y=X');
          Add('Обертання навколо осі Y=0');
          Add('Зміна маштабу');
          Add('Двовимірний зсув');
        end;
        Form1.ComboBox1.ItemIndex := 0;
      end;
  end;
  with Form1.StringGrid1 do
  begin
    for i := 1 to RowCount do
      for j := 1 to ColCount do
        Cells[i, j] :=
          IntToStr(Random((Form1.PaintBox1.Height div 2)
          div Form1.TrackBar1.Position) div 2);
  end;
  Form1.PaintBox1.Repaint;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Form1.PaintBox1.Repaint;
  Form1.Hint := IntToStr(Form1.TrackBar1.Position);
end;

end.
