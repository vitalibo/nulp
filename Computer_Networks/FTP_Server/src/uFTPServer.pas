unit uFTPServer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IdBaseComponent, IdComponent, IdTCPServer, IdCmdTCPServer, IdFTPList,
  IdExplicitTLSClientServerBase, IdFTPServer, StdCtrls, IdFTPListOutput,
  IdContext, IdCustomTCPServer, ComCtrls, Spin, ShellAPI, FileCtrl, ExtCtrls,
  Buttons, IdIntercept, IdLogBase, IdLogEvent, IdTCPConnection, IdTCPClient,
  IdFTP, IdLogDebug, IdUDPBase, IdUDPServer, IdSysLogServer,
  IdServerInterceptLogBase, IdServerInterceptLogEvent, IdLogStream, IdLogFile,
  Winsock, ImgList, IdUserAccounts, pngimage;

type
  TForm1 = class(TForm)
    IdFTPServer1: TIdFTPServer;
    Button1: TButton;
    StatusBar1: TStatusBar;
    TrayIcon1: TTrayIcon;
    SaveDialog1: TSaveDialog;
    IdServerInterceptLogEvent1: TIdServerInterceptLogEvent;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button6: TButton;
    TabSheet3: TTabSheet;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListBox1: TListBox;
    TabSheet4: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Edit3: TEdit;
    Edit4: TEdit;
    ListView2: TListView;
    Image2: TImage;
    Label3: TLabel;
    Edit5: TEdit;
    Button2: TButton;
    TabSheet2: TTabSheet;
    Image1: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    Splitter1: TSplitter;
    procedure IdFTPServer1UserLogin(ASender: TIdFTPServerContext;
      const AUsername, APassword: string; var AAuthenticated: Boolean);
    procedure IdFTPServer1RemoveDirectory(ASender: TIdFTPServerContext;
      var VDirectory: string);
    procedure IdFTPServer1MakeDirectory(ASender: TIdFTPServerContext;
      var VDirectory: string);
    procedure IdFTPServer1RetrieveFile(ASender: TIdFTPServerContext;
      const AFileName: string; var VStream: TStream);
    procedure IdFTPServer1GetFileSize(ASender: TIdFTPServerContext;
      const AFileName: string; var VFileSize: Int64);
    procedure IdFTPServer1StoreFile(ASender: TIdFTPServerContext;
      const AFileName: string; AAppend: Boolean; var VStream: TStream);
    procedure IdFTPServer1ListDirectory(ASender: TIdFTPServerContext;
      const APath: string; ADirectoryListing: TIdFTPListOutput;
      const ACmd, ASwitches: string);
    procedure FormCreate(Sender: TObject);
    procedure IdFTPServer1DeleteFile(ASender: TIdFTPServerContext;
      const APathName: string);
    procedure IdFTPServer1ChangeDirectory(ASender: TIdFTPServerContext;
      var VDirectory: string);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure IdServerInterceptLogEvent1LogString
      (ASender: TIdServerInterceptLogEvent; const AText: string);
    procedure ListBox1MouseActivate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    function ReplaceChars(APath: String): String;
    function GetSizeOfFile(AFile: String): Integer;
    procedure LoadUserList();
    function GetLineEle(s1, s2, s3: string): String;
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure OnControlWindow(var Msg: TMessage); message WM_SYSCOMMAND;
  end;

type
  User = record
    Name: String;
    Pass: String;
  end;

var
  Form1: TForm1;
  AppDir, UserFile: String;
  Users: array [0 .. 50] of User;
  user_online: Integer;

implementation

{$R *.DFM}

function TForm1.ReplaceChars(APath: String): String;
var
  s: string;
