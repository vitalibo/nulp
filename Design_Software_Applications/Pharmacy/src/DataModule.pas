unit DataModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DB, MemDS, DBAccess, MyAccess;

type
  TDBModule = class(TFrame)
    MyConnection1: TMyConnection;
    MyDataSource1: TMyDataSource;
    MyQuery1: TMyQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
