unit SaleModule;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DataModule;

type
  TRProduct = record
    Name: String;
    Company: String;
    Count: Integer;
    Price: String;
    Date: String;
    Description: String;
  end;

  TProducts = class
    DBModule1: TDBModule;
    IDProduct: Array [0 .. 100] of Integer;
    IDN: Integer;
    function CreateProduct(Drug: TRProduct): Boolean;
    function RemoveProduct(ID: Integer): Boolean;
    function UpdateProduct(Drug: TRProduct; ID: Integer): Boolean;
    function GetProduct(ID: Integer): TRProduct;
    function GetIDProduct(Index: Integer): Integer;
    function EofProducts: Boolean;
    function GetNextProduct: String;
    procedure GetListProduct;
    procedure FindProduct(Like: String);
    constructor Create;
  end;

implementation

{ TProducts }

constructor TProducts.Create;
begin
  DBModule1 := TDBModule.Create(nil);
end;

function TProducts.CreateProduct(Drug: TRProduct): Boolean;
begin
  try
    DBModule1.MyQuery1.SQL.Clear;
    DBModule1.MyQuery1.SQL.Add
      ('INSERT INTO products (name, company, count, price, date, description) VALUES ('''
      + Drug.Name + ''', ''' + Drug.Company + ''', ''' + IntToStr(Drug.Count) +
      ''', ''' + Drug.Price + ''', ''' + Drug.Date + ''', ''' + Drug.Description
      + ''');');
    DBModule1.MyQuery1.Active := True;
  except
    on E: Exception do
  end;
end;

function TProducts.EofProducts: Boolean;
begin
  Result := DBModule1.MyQuery1.Eof;
end;

procedure TProducts.FindProduct(Like: String);
begin
  DBModule1.MyQuery1.SQL.Clear;
  DBModule1.MyQuery1.SQL.Add('SET NAMES cp1251;');
  DBModule1.MyQuery1.SQL.Add
    ('SELECT id_products,name FROM products WHERE name LIKE ''%' + Like
    + '%'';');
  DBModule1.MyQuery1.Active := True;
  IDN := 0;
end;

function TProducts.GetIDProduct(Index: Integer): Integer;
begin
  Result := IDProduct[Index];
end;

procedure TProducts.GetListProduct;
begin
  DBModule1.MyQuery1.SQL.Clear;
  DBModule1.MyQuery1.SQL.Add('SET NAMES cp1251;');
  DBModule1.MyQuery1.SQL.Add('SELECT id_products,name FROM products;');
  DBModule1.MyQuery1.Active := True;
  IDN := 0;
end;

function TProducts.GetNextProduct: String;
begin
  Result := DBModule1.MyQuery1.Fields.Fields[1].AsString;
  IDProduct[IDN] := DBModule1.MyQuery1.Fields.Fields[0].AsInteger;
  Inc(IDN);
  DBModule1.MyQuery1.Next;
end;

function TProducts.GetProduct(ID: Integer): TRProduct;
var
  Drug: TRProduct;
begin
  DBModule1.MyQuery1.SQL.Clear;
  DBModule1.MyQuery1.SQL.Add('SET NAMES cp1251;');
  DBModule1.MyQuery1.SQL.Add('SELECT * FROM products WHERE id_products=''' +
    IntToStr(ID) + ''';');
  DBModule1.MyQuery1.Active := True;
  Drug.Name := DBModule1.MyQuery1.Fields.Fields[1].AsString;
  Drug.Company := DBModule1.MyQuery1.Fields.Fields[2].AsString;
  Drug.Count := DBModule1.MyQuery1.Fields.Fields[3].AsInteger;
  Drug.Price := DBModule1.MyQuery1.Fields.Fields[4].AsString;
  Drug.Date := DBModule1.MyQuery1.Fields.Fields[5].AsString;
  Drug.Description := DBModule1.MyQuery1.Fields.Fields[6].AsString;
  Result := Drug;
end;

function TProducts.RemoveProduct(ID: Integer): Boolean;
begin
  try
    DBModule1.MyQuery1.SQL.Clear;
    DBModule1.MyQuery1.SQL.Add('DELETE FROM products WHERE id_products=''' +
      IntToStr(ID) + ''';');
    DBModule1.MyQuery1.Active := True;
  except
    on E: Exception do
  end;
end;

function TProducts.UpdateProduct(Drug: TRProduct; ID: Integer): Boolean;
begin
  try
    DBModule1.MyQuery1.SQL.Clear;
    DBModule1.MyQuery1.SQL.Add('UPDATE products SET name=''' + Drug.Name +
      ''', company=''' + Drug.Company + ''', count=''' + IntToStr(Drug.Count) +
      ''', price=''' + Drug.Price + ''', date=''' + Drug.Date +
      ''', description=''' + Drug.Description + ''' WHERE id_products=''' +
      IntToStr(ID) + ''';');
    DBModule1.MyQuery1.Active := True;
  except
    on E: Exception do
  end;
end;

end.
