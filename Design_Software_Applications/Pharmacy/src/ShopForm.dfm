object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 700
  Height = 400
  TabOrder = 0
  object Label1: TLabel
    Left = 12
    Top = 10
    Width = 27
    Height = 13
    Caption = 'Find :'
  end
  object SpeedButton1: TSpeedButton
    Left = 169
    Top = 28
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
  object Edit1: TEdit
    Left = 12
    Top = 29
    Width = 151
    Height = 21
    TabOrder = 0
  end
  object ListBox1: TListBox
    Left = 12
    Top = 56
    Width = 180
    Height = 194
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBox1Click
  end
  object GroupBox1: TGroupBox
    Left = 198
    Top = 28
    Width = 491
    Height = 222
    Caption = 'Product'
    TabOrder = 2
    object Label2: TLabel
      Left = 16
      Top = 31
      Width = 34
      Height = 13
      Caption = 'Name :'
    end
    object Label3: TLabel
      Left = 16
      Top = 58
      Width = 52
      Height = 13
      Caption = 'Company :'
    end
    object Label4: TLabel
      Left = 255
      Top = 31
      Width = 36
      Height = 13
      Caption = 'Count :'
    end
    object Label5: TLabel
      Left = 255
      Top = 58
      Width = 30
      Height = 13
      Caption = 'Price :'
    end
    object Label6: TLabel
      Left = 255
      Top = 85
      Width = 30
      Height = 13
      Caption = 'Date :'
    end
    object Label7: TLabel
      Left = 16
      Top = 90
      Width = 60
      Height = 13
      Caption = 'Description :'
    end
    object Edit2: TEdit
      Left = 96
      Top = 28
      Width = 145
      Height = 21
      TabOrder = 0
    end
    object Edit3: TEdit
      Left = 96
      Top = 55
      Width = 145
      Height = 21
      TabOrder = 1
    end
    object Edit4: TEdit
      Left = 335
      Top = 28
      Width = 145
      Height = 21
      TabOrder = 2
    end
    object Edit5: TEdit
      Left = 335
      Top = 55
      Width = 145
      Height = 21
      TabOrder = 3
    end
    object DateTimePicker1: TDateTimePicker
      Left = 335
      Top = 82
      Width = 145
      Height = 21
      Date = 41263.823660972220000000
      Time = 41263.823660972220000000
      TabOrder = 4
    end
    object Memo1: TMemo
      Left = 16
      Top = 109
      Width = 465
      Height = 60
      TabOrder = 5
    end
    object Button1: TButton
      Left = 238
      Top = 183
      Width = 75
      Height = 25
      Caption = 'Create'
      TabOrder = 6
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 319
      Top = 183
      Width = 75
      Height = 25
      Caption = 'Remove'
      TabOrder = 7
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 400
      Top = 183
      Width = 75
      Height = 25
      Caption = 'Update'
      TabOrder = 8
      OnClick = Button3Click
    end
  end
  object PageControl1: TPageControl
    Left = 12
    Top = 256
    Width = 677
    Height = 130
    ActivePage = TabSheet1
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'Basket'
      object Label8: TLabel
        Left = 178
        Top = 29
        Width = 36
        Height = 13
        Caption = 'Count :'
      end
      object Label9: TLabel
        Left = 483
        Top = 30
        Width = 57
        Height = 13
        Caption = 'Total price :'
      end
      object Label10: TLabel
        Left = 178
        Top = 3
        Width = 34
        Height = 13
        Caption = 'Name :'
      end
      object Label11: TLabel
        Left = 319
        Top = 28
        Width = 30
        Height = 13
        Caption = 'Price :'
      end
      object ListBox2: TListBox
        Left = 0
        Top = 3
        Width = 172
        Height = 99
        ItemHeight = 13
        TabOrder = 0
      end
      object Button4: TButton
        Left = 178
        Top = 74
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 1
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 259
        Top = 74
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 2
      end
      object Button6: TButton
        Left = 582
        Top = 74
        Width = 75
        Height = 25
        Caption = 'Sale'
        TabOrder = 3
      end
      object Edit6: TEdit
        Left = 558
        Top = 27
        Width = 108
        Height = 21
        TabOrder = 4
      end
      object Edit7: TEdit
        Left = 235
        Top = 27
        Width = 70
        Height = 21
        TabOrder = 5
      end
      object Edit8: TEdit
        Left = 235
        Top = 0
        Width = 211
        Height = 21
        TabOrder = 6
      end
      object Edit9: TEdit
        Left = 376
        Top = 27
        Width = 70
        Height = 21
        TabOrder = 7
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Repayment'
      ImageIndex = 1
    end
  end
end
