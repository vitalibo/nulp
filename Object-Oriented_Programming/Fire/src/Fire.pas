unit Fire;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Math;

const
  width = 120;
  height = 200;

type
  TFire = class(TObject)
  private
    fImage: TImage;
    fBuf: TStream;
    fFPLeft, fFPRight: Integer;
    fSpeed: Integer;
    fVPalette: array [0 .. 255] of Integer;
    fVBitmap: array [0 .. width * height] of Integer;
    procedure CreateVPalette;
    procedure DrawFire;
    procedure LoadFromVirtualToStream;
    procedure RandNFire;
  public
    fMax, fMin: Integer;
    constructor Create(Image: TImage);
    procedure Fire;
    procedure Pause(Form: TForm);
    function Size(m: Integer): Boolean;
    procedure Speed(Form: TForm; m: Integer);
  end;

implementation

{ TFire }

constructor TFire.Create(Image: TImage);
begin
  inherited Create;
  fImage := Image;
  fImage.Picture.Bitmap.SetSize(width, height);
  fBuf := TMemoryStream.Create;
  fImage.Picture.Bitmap.SaveToStream(fBuf);
  CreateVPalette;
  Randomize;
  fSpeed := 100;
  fMax := 255;
  fMin := 100;
  fFPLeft := width div 3;
  fFPRight := width - width div 3;
end;

procedure TFire.CreateVPalette;
var
  i: Integer;
begin
  for i := 0 to 63 do
  begin
    fVPalette[i] := RGB(0, 0, i * 4);
    fVPalette[i + 64] := RGB(0, i * 4, 255);
    fVPalette[i + 128] := RGB(i * 4, 255, 255);
    fVPalette[i + 192] := RGB(255, 255, 255);
  end;
end;

procedure TFire.DrawFire;
var
  i, v: Integer;
begin
  for i := width + 2 to width * height - 2 do
  begin
    v := fVBitmap[i - 1] + fVBitmap[i - 2] + fVBitmap[i + 1] + fVBitmap[i + 2]
      + fVBitmap[i - width] * 5;
    v := v div 9;
    v := EnsureRange(v, 0, 255);
    fVBitmap[i] := v;
  end;
end;

procedure TFire.Fire;
var
  i: Integer;
begin
  for i := 0 to 5 do
  begin
    RandNFire;
    DrawFire;
    LoadFromVirtualToStream;
    fBuf.Seek(0, 0);
    fImage.Picture.Bitmap.LoadFromStream(fBuf);
  end;
end;

procedure TFire.LoadFromVirtualToStream;
var
  i: Integer;
begin
  fBuf.Seek(-width * height * 4 - 4, 2);
  for i := 0 to width * height do
  begin
    fBuf.Write(fVPalette[fVBitmap[i]], 4);
  end;
end;

procedure TFire.Pause(Form: TForm);
begin
  KillTimer(Form.Handle, 1);
  MessageBox(Form.Handle, 'Please press key...', 'Pausa', MB_OK);
  SetTimer(Form.Handle, 1, fSpeed, NIL);
end;

procedure TFire.RandNFire;
var
  i: Integer;
begin
  for i := 0 to width do
  begin
    if (i > fFPLeft) and (i < fFPRight) then
      fVBitmap[i] := Random(fMax - fMin) + fMin
    else
      fVBitmap[i] := 0;
  end;
end;

function TFire.Size(m: Integer): Boolean;
begin
  fFPLeft := fFPLeft - 1 * m;
  fFPRight := fFPRight + 1 * m;
  fFPLeft := EnsureRange(fFPLeft, 0, width div 2);
  fFPRight := EnsureRange(fFPRight, width div 2, width);
  if fFPLeft = fFPRight then
    Result := True
  else
    Result := False;

end;

procedure TFire.Speed(Form: TForm; m: Integer);
begin
  KillTimer(Form.Handle, 1);
  fSpeed := fSpeed + 5 * m;
  SetTimer(Form.Handle, 1, fSpeed, NIL);
end;

end.
