object Frame6: TFrame6
  Left = 0
  Top = 0
  Width = 700
  Height = 400
  TabOrder = 0
  object Chart1: TChart
    Left = 288
    Top = 8
    Width = 400
    Height = 344
    Legend.Visible = False
    Title.Text.Strings = (
      'TChart')
    View3D = False
    Color = clBtnHighlight
    TabOrder = 0
    ColorPaletteIndex = 11
    object Series1: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = 13770496
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Button1: TButton
    Left = 601
    Top = 358
    Width = 75
    Height = 25
    Caption = 'Show'
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 3
    Top = 56
    Width = 279
    Height = 110
    Caption = 'Interval'
    TabOrder = 2
    object Label1: TLabel
      Left = 11
      Top = 36
      Width = 31
      Height = 13
      Caption = 'Start :'
    end
    object Label2: TLabel
      Left = 11
      Top = 71
      Width = 25
      Height = 13
      Caption = 'End :'
    end
    object DateTimePicker1: TDateTimePicker
      Left = 73
      Top = 28
      Width = 188
      Height = 21
      Date = 41265.903407627320000000
      Time = 41265.903407627320000000
      TabOrder = 0
    end
    object DateTimePicker2: TDateTimePicker
      Left = 73
      Top = 63
      Width = 186
      Height = 21
      Date = 41265.903428912040000000
      Time = 41265.903428912040000000
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 3
    Top = 188
    Width = 279
    Height = 110
    Caption = 'State'
    TabOrder = 3
    object Label3: TLabel
      Left = 11
      Top = 68
      Width = 34
      Height = 13
      Caption = 'Costs :'
    end
    object Label4: TLabel
      Left = 11
      Top = 41
      Width = 42
      Height = 13
      Caption = 'Income :'
    end
    object Edit1: TEdit
      Left = 73
      Top = 33
      Width = 188
      Height = 21
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 73
      Top = 60
      Width = 188
      Height = 21
      TabOrder = 1
    end
  end
end
