object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 433
  ClientWidth = 800
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
    Width = 481
    Height = 417
    OnPaint = PaintBox1Paint
  end
  object RadioGroup1: TRadioGroup
    Left = 495
    Top = 239
    Width = 297
    Height = 65
    Caption = #1058#1080#1087
    ItemIndex = 0
    Items.Strings = (
      #1055#1072#1088#1072#1083#1077#1083#1100#1085#1072' '#1087#1088#1086#1077#1082#1094#1110#1103
      #1050#1086#1089#1086#1082#1091#1090#1085#1072' '#1087#1088#1086#1077#1082#1094#1110#1103)
    TabOrder = 0
    OnClick = RadioGroup1Click
  end
  object GroupBox1: TGroupBox
    Left = 495
    Top = 80
    Width = 297
    Height = 153
    Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1080
    TabOrder = 1
    object SpeedButton1: TSpeedButton
      Left = 162
      Top = 119
      Width = 23
      Height = 25
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFE1D5CAA176538F582A995A219F5D21985B279B6C46D3BFB0FFFF
        FFFFFFFFFFFFFFFFFFFF865A38E6DED7FFFFFFB49B88875126A2520DA85100B0
        5700BB5E00CC6908B561157E502B9D7B60F7F4F2FFFFFFFFFFFF6F482A785337
        896952854E22C45A02B15100A74E00914B0D744824815E4494765F94765F6F48
        2A896A52F6F4F2FFFFFF614128E58D08D36C0AEA6A00D35F00C0560082471674
        5842D9D0CAFFFFFFFFFFFFFFFFFFFFFFFFC5B8AF917B6BFFFFFF523927FCB82B
        F39404EF7900DA66007E4518735E4FF5F3F2FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF433126FCDD78F7C044F1A819BD790F5A4A41F4F3F2FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF342A24FFF3B3
        FEE997FADB85DFBB64403631D8D7D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF252223252223252223252223252223252223322E30FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3630302924232924232924
        23292423292423292423FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFD9D7D6433832BE8504E0AB06F4DE7EFEFEFB382C25FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F3F25E4C41A76D09D794
        00E4AD05F6DF7E473326FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFF5F3F2755F4F754518B56400C17400D18700EAA705553B27FFFFFF947D6C
        C7B9AFFFFFFFFFFFFFFFFFFFFFFFFFD9D1CA785A43864817B15100B15400B559
        00B5600AC96D05644329FFFFFFF6F4F28C6B52734A2A97785F97785F85604482
        572BBC7610C96600BF5900BC5702814C228C6B527B5537734A2AFFFFFFFFFFFF
        F7F4F29F7C6082522BC09E6DE6CD95FBDC89F7C44EF2AD23CB7C108F5626B79C
        88FFFFFFE7DED7885B38FFFFFFFFFFFFFFFFFFFFFFFFD4C0B09D6D479F6C3DAE
        7F4EAE7E4A986232A47854E2D5CBFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = SpeedButton1Click
    end
    object Button1: TButton
      Left = 191
      Top = 119
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
    object StringGrid1: TStringGrid
      Left = 16
      Top = 17
      Width = 265
      Height = 57
      ColCount = 4
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 1
      ColWidths = (
        64
        64
        64
        64)
    end
    object StringGrid2: TStringGrid
      Left = 16
      Top = 80
      Width = 265
      Height = 33
      ColCount = 4
      RowCount = 1
      FixedRows = 0
      TabOrder = 2
      ColWidths = (
        64
        64
        63
        64)
    end
  end
  object GroupBox2: TGroupBox
    Left = 495
    Top = 8
    Width = 297
    Height = 66
    Caption = #1052#1072#1089#1096#1090#1072#1073
    TabOrder = 2
    OnClick = GroupBox2Click
    object TrackBar1: TTrackBar
      Left = 16
      Top = 24
      Width = 265
      Height = 25
      Max = 100
      Min = 10
      Position = 50
      ShowSelRange = False
      TabOrder = 0
      TickMarks = tmBoth
      TickStyle = tsNone
      OnChange = TrackBar1Change
    end
  end
  object GroupBox3: TGroupBox
    Left = 495
    Top = 310
    Width = 297
    Height = 115
    Caption = #1055#1072#1088#1072#1083#1077#1083#1100#1085#1072' '#1087#1088#1086#1077#1082#1094#1110#1103
    TabOrder = 3
    object Label4: TLabel
      Left = 56
      Top = 23
      Width = 20
      Height = 13
      Caption = 'd = '
    end
    object Edit1: TEdit
      Left = 104
      Top = 20
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '2,0'
    end
  end
  object GroupBox4: TGroupBox
    Left = 495
    Top = 310
    Width = 297
    Height = 115
    Caption = #1050#1086#1089#1086#1082#1091#1090#1085#1072' '#1087#1088#1086#1077#1082#1094#1110#1103
    TabOrder = 4
    Visible = False
    object Label1: TLabel
      Left = 56
      Top = 24
      Width = 17
      Height = 13
      Caption = 'a ='
    end
    object Label2: TLabel
      Left = 56
      Top = 51
      Width = 20
      Height = 13
      Caption = 'b = '
    end
    object Label3: TLabel
      Left = 56
      Top = 78
      Width = 16
      Height = 13
      Caption = 'l = '
    end
    object Edit2: TEdit
      Left = 104
      Top = 75
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '3'
    end
    object Edit3: TEdit
      Left = 104
      Top = 21
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '30'
    end
    object Edit4: TEdit
      Left = 104
      Top = 48
      Width = 121
      Height = 21
      TabOrder = 2
      Text = '60'
    end
  end
end
