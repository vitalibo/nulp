unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, jpeg, ExtCtrls, StdCtrls, DataModule,
  AccountModule, AdminForm, AccountForm, ShopForm, SupplyForm, AccouningForm;

type
  TForm1 = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    PageControl1: TPageControl;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Frame21: TFrame2;
    TabSheet1: TTabSheet;
    Frame51: TFrame5;
    Frame61: TFrame6;
    Frame11: TFrame1;
    Frame71: TFrame7;
    procedure SpeedButton4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Frame51Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Employee1: TEmployee;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Employee1 := TEmployee.Create;
  Form1.TabSheet1.TabVisible := False;
  Form1.TabSheet2.TabVisible := False;
  Form1.TabSheet3.TabVisible := False;
  Form1.TabSheet4.TabVisible := False;
  Form1.TabSheet5.TabVisible := False;
end;

procedure TForm1.Frame51Button3Click(Sender: TObject);
begin
  Frame51.Button3Click(Sender);

end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  Form1.OnCreate(nil);
  case Employee1.IsInLogin(Edit1.Text, Edit2.Text) of
    - 1:
      begin
        Form1.TabSheet1.TabVisible := True;
        Form1.TabSheet2.TabVisible := True;
        Form1.TabSheet3.TabVisible := True;
        Form1.TabSheet4.TabVisible := True;
        Form1.TabSheet5.TabVisible := True;
      end;
    1:
      begin
        Form1.TabSheet1.TabVisible := True;
        Form1.TabSheet3.TabVisible := True;
      end;
    2:
      begin
        Form1.TabSheet1.TabVisible := True;
        Form1.TabSheet2.TabVisible := True;
        Form1.TabSheet3.TabVisible := True;
        Form1.TabSheet4.TabVisible := True;
      end;
    3:
      begin
        Form1.TabSheet4.TabVisible := True;
        Form1.TabSheet5.TabVisible := True;
      end;
    0:
      MessageBox(Form1.Handle,
        'You have entered an invalid username or password', 'Error Message : ',
        MB_ICONWARNING or MB_OK);
  end;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  Form1.OnCreate(nil);
end;

end.
