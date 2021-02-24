unit SupplyModule;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DataModule;

type
  TRSupply = record
    Product: String;
    Suppliers: String;
    Price: String;
    Count: Integer;
    Date: String;
  end;

  TSupply = class
    DBModule1: TDBModule;
    IDSupply: Array [0 .. 100] of Integer;
    IDN: Integer;
    function CreateSupply(List: TRSupply): Boolean;
    function RemoveSupply(ID: Integer): Boolean;
    function UpdateSupply(List: TRSupply; ID: Integer): Boolean;
    function GetSupply(ID: Integer): TRSupply;
    function GetIDSupply(Index: Integer): Integer;
    function EofSupply: Boolean;
    function GetNextSupply: String;
    procedure GetListSupply;
    procedure FindSupply(Like: String);
    constructor Create;
  end;

implementation

{ TSupply }

constructor TSupply.Create;
begin
  DBModule1 := TDBModule.Create(nil);
end;

function TSupply.CreateSupply(List: TRSupply): Boolean;
begin
  try
    DBModule1.MyQuery1.SQL.Clear;
    DBModule1.MyQuery1.SQL.Add
      ('INSERT INTO supply (id_products, id_suppliers, count, sum, date) VALUES ('''
      + List.Product + ''', ''' + List.Suppliers + ''', ''' + List.Price +
      ''', ''' + IntToStr(List.Count) + ''', ''' + List.Date + ''');');
    DBModule1.MyQuery1.Active := True;
  except
    on E: Exception do
  end;
end;

function TSupply.EofSupply: Boolean;
begin
  Result := DBModule1.MyQuery1.Eof;
end;

procedure TSupply.FindSupply(Like: String);
begin
  DBModule1.MyQuery1.SQL.Clear;
  DBModule1.MyQuery1.SQL.Add('SET NAMES cp1251;');
  DBModule1.MyQuery1.SQL.Add
    ('SELECT id_supply,id_products,id_syppliers FROM supply WHERE name LIKE ''%'
    + Like + '%'';');
  DBModule1.MyQuery1.Active := True;
  IDN := 0;
end;

function TSupply.GetIDSupply(Index: Integer): Integer;
begin
  Result := IDSupply[Index];
end;

procedure TSupply.GetListSupply;
begin
  DBModule1.MyQuery1.SQL.Clear;
  DBModule1.MyQuery1.SQL.Add('SET NAMES cp1251;');
  DBModule1.MyQuery1.SQL.Add
    ('SELECT id_supply,id_products,id_syppliers FROM supply;');
  DBModule1.MyQuery1.Active := True;
  IDN := 0;
end;

function TSupply.GetNextSupply: String;
begin
  Result := DBModule1.MyQuery1.Fields.Fields[1].AsString + ' / ' +
    DBModule1.MyQuery1.Fields.Fields[3].AsString;
  IDSupply[IDN] := DBModule1.MyQuery1.Fields.Fields[0].AsInteger;
  Inc(IDN);
  DBModule1.MyQuery1.Next;
end;

function TSupply.GetSupply(ID: Integer): TRSupply;
begin

end;

function TSupply.RemoveSupply(ID: Integer): Boolean;
begin

end;

function TSupply.UpdateSupply(List: TRSupply; ID: Integer): Boolean;
begin

end;

end.
