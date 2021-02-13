object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072' '#1088#1086#1073#1086#1090#1072' '#8470'8'
  ClientHeight = 457
  ClientWidth = 729
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 8
    Top = 8
    Width = 441
    Height = 441
    Color = clBtnFace
    ParentColor = False
    OnMouseDown = PaintBox1MouseDown
    OnPaint = PaintBox1Paint
  end
  object GroupBox1: TGroupBox
    Left = 455
    Top = 8
    Width = 258
    Height = 241
    Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1080
    TabOrder = 0
    object StringGrid1: TStringGrid
      Left = 12
      Top = 24
      Width = 230
      Height = 177
      ColCount = 3
      RowCount = 2
      FixedRows = 0
      TabOrder = 0
      RowHeights = (
        24
        24)
    end
    object Button1: TButton
      Left = 160
      Top = 207
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
end
