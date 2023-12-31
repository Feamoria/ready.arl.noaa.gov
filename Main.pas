﻿unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdCookieManager, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, idURI, Vcl.Samples.Gauges,
  Vcl.Menus, Vcl.FileCtrl, Vcl.Samples.Spin, IdException, IdStack;

type
  TForm1 = class(TForm)
    idhtp1: TIdHTTP;
    idckmngr1: TIdCookieManager;
    BTN_1: TBitBtn;
    Memo1: TMemo;
    ComboBox_1: TComboBox;
    Memo_2: TMemo;
    ComboBox_hour: TComboBox;
    Label_1: TLabel;
    E_1: TEdit;
    E_2: TEdit;
    ComboBox_3: TComboBox;
    ComboBox_4: TComboBox;
    Label_2: TLabel;
    RadioGroup_1: TRadioGroup;
    Label_3: TLabel;
    Label_4: TLabel;
    Label_5: TLabel;
    ComboBox_day: TComboBox;
    pnl1: TPanel;
    pnl2: TPanel;
    Label_6: TLabel;
    Label_7: TLabel;
    ComboBox_month: TComboBox;
    ComboBox_year: TComboBox;
    Label_8: TLabel;
    Label_9: TLabel;
    Label_10: TLabel;
    E_3: TEdit;
    E_4: TEdit;
    E_5: TEdit;
    BTN_2: TBitBtn;
    idslhndlrscktpnsl1: TIdSSLIOHandlerSocketOpenSSL;
    CheckBox_GIF: TCheckBox;
    CheckBox_PDF: TCheckBox;
    CheckBox_PS: TCheckBox;
    CheckBox_CONTROL: TCheckBox;
    CheckBox_TR: TCheckBox;
    Label_11: TLabel;
    CheckBox_MESSAGE: TCheckBox;
    Label_12: TLabel;
    pnl3: TPanel;
    Label_13: TLabel;
    lst1: TListBox;
    BTN_3: TBitBtn;
    Gauge_file: TGauge;
    pnl4: TPanel;
    Gauge_1: TGauge;
    Gauge_2: TGauge;
    Gauge_3: TGauge;
    mm1: TMainMenu;
    File1: TMenuItem;
    SaveLOG1: TMenuItem;
    MergeAllCSV1: TMenuItem;
    Info_1: TMenuItem;
    CheckBox_1: TCheckBox;
    chk1: TCheckBox;
    grp1: TGroupBox;
    se1: TSpinEdit;
    se2: TSpinEdit;
    N111: TMenuItem;
    procedure BTN_1Click(Sender: TObject);
    procedure BTN_2Click(Sender: TObject);
    procedure BTN_3Click(Sender: TObject);
    procedure BTN_4Click(Sender: TObject);
    procedure MergeAllCSV1Click(Sender: TObject);
    procedure Info_1Click(Sender: TObject);
    procedure CheckBox_1Click(Sender: TObject);
    procedure idslhndlrscktpnsl1StatusInfo(const AMsg: string);
    procedure idslhndlrscktpnsl1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    procedure idhtp1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  regexpr, Unit_Info, RegularExpressionsAPI, RegularExpressionsCore,
  RegularExpressionsConsts, RegularExpressions, jclPCRE;
{$R *.dfm}
          // 1 - часы
          // 2 - ƒни
          // 3 - мес¤цы
          // 4 - годы
     //https://stackoverflow.com/questions/13950676/how-to-check-url-with-idhttp/13954599#13954599
     //  https://stackoverflow.com/questions/16268913/tidhttp-exception-handling

function parseDate(parse: string; mode: Integer; var CB: TComboBox): Boolean;
var
  repl, parse_1: string;
 // RegExp: TRegExpr;
  RegExp: TRegExpr;
