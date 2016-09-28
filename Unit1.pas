unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, Unit2;

const
  MAX_COLOR = 6;
  MAX_GOLYO = 4; //Golyók száma
  MAX_TIPS  = 8; //Tippelések száma
  KORPOSITION_LEFT = 20;
  KORPOSITION_TOP = 75;
  KORPOSITION2_LEFT = 111;
  KORPOSITION2_TOP = 16;
  KORPOSITION3_LEFT = 300;
  KORMAGASSAG = 40;
  KORSZELESSEG = 40;
  KORMAGASSAG2 = 20;
  KORSZELESSEG2 = 20;
type
  TTip = array[1..MAX_GOLYO] of Integer;
  TMasterMind = record
    Code :array[1..MAX_GOLYO] of Integer;
    Tips :array[1..MAX_GOLYO,1..MAX_TIPS] of Integer;
    Count:Integer;
    Eredmeny:array[1..MAX_GOLYO,1..MAX_TIPS] of Integer;
    EredmenyNovekvo:array[1..MAX_GOLYO,1..MAX_TIPS] of Integer;
//    MouseX, MouseY:Integer;
//    KorX, KorY:Integer;
    KorTippek:Integer;
    KorTips: array[1..MAX_GOLYO] of Integer;
//    KorBoolen: array[1..MAX_COLOR] of Boolean;
  end;
  TForm1 = class(TForm)
    bNewTip: TButton;
    Kor1: TImage;
    Hatter: TImage;
    Torol: TButton;
    Kor2: TImage;
    Kor3: TImage;
    Kor4: TImage;
    Kor5: TImage;
    Kor6: TImage;
    Golyo1: TImage;
    Golyo2: TImage;
    Golyo3: TImage;
    Golyo4: TImage;
    Tip11: TImage;
    Tip12: TImage;
    Tip13: TImage;
    Tip14: TImage;
    Tip21: TImage;
    Tip22: TImage;
    Tip23: TImage;
    Tip24: TImage;
    Tip31: TImage;
    Tip32: TImage;
    Tip33: TImage;
    Tip34: TImage;
    Tip41: TImage;
    Tip42: TImage;
    Tip43: TImage;
    Tip44: TImage;
    Tip51: TImage;
    Tip52: TImage;
    Tip53: TImage;
    Tip54: TImage;
    Tip61: TImage;
    Tip62: TImage;
    Tip63: TImage;
    Tip64: TImage;
    Tip71: TImage;
    Tip72: TImage;
    Tip73: TImage;
    Tip74: TImage;
    Tip81: TImage;
    Tip82: TImage;
    Tip83: TImage;
    Tip84: TImage;
    iEredmeny11: TImage;
    iEredmeny12: TImage;
    iEredmeny13: TImage;
    iEredmeny14: TImage;
    iEredmeny21: TImage;
    iEredmeny22: TImage;
    iEredmeny23: TImage;
    iEredmeny24: TImage;
    iEredmeny31: TImage;
    iEredmeny32: TImage;
    iEredmeny33: TImage;
    iEredmeny34: TImage;
    iEredmeny41: TImage;
    iEredmeny42: TImage;
    iEredmeny43: TImage;
    iEredmeny44: TImage;
    iEredmeny51: TImage;
    iEredmeny52: TImage;
    iEredmeny53: TImage;
    iEredmeny54: TImage;
    iEredmeny61: TImage;
    iEredmeny62: TImage;
    iEredmeny63: TImage;
    iEredmeny64: TImage;
    Felad: TButton;
    iEredmeny71: TImage;
    iEredmeny72: TImage;
    iEredmeny73: TImage;
    iEredmeny74: TImage;
    iEredmeny81: TImage;
    iEredmeny82: TImage;
    iEredmeny83: TImage;
    iEredmeny84: TImage;
    procedure bNewTipClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Kor1Click(Sender: TObject);
    procedure TorolClick(Sender: TObject);
    procedure Kor2Click(Sender: TObject);
    procedure Kor3Click(Sender: TObject);
    procedure Kor4Click(Sender: TObject);
    procedure Kor5Click(Sender: TObject);
    procedure Kor6Click(Sender: TObject);
    procedure FeladClick(Sender: TObject);
    procedure Golyo1Click(Sender: TObject);
    procedure Golyo2Click(Sender: TObject);
    procedure Golyo3Click(Sender: TObject);
    procedure Golyo4Click(Sender: TObject);
   private
    procedure TorolMM(var MM:TMasterMind);
    procedure Kiertekeles(var MM:TMasterMind);
    procedure KorTorol(var MM:TMasterMind);
    procedure UjTip(var MM:TMasterMind; KorSzin:Integer);
    procedure KorKeres(var MM:TMasterMind;KorSzin2:Integer;Kep:TImage);
    procedure UjtippIras(var MM:TMasterMind; Tipp: Integer);
    procedure EredmenyNov(var MM:TMasterMind);
    procedure EredmenyMegjelenit(var MM:TMasterMind);
    procedure EredmenyMegjelenitKepcsere(var MM:TMasterMind; Kep: TImage; Szin: Integer);
    procedure TorolKep(var MM:TMasterMind);
    procedure KepPozicio(var MM:TMasterMind);
    procedure Vege(MM:TMasterMind; Felad: Boolean);

    { Private declarations }
  public
    procedure Ujkod(var MM:TMasterMind);
    { Public declarations }
  end;

