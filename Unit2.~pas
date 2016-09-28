unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    iKod1: TImage;
    iKod2: TImage;
    iKod3: TImage;
    iKod4: TImage;
    Label2: TLabel;
    Button2: TButton;
    hatter2: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public

  end;

var
  Form2: TForm2;

implementation

uses Unit1;
{$R *.dfm}

{ TForm2 }



procedure TForm2.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Ujkod(MM1);
  Form1.Enabled := true;
end;

end.
