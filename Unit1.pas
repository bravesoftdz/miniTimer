unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    lbl1: TLabel;
    scrlbr1: TScrollBar;
    edt1: TEdit;
    btn1: TButton;
    tmr1: TTimer;
    mmo1: TMemo;
    procedure scrlbr1Change(Sender: TObject);
    procedure lbl1DblClick(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbl1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure edt1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    mx: Integer;
    my: Integer;
    step: Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  h, m, s: integer;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    begin
      sl.Delimiter := ':';
      sl.DelimitedText := edt1.Text;
      h := StrToInt(sl[0]);
      m := strtoint(sl[1]);
      s := strtoint(sl[2]);
      tmr1.Enabled := True;
      scrlbr1.Visible := False;
      scrlbr1.Enabled := False;
      btn1.Visible := False;
      btn1.Enabled := False;
      edt1.Visible := False;
      edt1.Enabled := False;
            mmo1.Visible := False;
      mmo1.Enabled := False;
      lbl1.Font.Color := clLime;
    end;
  finally
    edt1.Text := '00:00:00';
  end;

  sl.Free;
end;

procedure TForm1.edt1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btn1Click(nil);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  TransparentColor := True;
  TransparentColorValue := Color;
  step := 0;
end;

procedure TForm1.lbl1DblClick(Sender: TObject);
begin
  scrlbr1.Visible := not scrlbr1.Visible;
  scrlbr1.Enabled := not scrlbr1.Enabled;
  btn1.Visible := not btn1.Visible;
  btn1.Enabled := not btn1.Enabled;
  edt1.Visible := not edt1.Visible;
  edt1.Enabled := not edt1.Enabled;
    mmo1.Visible := not mmo1.Visible;
  mmo1.Enabled := not mmo1.Enabled;
end;

procedure TForm1.lbl1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;

procedure TForm1.scrlbr1Change(Sender: TObject);
begin
  lbl1.Font.Size := scrlbr1.Position;
  scrlbr1.Height := 35;
  if ((lbl1.Height + scrlbr1.Height) > 75) then
  begin
    Height := lbl1.Height + scrlbr1.Height;
  end;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
begin
  s := s - round(tmr1.Interval / 1000);
  if s < 0 then
  begin
    s := 59;
    m := m - 1;
    if m < 0 then
    begin
      m := 59;
      h := h - 1;
      if h < 0 then
      begin
        h := 0;
        m := 0;
        s := 0;
        tmr1.Enabled := False;
        scrlbr1.Visible := True;
        scrlbr1.Enabled := True;
        btn1.Visible := True;
        btn1.Enabled := True;
        edt1.Visible := True;
        edt1.Enabled := True;
                mmo1.Visible := True;
        mmo1.Enabled := True;
      end;
    end;
  end;
  if h = 0 then
  begin
    if m < 5 then
      lbl1.Font.Color := clRed;
  end;
  lbl1.Caption := FormatFloat('00', h) + ':' + FormatFloat('00', m) + ':' + FormatFloat('00', s);
end;



end.