var
  Form1: TForm1;
  Mm1:  TMasterMind;

implementation

{$R *.dfm}
{$R bmp-k.res}
{ TForm1 }

procedure TForm1.Ujkod(var MM: TMasterMind);
var
  i:Integer;
begin
  TorolMM(MM);
  for i:=1 to MAX_GOLYO do
  begin
    MM.Code[i] := Trunc(1+Random(MAX_COLOR));
  end;
end;


procedure TForm1.TorolMM(var MM: TMasterMind);
var
  i,j:Integer;
begin
  for i:=1 to MAX_GOLYO do
  begin
    for j:=1 to MAX_TIPS do
    begin
      MM.Tips[i,j] := 0;
      MM.Eredmeny[i,j] := 0;
    end;
    MM.Code[i] := 0;
  end;
  MM.Count := 0;
  TorolKep(MM1);
end;


procedure TForm1.bNewTipClick(Sender: TObject);
var
  Tip:TTip;
  i,talalat:Integer;
begin
  MM1.Count := MM1.Count+1;
  If MM1.Count=1 then
  begin
    Tip11.Picture := Golyo1.Picture;
    Tip12.Picture := Golyo2.Picture;
    Tip13.Picture := Golyo3.Picture;
    Tip14.Picture := Golyo4.Picture;
    UjtippIras(MM1,1);
  end
  else If MM1.Count=2 then
  begin
    Tip21.Picture := Golyo1.Picture;
    Tip22.Picture := Golyo2.Picture;
    Tip23.Picture := Golyo3.Picture;
    Tip24.Picture := Golyo4.Picture;
    UjtippIras(MM1,2);
  end
  else If MM1.Count=3 then
  begin
    Tip31.Picture := Golyo1.Picture;
    Tip32.Picture := Golyo2.Picture;
    Tip33.Picture := Golyo3.Picture;
    Tip34.Picture := Golyo4.Picture;
    UjtippIras(MM1,3);
  end
  else If MM1.Count=4 then
  begin
    Tip41.Picture := Golyo1.Picture;
    Tip42.Picture := Golyo2.Picture;
    Tip43.Picture := Golyo3.Picture;
    Tip44.Picture := Golyo4.Picture;
    UjtippIras(MM1,4);
  end
  else If MM1.Count=5 then
  begin
    Tip51.Picture := Golyo1.Picture;
    Tip52.Picture := Golyo2.Picture;
    Tip53.Picture := Golyo3.Picture;
    Tip54.Picture := Golyo4.Picture;
    UjtippIras(MM1,5);
  end
  else If MM1.Count=6 then
  begin
    Tip61.Picture := Golyo1.Picture;
    Tip62.Picture := Golyo2.Picture;
    Tip63.Picture := Golyo3.Picture;
    Tip64.Picture := Golyo4.Picture;
    UjtippIras(MM1,6);
  end
  else If MM1.Count=7 then
  begin
    Tip71.Picture := Golyo1.Picture;
    Tip72.Picture := Golyo2.Picture;
    Tip73.Picture := Golyo3.Picture;
    Tip74.Picture := Golyo4.Picture;
    UjtippIras(MM1,7);
  end
  else If MM1.Count=8 then
  begin
    Tip81.Picture := Golyo1.Picture;
    Tip82.Picture := Golyo2.Picture;
    Tip83.Picture := Golyo3.Picture;
    Tip84.Picture := Golyo4.Picture;
    UjtippIras(MM1,8);
  end;
  KorTorol(MM1);
  Kiertekeles(MM1);
  EredmenyNov(MM1);
  EredmenyMegjelenit(MM1);


  talalat := 0;
  for i:=1 to MAX_GOLYO do
  begin
    If MM1.EredmenyNovekvo[i,MM1.Count]=2 then talalat := talalat+1;
  end;
  If talalat=MAX_GOLYO then  Vege(MM1,false)
  else If MM1.Count=MAX_TIPS then Vege(MM1,true);
end;

procedure TForm1.UjtippIras(var MM: TMasterMind; Tipp: Integer);
var
  i:Integer;
begin
  for i:=1 to MAX_GOLYO do
  begin
    MM.Tips[i,Tipp] := MM.KorTips[i];
  end;
