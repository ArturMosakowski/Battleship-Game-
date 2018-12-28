unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    MainMenu1: TMainMenu;
    Plik1: TMenuItem;
    NowaGra1: TMenuItem;
    Zakoncz1: TMenuItem;
    Image4: TImage;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edycja1: TMenuItem;
    Stawiajstatkiodnowa1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    Label43: TLabel;
    Label44: TLabel;
    Shape3: TShape;
    Shape4: TShape;
    Label45: TLabel;
    Label46: TLabel;
    Shape5: TShape;
    Shape6: TShape;
    Label47: TLabel;
    Label48: TLabel;
    Info1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Zakoncz1Click(Sender: TObject);
    procedure NowaGra1Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Stawiajstatkiodnowa1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Info1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
{********************  KLASA STATEK  ******************************************}
type
  TStatek = class
    maszty  : Byte;
  end;
{********************  KLASA PLANSZA  *****************************************}
type
  TPlansza = class(TStatek)
      Procedure UstawStatekKompa();
      Procedure UstawStatekGracza(X1,Y1,Ktory,Pozycja : Byte);
      Procedure Dookola(ktory : Byte);
      Procedure CzyscEkran(ktory : Byte);
      Procedure PokazSiatke(ktora : byte);
      procedure NaniesNaPlansze(ktora : Byte);
  end;
{********************  KLASA GRA  *********************************************}
type
  TGra = class(TPlansza)
    tmp : Byte;
      Procedure NowaGra();
      Procedure StrzalGracza(X,Y : Byte);
      Procedure StrzalKompa();
      Procedure Skosy(X,Y :Byte);
  end;
var
  Form1: TForm1;
  PozX, PozY : Byte;  //pozycja myszy przy stawianiu statku
  PGracza    : Byte;  //punkty gracza
  PKompa     : Byte;  //punkty komputera
  k          : Byte;  //numer statku przy stawianiu statkow przez gracza
  s          : Byte;  //zmienna wykorzystywana przy strzelaniu komputera
implementation

uses Unit2;

{$R *.dfm}
{==============================================================================}
{********************  USTAWIANIE STATKOW KOMPUTERA  **************************}
{==============================================================================}
Procedure TPlansza.UstawStatekKompa();
var
  Poz     : Byte;  //losowa pozycja (pion/poziom) przy stawianiu statkow przez komputer
  X, Y    : Byte;  //wspolrzedne X i Y na planszy
  tmp     : Byte;  //zmienna tymczasowa
  i,j,k,l : Byte;  //iteracje
  licz    : Byte;  //licznik (zmienna tymczasowa)
  stop    : Byte;  //warunek stopu przy ustawianiu statkow
begin
  Randomize();
  tmp:=0;
  Poz:=Random(2);
  stop:=0;
  While (tmp=0) and (stop<200) do
  begin
    X:=Random(10);
    Y:=Random(10);
{******************** USTAWIANIE STATKU POZIOMO *******************************}
    if Poz=0 then
    begin
      licz:=0;
      if X>10-maszty then tmp:=0;
      if X<=10-maszty then
        for i:=0 to maszty-1 do
        begin
          if (Form1.Image2.Canvas.Pixels[X+i,Y]=clBlack) or
             (Form1.Image2.Canvas.Pixels[X+i,Y]=clRed) then
             begin
               licz:=licz+0;
               inc(stop);
             end;
          if (Form1.Image2.Canvas.Pixels[X+i,Y]<>clBlack) and
             (Form1.Image2.Canvas.Pixels[X+i,Y]<>clRed) then
             begin
               licz:=licz+1;
               inc(stop);
             end;
        end;
      if licz<maszty then tmp:=0;
      if licz=maszty then
      begin
        for j:=0 to maszty-1 do
          Form1.Image2.Canvas.Pixels[X+j,Y]:=clBlack;
      tmp:=1;
      inc(stop)
      end;
    end;
{******************** USTAWIANIE STATKU PIONOWO *******************************}
    if Poz=1 then
    begin
      licz:=0;
      if Y>10-maszty then tmp:=0;
      if Y<=10-maszty then
      begin
        for k:=0 to maszty-1 do
        begin
          if (Form1.Image2.Canvas.Pixels[X,Y+k]=clBlack) or
             (Form1.Image2.Canvas.Pixels[X,Y+k]=clRed) then
             begin
               licz:=licz+0;
               inc(stop);
             end;
          if (Form1.Image2.Canvas.Pixels[X,Y+k]<>clBlack) and
             (Form1.Image2.Canvas.Pixels[X,Y+k]<>clRed) then
             begin
               licz:=licz+1;
               inc(stop);
             end;
        end;
      if licz<maszty then tmp:=0;
      if licz=maszty then
      begin
        for l:=0 to maszty-1 do
          Form1.Image2.Canvas.Pixels[X,Y+l]:=clBlack;
        tmp:=1;
        inc(stop);
      end;
      end;
    end;
  end;
end;
{==============================================================================}
{********************  USTAWIANIE STATKOW GRACZA  *****************************}
{==============================================================================}
Procedure TPlansza.UstawStatekGracza(X1,Y1,Ktory,Pozycja : Byte);
var
  licz : Byte;  //licznik (zmienna tymczasowa)
  i, j : Byte;  //iteracje
  tab  : array[1..12] of Byte;  //tablica ile poszczegolne statki maja masztow
