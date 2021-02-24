program Pharmacy;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  DataModule in 'DataModule.pas' {DBModule: TFrame},
  AccountModule in 'AccountModule.pas',
  AdminForm in 'AdminForm.pas' {Frame2: TFrame},
  AccountForm in 'AccountForm.pas' {Frame5: TFrame},
  AccouningForm in 'AccouningForm.pas' {Frame6: TFrame},
  ShopForm in 'ShopForm.pas' {Frame1: TFrame},
  SaleModule in 'SaleModule.pas',
  SupplyForm in 'SupplyForm.pas' {Frame7: TFrame},
  SupplyModule in 'SupplyModule.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