end;

procedure TForm1.Kiertekeles(var MM: TMasterMind);
var
  i,j:Integer;
  xtip, xcode:array[1..MAX_GOLYO] of Boolean;
begin
  for i:=1 to MAX_GOLYO do
  begin
    xtip[i]:=true;
    xcode[i]:=true;
  end;

  for i:=1 to MAX_GOLYO do        //Jó szín, jó helyen
  begin
    If MM.Tips[i,MM.Count]=MM.Code[i] then
    begin
      MM.Eredmeny[i,MM.Count] := 2;
      xtip[i] := false;
      xcode[i] := false;
    end;
  end;

  for i:=1 to MAX_GOLYO do        //Jó szín, rossz helyen
  begin
    If xtip[i]=true then
    begin
      for j:=1 to MAX_GOLYO do
      begin
        If xcode[j]=true and xtip[i]=true then
        begin
          If MM.Tips[i,MM.Count]= MM.Code[j] then
          begin
            MM.Eredmeny[i,MM.Count] := 1;
            xtip[i] := false;
            xcode[j] := false;
          end;
        end;
      end;
    end;
  end;

  for i:=1 to MAX_GOLYO do        //Rossz színek
  begin
    If xtip[i]=true then MM.Eredmeny[i,MM.Count] := 0;
  end;
end;

procedure TForm1.EredmenyNov(var MM: TMasterMind);
var
  i,j,k:Integer;
begin
  j:=0;
  for k:=0 to 2 do
  begin
    for i:=1 to MAX_GOLYO do
    begin
      If MM.Eredmeny[i,MM.Count]=(2-k) then
      begin
        j := j+1;
        MM.EredmenyNovekvo[j,MM.Count] := MM.Eredmeny[i,MM.Count];
      end;
    end;
  end;
end;

