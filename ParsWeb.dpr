program ParsWeb;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  Unit_Info in 'Unit_Info.pas' {InfoFile};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TInfoFile, InfoFile);
  Application.Run;
end.