begin
  tab[1]:=5;
  tab[2]:=4;
  tab[3]:=4;
  tab[4]:=3;
  tab[5]:=3;
  tab[6]:=2;
  tab[7]:=2;
  tab[8]:=2;
  tab[9]:=1;
  tab[10]:=1;
  tab[11]:=1;
  tab[12]:=1;
  if Pozycja=1 then
  begin
    licz:=0;
    for i:=0 to tab[ktory]-1 do
    begin
      if Form1.Image4.Canvas.Pixels[X1+i,Y1]=clWhite then
        licz:=licz+1;
    end;
    if licz=tab[ktory] then
    begin
      k:=k+1;
      for j:=0 to tab[ktory]-1 do
        Form1.Image4.Canvas.Pixels[X1+j,Y1]:=clBlack;
    end;
  end;
  if Pozycja=2 then
  begin
    licz:=0;
    for i:=0 to tab[ktory]-1 do
    begin
      if Form1.Image4.Canvas.Pixels[X1,Y1+i]=clWhite then
        licz:=licz+1;
    end;
    if licz=tab[ktory] then
    begin
      k:=k+1;
      for j:=0 to tab[ktory]-1 do
        Form1.Image4.Canvas.Pixels[X1,Y1+j]:=clBlack;
    end;
  end;

end;
{==============================================================================}
{********************  NANIESIENIE STATKOW NA PLANSZE  ************************}
{==============================================================================}
Procedure TPlansza.NaniesNaPlansze(ktora : Byte);
var
  i, j : Byte; //iteracje
begin
  if ktora=1 then
  begin
    for i:=0 to 9 do
    begin
      for j:=0 to 9 do
      begin
        if Form1.Image4.Canvas.Pixels[i,j]=clBlack then
        begin
          Form1.Image1.Canvas.Pen.Color:=clLime;
          Form1.Image1.Canvas.Brush.Color:=clLime;
          Form1.Image1.Canvas.Rectangle(i*20+1,j*20+1,i*20+19,j*20+19);
          Form1.Image3.Canvas.Pen.Color:=clWhite;
          Form1.Image3.Canvas.Brush.Color:=clWhite;
        end;
        if Form1.Image4.Canvas.Pixels[i,j]=clRed then
        begin
          Form1.Image1.Canvas.Pen.Color:=clRed;
          Form1.Image1.Canvas.MoveTo(i*20+5,j*20+5);
          Form1.Image1.Canvas.LineTo(i*20+16,j*20+16);
          Form1.Image1.Canvas.MoveTo(i*20+5,j*20+15);
          Form1.Image1.Canvas.LineTo(i*20+16,j*20+4);
          Form1.Image3.Canvas.Pen.Color:=clWhite;
          Form1.Image3.Canvas.Brush.Color:=clWhite;
        end;
      end;
    end;
  end;

  if ktora=2 then
  begin
    for i:=0 to 9 do
    begin
      for j:=0 to 9 do
      begin
        if Form1.Image2.Canvas.Pixels[i,j]=clBlack then
        begin
          Form1.Image3.Canvas.Pen.Color:=clLime;
          Form1.Image3.Canvas.Brush.Color:=clLime;
          Form1.Image3.Canvas.Rectangle(i*20+1,j*20+1,i*20+19,j*20+19);
          Form1.Image3.Canvas.Pen.Color:=clWhite;
          Form1.Image3.Canvas.Brush.Color:=clWhite;
        end;
      end;
    end;
  end;

  if ktora=3 then
  begin
    for i:=0 to 9 do
    begin
      for j:=0 to 9 do
      begin
        if Form1.Image4.Canvas.Pixels[i,j]=clBlack then
        begin
          Form1.Image1.Canvas.Pen.Color:=clLime;
          Form1.Image1.Canvas.Brush.Color:=clLime;
          Form1.Image1.Canvas.Rectangle(i*20+1,j*20+1,i*20+19,j*20+19);
          Form1.Image1.Canvas.Pen.Color:=clWhite;
          Form1.Image1.Canvas.Brush.Color:=clWhite;
        end;
      end;
    end;
  end;

  if ktora=4 then
  begin
    for i:=0 to 9 do
    begin
      for j:=0 to 9 do
      begin
        if Form1.Image4.Canvas.Pixels[i,j]=clBlack then
        begin
          Form1.Image1.Canvas.Pen.Color:=clLime;
          Form1.Image1.Canvas.Brush.Color:=clLime;
          Form1.Image1.Canvas.Rectangle(i*20+1,j*20+1,i*20+19,j*20+19);
          Form1.Image1.Canvas.Pen.Color:=clWhite;
          Form1.Image1.Canvas.Brush.Color:=clWhite;
        end;
        if Form1.Image4.Canvas.Pixels[i,j]=clBlue then
        begin
          Form1.Image1.Canvas.Pen.Color:=clRed;
          Form1.Image1.Canvas.Brush.Color:=clRed;
          Form1.Image1.Canvas.Rectangle(i*20+1,j*20+1,i*20+19,j*20+19);
          Form1.Image1.Canvas.Pen.Color:=clWhite;
          Form1.Image1.Canvas.Brush.Color:=clWhite;
        end;
        if Form1.Image4.Canvas.Pixels[i,j]=clYellow then
        begin
          Form1.Image1.Canvas.Pen.Color:=clRed;
          Form1.Image1.Canvas.Brush.Color:=clRed;
          Form1.Image1.Canvas.Rectangle(i*20+1,j*20+1,i*20+19,j*20+19);
          Form1.Image1.Canvas.Pen.Color:=clWhite;
          Form1.Image1.Canvas.Brush.Color:=clWhite;
        end;
        if Form1.Image4.Canvas.Pixels[i,j]=clRed then
        begin
          Form1.Image1.Canvas.Pen.Color:=clRed;
          Form1.Image1.Canvas.MoveTo(i*20+5,j*20+5);
          Form1.Image1.Canvas.LineTo(i*20+16,j*20+16);
          Form1.Image1.Canvas.MoveTo(i*20+5,j*20+15);
          Form1.Image1.Canvas.LineTo(i*20+16,j*20+4);
          Form1.Image1.Canvas.Pen.Color:=clWhite;
          Form1.Image1.Canvas.Brush.Color:=clWhite;
        end;
      end;
    end;
  end;