procedure TForm1.EredmenyMegjelenit(var MM: TMasterMind);
begin
  If MM.Count=1 then
  begin
    EredmenyMegjelenitKepcsere(MM1,iEredmeny11,MM.EredmenyNovekvo[1,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny12,MM.EredmenyNovekvo[2,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny13,MM.EredmenyNovekvo[3,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny14,MM.EredmenyNovekvo[4,MM.Count]);
  end

  else if MM.Count=2 then
  begin
    EredmenyMegjelenitKepcsere(MM1,iEredmeny21,MM.EredmenyNovekvo[1,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny22,MM.EredmenyNovekvo[2,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny23,MM.EredmenyNovekvo[3,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny24,MM.EredmenyNovekvo[4,MM.Count]);
  end

  else if MM.Count=3 then
  begin
    EredmenyMegjelenitKepcsere(MM1,iEredmeny31,MM.EredmenyNovekvo[1,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny32,MM.EredmenyNovekvo[2,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny33,MM.EredmenyNovekvo[3,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny34,MM.EredmenyNovekvo[4,MM.Count]);
  end
  else if MM.Count=4 then
  begin
    EredmenyMegjelenitKepcsere(MM1,iEredmeny41,MM.EredmenyNovekvo[1,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny42,MM.EredmenyNovekvo[2,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny43,MM.EredmenyNovekvo[3,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny44,MM.EredmenyNovekvo[4,MM.Count]);
  end
  else if MM.Count=5 then
  begin
    EredmenyMegjelenitKepcsere(MM1,iEredmeny51,MM.EredmenyNovekvo[1,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny52,MM.EredmenyNovekvo[2,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny53,MM.EredmenyNovekvo[3,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny54,MM.EredmenyNovekvo[4,MM.Count]);
  end
  else if MM.Count=6 then
  begin
    EredmenyMegjelenitKepcsere(MM1,iEredmeny61,MM.EredmenyNovekvo[1,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny62,MM.EredmenyNovekvo[2,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny63,MM.EredmenyNovekvo[3,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny64,MM.EredmenyNovekvo[4,MM.Count]);
  end
  else if MM.Count=7 then
  begin
    EredmenyMegjelenitKepcsere(MM1,iEredmeny71,MM.EredmenyNovekvo[1,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny72,MM.EredmenyNovekvo[2,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny73,MM.EredmenyNovekvo[3,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny74,MM.EredmenyNovekvo[4,MM.Count]);
  end
  else if MM.Count=8 then
  begin
    EredmenyMegjelenitKepcsere(MM1,iEredmeny81,MM.EredmenyNovekvo[1,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny82,MM.EredmenyNovekvo[2,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny83,MM.EredmenyNovekvo[3,MM.Count]);
    EredmenyMegjelenitKepcsere(MM1,iEredmeny84,MM.EredmenyNovekvo[4,MM.Count]);
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  Ujkod(MM1);
{  Form1.Width := Form1.Hatter.Width+16;
  Form1.Height := Form1.Hatter.Height+39;}
  KepPozicio(MM1);
  Form1.Width := 430;
  Form1.Height := 460;
end;

procedure TForm1.TorolClick(Sender: TObject);
begin
  KorTorol(MM1);
end;

procedure TForm1.UjTip(var MM:TMasterMind; KorSzin:Integer);
var
  i:Integer;
  kesz:Boolean;
begin
  kesz:=false;
  for i:=1 to MAX_GOLYO do
  begin
    If kesz=false then
    begin
      If MM1.KorTips[i]=0 then
      begin
        MM1.KorTips[i]:= KorSzin;
        If i=1 then KorKeres(MM1,KorSzin,Golyo1);
        If i=2 then KorKeres(MM1,KorSzin,Golyo2);
        If i=3 then KorKeres(MM1,KorSzin,Golyo3);
        If i=4 then KorKeres(MM1,KorSzin,Golyo4);
        kesz:=true;
      end;
    end;
  end;
end;


procedure TForm1.FeladClick(Sender: TObject);
begin
  Vege(MM1,true);
end;

procedure TForm1.Kor1Click(Sender: TObject);
begin
  UjTip(Mm1,1);
end;

procedure TForm1.Kor2Click(Sender: TObject);
begin
  UjTip(Mm1,2);
end;

procedure TForm1.Kor3Click(Sender: TObject);
begin
  UjTip(Mm1,3);
end;

procedure TForm1.Kor4Click(Sender: TObject);
begin
  UjTip(Mm1,4);
end;

procedure TForm1.Kor5Click(Sender: TObject);
begin
  UjTip(Mm1,5);
end;

procedure TForm1.Kor6Click(Sender: TObject);
begin
  UjTip(Mm1,6);
end;

procedure TForm1.Golyo1Click(Sender: TObject);
begin
  MM1.KorTips[1]:=0;
  Golyo1.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
end;

procedure TForm1.Golyo2Click(Sender: TObject);
begin
  MM1.KorTips[2]:=0;
  Golyo2.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
end;

procedure TForm1.Golyo3Click(Sender: TObject);
begin
  MM1.KorTips[3]:=0;
  Golyo3.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
end;

procedure TForm1.Golyo4Click(Sender: TObject);
begin
  MM1.KorTips[4]:=0;
  Golyo4.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
end;

procedure TForm1.EredmenyMegjelenitKepcsere(var MM: TMasterMind;
  Kep: TImage; Szin: Integer);
begin
  If Szin=0 then Kep.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  If Szin=1 then Kep.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE1');
  If Szin=2 then Kep.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE2');
end;

procedure TForm1.KorTorol(var MM: TMasterMind);
var
  i:Integer;
begin
  Golyo1.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Golyo2.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Golyo3.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Golyo4.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');

  MM.KorTippek := 0;
  for i:=1 to MAX_GOLYO do
  begin
    MM1.KorTips[i]:=0;
  end;
end;

procedure TForm1.KorKeres(var MM: TMasterMind; KorSzin2: Integer;
  Kep: TImage);
begin
  If KorSzin2=1 then Kep.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR1');
  If KorSzin2=2 then Kep.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR2');
  If KorSzin2=3 then Kep.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR3');
  If KorSzin2=4 then Kep.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR4');
  If KorSzin2=5 then Kep.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR5');
  If KorSzin2=6 then Kep.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR6');
end;

procedure TForm1.Vege(MM: TMasterMind; Felad: Boolean);
var
  i,talalat:Integer;
begin
    If Felad=true then
    begin
      Form2.Label1.Caption := 'Vesztettél!';
      Form2.Label1.Color := clred;
    end
    else
    begin
      Form2.Label1.Caption := 'Graturálunk, nyertél!';
      Form2.Label1.Color := clgreen;
    end;
    Form2.Label1.Left := Trunc(((Form2.hatter2.Width)-(Form2.Label1.Width))/2);
    Form2.Label2.Caption := 'Az eredeti kód:';
    KorKeres(MM1,MM.Code[1],Form2.iKod1);
    KorKeres(MM1,MM.Code[2],Form2.iKod2);
    KorKeres(MM1,MM.Code[3],Form2.iKod3);
    KorKeres(MM1,MM.Code[4],Form2.iKod4);

    Form2.Show;
    Form1.Enabled := false;
end;

procedure TForm1.TorolKep(var MM: TMasterMind);
begin
  Golyo1.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Golyo1.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Golyo2.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Golyo3.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Golyo4.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip11.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip12.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip13.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip14.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip21.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip22.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip23.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip24.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip31.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip32.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip33.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip34.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip41.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip42.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip43.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip44.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip51.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip52.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip53.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip54.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip61.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip62.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip63.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip64.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip71.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip72.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip73.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip74.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip81.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip82.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip83.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  Tip84.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR0');
  iEredmeny11.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny12.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny13.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny14.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny21.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny22.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny23.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny24.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny31.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny32.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny33.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny34.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny41.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny42.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny43.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny44.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny51.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny52.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny53.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny54.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny61.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny62.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny63.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny64.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny71.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny72.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny73.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny74.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny81.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny82.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny83.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  iEredmeny84.Picture.Bitmap.LoadFromResourceName(hInstance,'KORE0');
  Form1.Kor1.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR1');
  Form1.Kor2.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR2');
  Form1.Kor3.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR3');
  Form1.Kor4.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR4');
  Form1.Kor5.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR5');
  Form1.Kor6.Picture.Bitmap.LoadFromResourceName(hInstance,'KOR6');
end;

procedure TForm1.KepPozicio(var MM: TMasterMind);
begin
  Kor1.Left := KORPOSITION_LEFT;
  Kor2.Left := KORPOSITION_LEFT;
  Kor3.Left := KORPOSITION_LEFT;
  Kor4.Left := KORPOSITION_LEFT;
  Kor5.Left := KORPOSITION_LEFT;
  Kor6.Left := KORPOSITION_LEFT;
  Kor1.Top  := KORPOSITION_TOP+0*KORMAGASSAG;
  Kor2.Top  := KORPOSITION_TOP+1*KORMAGASSAG;
  Kor3.Top  := KORPOSITION_TOP+2*KORMAGASSAG;
  Kor4.Top  := KORPOSITION_TOP+3*KORMAGASSAG;
  Kor5.Top  := KORPOSITION_TOP+4*KORMAGASSAG;
  Kor6.Top  := KORPOSITION_TOP+5*KORMAGASSAG;

  Golyo1.Left := KORPOSITION2_LEFT+0*KORSZELESSEG;
  Golyo2.Left := KORPOSITION2_LEFT+1*KORSZELESSEG;
  Golyo3.Left := KORPOSITION2_LEFT+2*KORSZELESSEG;
  Golyo4.Left := KORPOSITION2_LEFT+3*KORSZELESSEG;
  Golyo1.Top  := KORPOSITION2_TOP;
  Golyo2.Top  := KORPOSITION2_TOP;
  Golyo3.Top  := KORPOSITION2_TOP;
  Golyo4.Top  := KORPOSITION2_TOP;

  Tip11.Left := KORPOSITION2_LEFT+0*KORSZELESSEG;
  Tip12.Left := KORPOSITION2_LEFT+1*KORSZELESSEG;
  Tip13.Left := KORPOSITION2_LEFT+2*KORSZELESSEG;
  Tip14.Left := KORPOSITION2_LEFT+3*KORSZELESSEG;
  Tip21.Left := KORPOSITION2_LEFT+0*KORSZELESSEG;
  Tip22.Left := KORPOSITION2_LEFT+1*KORSZELESSEG;
  Tip23.Left := KORPOSITION2_LEFT+2*KORSZELESSEG;
  Tip24.Left := KORPOSITION2_LEFT+3*KORSZELESSEG;
  Tip31.Left := KORPOSITION2_LEFT+0*KORSZELESSEG;
  Tip32.Left := KORPOSITION2_LEFT+1*KORSZELESSEG;
  Tip33.Left := KORPOSITION2_LEFT+2*KORSZELESSEG;
  Tip34.Left := KORPOSITION2_LEFT+3*KORSZELESSEG;
  Tip41.Left := KORPOSITION2_LEFT+0*KORSZELESSEG;
  Tip42.Left := KORPOSITION2_LEFT+1*KORSZELESSEG;
  Tip43.Left := KORPOSITION2_LEFT+2*KORSZELESSEG;
  Tip44.Left := KORPOSITION2_LEFT+3*KORSZELESSEG;
  Tip51.Left := KORPOSITION2_LEFT+0*KORSZELESSEG;
  Tip52.Left := KORPOSITION2_LEFT+1*KORSZELESSEG;
  Tip53.Left := KORPOSITION2_LEFT+2*KORSZELESSEG;
  Tip54.Left := KORPOSITION2_LEFT+3*KORSZELESSEG;
  Tip61.Left := KORPOSITION2_LEFT+0*KORSZELESSEG;
  Tip62.Left := KORPOSITION2_LEFT+1*KORSZELESSEG;
  Tip63.Left := KORPOSITION2_LEFT+2*KORSZELESSEG;
  Tip64.Left := KORPOSITION2_LEFT+3*KORSZELESSEG;
  Tip71.Left := KORPOSITION2_LEFT+0*KORSZELESSEG;
  Tip72.Left := KORPOSITION2_LEFT+1*KORSZELESSEG;
  Tip73.Left := KORPOSITION2_LEFT+2*KORSZELESSEG;
  Tip74.Left := KORPOSITION2_LEFT+3*KORSZELESSEG;
  Tip81.Left := KORPOSITION2_LEFT+0*KORSZELESSEG;
  Tip82.Left := KORPOSITION2_LEFT+1*KORSZELESSEG;
  Tip83.Left := KORPOSITION2_LEFT+2*KORSZELESSEG;
  Tip84.Left := KORPOSITION2_LEFT+3*KORSZELESSEG;
  Tip11.Top  := KORPOSITION_TOP+0*KORMAGASSAG;
  Tip12.Top  := KORPOSITION_TOP+0*KORMAGASSAG;
  Tip13.Top  := KORPOSITION_TOP+0*KORMAGASSAG;
  Tip14.Top  := KORPOSITION_TOP+0*KORMAGASSAG;
  Tip21.Top  := KORPOSITION_TOP+1*KORMAGASSAG;
  Tip22.Top  := KORPOSITION_TOP+1*KORMAGASSAG;
  Tip23.Top  := KORPOSITION_TOP+1*KORMAGASSAG;
  Tip24.Top  := KORPOSITION_TOP+1*KORMAGASSAG;
  Tip31.Top  := KORPOSITION_TOP+2*KORMAGASSAG;
  Tip32.Top  := KORPOSITION_TOP+2*KORMAGASSAG;
  Tip33.Top  := KORPOSITION_TOP+2*KORMAGASSAG;
  Tip34.Top  := KORPOSITION_TOP+2*KORMAGASSAG;
  Tip41.Top  := KORPOSITION_TOP+3*KORMAGASSAG;
  Tip42.Top  := KORPOSITION_TOP+3*KORMAGASSAG;
  Tip43.Top  := KORPOSITION_TOP+3*KORMAGASSAG;
  Tip44.Top  := KORPOSITION_TOP+3*KORMAGASSAG;
  Tip51.Top  := KORPOSITION_TOP+4*KORMAGASSAG;
  Tip52.Top  := KORPOSITION_TOP+4*KORMAGASSAG;
  Tip53.Top  := KORPOSITION_TOP+4*KORMAGASSAG;
  Tip54.Top  := KORPOSITION_TOP+4*KORMAGASSAG;
  Tip61.Top  := KORPOSITION_TOP+5*KORMAGASSAG;
  Tip62.Top  := KORPOSITION_TOP+5*KORMAGASSAG;
  Tip63.Top  := KORPOSITION_TOP+5*KORMAGASSAG;
  Tip64.Top  := KORPOSITION_TOP+5*KORMAGASSAG;
  Tip71.Top  := KORPOSITION_TOP+6*KORMAGASSAG;
  Tip72.Top  := KORPOSITION_TOP+6*KORMAGASSAG;
  Tip73.Top  := KORPOSITION_TOP+6*KORMAGASSAG;
  Tip74.Top  := KORPOSITION_TOP+6*KORMAGASSAG;
  Tip81.Top  := KORPOSITION_TOP+7*KORMAGASSAG;
  Tip82.Top  := KORPOSITION_TOP+7*KORMAGASSAG;
  Tip83.Top  := KORPOSITION_TOP+7*KORMAGASSAG;
  Tip84.Top  := KORPOSITION_TOP+7*KORMAGASSAG;

  iEredmeny11.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny12.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny13.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny14.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny21.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny22.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny23.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny24.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny31.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny32.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny33.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny34.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny41.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny42.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny43.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny44.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny51.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny52.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny53.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny54.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny61.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny62.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny63.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny64.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny71.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny72.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny73.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny74.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny81.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny82.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny83.Left := KORPOSITION3_LEFT+0*KORSZELESSEG2;
  iEredmeny84.Left := KORPOSITION3_LEFT+1*KORSZELESSEG2;
  iEredmeny11.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+0*KORMAGASSAG;
  iEredmeny12.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+0*KORMAGASSAG;
  iEredmeny13.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+0*KORMAGASSAG;
  iEredmeny14.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+0*KORMAGASSAG;
  iEredmeny21.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+1*KORMAGASSAG;
  iEredmeny22.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+1*KORMAGASSAG;
  iEredmeny23.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+1*KORMAGASSAG;
  iEredmeny24.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+1*KORMAGASSAG;
  iEredmeny31.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+2*KORMAGASSAG;
  iEredmeny32.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+2*KORMAGASSAG;
  iEredmeny33.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+2*KORMAGASSAG;
  iEredmeny34.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+2*KORMAGASSAG;
  iEredmeny41.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+3*KORMAGASSAG;
  iEredmeny42.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+3*KORMAGASSAG;
  iEredmeny43.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+3*KORMAGASSAG;
  iEredmeny44.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+3*KORMAGASSAG;
  iEredmeny51.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+4*KORMAGASSAG;
  iEredmeny52.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+4*KORMAGASSAG;
  iEredmeny53.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+4*KORMAGASSAG;
  iEredmeny54.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+4*KORMAGASSAG;
  iEredmeny61.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+5*KORMAGASSAG;
  iEredmeny62.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+5*KORMAGASSAG;
  iEredmeny63.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+5*KORMAGASSAG;
  iEredmeny64.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+5*KORMAGASSAG;
  iEredmeny71.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+6*KORMAGASSAG;
  iEredmeny72.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+6*KORMAGASSAG;
  iEredmeny73.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+6*KORMAGASSAG;
  iEredmeny74.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+6*KORMAGASSAG;
  iEredmeny81.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+7*KORMAGASSAG;
  iEredmeny82.Top  := KORPOSITION_TOP+0*KORMAGASSAG2+7*KORMAGASSAG;
  iEredmeny83.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+7*KORMAGASSAG;
  iEredmeny84.Top  := KORPOSITION_TOP+1*KORMAGASSAG2+7*KORMAGASSAG;

  Kor1.Width := KORSZELESSEG;
  Kor2.Width := KORSZELESSEG;
  Kor3.Width := KORSZELESSEG;
  Kor4.Width := KORSZELESSEG;
  Kor5.Width := KORSZELESSEG;
  Kor6.Width := KORSZELESSEG;
  Golyo1.Width := KORSZELESSEG;
  Golyo2.Width := KORSZELESSEG;
  Golyo3.Width := KORSZELESSEG;
  Golyo4.Width := KORSZELESSEG;
  Tip11.Width := KORSZELESSEG;
  Tip12.Width := KORSZELESSEG;
  Tip13.Width := KORSZELESSEG;
  Tip14.Width := KORSZELESSEG;
  Tip21.Width := KORSZELESSEG;
  Tip22.Width := KORSZELESSEG;
  Tip23.Width := KORSZELESSEG;
  Tip24.Width := KORSZELESSEG;
  Tip31.Width := KORSZELESSEG;
  Tip32.Width := KORSZELESSEG;
  Tip33.Width := KORSZELESSEG;
  Tip34.Width := KORSZELESSEG;
  Tip41.Width := KORSZELESSEG;
  Tip42.Width := KORSZELESSEG;
  Tip43.Width := KORSZELESSEG;
  Tip44.Width := KORSZELESSEG;
  Tip51.Width := KORSZELESSEG;
  Tip52.Width := KORSZELESSEG;
  Tip53.Width := KORSZELESSEG;
  Tip54.Width := KORSZELESSEG;
  Tip61.Width := KORSZELESSEG;
  Tip62.Width := KORSZELESSEG;
  Tip63.Width := KORSZELESSEG;
  Tip64.Width := KORSZELESSEG;
  Tip71.Width := KORSZELESSEG;
  Tip72.Width := KORSZELESSEG;
  Tip73.Width := KORSZELESSEG;
  Tip74.Width := KORSZELESSEG;
  Tip81.Width := KORSZELESSEG;
  Tip82.Width := KORSZELESSEG;
  Tip83.Width := KORSZELESSEG;
  Tip84.Width := KORSZELESSEG;
  iEredmeny11.Width := KORSZELESSEG2;
  iEredmeny12.Width := KORSZELESSEG2;
  iEredmeny13.Width := KORSZELESSEG2;
  iEredmeny14.Width := KORSZELESSEG2;
  iEredmeny21.Width := KORSZELESSEG2;
  iEredmeny22.Width := KORSZELESSEG2;
  iEredmeny23.Width := KORSZELESSEG2;
  iEredmeny24.Width := KORSZELESSEG2;
  iEredmeny31.Width := KORSZELESSEG2;
  iEredmeny32.Width := KORSZELESSEG2;
  iEredmeny33.Width := KORSZELESSEG2;
  iEredmeny34.Width := KORSZELESSEG2;
  iEredmeny41.Width := KORSZELESSEG2;
  iEredmeny42.Width := KORSZELESSEG2;
  iEredmeny43.Width := KORSZELESSEG2;
  iEredmeny44.Width := KORSZELESSEG2;
  iEredmeny51.Width := KORSZELESSEG2;
  iEredmeny52.Width := KORSZELESSEG2;
  iEredmeny53.Width := KORSZELESSEG2;
  iEredmeny54.Width := KORSZELESSEG2;
  iEredmeny61.Width := KORSZELESSEG2;
  iEredmeny62.Width := KORSZELESSEG2;
  iEredmeny63.Width := KORSZELESSEG2;
  iEredmeny64.Width := KORSZELESSEG2;
  iEredmeny71.Width := KORSZELESSEG2;
  iEredmeny72.Width := KORSZELESSEG2;
  iEredmeny73.Width := KORSZELESSEG2;
  iEredmeny74.Width := KORSZELESSEG2;
  iEredmeny81.Width := KORSZELESSEG2;
  iEredmeny82.Width := KORSZELESSEG2;
  iEredmeny83.Width := KORSZELESSEG2;
  iEredmeny84.Width := KORSZELESSEG2;

  Kor1.Height := KORMAGASSAG;
  Kor2.Height := KORMAGASSAG;
  Kor3.Height := KORMAGASSAG;
  Kor4.Height := KORMAGASSAG;
  Kor5.Height := KORMAGASSAG;
  Kor6.Height := KORMAGASSAG;
  Golyo1.Height := KORMAGASSAG;
  Golyo2.Height := KORMAGASSAG;
  Golyo3.Height := KORMAGASSAG;
  Golyo4.Height := KORMAGASSAG;
  Tip11.Height := KORMAGASSAG;
  Tip12.Height := KORMAGASSAG;
  Tip13.Height := KORMAGASSAG;
  Tip14.Height := KORMAGASSAG;
  Tip21.Height := KORMAGASSAG;
  Tip22.Height := KORMAGASSAG;
  Tip23.Height := KORMAGASSAG;
  Tip24.Height := KORMAGASSAG;
  Tip31.Height := KORMAGASSAG;
  Tip32.Height := KORMAGASSAG;
  Tip33.Height := KORMAGASSAG;
  Tip34.Height := KORMAGASSAG;
  Tip41.Height := KORMAGASSAG;
  Tip42.Height := KORMAGASSAG;
  Tip43.Height := KORMAGASSAG;
  Tip44.Height := KORMAGASSAG;
  Tip51.Height := KORMAGASSAG;
  Tip52.Height := KORMAGASSAG;
  Tip53.Height := KORMAGASSAG;
  Tip54.Height := KORMAGASSAG;
  Tip61.Height := KORMAGASSAG;
  Tip62.Height := KORMAGASSAG;
  Tip63.Height := KORMAGASSAG;
  Tip64.Height := KORMAGASSAG;
  Tip71.Height := KORMAGASSAG;
  Tip72.Height := KORMAGASSAG;
  Tip73.Height := KORMAGASSAG;
  Tip74.Height := KORMAGASSAG;
  Tip81.Height := KORMAGASSAG;
  Tip82.Height := KORMAGASSAG;
  Tip83.Height := KORMAGASSAG;
  Tip84.Height := KORMAGASSAG;
  iEredmeny11.Height := KORMAGASSAG2;
  iEredmeny12.Height := KORMAGASSAG2;
  iEredmeny13.Height := KORMAGASSAG2;
  iEredmeny14.Height := KORMAGASSAG2;
  iEredmeny21.Height := KORMAGASSAG2;
  iEredmeny22.Height := KORMAGASSAG2;
  iEredmeny23.Height := KORMAGASSAG2;
  iEredmeny24.Height := KORMAGASSAG2;
  iEredmeny31.Height := KORMAGASSAG2;
  iEredmeny32.Height := KORMAGASSAG2;
  iEredmeny33.Height := KORMAGASSAG2;
  iEredmeny34.Height := KORMAGASSAG2;
  iEredmeny41.Height := KORMAGASSAG2;
  iEredmeny42.Height := KORMAGASSAG2;
  iEredmeny43.Height := KORMAGASSAG2;
  iEredmeny44.Height := KORMAGASSAG2;
  iEredmeny51.Height := KORMAGASSAG2;
  iEredmeny52.Height := KORMAGASSAG2;
  iEredmeny53.Height := KORMAGASSAG2;
  iEredmeny54.Height := KORMAGASSAG2;
  iEredmeny61.Height := KORMAGASSAG2;
  iEredmeny62.Height := KORMAGASSAG2;
  iEredmeny63.Height := KORMAGASSAG2;
  iEredmeny64.Height := KORMAGASSAG2;
  iEredmeny71.Height := KORMAGASSAG2;
  iEredmeny72.Height := KORMAGASSAG2;
  iEredmeny73.Height := KORMAGASSAG2;
  iEredmeny74.Height := KORMAGASSAG2;
  iEredmeny81.Height := KORMAGASSAG2;
  iEredmeny82.Height := KORMAGASSAG2;
  iEredmeny83.Height := KORMAGASSAG2;
  iEredmeny84.Height := KORMAGASSAG2;
end;

end.
