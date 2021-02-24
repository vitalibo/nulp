unit AccountForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DataModule, AccountModule;

type
  TFrame5 = class(TFrame)
    ListBox1: TListBox;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit2: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    constructor Create(AOwner: TComponent); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

var
  Employee1: TEmployee;

{$R *.dfm}

procedure TFrame5.Button1Click(Sender: TObject);
var
  User: TRContact;
begin
  if (MessageBox(Application.Handle, 'Do you really want to create a new user?', 'Message',MB_OKCANCEL or MB_ICONASTERISK)=1) then
  begin
    User.Login := Edit2.Text;
    User.Password := Edit3.Text;
    User.Post := ComboBox1.ItemIndex;
    User.SerialNumber := Edit4.Text;
    User.Passport := Edit5.Text;
    User.Name := Edit6.Text;
    User.Surname := Edit7.Text;
    User.Patronymic := Edit8.Text;
    User.Address := Edit9.Text;
    User.Phone := Edit10.Text;
    Employee1.CreateEmployee(User);
    Employee1.GetListEmployee;
    ListBox1.Items.Clear;
    while not Employee1.EofEmployee do
      ListBox1.Items.Add(Employee1.GetNextEmployee);
  end;
end;

procedure TFrame5.Button2Click(Sender: TObject);
begin
  if Application.MessageBox('Ви дійсно бажаєте видалити користувача',
    'Message :', MB_OKCANCEL) = 1 then
  begin
    Employee1.RemoveEmployee(Employee1.GetIDEmployee(ListBox1.ItemIndex));
    Employee1.GetListEmployee;
    ListBox1.Items.Clear;
    while not Employee1.EofEmployee do
      ListBox1.Items.Add(Employee1.GetNextEmployee);
  end;
end;

procedure TFrame5.Button3Click(Sender: TObject);
var
  User: TRContact;
begin
  if Application.MessageBox('You are sure?',
    'Message :', MB_OKCANCEL) = 1 then
  begin
    User.Login := Edit2.Text;
    User.Password := Edit3.Text;
    User.Post := ComboBox1.ItemIndex;
    User.SerialNumber := Edit4.Text;
    User.Passport := Edit5.Text;
    User.Name := Edit6.Text;
    User.Surname := Edit7.Text;
    User.Patronymic := Edit8.Text;
    User.Address := Edit9.Text;
    User.Phone := Edit10.Text;
    Employee1.UpdateEmployee(User, Employee1.GetIDEmployee(ListBox1.ItemIndex));
    Employee1.GetListEmployee;
    ListBox1.Items.Clear;
    while not Employee1.EofEmployee do
      ListBox1.Items.Add(Employee1.GetNextEmployee);
  end;
end;

constructor TFrame5.Create;
begin
  inherited;
  Employee1 := TEmployee.Create;
  Employee1.GetListEmployee;
  ListBox1.Items.Clear;
  while not Employee1.EofEmployee do
    ListBox1.Items.Add(Employee1.GetNextEmployee);
end;

procedure TFrame5.ListBox1Click(Sender: TObject);
var
  User: TRContact;
begin
  User := Employee1.GetEmployee(Employee1.GetIDEmployee(ListBox1.ItemIndex));
  Edit2.Text := User.Login;
  Edit3.Text := User.Password;
  ComboBox1.ItemIndex := User.Post;
  Edit4.Text := User.SerialNumber;
  Edit5.Text := User.Passport;
  Edit6.Text := User.Name;
  Edit7.Text := User.Surname;
  Edit8.Text := User.Patronymic;
  Edit9.Text := User.Address;
  Edit10.Text := User.Phone;
end;

procedure TFrame5.SpeedButton1Click(Sender: TObject);
begin
  Employee1.FindEmployee(Edit1.Text);
  ListBox1.Items.Clear;
  while not Employee1.EofEmployee do
    ListBox1.Items.Add(Employee1.GetNextEmployee);
end;

end.