end;
{==============================================================================}
{********************  ZAZNACZENIE POL DOOKOLA DANEGO STATKU  *****************}
{==============================================================================}
Procedure TPlansza.Dookola(ktory : Byte);
var
  i, j : Byte;  //iteracje
begin
if ktory=2 then
begin
  for i:=0 to 9 do
  begin
    for j:=0 to 9 do
    begin
      if (form1.Image2.Canvas.Pixels[i,j]=clBlack) then
         begin
           if (form1.Image2.Canvas.Pixels[i-1,j-1]=clWhite) then
             form1.Image2.Canvas.Pixels[i-1,j-1]:=clRed;
           if (form1.Image2.Canvas.Pixels[i,j-1]=clWhite) then
             form1.Image2.Canvas.Pixels[i,j-1]:=clRed;
           if (form1.Image2.Canvas.Pixels[i+1,j-1]=clWhite) then
             form1.Image2.Canvas.Pixels[i+1,j-1]:=clRed;
           if (form1.Image2.Canvas.Pixels[i-1,j]=clWhite) then
             form1.Image2.Canvas.Pixels[i-1,j]:=clRed;
           if (form1.Image2.Canvas.Pixels[i+1,j]=clWhite) then
             form1.Image2.Canvas.Pixels[i+1,j]:=clRed;
           if (form1.Image2.Canvas.Pixels[i-1,j+1]=clWhite) then
             form1.Image2.Canvas.Pixels[i-1,j+1]:=clRed;
           if (form1.Image2.Canvas.Pixels[i,j+1]=clWhite) then
             form1.Image2.Canvas.Pixels[i,j+1]:=clRed;
           if (form1.Image2.Canvas.Pixels[i+1,j+1]=clWhite) then
             form1.Image2.Canvas.Pixels[i+1,j+1]:=clRed;
         end;
    end;
  end;
end;
if ktory=1 then
begin
  for i:=0 to 9 do
  begin
    for j:=0 to 9 do
    begin
      if (form1.Image4.Canvas.Pixels[i,j]=clBlack) then
         begin
           if (form1.Image4.Canvas.Pixels[i-1,j-1]=clWhite) then
             form1.Image4.Canvas.Pixels[i-1,j-1]:=clRed;
           if (form1.Image4.Canvas.Pixels[i,j-1]=clWhite) then
             form1.Image4.Canvas.Pixels[i,j-1]:=clRed;
           if (form1.Image4.Canvas.Pixels[i+1,j-1]=clWhite) then
             form1.Image4.Canvas.Pixels[i+1,j-1]:=clRed;
           if (form1.Image4.Canvas.Pixels[i-1,j]=clWhite) then
             form1.Image4.Canvas.Pixels[i-1,j]:=clRed;
           if (form1.Image4.Canvas.Pixels[i+1,j]=clWhite) then
             form1.Image4.Canvas.Pixels[i+1,j]:=clRed;
           if (form1.Image4.Canvas.Pixels[i-1,j+1]=clWhite) then
             form1.Image4.Canvas.Pixels[i-1,j+1]:=clRed;
           if (form1.Image4.Canvas.Pixels[i,j+1]=clWhite) then
             form1.Image4.Canvas.Pixels[i,j+1]:=clRed;
           if (form1.Image4.Canvas.Pixels[i+1,j+1]=clWhite) then
             form1.Image4.Canvas.Pixels[i+1,j+1]:=clRed;
         end;
    end;
  end;
end;
end;
{==============================================================================}
{********************  CZYSZCZENIE PLANSZY GRACZA / KOMPUTERA  ****************}
{==============================================================================}
Procedure TPlansza.CzyscEkran(ktory : Byte);
begin
  if ktory=1 then
  begin
    Form1.Image1.Canvas.Brush.Color:=clWhite;
    Form1.Image1.Canvas.Pen.Color:=clWhite;
    Form1.Image1.Canvas.Rectangle(-1,-1,201,201);
    Form1.Image4.Canvas.Rectangle(-1,-1,11,11);
  end;
  if ktory=2 then
  begin
    Form1.Image1.Canvas.Brush.Color:=clWhite;
    Form1.Image1.Canvas.Pen.Color:=clWhite;
    Form1.Image2.Canvas.Rectangle(-1,-1,11,11);
    Form1.Image3.Canvas.Rectangle(-1,-1,201,201);
  end;
  if ktory=3 then
  begin
    Form1.Image1.Canvas.Brush.Color:=clWhite;
    Form1.Image1.Canvas.Pen.Color:=clWhite;
    Form1.Image1.Canvas.Rectangle(-1,-1,201,201);
  end;
end;
{==============================================================================}
{**************  NANIESIENIE SIATKI NA PLANSZE GRACZA / KOMPUTERA  ************}
{==============================================================================}
Procedure TPlansza.PokazSiatke(ktora : Byte);
var
  i, j : Byte;  //iteracje
begin
  if ktora=1 then
  begin
    for i:=0 to 9 do
    begin
      for j:=0 to 9 do
      begin
        Form1.Image1.Canvas.Pen.Color:=clSkyBlue;
        Form1.Image1.Canvas.Rectangle(i*20,j*20,i*20+20,j*20+20);
        Form1.Image1.Canvas.Pen.Color:=clWhite;
      end;
    end;
  end;
  if ktora=2 then
  begin
    for i:=0 to 9 do
    begin
      for j:=0 to 9 do
      begin
        Form1.Image3.Canvas.Pen.Color:=clSkyBlue;
        Form1.Image3.Canvas.Rectangle(i*20,j*20,i*20+20,j*20+20);
        Form1.Image3.Canvas.Pen.Color:=clWhite;
      end;
    end;
  end;
