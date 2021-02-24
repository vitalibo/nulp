object Frame7: TFrame7
  Left = 0
  Top = 0
  Width = 700
  Height = 400
  TabOrder = 0
  object SpeedButton1: TSpeedButton
    Left = 172
    Top = 29
    Width = 23
    Height = 22
    Glyph.Data = {
      E6010000424DE60100000000000036000000280000000C0000000C0000000100
      180000000000B0010000C40E0000C40E00000000000000000000FFFFFFA0A0A0
      101010D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA0A0
      A0000000000000101010D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF101010000000000000000000101010D0D0D0FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFD0D0D01010100000000000000000001010101010100000001010
      10606060F0F0F0FFFFFFFFFFFFD0D0D010101000000000000000000010101040
      4040101010000000101010E0E0E0FFFFFFFFFFFFD0D0D0101010000000606060
      F0F0F0FFFFFFFFFFFF606060000000606060FFFFFFFFFFFFFFFFFF1010101010
      10F0F0F0FFFFFFFFFFFFFFFFFFFFFFFF202020000000FFFFFFFFFFFFFFFFFF00
      0000404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF404040000000FFFFFFFFFFFF
      FFFFFF101010101010FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF303030000000FFFF
      FFFFFFFFFFFFFF606060000000606060FFFFFFFFFFFFFFFFFF80808000000040
      4040FFFFFFFFFFFFFFFFFFF0F0F0101010000000202020404040202020000000
      101010D0D0D0FFFFFFFFFFFFFFFFFFFFFFFFE0E0E06060600000000000000000
      00404040D0D0D0FFFFFF}
  end
  object Label1: TLabel
    Left = 15
    Top = 10
    Width = 27
    Height = 13
    Caption = 'Find :'
  end
  object GroupBox1: TGroupBox
    Left = 201
    Top = 56
    Width = 484
    Height = 305
    Caption = 'Supply'
    TabOrder = 0
    object Label2: TLabel
      Left = 51
      Top = 38
      Width = 44
      Height = 13
      Caption = 'Product :'
    end
    object Label3: TLabel
      Left = 51
      Top = 65
      Width = 50
      Height = 13
      Caption = 'Suppliers :'
    end
    object Label4: TLabel
      Left = 51
      Top = 92
      Width = 30
      Height = 13
      Caption = 'Price :'
    end
    object Label5: TLabel
      Left = 51
      Top = 119
      Width = 36
      Height = 13
      Caption = 'Count :'
    end
    object Label6: TLabel
      Left = 51
      Top = 146
      Width = 30
      Height = 13
      Caption = 'Date :'
    end
    object Edit2: TEdit
      Left = 152
      Top = 89
      Width = 281
      Height = 21
      TabOrder = 0
    end
    object Edit3: TEdit
      Left = 152
      Top = 116
      Width = 281
      Height = 21
      TabOrder = 1
    end
    object DateTimePicker1: TDateTimePicker
      Left = 152
      Top = 143
      Width = 281
      Height = 21
      Date = 41264.149782754630000000
      Time = 41264.149782754630000000
      TabOrder = 2
    end
    object ComboBox1: TComboBox
      Left = 152
      Top = 35
      Width = 281
      Height = 21
      TabOrder = 3
    end
    object ComboBox2: TComboBox
      Left = 152
      Top = 62
      Width = 281
      Height = 21
      TabOrder = 4
    end
  end
  object ListBox1: TListBox
    Left = 15
    Top = 56
    Width = 180
    Height = 305
    ItemHeight = 13
    Items.Strings = (
      #1041#1048#1054#1050#1054#1053' '#1047#1059' '#1073#1072#1083#1100#1079#1072#1084' '#1076'/'#1075#1091#1073' '#1079#1072#1097#1080#1090'. 4,6 '#1075
      'URIAGE '#1048#1079#1086#1092#1080#1083#1100' '#1056#1080#1096' '#1082#1088#1077#1084' '#1087#1088#1086#1090#1080#1074' '#1084#1086#1088#1097#1080
      'STYX '#1052#1099#1083#1086' '#1052#1072#1085#1076#1072#1088#1080#1085'/'#1040#1087#1077#1083#1100#1089#1080#1085' 100 '#1075
      #1062#1080#1090#1088#1072#1084#1086#1085' '#1044#1072#1088#1085#1080#1094#1103' 50')
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 15
    Top = 29
    Width = 151
    Height = 21
    TabOrder = 2
  end
  object Button1: TButton
    Left = 439
    Top = 367
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 3
  end
  object Button2: TButton
    Left = 520
    Top = 367
    Width = 75
    Height = 25
    Caption = 'Remove'
    TabOrder = 4
  end
  object Button3: TButton
    Left = 601
    Top = 367
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 5
    OnClick = Button3Click
  end
end