begin

  parse_1 := parse;
  case mode of
    1:
      repl := 'NAME="Start hour" size="1"';
    2:
      repl := 'NAME="Start day" size="1"';
    3:
      repl := 'NAME="Start month" size="1"';
    4:
      repl := 'NAME="Start year" size="1"';

  end;
  RegExp := TRegExpr.Create;
  try
    parse_1 := StringReplace(parse_1, repl, 'ZZ', [rfReplaceAll, rfIgnoreCase]);
    parse_1 := StringReplace(parse_1, #13, '', [rfReplaceAll, rfIgnoreCase]);
    parse_1 := StringReplace(parse_1, #10, '', [rfReplaceAll, rfIgnoreCase]);
    parse_1 := StringReplace(parse_1, '  ', '', [rfReplaceAll, rfIgnoreCase]);
    parse_1 := StringReplace(parse_1, ' SELECTED', '', [rfReplaceAll, rfIgnoreCase]);
    parse_1 := UpperCase(parse_1);
      // тест
    //  Memo_2.Clear;
    //  Memo_2.lines.add(temp);
    //  Memo_2.Lines.SaveToFile('traj1_2.html');
      ////
    RegExp.Expression := '<SELECT ZZ>(.*?)/SELECT>';
    RegExp.InputString := parse_1;
    if RegExp.Exec then
      parse_1 := RegExp.Match[1]
    else
      Form1.Memo1.Lines.Add('RegExp Error! traj1.pl :' + RegExp.Expression + #13 + parse_1);
    Form1.Memo1.Lines.Add(parse_1);

  //parse_1 := StringReplace(parse_1, '<OPTION>', '><', [rfReplaceAll, rfIgnoreCase]);
  //parse_1 := StringReplace(parse_1, '<', 'M', [rfReplaceAll, rfIgnoreCase]);
  //Form1.Memo1.Lines.Add(parse_1);
    RegExp.Expression := '<OPTION>(.?\d)';
    CB.Clear;
    if RegExp.Exec(parse_1) then
    begin
      repeat
        CB.Items.Add(RegExp.Match[1]);
      until not RegExp.ExecNext;
      CB.ItemIndex := 0;
    end
    else
      Form1.Memo1.Lines.Add('RegExp Error! traj1.pl :' + RegExp.Expression + #13 + parse_1);
  finally
    RegExp.Free;
  end;
  Result := true;
end;

procedure TForm1.BTN_1Click(Sender: TObject);
var
  Info1: TStringList;
  Response: TStringStream;
  RegExp: TRegExpr;
  parser: string;
//  i: Integer;
//  U: TidURI;
begin
  //Memo1.Clear;
  /// форматирование данных
  ///


  RegExp := TRegExpr.Create;
  Info1 := TStringList.Create;
  Response := TStringStream.Create('');
  E_1.Text := StringReplace(E_1.Text, '.', FormatSettings.DecimalSeparator, [rfReplaceAll, rfIgnoreCase]);
  E_1.Text := StringReplace(E_1.Text, ',', FormatSettings.DecimalSeparator, [rfReplaceAll, rfIgnoreCase]);
  E_2.Text := StringReplace(E_2.Text, '.', FormatSettings.DecimalSeparator, [rfReplaceAll, rfIgnoreCase]);
  E_2.Text := StringReplace(E_2.Text, ',', FormatSettings.DecimalSeparator, [rfReplaceAll, rfIgnoreCase]);
  E_1.Text := FloatToStrF(StrToFloat(E_1.Text), ffFixed, 9, 6);
  E_2.Text := FloatToStrF(StrToFloat(E_2.Text), ffFixed, 9, 6);
  E_1.Text := StringReplace(E_1.Text, FormatSettings.DecimalSeparator, '.', [rfReplaceAll, rfIgnoreCase]);
  E_2.Text := StringReplace(E_2.Text, FormatSettings.DecimalSeparator, '.', [rfReplaceAll, rfIgnoreCase]);
  try
      // 0й запрос
    Info1.Clear;
      // https://ready.arl.noaa.gov/hypub-bin/trajtype.pl?runtype=archive
      //try
    Memo1.Lines.Add('POST: https://www.ready.noaa.gov/hypub-bin/trajtype.pl?runtype=archive');
    try
      idhtp1.Get('https://www.ready.noaa.gov/hypub-bin/trajtype.pl?runtype=archive');
      idhtp1.Disconnect;
    except
      on E: EIdHTTPProtocolException do
        Memo1.Lines.Add('Indy raised a protocol error!' + sLineBreak + 'HTTP status code: ' + IntToStr(E.ErrorCode) + sLineBreak + 'Error message' + E.Message);
      on E: EIdConnClosedGracefully do
      begin
        Memo1.Lines.Add('Indy reports, that connection was closed gracefully!');
        BTN_1Click(BTN_1);
        Exit;
      end;
      on E: EIdSocketError do
        Memo1.Lines.Add('Indy raised a socket error!' + sLineBreak + 'Error code: ' + IntToStr(E.LastError) + sLineBreak + 'Error message' + E.Message);
      on E: EIdException do
        Memo1.Lines.Add('Indy raised an exception!' + sLineBreak + 'Exception class: ' + E.ClassName + sLineBreak + 'Error message: ' + E.Message);
      on E: Exception do
        Memo1.Lines.Add('A non-Indy related exception has been raised!');
    end;
    Info1.Clear;
    Info1.Add('nsrc=1');
    Info1.Add('trjtype=1');
    Memo1.Lines.Add('POST:https://ready.arl.noaa.gov/hypub-bin/trajasrc.pl ');

    try
      idhtp1.Post('https://www.ready.noaa.gov/hypub-bin/trajasrc.pl', Info1, Response);
      idhtp1.Disconnect;
    except
      on E: EIdHTTPProtocolException do
        Memo1.Lines.Add('Indy raised a protocol error!' + sLineBreak + 'HTTP status code: ' + IntToStr(E.ErrorCode) + sLineBreak + 'Error message' + E.Message);
      on E: EIdConnClosedGracefully do
      begin
        Memo1.Lines.Add('Indy reports, that connection was closed gracefully!');
        BTN_1Click(BTN_1);
        Exit;
      end;
      on E: EIdSocketError do
        Memo1.Lines.Add('Indy raised a socket error!' + sLineBreak + 'Error code: ' + IntToStr(E.LastError) + sLineBreak + 'Error message' + E.Message);
      on E: EIdException do
        Memo1.Lines.Add('Indy raised an exception!' + sLineBreak + 'Exception class: ' + E.ClassName + sLineBreak + 'Error message: ' + E.Message);
      on E: Exception do
        Memo1.Lines.Add('A non-Indy related exception has been raised!');
    end;

    Memo_2.Clear;
    Memo_2.lines.add(Response.DataString);
    Memo_2.Lines.SaveToFile('temp/trajasrc.html');
    Response.Clear;
      //Memo1.lines.add('DONE! https://ready.arl.noaa.gov/hypub-bin/trajasrc.pl');
// 2й запрос
    Info1.Clear;
    Info1.Add('metdata=GDAS1');
    Info1.Add('SOURCELOC=decdegree');
    Info1.Add('Lat=' + E_1.Text);  // мен¤ть  62.500000
    Info1.Add('Latns=' + ComboBox_3.Text);
    Info1.Add('Lon=' + E_2.Text); // мен¤ть  58.500000
    Info1.Add('Lonew=' + ComboBox_4.Text);
    Info1.Add('Latd=');
    Info1.Add('Latm=');
    Info1.Add('Lats=');
    Info1.Add('Latdns=N');
    Info1.Add('Lond=');
    Info1.Add('Lonm=');
    Info1.Add('Lons=');
    Info1.Add('Londew=W');
    Info1.Add('CITYNAME=');
    Info1.Add('WMO=');
    Memo1.Lines.Add('POST: https://www.ready.noaa.gov/hypub-bin/trajsrcm.pl');

    try
      idhtp1.Post('https://www.ready.noaa.gov/hypub-bin/trajsrcm.pl', Info1, Response);
      idhtp1.Disconnect;
    except
      on E: EIdHTTPProtocolException do
        Memo1.Lines.Add('Indy raised a protocol error!' + sLineBreak + 'HTTP status code: ' + IntToStr(E.ErrorCode) + sLineBreak + 'Error message' + E.Message);
      on E: EIdConnClosedGracefully do
      begin
        Memo1.Lines.Add('Indy reports, that connection was closed gracefully!');
        BTN_1Click(BTN_1);
        Exit;
      end;
      on E: EIdSocketError do
        Memo1.Lines.Add('Indy raised a socket error!' + sLineBreak + 'Error code: ' + IntToStr(E.LastError) + sLineBreak + 'Error message' + E.Message);
      on E: EIdException do
        Memo1.Lines.Add('Indy raised an exception!' + sLineBreak + 'Exception class: ' + E.ClassName + sLineBreak + 'Error message: ' + E.Message);
      on E: Exception do
        Memo1.Lines.Add('A non-Indy related exception has been raised!');

    end;

    parser := LowerCase(Response.DataString);
      //Memo1.lines.add('DONE! https://ready.arl.noaa.gov/hypub-bin/trajsrcm.pl');
    Memo_2.Clear;
    Memo_2.lines.add(LowerCase(Response.DataString));
    Memo_2.Lines.SaveToFile('temp/trajsrcm.html');
    Response.Clear;

    ////если список дней не заполнен получаем данные по дн¤м недели)
    ///
    if ComboBox_1.Items.Count = 0 then
    begin
    ////
      parser := StringReplace(parser, ' name="mfile" size="1"', '', [rfReplaceAll, rfIgnoreCase]);
      parser := StringReplace(parser, '<option selected>', '<option>', [rfReplaceAll, rfIgnoreCase]);
      RegExp.Expression := '<select>(.*?)</select>';
      if RegExp.Exec(parser) then
        parser := RegExp.Match[1]
      else
        Memo1.lines.add('RegExp Error! trajsrcm.html REG:' + RegExp.Expression);
      RegExp.Expression := '<option>(.*?)</option>';
      if RegExp.Exec(parser) then
      begin
        repeat
          ComboBox_1.Items.Add(RegExp.Match[1]);
          lst1.Items.Add(RegExp.Match[1]);
        until not RegExp.ExecNext;
       // ComboBox_1.ItemIndex := 0;
      end
      else
        Memo1.Lines.Add('RegExp Error! trajsrcm.html REG:' + RegExp.Expression);
    end;

    ///  ќтправл¤ем дни
    ///
    ///
    ///   https://ready.arl.noaa.gov/hypub-bin/traj1.pl
    ///   POST :  mfile=gdas1.oct17.w3
    if ComboBox_1.ItemIndex <> -1 then
    begin
      Info1.Clear;
      Info1.Add('mfile=' + ComboBox_1.Text);
      Memo1.Lines.Add('POST: https://www.ready.noaa.gov/hypub-bin/traj1.pl');
      try
        idhtp1.Post('https://www.ready.noaa.gov/hypub-bin/traj1.pl', Info1, Response);
        idhtp1.Disconnect;
      except
        on E: EIdHTTPProtocolException do
          Memo1.Lines.Add('Indy raised a protocol error!' + sLineBreak + 'HTTP status code: ' + IntToStr(E.ErrorCode) + sLineBreak + 'Error message' + E.Message);
        on E: EIdConnClosedGracefully do
        begin
          Memo1.Lines.Add('Indy reports, that connection was closed gracefully!');
          BTN_1Click(BTN_1);
          Exit;
        end;
        on E: EIdSocketError do
          Memo1.Lines.Add('Indy raised a socket error!' + sLineBreak + 'Error code: ' + IntToStr(E.LastError) + sLineBreak + 'Error message' + E.Message);
        on E: EIdException do
          Memo1.Lines.Add('Indy raised an exception!' + sLineBreak + 'Exception class: ' + E.ClassName + sLineBreak + 'Error message: ' + E.Message);
        on E: Exception do
          Memo1.Lines.Add('A non-Indy related exception has been raised!');
      end;

      Memo_2.Clear;
      parser := Response.DataString;
      Memo_2.lines.add(Response.DataString);
      Memo_2.Lines.SaveToFile('temp/traj1.html');
      //Memo1.lines.add('DONE! https://ready.arl.noaa.gov/hypub-bin/traj1.pl');
      Response.Clear;
    ///// список часов..
      parseDate(parser, 1, ComboBox_hour);
    ///// список дней..
      parseDate(parser, 2, ComboBox_day);
    ///  список мес¤цев
      parseDate(parser, 3, ComboBox_month);
    ///  cписок годов
      parseDate(parser, 4, ComboBox_year);
    end;

  finally
    begin
      idhtp1.Disconnect;
      Response.Free;
      Info1.Free;
      RegExp.Free;
    end;
  end;

end;

function SaveCSV(URL: string; path: string): Boolean;
var
  f: TStringList;
  I: Integer;
begin
  f := TStringList.Create;
  try

    f.LoadFromFile(ExtractFilePath(Application.ExeName) + 'date\' + path + ' ' + URL + ' tdump.' + URL + '.txt');
    for I := 0 to f.Count - 1 do
    begin
      if f.Strings[I] = '<head>' then
      begin
        Form1.Memo1.Lines.Add('!!!!!!!!!!!!! ' + 'tdump.' + URL + '.txt');
        Result := false;
        Exit;
      end;
      f.Strings[I] := Trim(f.Strings[I]);
      f.Strings[I] := StringReplace(f.Strings[I], '  ', ' ', [rfReplaceAll, rfIgnoreCase]);
      f.Strings[I] := StringReplace(f.Strings[I], '   ', ' ', [rfReplaceAll, rfIgnoreCase]);
      f.Strings[I] := StringReplace(f.Strings[I], '  ', ' ', [rfReplaceAll, rfIgnoreCase]);
      f.Strings[I] := StringReplace(f.Strings[I], ' ', ';', [rfReplaceAll, rfIgnoreCase]);
    end;
    f.SaveToFile(ExtractFilePath(Application.ExeName) + 'date\' + path + ' ' + URL + ' tdump.' + URL + '.csv');
    Result := true;
  finally
    f.Free
  end;
end;

function SaveData(URL: string; path: string): Boolean;
const
  U: string = 'https://www.ready.noaa.gov/hypubout/';
var
  Info1, info2: TStringList;
  I, Y: Integer;
  Stream: TMemoryStream;
begin
  Info1 := TStringList.Create;
  info2 := TStringList.Create;
  Stream := TMemoryStream.Create;
  try

    with Form1 do
    begin
      if CheckBox_CONTROL.Checked then
        Info1.Add('CONTROL.' + URL + '.txt');
      if CheckBox_TR.Checked then
        Info1.Add('tdump.' + URL + '.txt');
      if CheckBox_GIF.Checked then
        Info1.Add(URL + '_trj001.gif');
      if CheckBox_PS.Checked then
        Info1.Add('trajplot_' + URL + '.ps');
      if CheckBox_PDF.Checked then
        Info1.Add('trajplot_' + URL + '.pdf');
      if CheckBox_MESSAGE.Checked then
        Info1.Add('MESSAGE.' + URL + '.txt');
    end;
    if Info1.Count > 0 then
      for I := 0 to Info1.Count - 1 do
      begin
        Stream.Clear;
        Form1.Memo1.Lines.Add('TRY SAVE:' + U + Info1.Strings[I]);
        Form1.Label_12.Visible := True;
        for Y := Form1.se1.Value * 100 downto 0 do
        begin
          Form1.Label_12.Caption := 'ОЖИДАНИЕ: ' + FloatToStr(Y / 100) + ' сек';
          Application.ProcessMessages;
          Sleep(10);
        end;
        Form1.Label_12.Visible := false;
        Application.ProcessMessages;
        try
         // Form1.Memo1.Lines.Add('----');
          Form1.idhtp1.get(U + Info1.Strings[I], Stream);

          Form1.Memo1.Lines.Add('-done-');
        except
          on e: EIdHTTPProtocolException do
          begin
            with Form1 do
            begin
              Form1.Memo1.Lines.Add('Indy raised a protocol error!' + sLineBreak + 'HTTP status code: ' + IntToStr(E.ErrorCode) + sLineBreak + 'Error message' + E.Message);
              Memo1.Lines.Add(inttostr(e.ErrorCode) + ' Ошибка: Ожидаем 10 сек  ');
              Label_12.Visible := True;
              for Y := se1.Value * 100 downto 0 do
              begin
                Form1.Label_12.Caption := 'ОЖИДАНИЕ: ' + FloatToStr(Y / 100) + ' сек';
                Application.ProcessMessages;
                Sleep(10);
              end;
              Label_12.Visible := false;
              Application.ProcessMessages;
              SaveData(URL, path);
              Exit;
            end;

          end;
          on E: EIdConnClosedGracefully do
            Form1.Memo1.Lines.Add('Indy reports, that connection was closed gracefully!');
      // this exception class covers all the low level socket exceptions
          on E: EIdSocketError do
            Form1.Memo1.Lines.Add('Indy raised a socket error!' + sLineBreak + 'Error code: ' + IntToStr(E.LastError) + sLineBreak + 'Error message' + E.Message);
      // this exception class covers all exceptions thrown by Indy library
          on E: EIdException do
            Form1.Memo1.Lines.Add('Indy raised an exception!' + sLineBreak + 'Exception class: ' + E.ClassName + sLineBreak + 'Error message: ' + E.Message);
      // this exception class is a base Delphi exception class and covers here
      // all exceptions different from those listed above
          on E: Exception do
            Form1.Memo1.Lines.Add('A non-Indy related exception has been raised!');
        end;
      //  Form1.Memo1.Lines.Add('SAVE DONE:' + ExtractFilePath(Application.ExeName) + 'date\' + URL + ' ' + Info1.Strings[I]);
        Stream.SaveToFile(ExtractFilePath(Application.ExeName) + 'date\' + path + ' ' + URL + ' ' + Info1.Strings[I]);
      end;
    if Form1.CheckBox_TR.Checked then
      if (SaveCSV(URL, path)) then
      begin
        Result := True;
      end
      else
      begin
        Result := false;
      end;
  finally
    Stream.Free;
    Info1.Free;
    info2.Free;
  end;
end;

procedure TForm1.BTN_2Click(Sender: TObject);
var
  Info1: TStringList;
  Response: TStringStream;
  RegExp: TRegExpr;
  parser, path: string;
  I: Integer;
  res: Boolean;
begin
  Info1 := TStringList.Create;
  Response := TStringStream.Create('');
  RegExp := TRegExpr.Create;
  try
    Info1.Clear;
    if RadioGroup_1.ItemIndex = 0 then
      Info1.Add('direction=Forward')
    else
      Info1.Add('direction=Backward'); /// ѕеременна¤
    Info1.Add('vertical=0');
    Info1.Add('Start year=' + ComboBox_year.Text);
    Info1.Add('Start month=' + ComboBox_month.Text);
    Info1.Add('Start day=' + ComboBox_day.Text);
    Info1.Add('Start hour=' + ComboBox_hour.Text);
    Info1.Add('duration=24');
    Info1.Add('repeatsrc=0');
    Info1.Add('ntrajs=24');
    if ComboBox_3.ItemIndex = 0 then
      Info1.Add('Source lat=' + E_1.Text)   /// ѕ≈–≈ћЌЌјя
    else
      Info1.Add('Source lat=-' + E_1.Text);
    if ComboBox_4.ItemIndex = 0 then
      Info1.Add('Source lon=-' + E_2.Text) // ѕ≈–≈ћЌЌјя ?? почему - ???
    else
      Info1.Add('Source lon=' + E_2.Text);
    Info1.Add('Source lat2=');
    Info1.Add('Source lon2=');
    Info1.Add('Source lat3=');
    Info1.Add('Source lon3=');
    Info1.Add('Source hgt1=' + E_3.Text); /// ѕ≈–≈ћЌЌјя
    Info1.Add('Source hunit=0');
    Info1.Add('Source hgt2=' + E_4.Text); /// ѕ≈–≈ћЌЌјя
    Info1.Add('Source hgt3=' + E_5.Text); /// ѕ≈–≈ћЌЌјя
    Info1.Add('gis=0');
    Info1.Add('gsize=96');
    Info1.Add('Zoom Factor=70');
    Info1.Add('projection=0');
    Info1.Add('Vertical Unit=1');
    Info1.Add('Label Interval=6');
    Info1.Add('color=Yes');
    Info1.Add('colortype=Yes');
    Info1.Add('pltsrc=1');
    Info1.Add('circle=-1');
    Info1.Add('county=arlmap');
    if CheckBox_PS.Checked then
      Info1.Add('psfile=Yes')
    else
      Info1.Add('psfile=No');
    //
    if CheckBox_PDF.Checked then
      Info1.Add('pdffile=Yes')
    else
      Info1.Add('pdffile=No');
    Info1.Add('mplot=NO');
    Form1.Memo1.Lines.Add('Post: https://www.ready.noaa.gov/hypub-bin/traj2.pl');
    try
      idhtp1.Post('https://www.ready.noaa.gov/hypub-bin/traj2.pl', Info1, Response);
      idhtp1.Disconnect;
    except
      on E: EIdHTTPProtocolException do
        Memo1.Lines.Add('Indy raised a protocol error!' + sLineBreak + 'HTTP status code: ' + IntToStr(E.ErrorCode) + sLineBreak + 'Error message' + E.Message);
      on E: EIdConnClosedGracefully do
      begin
        Memo1.Lines.Add('Indy reports, that connection was closed gracefully!');
        BTN_2Click(BTN_2);
        Exit;
      end;

      on E: EIdSocketError do
        Memo1.Lines.Add('Indy raised a socket error!' + sLineBreak + 'Error code: ' + IntToStr(E.LastError) + sLineBreak + 'Error message' + E.Message);
      on E: EIdException do
        Memo1.Lines.Add('Indy raised an exception!' + sLineBreak + 'Exception class: ' + E.ClassName + sLineBreak + 'Error message: ' + E.Message);
      on E: Exception do
        Memo1.Lines.Add('A non-Indy related exception has been raised!');
    end;
    parser := Response.DataString;
    if Pos('Your IP address has exceeded', parser) > 0 then
    begin
      Form1.Memo1.Lines.Add('Your IP address has exceeded the daily limit on the number of HYSPLIT simulations allowed (500).');
      Form1.Memo1.Lines.Add('This limit is needed to share resources with other HYSPLIT users.  You are encouraged to download the PC version of the model and run it locally for numerous simulations.');
      exit;
    end;
    Memo_2.Lines.Clear;
    Memo_2.Lines.Add(Response.DataString);
    Memo_2.Lines.SaveToFile('temp/traj2.pl');
    RegExp.Expression := 'jobidno=(.*?)">';
    if RegExp.Exec(parser) then
    begin
      //Memo1.Lines.Add(RegExp.Match[1]);
      Label_12.Visible := True;
      for I := se2.Value * 100 downto 0 do
      begin
        Label_12.Caption := 'ОЖИДАНИЕ: ' + FloatToStr(I / 100) + ' сек';
        Application.ProcessMessages;
        Sleep(10);
      end;
      Label_12.Visible := false;
      Application.ProcessMessages;
      path := ComboBox_year.Text + '-' + ComboBox_month.Text + '-' + ComboBox_day.Text + '-' + ComboBox_hour.Text;
      res := SaveData(RegExp.Match[1], path);
      if not (res) then
      begin
        for I := se2.Value* 2 * 100 downto 0 do
        begin
          Label_12.Caption := 'ОЖИДАНИЕ: ' + FloatToStr(I / 100) + ' сек';
          Application.ProcessMessages;
          Sleep(10);
        end;
        SaveData(RegExp.Match[1], path);
      end;
    end
    else
      Memo1.Lines.Add('REGEXP ERROR traj2.pl: ' + RegExp.Expression)

  finally
    begin
    //  idhtp1.Disconnect;
      Response.Free;
      Info1.Free;
      RegExp.Free;
    end;
  end;
end;

procedure TForm1.BTN_3Click(Sender: TObject);
var
  i, j, k, q, z: Integer;
begin
  if lst1.SelCount = 0 then
    Exit;
  Memo1.Clear;
//Memo1.Lines.Add(IntToStr(lst1.SelCount));
///—мотрим сколько выбрано
///
  j := 0;
  for i := 0 to lst1.Items.Count - 1 do
    if lst1.Selected[i] then
    begin
      j := j + 1;
      Gauge_file.MaxValue := lst1.SelCount;
      Gauge_file.Progress := j;
      Memo1.Lines.Add('Begin: ' + IntToStr(j) + '/' + inttostr(lst1.SelCount) + ':' + lst1.Items.Strings[i]);
     // Memo1.Lines.Add(Inttostr( ComboBox_1.Items.IndexOf(lst1.Items.Strings[i])));
      ComboBox_1.ItemIndex := ComboBox_1.Items.IndexOf(lst1.Items.Strings[i]);
      BTN_1Click(BTN_1);
      for q := 0 to ComboBox_year.Items.Count - 1 do //по годам
      begin
        ComboBox_year.ItemIndex := q;
        Gauge_1.MaxValue := ComboBox_year.Items.Count;
        Gauge_1.Progress := q + 1;
        for z := 0 to ComboBox_month.Items.Count - 1 do //по мес¤цам
        begin
          Gauge_2.MaxValue := ComboBox_month.Items.Count;
          Gauge_2.Progress := z + 1;
          ComboBox_month.ItemIndex := z;
          for k := 0 to ComboBox_day.Items.Count - 1 do  //по дн¤м
          begin
            Gauge_3.MaxValue := ComboBox_day.Items.Count;
            Gauge_3.Progress := k + 1;
            ComboBox_day.ItemIndex := k;
           // Memo1.Lines.Add(ComboBox_year.text+'\'+ComboBox_month.Text+'\'+ComboBox_day.text);
            BTN_2Click(BTN_2);
          end;
        end;
      end;

     // Memo1.Lines.Add('END:   ' + IntToStr(j) + '/' + inttostr(lst1.SelCount) + ':' + lst1.Items.Strings[i]);
    end;

  ShowMessage('Завершено!');
  BTN_4Click(SaveLOG1);
end;

procedure TForm1.BTN_4Click(Sender: TObject);
begin
  Memo1.Lines.SaveToFile(datetostr(now()) + '.log');
end;

procedure TForm1.CheckBox_1Click(Sender: TObject);
begin
  if CheckBox_1.Checked = true then
  begin
    idhtp1.ProxyParams.ProxyPort := 3128;
    idhtp1.ProxyParams.ProxyServer := '172.19.1.1';
  end
  else
  begin
    idhtp1.ProxyParams.ProxyPort := 0;
    idhtp1.ProxyParams.ProxyServer := '';
  end;
end;

procedure TForm1.idhtp1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin

  if chk1.Checked then
    Memo1.Lines.Add('Htp1Status:' + AStatusText);
end;

procedure TForm1.idslhndlrscktpnsl1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
  if chk1.Checked then
    Memo1.Lines.Add('AStatusText:' + AStatusText);
end;

procedure TForm1.idslhndlrscktpnsl1StatusInfo(const AMsg: string);
begin
  if chk1.Checked then
    Memo1.Lines.Add('AMsg:' + AMsg);
end;

procedure TForm1.Info_1Click(Sender: TObject);
begin
///
  Unit_Info.InfoFile.Visible := False;
  Unit_Info.InfoFile.Visible := True;
end;

procedure TForm1.MergeAllCSV1Click(Sender: TObject);
var
  FLB: TFileListBox;
  SL1, SL2: TStringList;
  I: Integer;
begin
 //
  FLB := TFileListBox.Create(nil);
  SL1 := TStringList.Create;
  SL2 := TStringList.Create;
  try

    FLB.Parent := Form1;
    FLB.Visible := false;
    FLB.Mask := '*.csv';
    FLB.Directory := ExtractFilePath(Application.ExeName) + 'date\';
    FLB.Update;
    //ShowMessage(IntToStr(FLB.Count));
    for I := 0 to FLB.Count - 1 do
    begin
      SL1.Clear;
      SL1.LoadFromFile(ExtractFilePath(Application.ExeName) + 'date\' + FLB.Items.Strings[I]);
      SL2.Add(SL1.Text);
    end;
    SL2.SaveToFile(ExtractFilePath(Application.ExeName) + 'date\_MERGE.csv');
    FLB.Directory := ExtractFilePath(Application.ExeName);
  finally
    FreeAndNil(FLB); //.Free;
    SL2.Free;
    SL1.Free;
  end;
end;

end.