end;
{==============================================================================}
{********************  WYSTARTOWANIE NOWEJ GRY  *******************************}
{==============================================================================}
Procedure TGra.NowaGra();
begin
  CzyscEkran(2);
  PokazSiatke(2);
  maszty:=5;
  UstawStatekKompa();
  Dookola(2);
  maszty:=4;
  UstawStatekKompa();
  Dookola(2);
  maszty:=4;
  UstawStatekKompa();
  Dookola(2);
  maszty:=3;
  UstawStatekKompa();
  Dookola(2);
  maszty:=3;
  UstawStatekKompa();
  Dookola(2);
  maszty:=2;
  UstawStatekKompa();
  Dookola(2);
  maszty:=2;
  UstawStatekKompa();
  Dookola(2);
  maszty:=2;
  UstawStatekKompa();
  Dookola(2);
  maszty:=1;
  UstawStatekKompa();
  Dookola(2);
  maszty:=1;
  UstawStatekKompa();
  Dookola(2);
  maszty:=1;
  UstawStatekKompa();
  Dookola(2);
  maszty:=1;
  UstawStatekKompa();
  Dookola(2);

  CzyscEkran(1);
  PokazSiatke(1);
  k:=1;
  Form1.Label43.Visible:=False;
  Form1.Label44.Visible:=False;
  PKompa:=0;
  PGracza:=0;
  s:=0;
end;
{==============================================================================}
{********************  STRZAL GRACZA W PLANSZE KOMPUTERA  *********************}
{==============================================================================}
Procedure TGra.StrzalGracza(X,Y : Byte);
begin
if (Form1.Label1.Caption='Strzelaj') and (Form1.Label44.Visible=False) and
   (Form1.Label43.Visible=False) and
   (Form1.Image3.Canvas.Pixels[X*20+10,Y*20+10]=clWhite) then
begin
  if (Form1.Image2.Canvas.Pixels[X,Y]=clBlack) and (PGracza<29) then
  begin
    Form1.Image3.Canvas.Pen.Color:=clLime;
    Form1.Image3.Canvas.Brush.Color:=clLime;
    Form1.Image3.Canvas.Rectangle(X*20+1,Y*20+1,X*20+19,Y*20+19);
    Form1.Image3.Canvas.Pen.Color:=clWhite;
    Form1.Image3.Canvas.Brush.Color:=clWhite;
    inc(PGracza);
    StrzalKompa();
  end;
  if  (Form1.Image3.Canvas.Pixels[X*20+10,Y*20+10]=clWhite) and (PGracza<29) then
     begin
       Form1.Image3.Canvas.Pen.Color:=clRed;
       Form1.Image3.Canvas.MoveTo(X*20+5,Y*20+5);
       Form1.Image3.Canvas.LineTo(X*20+16,Y*20+16);
       Form1.Image3.Canvas.MoveTo(X*20+5,Y*20+15);
       Form1.Image3.Canvas.LineTo(X*20+16,Y*20+4);
       Form1.Image3.Canvas.Pen.Color:=clWhite;
       Form1.Image3.Canvas.Brush.Color:=clWhite;
       StrzalKompa();
     end;
     if PGracza=29 then Form1.Label43.Visible:=True;
end;
end;
{==============================================================================}
{********************  OZNACZENIE "SKOSOW" OD PUNKTU(X,Y)  ********************}
{==============================================================================}
Procedure TGra.Skosy(X,Y : Byte);
begin
  if Form1.Image4.Canvas.Pixels[X-1,Y-1]=clWhite then
    Form1.Image4.Canvas.Pixels[X-1,Y-1]:=clSilver;
  if Form1.Image4.Canvas.Pixels[X-1,Y+1]=clWhite then
    Form1.Image4.Canvas.Pixels[X-1,Y+1]:=clSilver;
  if Form1.Image4.Canvas.Pixels[X+1,Y-1]=clWhite then
    Form1.Image4.Canvas.Pixels[X+1,Y-1]:=clSilver;
  if Form1.Image4.Canvas.Pixels[X+1,Y+1]=clWhite then
    Form1.Image4.Canvas.Pixels[X+1,Y+1]:=clSilver;
end;
{==============================================================================}
{********************  STRZAL KOMPUTERA W PLANSZE GRACZA  *********************}
{==============================================================================}
Procedure TGra.StrzalKompa();
var
  X, Y : Byte;  //pozycja X i Y na planszy
  i, j : Byte;  //iteracje
  ruch : Byte;  //zmienna wskazujaca czy strzal zostal zuzyty
