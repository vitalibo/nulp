object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072' '#1088#1086#1073#1086#1090#1072' '#8470'2'
  ClientHeight = 585
  ClientWidth = 985
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
  object GroupBox1: TGroupBox
    Left = 650
    Top = 8
    Width = 326
    Height = 169
    Caption = #1052#1072#1090#1088#1080#1094#1103' '#1087#1077#1088#1077#1090#1074#1086#1088#1077#1085#1085#1103
    TabOrder = 0
    object Button1: TButton
      Left = 238
      Top = 132
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
    object StringGrid1: TStringGrid
      Left = 11
      Top = 16
      Width = 302
      Height = 110
      ColCount = 4
      FixedCols = 0
      RowCount = 4
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 636
    Height = 569
    Caption = #1043#1088#1072#1092#1110#1082
    TabOrder = 1
    object PaintBox1: TPaintBox
      Left = 3
      Top = 16
      Width = 590
      Height = 544
      OnPaint = PaintBox1Paint
    end
    object TrackBar1: TTrackBar
      Left = 612
      Top = 16
      Width = 21
      Height = 279
      Max = 200
      Min = 50
      Orientation = trVertical
      Position = 100
      ShowSelRange = False
      TabOrder = 0
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TrackBar1Change
    end
  end
  object GroupBox3: TGroupBox
    Left = 650
    Top = 183
    Width = 326
    Height = 130
    Caption = #1052#1072#1089#1096#1090#1072#1073' '#1082#1091#1073#1072
    TabOrder = 2
    object Label13: TLabel
      Left = 20
      Top = 23
      Width = 13
      Height = 13
      Caption = 'X :'
    end
    object Label14: TLabel
      Left = 20
      Top = 49
      Width = 13
      Height = 13
      Caption = 'Y :'
    end
    object Label15: TLabel
      Left = 20
      Top = 76
      Width = 13
      Height = 13
      Caption = 'Z :'
    end
    object Label16: TLabel
      Left = 20
      Top = 103
      Width = 25
      Height = 13
      Caption = 'XYZ :'
    end
    object Label17: TLabel
      Left = 280
      Top = 23
      Width = 29
      Height = 13
      Caption = '100%'
    end
    object Label18: TLabel
      Left = 280
      Top = 76
      Width = 29
      Height = 13
      Caption = '100%'
    end
    object Label19: TLabel
      Left = 280
      Top = 49
      Width = 29
      Height = 13
      Caption = '100%'
    end
    object Label20: TLabel
      Left = 280
      Top = 103
      Width = 29
      Height = 13
      Caption = '100%'
    end
    object TrackBar5: TTrackBar
      Left = 56
      Top = 17
      Width = 217
      Height = 21
      Max = 20
      Min = 1
      Position = 10
      ShowSelRange = False
      TabOrder = 0
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TrackBar5Change
    end
    object TrackBar6: TTrackBar
      Left = 56
      Top = 44
      Width = 217
      Height = 21
      Max = 20
      Min = 1
      Position = 10
      ShowSelRange = False
      TabOrder = 1
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TrackBar6Change
    end
    object TrackBar7: TTrackBar
      Left = 56
      Top = 71
      Width = 217
      Height = 21
      Max = 20
      Min = 1
      Position = 10
      ShowSelRange = False
      TabOrder = 2
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TrackBar7Change
    end
    object TrackBar8: TTrackBar
      Left = 56
      Top = 98
      Width = 217
      Height = 21
      Max = 20
      Min = 1
      Position = 10
      ShowSelRange = False
      TabOrder = 3
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TrackBar8Change
    end
  end
  object GroupBox4: TGroupBox
    Left = 650
    Top = 319
    Width = 326
    Height = 114
    Caption = #1058#1088#1100#1086#1093#1074#1080#1084#1110#1088#1085#1080#1081' '#1079#1089#1091#1074
    TabOrder = 3
    object Label1: TLabel
      Left = 24
      Top = 22
      Width = 13
      Height = 13
      Caption = 'X :'
    end
    object Label2: TLabel
      Left = 24
      Top = 53
      Width = 13
      Height = 13
      Caption = 'Y :'
    end
    object Label3: TLabel
      Left = 24
      Top = 84
      Width = 13
      Height = 13
      Caption = 'Z :'
    end
    object Label10: TLabel
      Left = 291
      Top = 22
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label11: TLabel
      Left = 291
      Top = 53
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label12: TLabel
      Left = 291
      Top = 84
      Width = 6
      Height = 13
      Caption = '0'
    end
    object TrackBar2: TTrackBar
      Left = 56
      Top = 17
      Width = 217
      Height = 25
      Max = 5
      Min = -5
      ShowSelRange = False
      TabOrder = 0
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TrackBar2Change
    end
    object TrackBar3: TTrackBar
      Left = 56
      Top = 49
      Width = 217
      Height = 25
      Max = 5
      Min = -5
      ShowSelRange = False
      TabOrder = 1
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TrackBar3Change
    end
    object TrackBar4: TTrackBar
      Left = 56
      Top = 80
      Width = 217
      Height = 25
      Min = -10
      ShowSelRange = False
      TabOrder = 2
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TrackBar4Change
    end
  end
  object GroupBox5: TGroupBox
    Left = 650
    Top = 439
    Width = 160
    Height = 138
    Caption = #1055#1086#1074#1086#1088#1086#1090
    TabOrder = 4
    object Label4: TLabel
      Left = 16
      Top = 21
      Width = 21
      Height = 13
      Caption = 'OX :'
    end
    object Label5: TLabel
      Left = 16
      Top = 48
      Width = 21
      Height = 13
      Caption = 'OY :'
    end
    object Label6: TLabel
      Left = 16
      Top = 75
      Width = 21
      Height = 13
      Caption = 'OZ :'
    end
    object Label7: TLabel
      Left = 146
      Top = 16
      Width = 5
      Height = 13
      Caption = #176
    end
    object Label8: TLabel
      Left = 146
      Top = 43
      Width = 5
      Height = 13
      Caption = #176
    end
    object Label9: TLabel
      Left = 146
      Top = 70
      Width = 5
      Height = 13
      Caption = #176
    end
    object Edit2: TEdit
      Left = 56
      Top = 16
      Width = 84
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object Edit3: TEdit
      Left = 56
      Top = 43
      Width = 84
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object Edit4: TEdit
      Left = 56
      Top = 70
      Width = 84
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object Button3: TButton
      Left = 72
      Top = 104
      Width = 75
      Height = 25
      Caption = 'Rotate'
      TabOrder = 3
      OnClick = Button3Click
    end
  end
  object GroupBox6: TGroupBox
    Left = 816
    Top = 439
    Width = 160
    Height = 138
    Caption = #1042#1110#1076#1086#1073#1088#1072#1078#1077#1085#1085#1103
    TabOrder = 5
    object CheckBox1: TCheckBox
      Left = 23
      Top = 20
      Width = 98
      Height = 17
      Alignment = taLeftJustify
      Caption = 'OX :'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 23
      Top = 47
      Width = 98
      Height = 17
      Alignment = taLeftJustify
      Caption = 'OY :'
      TabOrder = 1
      OnClick = CheckBox2Click
    end
    object CheckBox3: TCheckBox
      Left = 23
      Top = 74
      Width = 98
      Height = 17
      Alignment = taLeftJustify
      Caption = 'OZ :'
      TabOrder = 2
      OnClick = CheckBox3Click
    end
  end
end
