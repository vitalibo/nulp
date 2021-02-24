object Frame5: TFrame5
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
    OnClick = SpeedButton1Click
  end
  object Label1: TLabel
    Left = 15
    Top = 10
    Width = 27
    Height = 13
    Caption = 'Find :'
  end
  object ListBox1: TListBox
    Left = 15
    Top = 56
    Width = 180
    Height = 305
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object Edit1: TEdit
    Left = 15
    Top = 29
    Width = 151
    Height = 21
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 201
    Top = 56
    Width = 482
    Height = 113
    Caption = 'Sign In'
    TabOrder = 2
    object Label2: TLabel
      Left = 40
      Top = 24
      Width = 32
      Height = 13
      Caption = 'Login :'
    end
    object Label3: TLabel
      Left = 40
      Top = 51
      Width = 53
      Height = 13
      Caption = 'Password :'
    end
    object Label4: TLabel
      Left = 40
      Top = 78
      Width = 28
      Height = 13
      Caption = 'Role :'
    end
    object Edit2: TEdit
      Left = 156
      Top = 21
      Width = 293
      Height = 21
      TabOrder = 0
    end
    object Edit3: TEdit
      Left = 156
      Top = 48
      Width = 293
      Height = 21
      TabOrder = 1
    end
    object ComboBox1: TComboBox
      Left = 156
      Top = 75
      Width = 293
      Height = 21
      TabOrder = 2
      Items.Strings = (
        #1040#1076#1084#1110#1085#1110#1089#1090#1088#1072#1090#1086#1088
        #1047#1072#1074#1110#1076#1091#1074#1072#1095' '#1072#1087#1090#1077#1082#1080
        #1040#1087#1090#1077#1082#1072#1088)
    end
  end
  object GroupBox2: TGroupBox
    Left = 201
    Top = 175
    Width = 482
    Height = 186
    Caption = 'Contact'
    TabOrder = 3
    object Label5: TLabel
      Left = 40
      Top = 20
      Width = 49
      Height = 13
      Caption = 'Passport :'
    end
    object Label6: TLabel
      Left = 40
      Top = 47
      Width = 34
      Height = 13
      Caption = 'Name :'
    end
    object Label7: TLabel
      Left = 40
      Top = 74
      Width = 49
      Height = 13
      Caption = 'Surname :'
    end
    object Label8: TLabel
      Left = 40
      Top = 101
      Width = 60
      Height = 13
      Caption = 'Patronymic :'
    end
    object Label9: TLabel
      Left = 40
      Top = 128
      Width = 46
      Height = 13
      Caption = 'Address :'
    end
    object Label10: TLabel
      Left = 40
      Top = 155
      Width = 37
      Height = 13
      Caption = 'Phone :'
    end
    object Edit4: TEdit
      Left = 158
      Top = 17
      Width = 100
      Height = 21
      TabOrder = 0
    end
    object Edit5: TEdit
      Left = 264
      Top = 17
      Width = 185
      Height = 21
      TabOrder = 1
    end
    object Edit6: TEdit
      Left = 158
      Top = 44
      Width = 291
      Height = 21
      TabOrder = 2
    end
    object Edit7: TEdit
      Left = 158
      Top = 71
      Width = 291
      Height = 21
      TabOrder = 3
    end
    object Edit8: TEdit
      Left = 158
      Top = 98
      Width = 291
      Height = 21
      TabOrder = 4
    end
    object Edit9: TEdit
      Left = 158
      Top = 125
      Width = 291
      Height = 21
      TabOrder = 5
    end
    object Edit10: TEdit
      Left = 158
      Top = 152
      Width = 291
      Height = 21
      TabOrder = 6
    end
  end
  object Button1: TButton
    Left = 439
    Top = 367
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 520
    Top = 367
    Width = 75
    Height = 25
    Caption = 'Remove'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 601
    Top = 367
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 6
    OnClick = Button3Click
  end
end