begin
  if PKompa=29 then
  begin
    Form1.Label44.Visible:=True;
    ruch:=5;
  end;
  ruch:=0;
  tmp:=0;
  if (s=0) and (ruch=0) then
  begin
    while tmp=0 do
    begin
      X:=Random(10);
      Y:=Random(10);
      if Form1.Image4.Canvas.Pixels[X,Y]=clWhite then
      begin
        Form1.Image1.Canvas.Pen.Color:=clRed;
        Form1.Image1.Canvas.MoveTo(X*20+5,Y*20+5);
        Form1.Image1.Canvas.LineTo(X*20+16,Y*20+16);
        Form1.Image1.Canvas.MoveTo(X*20+5,Y*20+15);
        Form1.Image1.Canvas.LineTo(X*20+16,Y*20+4);
        Form1.Image3.Canvas.Pen.Color:=clWhite;
        Form1.Image3.Canvas.Brush.Color:=clWhite;
        Form1.Image4.Canvas.Pixels[X,Y]:=clRed;
        tmp:=1;
      end;
      if Form1.Image4.Canvas.Pixels[X,Y]=clSilver then
        tmp:=0;
      if Form1.Image4.Canvas.Pixels[X,Y]=clYellow then
        tmp:=0;
      if Form1.Image4.Canvas.Pixels[X,Y]=clBlue then
        tmp:=0;
      if Form1.Image4.Canvas.Pixels[X,Y]=clBlack then
      begin
        Form1.Image1.Canvas.Pen.Color:=clRed;
        Form1.Image1.Canvas.Brush.Color:=clRed;
        Form1.Image1.Canvas.Rectangle(X*20+1,Y*20+1,X*20+19,Y*20+19);
        Form1.Image3.Canvas.Pen.Color:=clWhite;
        Form1.Image3.Canvas.Brush.Color:=clWhite;
        Form1.Image4.Canvas.Pixels[X,Y]:=clYellow;
        tmp:=1;
        s:=1;
        ruch:=1;
        inc(PKompa);
      end;
    end;
  end;
  if (s=1) and (ruch=0) then
  begin
    for i:=0 to 9 do
    begin
      for j:=0 to 9 do
      begin
        if Form1.Image4.Canvas.Pixels[i,j]=clYellow then
        begin
          X:=i;
          Y:=j;
          ruch:=1;
        end;
      end;
    end;
   if (Form1.Image4.Canvas.Pixels[X-1,Y]=clWhite) or
      (Form1.Image4.Canvas.Pixels[X-1,Y]=clBlack) and (ruch=1) then
      begin
        if (Form1.Image4.Canvas.Pixels[X-1,Y]=clWhite) then
          Form1.Image4.Canvas.Pixels[X-1,Y]:=clRed;
        if (Form1.Image4.Canvas.Pixels[X-1,Y]=clBlack) then
        begin
          Form1.Image4.Canvas.Pixels[X-1,Y]:=clYellow;
          Form1.Image4.Canvas.Pixels[X,Y]:=clBlue;
          inc(PKompa);
        end;
        Skosy(X,Y);
        NaniesNaPlansze(4);
        ruch:=2;
      end;

    if (ruch=1) and
       ((Form1.Image4.Canvas.Pixels[X,Y+1]=clWhite) or
       (Form1.Image4.Canvas.Pixels[X,Y+1]=clBlack)) then
      begin
        if (Form1.Image4.Canvas.Pixels[X,Y+1]=clWhite) then
          Form1.Image4.Canvas.Pixels[X,Y+1]:=clRed;
        if (Form1.Image4.Canvas.Pixels[X,Y+1]=clBlack) then
        begin
          Form1.Image4.Canvas.Pixels[X,Y+1]:=clYellow;
          Form1.Image4.Canvas.Pixels[X,Y]:=clBlue;
          inc(PKompa);
        end;
        Skosy(X,Y);
        NaniesNaPlansze(4);
        ruch:=2;
      end;
   if (ruch=1) and
      ((Form1.Image4.Canvas.Pixels[X+1,Y]=clWhite) or
      (Form1.Image4.Canvas.Pixels[X+1,Y]=clBlack))then
      begin
        if (Form1.Image4.Canvas.Pixels[X+1,Y]=clWhite) then
          Form1.Image4.Canvas.Pixels[X+1,Y]:=clRed;
        if (Form1.Image4.Canvas.Pixels[X+1,Y]=clBlack) then
        begin
          Form1.Image4.Canvas.Pixels[X+1,Y]:=clYellow;
          Form1.Image4.Canvas.Pixels[X,Y]:=clBlue;
          inc(PKompa);
        end;
        Skosy(X,Y);
        NaniesNaPlansze(4);
        ruch:=2;
      end;
    if (ruch=1) and
       ((Form1.Image4.Canvas.Pixels[X,Y-1]=clWhite) or
       (Form1.Image4.Canvas.Pixels[X,Y-1]=clBlack)) then
      begin
        if (Form1.Image4.Canvas.Pixels[X,Y-1]=clWhite) then
          Form1.Image4.Canvas.Pixels[X,Y-1]:=clRed;
        if (Form1.Image4.Canvas.Pixels[X,Y-1]=clBlack) then
        begin
          Form1.Image4.Canvas.Pixels[X,Y-1]:=clYellow;
          Form1.Image4.Canvas.Pixels[X,Y]:=clBlue;
          inc(PKompa);
        end;
        Skosy(X,Y);
        NaniesNaPlansze(4);
        ruch:=2;
      end;
     if (ruch=1) and
        (Form1.Image4.Canvas.Pixels[X-1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X+1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y-1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y+1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X+1,Y]<>clBlue) and
        (Form1.Image4.Canvas.Pixels[X,Y-1]<>clBlue) then
        begin
        Form1.Image4.Canvas.Pixels[X,Y]:=clBlue;
        s:=0;
        ruch:=0;
        if (s=0) and (ruch=0) then
        begin
          while tmp=0 do
            begin
              X:=Random(10);
              Y:=Random(10);
             if Form1.Image4.Canvas.Pixels[X,Y]=clWhite then
             begin
               Form1.Image1.Canvas.Pen.Color:=clRed;
               Form1.Image1.Canvas.MoveTo(X*20+5,Y*20+5);
               Form1.Image1.Canvas.LineTo(X*20+16,Y*20+16);
               Form1.Image1.Canvas.MoveTo(X*20+5,Y*20+15);
               Form1.Image1.Canvas.LineTo(X*20+16,Y*20+4);
               Form1.Image3.Canvas.Pen.Color:=clWhite;
               Form1.Image3.Canvas.Brush.Color:=clWhite;
               Form1.Image4.Canvas.Pixels[X,Y]:=clRed;
               tmp:=1;
             end;
      if Form1.Image4.Canvas.Pixels[X,Y]=clSilver then
        tmp:=0;
      if Form1.Image4.Canvas.Pixels[X,Y]=clYellow then
        tmp:=0;
      if Form1.Image4.Canvas.Pixels[X,Y]=clBlue then
        tmp:=0;
      if Form1.Image4.Canvas.Pixels[X,Y]=clBlack then
      begin
        Form1.Image1.Canvas.Pen.Color:=clRed;
        Form1.Image1.Canvas.Brush.Color:=clRed;
        Form1.Image1.Canvas.Rectangle(X*20+1,Y*20+1,X*20+19,Y*20+19);
        Form1.Image3.Canvas.Pen.Color:=clWhite;
        Form1.Image3.Canvas.Brush.Color:=clWhite;
        Form1.Image4.Canvas.Pixels[X,Y]:=clYellow;
        tmp:=1;
        s:=1;
        ruch:=2;
        inc(PKompa);
      end;
    end;
  end;
  end;
     if (ruch=1) and
        (Form1.Image4.Canvas.Pixels[X-1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X+1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y-1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y+1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X+1,Y]=clBlue) then
        begin
          Form1.Image4.Canvas.Pixels[X,Y]:=clBlue;
          Form1.Image4.Canvas.Pixels[X+1,Y]:=clYellow;
        end;
   if (ruch=1) and
      ((Form1.Image4.Canvas.Pixels[X+2,Y]=clWhite) or
      (Form1.Image4.Canvas.Pixels[X+2,Y]=clBlack)) and
      (Form1.Image4.Canvas.Pixels[X,Y-1]<>clBlue)then
      begin
        if (Form1.Image4.Canvas.Pixels[X+2,Y]=clWhite) then
          Form1.Image4.Canvas.Pixels[X+2,Y]:=clRed;
        if (Form1.Image4.Canvas.Pixels[X+2,Y]=clBlack) then
        begin
          Form1.Image4.Canvas.Pixels[X+2,Y]:=clYellow;
          Form1.Image4.Canvas.Pixels[X+1,Y]:=clBlue;
          inc(PKompa);
        end;
        Skosy(X,Y);
        NaniesNaPlansze(4);
        ruch:=2;
      end;

     if (ruch=1) and
        (Form1.Image4.Canvas.Pixels[X-1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X+1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y-1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y+1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X+2,Y]=clBlue) and
        (Form1.Image4.Canvas.Pixels[X,Y]=clBlue)then
        begin
          Form1.Image4.Canvas.Pixels[X+1,Y]:=clBlue;
          Form1.Image4.Canvas.Pixels[X+2,Y]:=clYellow;
        end;
   if (ruch=1) and
      ((Form1.Image4.Canvas.Pixels[X+3,Y]=clWhite) or
      (Form1.Image4.Canvas.Pixels[X+3,Y]=clBlack)) and
      (Form1.Image4.Canvas.Pixels[X,Y-1]<>clBlue)then
      begin
        if (Form1.Image4.Canvas.Pixels[X+3,Y]=clWhite) then
          Form1.Image4.Canvas.Pixels[X+3,Y]:=clRed;
        if (Form1.Image4.Canvas.Pixels[X+3,Y]=clBlack) then
        begin
          Form1.Image4.Canvas.Pixels[X+3,Y]:=clYellow;
          Form1.Image4.Canvas.Pixels[X+2,Y]:=clBlue;
          inc(PKompa);
        end;
        Skosy(X,Y);
        NaniesNaPlansze(4);
        ruch:=2;
      end;
     if (ruch=1) and
        (Form1.Image4.Canvas.Pixels[X-1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X+1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y-1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y+1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X+3,Y]=clBlue) and
        (Form1.Image4.Canvas.Pixels[X+1,Y]=clBlue)then
        begin
          Form1.Image4.Canvas.Pixels[X+2,Y]:=clBlue;
          Form1.Image4.Canvas.Pixels[X+3,Y]:=clYellow;
        end;
   if (ruch=1) and
      ((Form1.Image4.Canvas.Pixels[X+4,Y]=clWhite) or
      (Form1.Image4.Canvas.Pixels[X+4,Y]=clBlack)) and
      (Form1.Image4.Canvas.Pixels[X,Y-1]<>clBlue)then
      begin
        if (Form1.Image4.Canvas.Pixels[X+4,Y]=clWhite) then
          Form1.Image4.Canvas.Pixels[X+4,Y]:=clRed;
        if (Form1.Image4.Canvas.Pixels[X+4,Y]=clBlack) then
        begin
          Form1.Image4.Canvas.Pixels[X+4,Y]:=clYellow;
          Form1.Image4.Canvas.Pixels[X+3,Y]:=clBlue;
          inc(PKompa);
        end;
        Skosy(X,Y);
        NaniesNaPlansze(4);
        ruch:=2;
      end;

      if (ruch=1) and
        (Form1.Image4.Canvas.Pixels[X-1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X+1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y-1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y+1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y-1]=clBlue) then
        begin
          Form1.Image4.Canvas.Pixels[X,Y]:=clBlue;
          Form1.Image4.Canvas.Pixels[X,Y-1]:=clYellow;
        end;
    if (ruch=1) and
       ((Form1.Image4.Canvas.Pixels[X,Y]=clWhite) or
       (Form1.Image4.Canvas.Pixels[X,Y]=clBlack)) and
       (Form1.Image4.Canvas.Pixels[X+1,Y]<>clBlue) then
      begin
        if (Form1.Image4.Canvas.Pixels[X,Y]=clWhite) then
          Form1.Image4.Canvas.Pixels[X,Y]:=clRed;
        if (Form1.Image4.Canvas.Pixels[X,Y]=clBlack) then
        begin
          Form1.Image4.Canvas.Pixels[X,Y]:=clYellow;
          Form1.Image4.Canvas.Pixels[X,Y+1]:=clBlue;
          inc(PKompa);
        end;
        Skosy(X,Y);
        NaniesNaPlansze(4);
        ruch:=2;
      end;
      if (ruch=1) and
        (Form1.Image4.Canvas.Pixels[X-1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X+1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y-1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y+1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y-2]=clBlue) and
        (Form1.Image4.Canvas.Pixels[X,Y]=clBlue) then
        begin
          Form1.Image4.Canvas.Pixels[X,Y-1]:=clBlue;
          Form1.Image4.Canvas.Pixels[X,Y-2]:=clYellow;
        end;
    if (ruch=1) and
       ((Form1.Image4.Canvas.Pixels[X,Y-1]=clWhite) or
       (Form1.Image4.Canvas.Pixels[X,Y-1]=clBlack)) and
       (Form1.Image4.Canvas.Pixels[X+1,Y]<>clBlue) then
      begin
        if (Form1.Image4.Canvas.Pixels[X,Y-1]=clWhite) then
          Form1.Image4.Canvas.Pixels[X,Y-1]:=clRed;
        if (Form1.Image4.Canvas.Pixels[X,Y-1]=clBlack) then
        begin
          Form1.Image4.Canvas.Pixels[X,Y-1]:=clYellow;
          Form1.Image4.Canvas.Pixels[X,Y]:=clBlue;
          inc(PKompa);
        end;
        Skosy(X,Y);
        NaniesNaPlansze(4);
        ruch:=2;
      end;
      if (ruch=1) and
        (Form1.Image4.Canvas.Pixels[X-1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X+1,Y]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y-1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y+1]<>clWhite) and
        (Form1.Image4.Canvas.Pixels[X,Y-3]=clBlue) and
        (Form1.Image4.Canvas.Pixels[X,Y-1]=clBlue) then
        begin
          Form1.Image4.Canvas.Pixels[X,Y-2]:=clBlue;
          Form1.Image4.Canvas.Pixels[X,Y-3]:=clYellow;
        end;
    if (ruch=1) and
       ((Form1.Image4.Canvas.Pixels[X,Y-2]=clWhite) or
       (Form1.Image4.Canvas.Pixels[X,Y-2]=clBlack)) and
       (Form1.Image4.Canvas.Pixels[X+1,Y]<>clBlue) then
      begin
        if (Form1.Image4.Canvas.Pixels[X,Y-2]=clWhite) then
          Form1.Image4.Canvas.Pixels[X,Y-2]:=clRed;
        if (Form1.Image4.Canvas.Pixels[X,Y-2]=clBlack) then
        begin
          Form1.Image4.Canvas.Pixels[X,Y-2]:=clYellow;
          Form1.Image4.Canvas.Pixels[X,Y-1]:=clBlue;
          inc(PKompa);
        end;
        Skosy(X,Y);
        NaniesNaPlansze(4);
        ruch:=2;
      end;

  end;
    if PKompa=29 then
  begin
    Form1.Label44.Visible:=True;
    ruch:=5;
  end;
