object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 218
  ClientWidth = 217
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 120
    Height = 199
  end
  object Button1: TButton
    Left = 134
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Pause'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 134
    Top = 39
    Width = 33
    Height = 25
    Caption = '-'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 176
    Top = 39
    Width = 33
    Height = 25
    Caption = '+'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 134
    Top = 70
    Width = 33
    Height = 25
    Caption = '<'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 176
    Top = 70
    Width = 33
    Height = 25
    Caption = '>'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 132
    Top = 101
    Width = 75
    Height = 25
    Caption = 'Restart'
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 134
    Top = 132
    Width = 75
    Height = 25
    Caption = 'Exit'
    TabOrder = 6
    OnClick = Button7Click
  end
end
