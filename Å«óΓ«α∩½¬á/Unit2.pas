unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,MMSystem;

type
  TForm2 = class(TForm)
    head: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Timer1: TTimer;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    function ShowLevel:boolean;
    procedure ImgClick(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label3MouseEnter(Sender: TObject);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Label4MouseEnter(Sender: TObject);
    procedure Label4MouseLeave(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label5MouseEnter(Sender: TObject);
    procedure Label5MouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  b1,b2,r1,r2,g1,g2,y1,y2:TBitmap;
  MasClicks,MasRndClick:array of integer;
  Level,Rating:integer;
  Delay:integer = 1500;
  Clicks:integer = 0;
  l:integer = 0;
  GameOver:boolean = false;
  ShowNow:boolean = false;
implementation



{$R *.dfm}

procedure RndClicks;
begin
  ShowNow := true;
  Randomize;
  inc(Level);
  SetLength(MasRndClick,Level);
  MasRndClick[Level-1] := Random(4)+1;
  ShowNow := false;
end;

function isTrueClicks:boolean;
var i:integer;
begin
  for i := 0 to Clicks - 1 do
    if MasRndClick[i] <> MasClicks[i] then
    begin
      Result := false;
      exit;
    end;
  Result := true;  
end;

function PathProgram:string;
begin
  result := ExtractFIlePath(Application.ExeName)+'\';
end;

procedure TForm2.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form2.ImgClick(Sender);
end;

procedure TForm2.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Form2.ImgClick(Sender);
end;

procedure TForm2.Image3Click(Sender: TObject);
begin
Form2.ImgClick(Sender);
end;

procedure TForm2.Image4Click(Sender: TObject);
begin
Form2.ImgClick(Sender);
end;

procedure TForm2.ImgClick(Sender: TObject);
var i:integer;
begin
  if GameOver or ShowNow then
    exit;
  {if Clicks = Level then
  begin
    MessageBox(Form2.Handle,'Вы победили! Переходим к следующему уровню.','Ура!',MB_ICONINFORMATION);
    Clicks := 0;

    RndClicks;
    Form2.ShowLevel;
    exit;
  end;  }
    sndplaysound(PChar(PathProgram+'Click.wav'),SND_ASYNC);
    Application.ProcessMessages;
    case (Sender as TImage).Tag of
      1: Image1.Picture.Assign(b2);
      2: Image2.Picture.Assign(r2);
      3: Image3.Picture.Assign(g2);
      4: Image4.Picture.Assign(y2);
    end;
    Application.ProcessMessages;
        SetLength(MasClicks,Clicks+1);
  MasClicks[Clicks] := (Sender as TImage).Tag;
  if (Sender as TImage).Tag = MasRndClick[l] then
  begin
    inc(l);
    sleep(500);
    Application.ProcessMessages;
    case (Sender as TImage).Tag of
      1: Image1.Picture.Assign(b1);
      2: Image2.Picture.Assign(r1);
      3: Image3.Picture.Assign(g1);
      4: Image4.Picture.Assign(y1);
    end;
  if Level = l then
  begin
    sndplaysound(PChar(PathProgram+'Win.wav'),SND_ASYNC);
    l := 0;
    dec(Delay,50);
    inc(Clicks);
    inc(Rating,20);
    Label2.Caption := 'Очки: '+IntToStr(Rating);
    Label1.Caption := 'Уровень: '+IntToStr(Level+1);
    Application.ProcessMessages;
    sleep(600);
    Application.ProcessMessages;
    RndClicks;
    ShowLevel;
  end
  end else
  begin
    sndplaysound(PChar(PathProgram+'GameOver.wav'),SND_ASYNC);
    GameOver := true;
    Image1.Picture.Assign(b1);
    Image2.Picture.Assign(r1);
    Image3.Picture.Assign(g1);
    Image4.Picture.Assign(y1);
    if MessageDlg('Вы проиграли! Играть заново?',mtInformation,[mbYes,mbNo],0) = mrYes then
     begin
       l := 0;
       Level := 0;
       Clicks := 0;
       Rating := 0;
       Label2.Caption := 'Очки: 0';
       Label1.Caption := 'Уровень: 1';    
       GameOver := false;
       Application.ProcessMessages;
       sleep(600);
       Application.ProcessMessages;
       RndClicks;
       ShowLevel;
     end
     else
      Close;
    exit;
  end;
end;

procedure TForm2.Label3Click(Sender: TObject);
begin
  Image1.Visible := true;
  Image2.Visible := true;
  Image3.Visible := true;
  Image4.Visible := true;
  Label3.Visible := false;
  Label4.Visible := false;
  Label5.Visible := false;
  Application.ProcessMessages;
  sleep(400);
  Application.ProcessMessages;
  Label1.Caption := 'Уровень: '+IntToStr(Level+1);
  RndClicks;
  ShowLevel;
end;

procedure TForm2.Label3MouseEnter(Sender: TObject);
begin
  Label3.Font.Color := clRed;
  
end;

procedure TForm2.Label3MouseLeave(Sender: TObject);
begin
  Label3.Font.Color := clYellow;
end;

procedure TForm2.Label4Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.Label4MouseEnter(Sender: TObject);
begin
  Label4.Font.Color := clRed;
end;

procedure TForm2.Label4MouseLeave(Sender: TObject);
begin
  Label4.Font.Color := clYellow;
end;

procedure TForm2.Label5Click(Sender: TObject);
begin
  MessageBox(Handle,'Автор: Соколовский Вадим','О программе',MB_ICONINFORMATION);
end;

procedure TForm2.Label5MouseEnter(Sender: TObject);
begin
  Label5.Font.Color := clRed;
end;

procedure TForm2.Label5MouseLeave(Sender: TObject);
begin
  Label5.Font.Color := clYellow;
end;

function TForm2.ShowLevel:boolean;
var
  i,k: Integer;
begin
  ShowNow := true;
  for i := 0 to Level-1 do
  begin
    k := MasRndClick[i];
    Application.ProcessMessages;
    case k of
      1: Image1.Picture.Assign(b2);
      2: Image2.Picture.Assign(r2);
      3: Image3.Picture.Assign(g2);
      4: Image4.Picture.Assign(y2);
    end;
    Application.ProcessMessages;
    sleep(Delay div 2);
    Application.ProcessMessages;
    case k of
      1: Image1.Picture.Assign(b1);
      2: Image2.Picture.Assign(r1);
      3: Image3.Picture.Assign(g1);
      4: Image4.Picture.Assign(y1);
    end;
    Application.ProcessMessages;
    sleep(Delay div 2);
    Application.ProcessMessages;
  end;
  Result := true;
  ShowNow := false;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  b1 := TBitmap.Create;
  b2 := TBitmap.Create;
  r1 := TBitmap.Create;
  r2 := TBitmap.Create;
  g1 := TBitmap.Create;
  g2 := TBitmap.Create;
  y1 := TBitmap.Create;
  y2 := TBitmap.Create;
  b1.LoadFromFile(PathProgram+'\1-1.bmp');
  b2.LoadFromFile(PathProgram+'\1-2.bmp');
  r1.LoadFromFile(PathProgram+'\2-1.bmp');
  r2.LoadFromFile(PathProgram+'\2-2.bmp');
  g1.LoadFromFile(PathProgram+'\3-1.bmp');
  g2.LoadFromFile(PathProgram+'\3-2.bmp');
  y1.LoadFromFile(PathProgram+'\4-1.bmp');
  y2.LoadFromFile(PathProgram+'\4-2.bmp');
  Level := 0;
end;

end.