begin
  s := StringReplace(APath, '/', '\', [rfReplaceAll]);
  s := StringReplace(s, '\\', '\', [rfReplaceAll]);
  Result := s;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    ListBox1.Items.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  ListBox1.Items.Clear;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var
  F: TextFile;
  s: string;
  ListItem: TListItem;
  i: Integer;
begin
  AssignFile(F, UserFile);
  Rewrite(F);
  for i := 0 to ListView2.Items.Count - 1 do
  begin
    ListItem := ListView2.Items[i];
    s := '<user>' + ListItem.Caption + '</user>';
    s := s + '<password>' + ListItem.SubItems.Strings[0] + '</password>';
    Writeln(F, s);
  end;
  CloseFile(F);
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var
  ListItem: TListItem;
  i: Integer;
begin
  ListItem := ListView2.Items.Add;
  ListItem.Caption := Edit3.Text;
  ListItem.SubItems.Add(Edit4.Text);
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  if ListView2.SelCount > 0 then
    ListView2.Items.Delete(ListView2.Selected.Index);
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
var
  ListItem: TListItem;
begin
  if ListView2.Items.Count = 0 then
    Exit;
  if ListView2.SelCount = 0 then
    Exit;
  ListItem := ListView2.Selected;
  if Edit3.Text = '' then
    Edit3.Text := 'Anonymous';
  if Edit4.Text = '' then
    Edit4.Text := 'Guest';
  ListItem.Caption := Edit3.Text;
  ListItem.SubItems[0] := Edit4.Text;
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  ShowWindow(Handle, SW_SHOW);
  ShowWindow(Application.Handle, SW_SHOW);
end;

function TForm1.GetLineEle(s1, s2, s3: string): String;
var
  n1, n2: Integer;
begin
  n1 := pos(s2, s1);
  n2 := pos(s3, s1);
  n1 := n1 + length(s2);
  Result := copy(s1, n1, n2 - n1);
end;

function TForm1.GetSizeOfFile(AFile: String): Integer;
var
  FStream: TFileStream;
begin
  Try
    FStream := TFileStream.Create(AFile, fmOpenRead);
    Try
      Result := FStream.Size;
    Finally
      FreeAndNil(FStream);
    End;
  Except
    Result := 0;
  End;
end;

procedure TForm1.IdFTPServer1ChangeDirectory(ASender: TIdFTPServerContext;
  var VDirectory: string);
begin
  ASender.CurrentDir := VDirectory;
end;

procedure TForm1.IdFTPServer1DeleteFile(ASender: TIdFTPServerContext;
  const APathName: string);
begin
  DeleteFile(ReplaceChars(AppDir + ASender.CurrentDir + '\' + APathName));
end;

procedure TForm1.OnControlWindow(var Msg: TMessage);
begin
  if Msg.WParam = SC_MINIMIZE then
  begin
    TrayIcon1.Visible := True;
    ShowWindow(Handle, SW_HIDE);
    ShowWindow(Application.Handle, SW_HIDE);
  end
  else
    Inherited;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  PostMessage(Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
end;

procedure TForm1.Button2Click(Sender: TObject);
const
  WSVer = $101;
var
  wsaData: TWSAData;
  P: PHostEnt;
  Buf: array [0 .. 127] of Char;
begin
  Edit5.Text := '___.___.___.___';
  if WSAStartup(WSVer, wsaData) = 0 then
  begin
    if GetHostName(@Buf, 128) = 0 then
    begin
      P := GetHostByName(@Buf);
      if P <> nil then
        Edit5.Text := iNet_ntoa(PInAddr(P^.h_addr_list^)^);
    end;
    WSACleanup;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Button3.Enabled := False;
  Button4.Enabled := True;
  IdFTPServer1.Greeting.Text.Text := Edit1.Text;
  IdFTPServer1.MaxConnections := SpinEdit1.Value;
  AppDir := Edit2.Text;
  IdFTPServer1.Active := True;
  StatusBar1.Panels[0].Text := 'Запушений';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Button3.Enabled := True;
  Button4.Enabled := False;
  user_online := 0;
  StatusBar1.Panels[0].Text := 'Зупинений';
  StatusBar1.Panels[1].Text := 'Кількість коритувачів : 0';
  IdFTPServer1.Active := False;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  Dir: String;
begin
  Dir := '';
  if DirectoryExists(Edit2.Text) = True then
    Dir := Edit2.Text;
  if SelectDirectory('Виберіть дерикторію', '', Dir) then
    Edit2.Text := Dir;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit2.Text := ExtractFilePath(Application.Exename);
  Edit1.Text := IdFTPServer1.Greeting.Text.Text;
  UserFile := Edit2.Text + 'users.txt';
  LoadUserList;
  Button2Click(NIL);
end;

procedure TForm1.IdFTPServer1ListDirectory(ASender: TIdFTPServerContext;
  const APath: string; ADirectoryListing: TIdFTPListOutput;
  const ACmd, ASwitches: string);
var
  LFTPItem: TIdFTPListItem;
  SR: TSearchRec;
  SRI: Integer;
begin
  ADirectoryListing.DirFormat := doUnix;
  SRI := FindFirst(AppDir + APath + '\*.*', faAnyFile - faHidden - faSysFile,
    SR);
  While SRI = 0 do
  begin
    LFTPItem := ADirectoryListing.Add;
    LFTPItem.FileName := SR.Name;
    LFTPItem.Size := SR.Size;
    LFTPItem.ModifiedDate := FileDateToDateTime(SR.Time);
    if SR.Attr = faDirectory then
      LFTPItem.ItemType := ditDirectory
    else
      LFTPItem.ItemType := ditFile;
    SRI := FindNext(SR);
  end;
  FindClose(SR);
  SetCurrentDir(AppDir + APath + '\..');
end;

procedure TForm1.IdFTPServer1StoreFile(ASender: TIdFTPServerContext;
  const AFileName: string; AAppend: Boolean; var VStream: TStream);
begin
  if not AAppend then
    VStream := TFileStream.Create(ReplaceChars(AppDir + AFileName), fmCreate)
  else
    VStream := TFileStream.Create(ReplaceChars(AppDir + AFileName), fmOpenWrite)
end;

procedure TForm1.IdFTPServer1GetFileSize(ASender: TIdFTPServerContext;
  const AFileName: string; var VFileSize: Int64);
Var
  LFile: String;
begin
  LFile := ReplaceChars(AppDir + AFileName);
  try
    If FileExists(LFile) then
      VFileSize := GetSizeOfFile(LFile)
    else
      VFileSize := 0;
  except
    VFileSize := 0;
  end;
end;

procedure TForm1.IdFTPServer1RetrieveFile(ASender: TIdFTPServerContext;
  const AFileName: string; var VStream: TStream);
begin
  VStream := TFileStream.Create(ReplaceChars(AppDir + AFileName), fmOpenRead);
end;

procedure TForm1.IdFTPServer1MakeDirectory(ASender: TIdFTPServerContext;
  var VDirectory: string);
Var
  LDir: String;
begin
  LDir := ReplaceChars(AppDir + VDirectory);
  if not DirectoryExists(LDir) then
    if not CreateDir(LDir) then
      raise Exception.Create('Cannot create ' + LDir)
end;

procedure TForm1.IdFTPServer1RemoveDirectory(ASender: TIdFTPServerContext;
  var VDirectory: string);
Var
  LFile: String;
begin
  LFile := ReplaceChars(AppDir + VDirectory);
  if DirectoryExists(LFile) then
    RemoveDir(LFile)
  else
    Raise Exception.Create('Could not remove directory');
end;

procedure TForm1.IdFTPServer1UserLogin(ASender: TIdFTPServerContext;
  const AUsername, APassword: string; var AAuthenticated: Boolean);
var
  i: Integer;
  ListItem: TListItem;
begin
  AAuthenticated := False;
  for i := 0 to ListView2.Items.Count - 1 do
  begin
    ListItem := ListView2.Items[i];
    if (AUsername = ListItem.Caption) and
      (APassword = ListItem.SubItems.Strings[0]) then
      AAuthenticated := True;
  end;
end;

procedure TForm1.IdServerInterceptLogEvent1LogString
  (ASender: TIdServerInterceptLogEvent; const AText: string);
begin
  ListBox1.ItemIndex := ListBox1.Items.Add(AText);
  if pos(': 230', AText) > 0 then
    inc(user_online);
  if pos('QUIT<EOL>', AText) > 0 then
    dec(user_online);
  StatusBar1.Panels[1].Text := 'Кількість коритувачів : ' + IntToStr
    (user_online);
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  if pos('Recv', ListBox1.Items[index]) > 1 then
    ListBox1.Canvas.Font.Color := clRed
  else
    ListBox1.Canvas.Font.Color := clBlue;
  if odSelected in State then
  begin
    ListBox1.Canvas.Brush.Color := $00895F0A;
    ListBox1.Canvas.Font.Color := clWhite;
  end
  else
    ListBox1.Canvas.Brush.Color := clWindow;
  ListBox1.Canvas.FillRect(Rect);
  ListBox1.Canvas.TextOut(Rect.Left, Rect.Top, ListBox1.Items[index]);
end;

procedure TForm1.ListBox1MouseActivate(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
begin
  if ListBox1.ItemIndex > 0 then
    ListBox1.Hint := ListBox1.Items[ListBox1.ItemIndex];
end;

procedure TForm1.LoadUserList();
var
  F: TextFile;
  s: string;
  ListItem: TListItem;
  i: Integer;
begin
  AssignFile(F, UserFile);
  Reset(F);
  i := 0;
  while not EOF(F) do
  begin
    Readln(F, s);
    ListItem := ListView2.Items.Add;
    ListItem.Caption := GetLineEle(s, '<user>', '</user>');
    ListItem.SubItems.Add(GetLineEle(s, '<password>', '</password>'));
  end;
  CloseFile(F);
end;

end.
