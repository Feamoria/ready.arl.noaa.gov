object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 556
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Memo_2: TMemo
    Left = 139
    Top = 282
    Width = 33
    Height = 37
    Align = alCustom
    ScrollBars = ssBoth
    TabOrder = 0
    Visible = False
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 133
    Height = 282
    Align = alLeft
    TabOrder = 1
    object Label_1: TLabel
      Left = 6
      Top = 3
      Width = 121
      Height = 13
      Caption = 'Decimal Degrees Latitude'
    end
    object Label_10: TLabel
      Left = 6
      Top = 174
      Width = 71
      Height = 13
      Caption = 'Level 3 height:'
    end
    object Label_8: TLabel
      Left = 6
      Top = 132
      Width = 71
      Height = 13
      Caption = 'Level 1 height:'
    end
    object Label_9: TLabel
      Left = 6
      Top = 153
      Width = 71
      Height = 13
      Caption = 'Level 2 height:'
    end
    object ComboBox_3: TComboBox
      Left = 51
      Top = 16
      Width = 33
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'N'
      Items.Strings = (
        'N'
        'S')
    end
    object ComboBox_4: TComboBox
      Left = 51
      Top = 37
      Width = 33
      Height = 21
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 1
      Text = 'E'
      Items.Strings = (
        'W'
        'E')
    end
    object E_1: TEdit
      Left = 6
      Top = 16
      Width = 45
      Height = 21
      TabOrder = 2
      Text = '62.5'
    end
    object E_2: TEdit
      Left = 6
      Top = 37
      Width = 45
      Height = 21
      TabOrder = 3
      Text = '58.5'
    end
    object RadioGroup_1: TRadioGroup
      Left = 0
      Top = 64
      Width = 127
      Height = 63
      Caption = 'Trajectory direction:'
      ItemIndex = 0
      Items.Strings = (
        'Forward'
        'Backward')
      TabOrder = 4
    end
    object BTN_1: TBitBtn
      Left = 52
      Top = 193
      Width = 75
      Height = 25
      Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100'>'
      TabOrder = 5
      OnClick = BTN_1Click
    end
    object E_3: TEdit
      Left = 82
      Top = 129
      Width = 45
      Height = 21
      TabOrder = 6
      Text = '500'
    end
    object E_4: TEdit
      Left = 82
      Top = 150
      Width = 45
      Height = 21
      TabOrder = 7
      Text = '0'
    end
    object E_5: TEdit
      Left = 82
      Top = 171
      Width = 45
      Height = 21
      TabOrder = 8
      Text = '0'
    end
    object CheckBox_1: TCheckBox
      Left = 1
      Top = 224
      Width = 97
      Height = 17
      Caption = 'Proxy'
      Checked = True
      State = cbChecked
      TabOrder = 9
      OnClick = CheckBox_1Click
    end
    object chk1: TCheckBox
      Left = 52
      Top = 224
      Width = 57
      Height = 17
      Caption = 'DEBUG'
      TabOrder = 10
    end
    object grp1: TGroupBox
      Left = -1
      Top = 242
      Width = 128
      Height = 35
      Caption = 'Delay'
      TabOrder = 11
      object se1: TSpinEdit
        Left = 20
        Top = 13
        Width = 45
        Height = 22
        Hint = #1047#1072#1076#1077#1088#1078#1082#1072' '#1076#1086' '#1089#1082#1072#1095#1080#1074#1072#1085#1080#1103' '#1092#1072#1081#1083#1072
        MaxValue = 10
        MinValue = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Value = 2
      end
      object se2: TSpinEdit
        Left = 71
        Top = 13
        Width = 45
        Height = 22
        Hint = #1047#1072#1076#1077#1088#1078#1082#1072' '#1084#1077#1078#1076#1091' '#1079#1072#1087#1088#1086#1089#1072#1084#1080' '#1082' '#1089#1072#1081#1090#1091
        MaxValue = 20
        MinValue = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Value = 6
      end
    end
  end
  object pnl2: TPanel
    Left = 133
    Top = 0
    Width = 200
    Height = 282
    Align = alLeft
    TabOrder = 2
    object Label_2: TLabel
      Left = 6
      Top = 3
      Width = 184
      Height = 13
      Caption = 'Choose an archived meteorological file'
    end
    object Label_3: TLabel
      Left = 12
      Top = 50
      Width = 82
      Height = 13
      Caption = 'Start time (UTC):'
    end
    object Label_4: TLabel
      Left = 84
      Top = 62
      Width = 18
      Height = 13
      Caption = 'day'
    end
    object Label_5: TLabel
      Left = 126
      Top = 62
      Width = 22
      Height = 13
      Caption = 'hour'
    end
    object Label_6: TLabel
      Left = 12
      Top = 62
      Width = 22
      Height = 13
      Caption = 'year'
    end
    object Label_7: TLabel
      Left = 48
      Top = 62
      Width = 30
      Height = 13
      Caption = 'month'
    end
    object Label_11: TLabel
      Left = 6
      Top = 102
      Width = 25
      Height = 13
      Caption = 'SAVE'
    end
    object Label_12: TLabel
      Left = 6
      Top = 252
      Width = 121
      Height = 16
      Caption = #1054#1046#1048#1044#1040#1053#1048#1045' 20 '#1057#1045#1050
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object ComboBox_1: TComboBox
      Left = 15
      Top = 27
      Width = 160
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object ComboBox_day: TComboBox
      Left = 84
      Top = 77
      Width = 42
      Height = 21
      Style = csDropDownList
      TabOrder = 1
    end
    object ComboBox_hour: TComboBox
      Left = 126
      Top = 77
      Width = 40
      Height = 21
      Style = csDropDownList
      TabOrder = 2
    end
    object ComboBox_month: TComboBox
      Left = 48
      Top = 77
      Width = 36
      Height = 21
      Style = csDropDownList
      TabOrder = 3
    end
    object ComboBox_year: TComboBox
      Left = 12
      Top = 77
      Width = 36
      Height = 21
      Style = csDropDownList
      TabOrder = 4
    end
    object BTN_2: TBitBtn
      Left = 6
      Top = 223
      Width = 188
      Height = 23
      Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      TabOrder = 5
      WordWrap = True
      OnClick = BTN_2Click
    end
    object CheckBox_GIF: TCheckBox
      Left = 6
      Top = 115
      Width = 97
      Height = 17
      Caption = 'GIF Plots'
      TabOrder = 6
    end
    object CheckBox_PDF: TCheckBox
      Left = 6
      Top = 132
      Width = 97
      Height = 17
      Caption = 'PDF Plots'
      TabOrder = 7
    end
    object CheckBox_PS: TCheckBox
      Left = 6
      Top = 149
      Width = 97
      Height = 17
      Caption = 'PostScript Plots'
      TabOrder = 8
    end
    object CheckBox_CONTROL: TCheckBox
      Left = 6
      Top = 183
      Width = 144
      Height = 17
      Caption = 'HYSPLIT CONTROL file.'
      TabOrder = 9
    end
    object CheckBox_TR: TCheckBox
      Left = 6
      Top = 166
      Width = 145
      Height = 17
      Caption = 'Trajectory endpoints file.'
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    object CheckBox_MESSAGE: TCheckBox
      Left = 6
      Top = 200
      Width = 188
      Height = 17
      Caption = 'HYSPLIT MESSAGE (diagnostics) file.'
      Checked = True
      State = cbChecked
      TabOrder = 11
    end
  end
  object pnl3: TPanel
    Left = 333
    Top = 0
    Width = 211
    Height = 282
    Align = alLeft
    TabOrder = 3
    object Label_13: TLabel
      Left = 6
      Top = 3
      Width = 24
      Height = 13
      Caption = 'Mass'
    end
    object lst1: TListBox
      Left = 6
      Top = 22
      Width = 195
      Height = 224
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 0
    end
    object BTN_3: TBitBtn
      Left = 134
      Top = 246
      Width = 65
      Height = 25
      Caption = 'GO!'
      TabOrder = 1
      OnClick = BTN_3Click
    end
  end
  object pnl4: TPanel
    Left = 0
    Top = 282
    Width = 535
    Height = 274
    Align = alBottom
    Caption = 'pnl4'
    TabOrder = 4
    object Gauge_1: TGauge
      Left = 1
      Top = 19
      Width = 533
      Height = 18
      Align = alTop
      Progress = 0
      ExplicitLeft = 3
      ExplicitTop = 17
      ExplicitWidth = 541
    end
    object Gauge_file: TGauge
      Left = 1
      Top = 1
      Width = 533
      Height = 18
      Align = alTop
      Progress = 0
      ExplicitLeft = 0
      ExplicitTop = 518
      ExplicitWidth = 773
    end
    object Gauge_2: TGauge
      Left = 1
      Top = 37
      Width = 533
      Height = 18
      Align = alTop
      Progress = 0
      ExplicitTop = 36
      ExplicitWidth = 541
    end
    object Gauge_3: TGauge
      Left = 1
      Top = 55
      Width = 533
      Height = 18
      Align = alTop
      Progress = 0
      ExplicitTop = 19
      ExplicitWidth = 771
    end
    object Memo1: TMemo
      Left = 1
      Top = 73
      Width = 533
      Height = 200
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object idhtp1: TIdHTTP
    OnStatus = idhtp1Status
    IOHandler = idslhndlrscktpnsl1
    AllowCookies = True
    HandleRedirects = True
    ProtocolVersion = pv1_0
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 3128
    ProxyParams.ProxyServer = '172.19.1.1'
    Request.CacheControl = 'no-cache'
    Request.Connection = 'keep-alive'
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.ContentType = 'application/x-www-form-urlencoded'
    Request.Pragma = 'no-cache'
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.AcceptEncoding = 'gzip, deflate, br'
    Request.AcceptLanguage = 'ru-RU,ru;q=0.8,en-US;q=0.5,en;q=0.3'
    Request.BasicAuthentication = False
    Request.Host = 'ready.arl.noaa.gov'
    Request.Referer = 'https://ready.arl.noaa.gov/hypub-bin/traj1.pl'
    Request.UserAgent = 
      'Mozilla/5.0 (Windows NT 6.1; rv:57.0) Gecko/20100101 Firefox/57.' +
      '0'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    CookieManager = idckmngr1
    Left = 184
    Top = 391
  end
  object idckmngr1: TIdCookieManager
    Left = 331
    Top = 388
  end
  object idslhndlrscktpnsl1: TIdSSLIOHandlerSocketOpenSSL
    OnStatus = idslhndlrscktpnsl1Status
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
    SSLOptions.Mode = sslmBoth
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    OnStatusInfo = idslhndlrscktpnsl1StatusInfo
    Left = 262
    Top = 390
  end
  object mm1: TMainMenu
    Left = 92
    Top = 286
    object File1: TMenuItem
      Caption = 'File'
      object SaveLOG1: TMenuItem
        Caption = 'Save LOG'
        OnClick = BTN_4Click
      end
      object MergeAllCSV1: TMenuItem
        Caption = 'Merge All CSV'
        OnClick = MergeAllCSV1Click
      end
    end
    object Info_1: TMenuItem
      Caption = 'Info'
      OnClick = Info_1Click
    end
    object N111: TMenuItem
      Caption = 'v1.1 '#1086#1090' 16.09.2022'
    end
  end
end
