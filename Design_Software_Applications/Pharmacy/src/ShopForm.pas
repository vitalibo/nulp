unit ShopForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, SaleModule;

type
  TFrame1 = class(TFrame)
    Label1: TLabel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    ListBox1: TListBox;
    GroupBox1: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label7: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ListBox2: TListBox;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Edit9: TEdit;
    constructor Create(AOwner: TComponent); override;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

var
  Products1: TProducts;

{$R *.dfm}

procedure TFrame1.Button1Click(Sender: TObject);
var
  Drug: TRProduct;
  i: Integer;
begin
  Drug.Name := Edit2.Text;
  Drug.Company := Edit3.Text;
  Drug.Count := StrToInt(Edit4.Text);
  Drug.Price := Edit5.Text;
  Drug.Date := DateToStr(DateTimePicker1.Date);
  Drug.Description := '';
  for i := 0 to Memo1.Lines.Count do
    Drug.Description := Drug.Description + Memo1.Lines.Strings[i];
  Products1.CreateProduct(Drug);
  Products1.GetListProduct;
  ListBox1.Items.Clear;
  while not Products1.EofProducts do
    ListBox1.Items.Add(Products1.GetNextProduct);
end;

procedure TFrame1.Button2Click(Sender: TObject);
begin
  if Application.MessageBox('Ви дійсно бажаєте видалити користувача',
    'Message :', MB_OKCANCEL) = 1 then
  begin
    Products1.RemoveProduct(Products1.GetIDProduct(ListBox1.ItemIndex));
    Products1.GetListProduct;
    ListBox1.Items.Clear;
    while not Products1.EofProducts do
      ListBox1.Items.Add(Products1.GetNextProduct);
  end;
end;

procedure TFrame1.Button3Click(Sender: TObject);
var
  Drug: TRProduct;
  i: Integer;
begin
  if Application.MessageBox('Ви дійсно бажаєте змінити інформацію?',
    'Message :', MB_OKCANCEL) = 1 then
  begin
    Drug.Name := Edit2.Text;
    Drug.Company := Edit3.Text;
    Drug.Count := StrToInt(Edit4.Text);
    Drug.Price := Edit5.Text;
    Drug.Date := DateToStr(DateTimePicker1.Date);
    Drug.Description := '';
    for i := 0 to Memo1.Lines.Count do
      Drug.Description := Drug.Description + Memo1.Lines.Strings[i];
    Products1.UpdateProduct(Drug, Products1.GetIDProduct(ListBox1.ItemIndex));
    Products1.GetListProduct;
    ListBox1.Items.Clear;
    while not Products1.EofProducts do
      ListBox1.Items.Add(Products1.GetNextProduct);
  end;
end;

procedure TFrame1.Button4Click(Sender: TObject);
var
  Drug: TRProduct;
begin

end;

constructor TFrame1.Create(AOwner: TComponent);
begin
  inherited;
  Products1 := TProducts.Create;
  Products1.GetListProduct;
  ListBox1.Items.Clear;
  while not Products1.EofProducts do
    ListBox1.Items.Add(Products1.GetNextProduct);
end;

procedure TFrame1.ListBox1Click(Sender: TObject);
var
  Drug: TRProduct;
begin
  Drug := Products1.GetProduct(Products1.GetIDProduct(ListBox1.ItemIndex));
  Edit2.Text := Drug.Name;
  Edit3.Text := Drug.Company;
  Edit4.Text := IntToStr(Drug.Count);
  Edit5.Text := Drug.Price;
  DateTimePicker1.Date := StrToDate(Drug.Date);
  Memo1.Lines.Clear;
  Memo1.Lines.Add(Drug.Description);
end;

procedure TFrame1.SpeedButton1Click(Sender: TObject);
begin
  Products1.FindProduct(Edit1.Text);
  ListBox1.Items.Clear;
  while not Products1.EofProducts do
    ListBox1.Items.Add(Products1.GetNextProduct);
end;

end.
