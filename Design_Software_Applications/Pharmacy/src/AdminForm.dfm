object Frame2: TFrame2
  Left = 0
  Top = 0
  Width = 700
  Height = 400
  TabOrder = 0
  object Label1: TLabel
    Left = 15
    Top = 10
    Width = 38
    Height = 13
    Caption = 'Tables :'
  end
  object Label2: TLabel
    Left = 176
    Top = 10
    Width = 26
    Height = 13
    Caption = 'Grid :'
  end
  object Label3: TLabel
    Left = 176
    Top = 253
    Width = 37
    Height = 13
    Caption = 'Query :'
  end
  object Label4: TLabel
    Left = 176
    Top = 215
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ListBox1: TListBox
    Left = 15
    Top = 29
    Width = 150
    Height = 323
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object DBGrid1: TDBGrid
    Left = 176
    Top = 29
    Width = 510
    Height = 180
    DataSource = DBModule1.MyDataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Memo1: TMemo
    Left = 176
    Top = 272
    Width = 510
    Height = 80
    Lines.Strings = (
      'SHOW DATABASES;')
    TabOrder = 2
  end
  object Button1: TButton
    Left = 601
    Top = 358
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 3
    OnClick = Button1Click
  end
  inline DBModule1: TDBModule
    Left = 454
    Top = 40
    Width = 222
    Height = 53
    TabOrder = 4
    Visible = False
    ExplicitLeft = 454
    ExplicitTop = 40
  end
end
