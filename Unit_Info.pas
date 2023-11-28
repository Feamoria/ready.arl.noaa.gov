unit Unit_Info;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TInfoFile = class(TForm)
    Memo_1: TMemo;
    img1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InfoFile: TInfoFile;

implementation

{$R *.dfm}

end.
