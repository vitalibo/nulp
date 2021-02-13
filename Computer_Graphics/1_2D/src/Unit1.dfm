object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072' '#1088#1086#1073#1086#1090#1072' '#8470'1'
  ClientHeight = 515
  ClientWidth = 823
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
    Width = 500
    Height = 500
    OnPaint = PaintBox1Paint
  end
  object GroupBox1: TGroupBox
    Left = 514
    Top = 103
    Width = 300
    Height = 58
    Caption = #1052#1072#1096#1090#1072#1073
    TabOrder = 1
    object TrackBar1: TTrackBar
      Left = 3
      Top = 13
      Width = 294
      Height = 45
      Max = 50
      Min = 1
      ParentShowHint = False
      Position = 10
      ShowHint = True
      ShowSelRange = False
      TabOrder = 0
      TickStyle = tsNone
      OnChange = TrackBar1Change
    end
  end
  object RadioGroup1: TRadioGroup
    Left = 514
    Top = 8
    Width = 300
    Height = 89
    Caption = #1060#1110#1075#1091#1088#1080
    ItemIndex = 0
    Items.Strings = (
      #1058#1086#1095#1082#1072
      #1055#1088#1103#1084#1072
      #1058#1088#1080#1082#1091#1090#1085#1080#1082)
    TabOrder = 0
    OnClick = RadioGroup1Click
  end
  object GroupBox2: TGroupBox
    Left = 514
    Top = 167
    Width = 300
    Height = 342
    Caption = #1052#1072#1090#1088#1080#1094#1103
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 63
      Height = 13
      Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090' :'
    end
    object Label2: TLabel
      Left = 16
      Top = 149
      Width = 74
      Height = 13
      Caption = #1055#1077#1088#1077#1090#1074#1086#1088#1077#1085#1100' :'
    end
    object StringGrid1: TStringGrid
      Left = 16
      Top = 35
      Width = 265
      Height = 108
      ColCount = 3
      RowCount = 4
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
      ColWidths = (
        64
        64
        64)
    end
    object StringGrid2: TStringGrid
      Left = 16
      Top = 195
      Width = 265
      Height = 103
      ColCount = 3
      RowCount = 4
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 1
      RowHeights = (
        24
        24
        23
        24)
    end
    object ComboBox1: TComboBox
      Left = 16
      Top = 168
      Width = 265
      Height = 21
      ItemIndex = 0
      TabOrder = 2
      Text = #1047#1084#1110#1085' '#1085#1077' '#1074#1110#1076#1073#1091#1074#1072#1108#1090#1100#1089#1103
      OnSelect = ComboBox1Select
      Items.Strings = (
        #1047#1084#1110#1085' '#1085#1077' '#1074#1110#1076#1073#1091#1074#1072#1108#1090#1100#1089#1103)
    end
    object Button1: TButton
      Left = 193
      Top = 304
      Width = 75
      Height = 25
      Caption = #1054#1050
      TabOrder = 3
      OnClick = Button1Click
    end
  end
end