end;
{==============================================================================}
{********************  PROCEDURY OBSLUGUJACE PRZYCISKI I POZOSTALE  ***********}
{==============================================================================}
procedure TForm1.FormCreate(Sender: TObject);
var
  w : TGra;
begin
  w := TGra.Create;
  Form1.Image2.Canvas.Rectangle(-1,-1,11,11);
  w.PokazSiatke(1);
  Form1.Image3.Canvas.Rectangle(-1,-1,201,201);
  Form1.Image4.Canvas.Rectangle(-2,-2,12,12);
  w.PokazSiatke(2);
  Form1.Label1.Caption:=' ';
  Form1.Label2.Caption:=' ';
  Form1.GroupBox1.Visible := False;
  Form1.Width:=503;
  PGracza:=0;
  PKompa:=0;
  s:=0;
end;
procedure TForm1.Zakoncz1Click(Sender: TObject);
begin
  Close();
end;
procedure TForm1.NowaGra1Click(Sender: TObject);
var
  w:TGra;
begin
  w:=TGra.Create;
  w.NowaGra();
  Form1.Label2.Caption := 'Ustaw statki';
  Form1.GroupBox1.Visible := True;
  Form1.Timer1.Enabled := True;
  Form1.Label1.Caption :='';
end;
{==============================================================================}
{***************  POKAZUJE JAKI MAMY NASTEPNY STATEK DO POSTAWINIA  ***********}
{==============================================================================}
Procedure PokazJakiStatekStawiam(poz, i : Byte);
begin
  if poz=1 then
  begin
      Form1.Image1.Canvas.Pen.Color:=clBlack;
      Form1.Image1.Canvas.Brush.Color:=clYellow;
      Form1.Image1.Canvas.Rectangle(PozX+i*20-10,PozY-10,PozX+i*20+10,PozY+10);
      Form1.Image1.Canvas.Pen.Color:=clWhite;
      Form1.Image1.Canvas.Brush.Color:=clWhite;
  end;
  if poz=2 then
  begin
      Form1.Image1.Canvas.Pen.Color:=clBlack;
      Form1.Image1.Canvas.Brush.Color:=clYellow;
      Form1.Image1.Canvas.Rectangle(PozX-10,PozY+i*20-10,PozX+10,PozY+i*20+10);
      Form1.Image1.Canvas.Pen.Color:=clWhite;
      Form1.Image1.Canvas.Brush.Color:=clWhite;
  end;
