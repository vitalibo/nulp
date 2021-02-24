unit AccountModule;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DataModule;

type
  TRContact = record
    SerialNumber: String;
    Passport: String;
    Name: String;
    Surname: String;
    Patronymic: String;
    Address: String;
    Phone: String;
    Login: String;
    Password: String;
    Post: Integer;
  end;

  TEmployee = class
    DBModule1: TDBModule;
    IDEmployee: Array [0 .. 100] of Integer;
    IDN: Integer;
    function IsInLogin(Login: String; Password: String): Integer;
    function CreateEmployee(User: TRContact): Boolean;
    function RemoveEmployee(ID: Integer): Boolean;
    function UpdateEmployee(User: TRContact; ID: Integer): Boolean;
    function GetEmployee(ID: Integer): TRContact;
    function GetIDEmployee(Index: Integer): Integer;
    function EofEmployee: Boolean;
    procedure FindEmployee(Like: String);
    procedure GetListEmployee;
    function GetNextEmployee: String;
    constructor Create;
  end;

implementation

{ TEmployee }

constructor TEmployee.Create;
begin
  DBModule1 := TDBModule.Create(nil);
end;

function TEmployee.CreateEmployee(User: TRContact): Boolean;
begin
  try
    DBModule1.MyQuery1.SQL.Clear;
    DBModule1.MyQuery1.SQL.Add
      ('INSERT INTO `pharmacy`.`employee` (`serial_number`, `passport`, `surname`, `name`, `patronymic`, `address`, `phone`, `login`, `password`, `post`) VALUES ('''
      + User.SerialNumber + ''', ''' + User.Passport + ''', ''' + User.Surname +
      ''', ''' + User.Name + ''', ''' + User.Patronymic + ''', ''' +
      User.Address + ''', ''' + User.Phone + ''', ''' + User.Login + ''', ''' +
      User.Password + ''', ''' + IntToStr(User.Post) + ''');');
    DBModule1.MyQuery1.Active := True;
  except
    on E: Exception do
  end;
end;

function TEmployee.EofEmployee: Boolean;
begin
  Result := DBModule1.MyQuery1.Eof;
end;

procedure TEmployee.FindEmployee(Like: String);
begin
  DBModule1.MyQuery1.SQL.Clear;
  DBModule1.MyQuery1.SQL.Add('SET NAMES cp1251;');
  DBModule1.MyQuery1.SQL.Add
    ('SELECT id_employee,name,surname,patronymic FROM employee WHERE name LIKE ''%'
    + Like + '%'' OR surname LIKE ''%' + Like + '%'' OR patronymic LIKE ''%' +
    Like + '%'';');
  DBModule1.MyQuery1.Active := True;
  IDN := 0;
end;

function TEmployee.GetEmployee(ID: Integer): TRContact;
var
  User: TRContact;
begin
  DBModule1.MyQuery1.SQL.Clear;
  DBModule1.MyQuery1.SQL.Add('SET NAMES cp1251;');
  DBModule1.MyQuery1.SQL.Add('SELECT * FROM employee WHERE id_employee=''' +
    IntToStr(ID) + ''';');
  DBModule1.MyQuery1.Active := True;
  User.SerialNumber := DBModule1.MyQuery1.Fields.Fields[1].AsString;
  User.Passport := DBModule1.MyQuery1.Fields.Fields[2].AsString;
  User.Name := DBModule1.MyQuery1.Fields.Fields[4].AsString;
  User.Surname := DBModule1.MyQuery1.Fields.Fields[3].AsString;
  User.Patronymic := DBModule1.MyQuery1.Fields.Fields[5].AsString;
  User.Address := DBModule1.MyQuery1.Fields.Fields[6].AsString;
  User.Phone := DBModule1.MyQuery1.Fields.Fields[7].AsString;
  User.Login := DBModule1.MyQuery1.Fields.Fields[8].AsString;
  User.Password := DBModule1.MyQuery1.Fields.Fields[9].AsString;
  User.Post := DBModule1.MyQuery1.Fields.Fields[10].AsInteger;
  Result := User;
end;

function TEmployee.GetIDEmployee(Index: Integer): Integer;
begin
  Result := IDEmployee[Index];
end;

procedure TEmployee.GetListEmployee;
begin
  DBModule1.MyQuery1.SQL.Clear;
  DBModule1.MyQuery1.SQL.Add('SET NAMES cp1251;');
  DBModule1.MyQuery1.SQL.Add
    ('SELECT id_employee,name,surname,patronymic FROM employee;');
  DBModule1.MyQuery1.Active := True;
  IDN := 0;
end;

function TEmployee.GetNextEmployee: String;
begin
  Result := DBModule1.MyQuery1.Fields.Fields[2].AsString + ' ' +
    DBModule1.MyQuery1.Fields.Fields[1].AsString + ' ' +
    DBModule1.MyQuery1.Fields.Fields[3].AsString;
  IDEmployee[IDN] := DBModule1.MyQuery1.Fields.Fields[0].AsInteger;
  Inc(IDN);
  DBModule1.MyQuery1.Next;
end;

function TEmployee.IsInLogin(Login: String; Password: String): Integer;
begin
  DBModule1.MyQuery1.SQL.Clear;
  DBModule1.MyQuery1.SQL.Add('SELECT post FROM employee WHERE login=''' + Login
    + ''' AND password=''' + Password + ''';');
  DBModule1.MyQuery1.Active := True;
  DBModule1.MyQuery1.Next;
  Result := DBModule1.MyQuery1.Fields.Fields[0].AsInteger;
end;

function TEmployee.RemoveEmployee(ID: Integer): Boolean;
begin
  try
    DBModule1.MyQuery1.SQL.Clear;
    DBModule1.MyQuery1.SQL.Add('DELETE FROM employee WHERE id_employee=''' +
      IntToStr(ID) + ''';');
    DBModule1.MyQuery1.Active := True;
  except
    on E: Exception do
  end;
end;

function TEmployee.UpdateEmployee(User: TRContact; ID: Integer): Boolean;
begin
  try
    DBModule1.MyQuery1.SQL.Clear;
    DBModule1.MyQuery1.SQL.Add('UPDATE employee SET serial_number=''' +
      User.SerialNumber + ''', passport=''' + User.Passport + ''', surname=''' +
      User.Surname + ''', name=''' + User.Name + ''', patronymic=''' +
      User.Patronymic + ''', address=''' + User.Address + ''', phone=''' +
      User.Phone + ''', login=''' + User.Login + ''', password=''' +
      User.Password + ''', post=''' + IntToStr(User.Post) +
      ''' WHERE `id_employee`=''' + IntToStr(ID) + ''';');
    DBModule1.MyQuery1.Active := True;
  except
    on E: Exception do
  end;
end;

end.
