program ProjectFire;

uses
  Forms,
  FormFire in 'FormFire.pas' {Form1},
  Fire in 'Fire.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