end;
procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  w      : TGra;
  i      : byte; //iteracja
begin
  w:=TGra.Create;
  PozX:=X;
  PozY:=Y;
  if Form1.RadioButton1.Checked=True then
  begin
  if k=1 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 4 do
    begin
      PokazJakiStatekStawiam(1,i);
    end;
  end;
  if k=2 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 3 do
    begin
      PokazJakiStatekStawiam(1,i);
    end;
  end;
  if k=3 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 3 do
    begin
      PokazJakiStatekStawiam(1,i);
    end;
  end;
  if k=4 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 2 do
    begin
      PokazJakiStatekStawiam(1,i);
    end;
  end;
  if k=5 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 2 do
    begin
      PokazJakiStatekStawiam(1,i);
    end;
  end;
  if k=6 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 1 do
    begin
      PokazJakiStatekStawiam(1,i);
    end;
  end;
  if k=7 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 1 do
    begin
      PokazJakiStatekStawiam(1,i);
    end;
  end;
  if k=8 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 1 do
    begin
      PokazJakiStatekStawiam(1,i);
    end;
  end;
  if k=9 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 0 do
    begin
      PokazJakiStatekStawiam(1,i);
    end;
  end;
  if k=10 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 0 do
    begin
      PokazJakiStatekStawiam(1,i);
    end;
  end;
  if k=11 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 0 do
    begin
      PokazJakiStatekStawiam(1,i);
    end;
  end;
  if k=12 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 0 do
    begin
      PokazJakiStatekStawiam(1,i);
    end;
  end;
  if k>12 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(4);
    Form1.GroupBox1.Visible:=False;
    Form1.Timer2.Enabled:=True;
  end;
  end;
  if Form1.RadioButton2.Checked=True then
  begin
  if k=1 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 4 do
    begin
      PokazJakiStatekStawiam(2,i);
    end;
  end;
  if k=2 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 3 do
    begin
      PokazJakiStatekStawiam(2,i);
    end;
  end;
  if k=3 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 3 do
    begin
      PokazJakiStatekStawiam(2,i);
    end;
  end;
  if k=4 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 2 do
    begin
      PokazJakiStatekStawiam(2,i);
    end;
  end;
  if k=5 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 2 do
    begin
      PokazJakiStatekStawiam(2,i);
    end;
  end;
  if k=6 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 1 do
    begin
      PokazJakiStatekStawiam(2,i);
    end;
  end;
  if k=7 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 1 do
    begin
      PokazJakiStatekStawiam(2,i);
    end;
  end;
  if k=8 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 1 do
    begin
      PokazJakiStatekStawiam(2,i);
    end;
  end;
  if k=9 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 0 do
    begin
      PokazJakiStatekStawiam(2,i);
    end;
  end;
  if k=10 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 0 do
    begin
      PokazJakiStatekStawiam(2,i);
    end;
  end;
  if k=11 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 0 do
    begin
      PokazJakiStatekStawiam(2,i);
    end;
  end;
  if k=12 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(1);
    for i:=0 to 0 do
    begin
      PokazJakiStatekStawiam(2,i);
    end;
  end;
  if k>12 then
  begin
    w.CzyscEkran(3);
    w.PokazSiatke(1);
    w.NaniesNaPlansze(4);
    Form1.GroupBox1.Visible:=False;
    Form1.Timer2.Enabled:=True;
  end;
  end;
