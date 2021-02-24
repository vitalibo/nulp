object DBModule: TDBModule
  Left = 0
  Top = 0
  Width = 222
  Height = 53
  TabOrder = 0
  object MyConnection1: TMyConnection
    Database = 'pharmacy'
    Username = 'root'
    Server = 'localhost'
    Connected = True
    Left = 24
    Top = 8
  end
  object MyDataSource1: TMyDataSource
    DataSet = MyQuery1
    Left = 104
    Top = 8
  end
  object MyQuery1: TMyQuery
    Connection = MyConnection1
    Left = 176
    Top = 8
  end
end
