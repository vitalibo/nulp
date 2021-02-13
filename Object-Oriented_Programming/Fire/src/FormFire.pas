unit FormFire;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Fire, StdCtrls, Math;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    procedure WMTimer(var Message: TMessage); message WM_TIMER;
  end;

var
  Form1: TForm1;
  Fire: TFire;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Fire.Pause(Form1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Fire.Size(-1);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Fire.Size(1);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Fire.Speed(Form1, -1);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Fire.Speed(Form1, 1);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Fire.Destroy;
  Fire := TFire.Create(Image1);
  Fire.Speed(Form1, 1);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  SetTimer(Form1.Handle, 2, 100, NIL);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Fire := TFire.Create(Image1);
  Fire.Speed(Form1, 1);
end;

procedure TForm1.WMTimer(var Message: TMessage);
begin
  Fire.Fire;
  if Message.WParam = 2 then
  begin
    Fire.fMax := EnsureRange(Fire.fMax - 20, 0, 255);
    Fire.fMin := EnsureRange(Fire.fMin - 20, 0, 255);
    if Fire.Size(-1) = True then
    begin
      KillTimer(Form1.Handle, 2);
      ExitProcess(0);
    end;
  end;
end;

end.
