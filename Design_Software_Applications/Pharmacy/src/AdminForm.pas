unit AdminForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataModule, StdCtrls, Grids, DBGrids;

type
  TFrame2 = class(TFrame)
    ListBox1: TListBox;
    DBGrid1: TDBGrid;
    Memo1: TMemo;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBModule1: TDBModule;
    constructor Create(AOwner: TComponent); override;
    procedure ListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
{ TFrame2 }

procedure TFrame2.Button1Click(Sender: TObject);
begin
  try
    Label4.Caption := '';
    DBModule1.MyQuery1.SQL.Clear;
    DBModule1.MyQuery1.SQL.Add('SET NAMES cp1251;');
    DBModule1.MyQuery1.SQL.Add(Memo1.Lines.Text);
    DBModule1.MyQuery1.Active := True;
  except
    on E: Exception do
    begin
      MessageBeep(100);
      Label4.Caption := E.Message;
    end;
  end;
end;

constructor TFrame2.Create(AOwner: TComponent);
begin
  inherited;
  DBModule1.MyQuery1.SQL.Clear;
  DBModule1.MyQuery1.SQL.Add('SHOW TABLES;');
  DBModule1.MyQuery1.Active := True;
  ListBox1.Items.Clear;
  while not DBModule1.MyQuery1.Eof do
  begin
    ListBox1.Items.Add(DBModule1.MyQuery1.Fields.Fields[0].AsString);
    DBModule1.MyQuery1.Next;
  end;
end;

procedure TFrame2.ListBox1Click(Sender: TObject);
begin
  DBModule1.MyQuery1.SQL.Clear;
  DBModule1.MyQuery1.SQL.Add('SET NAMES cp1251;');
  DBModule1.MyQuery1.SQL.Add('SELECT * FROM ' + ListBox1.Items
    [ListBox1.ItemIndex] + ';');
  DBModule1.MyQuery1.Active := True;
end;

end.
