object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072' '#1088#1086#1073#1086#1090#1072' '#8470'5'
  ClientHeight = 464
  ClientWidth = 705
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
    OnMouseDown = PaintBox1MouseDown
    OnMouseUp = PaintBox1MouseUp
    OnPaint = PaintBox1Paint
  end
  object GroupBox1: TGroupBox
    Left = 465
    Top = 8
    Width = 233
    Height = 153
    Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1080
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 112
      Top = 111
      Width = 26
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
    object StringGrid1: TStringGrid
      Left = 16
      Top = 24
      Width = 201
      Height = 81
      ColCount = 3
      RowCount = 3
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 0
    end
    object Button1: TButton
      Left = 144
      Top = 111
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object StringGrid2: TStringGrid
    Left = 465
    Top = 167
    Width = 233
    Height = 291
    ColCount = 4
    DefaultColWidth = 52
    TabOrder = 1
    RowHeights = (
      24
      24
      24
      24
      24)
  end
end