end;
procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  w    : TGra;
  Poz  : Byte;  //pozycja (1 - poziom, 2 - pion)
  i, j : Byte;  //iteracje
begin
  w:=tgra.Create;
    X:=X div 20;
    Y:=Y div 20;
    if Form1.RadioButton1.Checked=True then
    begin
      Poz:=1;
    end;
    if Form1.RadioButton2.Checked=True then
    begin
      Poz:=2;
    end;
  if k<=12 then
  begin
    w.UstawStatekGracza(X,Y,k,Poz);
    w.Dookola(1);
    w.NaniesNaPlansze(1);
  end;
  if k>12 then
  begin
    Form1.Label2.Caption:='Twoje statki';
    Form1.Label1.Caption:='Strzelaj';
    w.CzyscEkran(3);
    w.NaniesNaPlansze(3);
    Form1.GroupBox1.Visible:=False;
    for i:=0 to 9 do
    begin
      for j:=0 to 9 do
      begin
        if Form1.Image4.Canvas.Pixels[i,j]=clRed then
          Form1.Image4.Canvas.Pixels[i,j] := clWhite;
      end;
    end;
  end;
end;
{==============================================================================}
{********************  INICJOWANIE STAWIANIA STATKOW OD NOWA   ****************}
{==============================================================================}
procedure TForm1.Stawiajstatkiodnowa1Click(Sender: TObject);
var
  w    : TGra;
  i, j : Byte;  //iteracje
  licz : Byte;  //licznik (zmienna tymczasowa)
begin
  licz :=0;
  for i:=0 to 9 do
  begin
    for j:=0 to 9 do
    begin
      if Form1.Image3.Canvas.Pixels[i*20+10,j*20+10] <> clWhite then
        inc(licz);
    end
  end;
  if licz=0 then
  begin
    w:=TGra.Create;
    w.CzyscEkran(1);
    w.PokazSiatke(1);
    k:=1;
    Form1.Label2.Caption:='Ustaw statki';
    Form1.Label1.Caption:=' ';
    Form1.Timer1.Enabled:=True;
    Form1.GroupBox1.Visible:=True;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if form1.Width >= 596 then timer1.Enabled := false else
  form1.Width := form1.Width + 4;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  if form1.Width <= 503 then timer2.Enabled := false else
  form1.Width := form1.Width - 4;
end;

procedure TForm1.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  w:TGra;
begin
  w:=TGra.Create;
  X:=X div 20;
  Y:=Y div 20;
  w.StrzalGracza(X,Y);
  Form1.Label47.Caption:=IntToStr(29-PKompa);
  Form1.Label48.Caption:=IntToStr(29-PGracza);
end;

procedure TForm1.Info1Click(Sender: TObject);
begin
    Form2.Visible := True;
end;

end.
