object frmLookup: TfrmLookup
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pesquisar'
  ClientHeight = 424
  ClientWidth = 662
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 3
  Padding.Top = 3
  Padding.Right = 3
  Padding.Bottom = 3
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 3
    Top = 3
    Width = 656
    Height = 418
    Align = alClient
    BevelOuter = bvNone
    Color = clSilver
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    ParentBackground = False
    TabOrder = 0
    object dbGridPesquisa: TDBGrid
      Left = 5
      Top = 81
      Width = 646
      Height = 291
      Align = alBottom
      DataSource = dsGrid
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = dbGridPesquisaDblClick
      OnKeyDown = dbGridPesquisaKeyDown
      OnKeyPress = FormKeyPress
    end
    object Panel2: TPanel
      Left = 5
      Top = 5
      Width = 646
      Height = 76
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 73
        Height = 76
        Align = alLeft
        ParentShowHint = False
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000400000
          00400806000000AA6971DE0000000473424954080808087C0864880000000970
          485973000001D8000001D801FA5CA6720000001974455874536F667477617265
          007777772E696E6B73636170652E6F72679BEE3C1A000008DD4944415478DAED
          9B07B0144510861B0C98102C15450C885931A1226650CC09732E032898012D73
          C05406543080A954CC39E7326100C11C5031071033282630A0FD55F7D41BD6BB
          DBDBBBE5CE87AFABFE7A33B33B7B33FFCE749A7DCDC4A49362B0A2B3A285CCDC
          3255315AD157F15A339FFC0B8AD9EB3DB21ACBEF8A2E10F0AC620367E66AC54F
          F51ED90C96968A9E622BFD190898E2954B1447D47B7435928B15872BA642C0DF
          DE789A6240BD475623619EA7522845402BC548BFBE9EE2476F3F4471AEE218C5
          6529F726A5B5628462C51A4EF6ED02632A8B808E8AB7A2F2DB5EBE43B1B3E24E
          C52E29F72625BEAF96921C535904884F94EB77456DED14BB2A6E577C91726F21
          E1BE356B38F9970A8CA96C0266566922A01001FF4B6922202200F3F47CBD0754
          23595FCC3436E98026029A08C89F00C2EB4D155D142B28DA88B9CABF297E567C
          20E60D0E573C26C5DDE64645C05C8A03157D14CB67E847247A8FE27CC5AB8D91
          00FAEF2B161CB5495CFB58F186E233B15C83F83DCB88AD92B912F7E3AEF6538C
          2BF25BF38B59AAE5BC4E42E338C520AFCF2D66C5564BF41B23A6F533074369B2
          A0E23AC59651DB878ACBC502A6CF4BF425FFB09193475C31ABB74F56F456DC5A
          A0CF5A8A17136D0F29B6F1F2D28AF77D4E49A938182A26CB8AEDDFF65EFF5A71
          86E24AC51F194844D013672BB68FDACE529C2CFF76D2F652ACEC6574CA30B115
          166407C5DA893E6CADDB136D5511C0E449A32DE4F5077D6093BDCE3349AEF610
          4BB5113D2E2C966A83A8B1DE077C1F3D17026E104B59212469FB6524B35CA998
          00963DCBB0BDD7078AEDC3695EEF2EA6D0562D6310AC946B15A73831086FF73E
          C5925E3F5A71C17F8500EE65CF853D7F9EE2582FCFABB851B16D743FA48C1233
          7BDF28E6105B0D28A45861A29CF6F589234B38C9DCF3A798AE18F95F20607FC5
          355E7E544CF9FCE503869895FCDA44C539620AF29B02CF9945CC0F3F41B17944
          D6F14E2AB2AEE22931650981AC8CA9D1330E500C7152D324172B80C9C2ACB1EF
          59AEE801F63C6F7E6434F9BBC552CE3F94F9265831ECFB565EEF1991CCD63ADB
          CB47292E8CFAD167EF327F03A9DA0A1C29A69490431543BDCCB2DDCECB837CA0
          59C36B1C27DE765B31DBBEA1D8C9CD9C8AF7148B29BE547410739CC4EFED2566
          FBD324172BF0AE0F143B4F461705C61678C0AFE3CD91EB9B56A06F3B278F495E
          56E4F96B289EF349B3FFBBF8B8F6135394C8EE8ADB32925B4C321180D7F68A97
          83566E2EE6E5B1B4D8F34B49F165DFDFFB1007B494E2726AF4FB649BC93A735C
          3741CC0B64B5F5A8070168FA73BCBCB898AB8AB331CADB381F1858E2C7580117
          89AD80A125EE9B47F19198F647C9066BC3711D4A6FB213F167AD09B857CC4961
          704B7B1BCA29D87F26F8550E8342389E3B4C4CE3B7F149A3EC6EF0EBAB2B5E2F
          D17F51B1ADD43E6AABDA0A84FD0F113B781B4107A68C53E575739A3CB299988B
          1DCA8F8B395561D2697AA0BBF7494A55566092D89116CBB8AFB77D2A66FF8789
          F9076982994307FC95725F7BC5275EDEDF9FDFDAC780E01A0F2ED19FF9EC270D
          1123F2B2983E8925130198A6D9C4029493BCED57318D4D187C5CCAA4782B8F88
          85B25D53EEC5F109A60EC708DD83E314F63D01D29965109E269908F845CC118A
          5DDF6F150B282E153B662E25A7F8B391E652DA4F40C97DE7E5C3FDF9733AE148
          5EB14126023043381E68E35EDEF6A6987B8AFDDF31E5C762F39646C02A62E615
          C1AF204982620B49925E3E8E9A1280565DDFFF6EE86DECA99DC47CFD45A4F4DE
          CE420016E0122F43301A7C13C513DEC6767AB2D60460BB0F165B86F389E904A2
          B7617E9D68EDD99C08C057E826A6083B781B7AE70C2FB34526D69A005256C1F4
          04D3C440D81A786A98AD2D722000733AC2CB043E477979845FC38C75CC61F299
          09C084118CA08C6E9286280CB318BE29C251BABFC88FE1D6128CBC230D516352
          B032F81664925869449B7C7B4002F53D1FE7E961D0B52600B959B18798394251
          E11C911DFAC009C2CB2280195BA43F6F6E9C143F032091DADBCBB1B985F03DC5
          3C4E7287EFD78B0052CDAFFAFD7150C29B2707C0D26695E0298ECE3010B2C12C
          F7604AF12CD101B8C2ABFA6F36F7DFD829A7C957440012347F987858F271B034
          C5CB21FA2B25EC6B72089DBD4E769755445C814334DCEBC8F5621E5E5E47F915
          11406202454448FB934F608C5F239383B5085F9B621E391B205F30D62745B447
          E08429C577E8163D7BA4931B822AB24249179BE71F961309151180108CDCE2E5
          4F7C12212FCFDB42317696F20585C72AC0CC859C5F6CF6088250BEC1B7CF8B84
          8A0940F0C54FF4326E2B5A7EB8D7791E6FB2A79353ECC36BC8635FB3FF27785B
          0B9FE0015EC70AAC23E677E01F846F0BAF123B839C26954B550434F38187C890
          01E2EFF3F6A744F791306555E0467330C249CE7869381D8E85ACD31069D8F358
          0C7C8B77BCCE33F8DCAD9DD7AB5D095511100447058517CEF5C63911373B29E5
          C832FE9B6CADE6DEC6B2DF5A1A5606C2C9F31532FDB95F3524E4420082222438
          898FC439EEC2543E2DF6A62186789E1C3E1EE4B2DE8F94D73AF2EFC34C94E6C6
          6266353979F28EDF3A71D590901B01C8EC3E0842D5B615F4672F6352B12CFB24
          48E0DCE0F268F27C78F185935B8D62CC958020BC61FC833D7CF02D53EEC7A4A2
          08F1F682BBCB64FAF87526BA4862F22FFBB5B655923043088805BDD0D107C860
          31659C25B0153E15F3F02615E89724410A4C3E483524CC7002AA912409F8FF84
          DC8532CF9592301D01D324FF682B6F12D009DD722481978DC5FA9B1F0A292F8E
          A4B692E93F5AA83709F80607E74C0296E861318F7542B3888D6A849418FF87D3
          3F6AC39FDFDE113EC15DD4CB4B54F83B59482847064000668C8F1B76C9D0B190
          60F35789EAE37CC27126B7D8C1453D482049B377EC8474157350E6AD6050787E
          A4CDE2D3974ED2E028FDE66DE1B3BA2CDF12066152210F518A04A256B2D61CA8
          10955E9BB84E5286BCC3F030A0C6225974029EE3416209D4F9D31EDA98A45C12
          88183943C06D6E93F6C0C6268548C0511AEF754EB071B4F0443992DB6A6623A0
          10097895283522CADDC4F41826908FB01E4F7B506315C64E36E9C822D70748C3
          99E44C4940901E4E02DF12F3D6C94A63761F29A7F33F0736A47E420409200000
          000049454E44AE426082}
        Proportional = True
        ShowHint = False
        Stretch = True
        ExplicitTop = -6
        ExplicitHeight = 75
      end
      object Label1: TLabel
        Left = 88
        Top = -2
        Width = 57
        Height = 16
        Caption = 'Filtrar por'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 88
        Top = 36
        Width = 29
        Height = 16
        Caption = 'Filtro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object cmbFiltro: TComboBox
        Left = 88
        Top = 14
        Width = 558
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnKeyPress = FormKeyPress
      end
      object edtFiltro: TEdit
        Left = 88
        Top = 49
        Width = 558
        Height = 21
        TabOrder = 1
        OnChange = edtFiltroChange
        OnKeyPress = edtFiltroKeyPress
      end
    end
    object Panel3: TPanel
      Left = 5
      Top = 372
      Width = 646
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object Panel4: TPanel
        Left = 170
        Top = 6
        Width = 150
        Height = 30
        BevelOuter = bvNone
        TabOrder = 0
        object Image2: TImage
          Left = 0
          Top = 0
          Width = 30
          Height = 30
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
            00200806000000737A7AF40000000473424954080808087C0864880000000970
            485973000001740000017401963084020000001974455874536F667477617265
            007777772E696E6B73636170652E6F72679BEE3C1A000002964944415478DACD
            973B681551108677055FA068E32B511BA31024602311842069245A28A6D4345A
            042D441B25828A06146D140B4D0AD36863A1C442C126602060B0090846D4800F
            1251BB24205A78FD7EEE249CEC9EDC7BEEBA715DF838F79E9D9DF977E69CD9DD
            B8542A4521471CC74B195AE10034C20643C71763141EC3007E7F06F9AD2680C0
            EB182EC2115819A4368AA6E03E5CC2FFD74C0208BC84E12C9C811589D313F019
            C6ED7F3D6C82BA84DD345C876BC4F9152CC0EEFA21EC76A6C7E02EF473CDE83C
            A2559A83700CB638A786A0DD978D94009C34313CB13BD2F11B6EC1396C7F84E4
            1F1FCB19AEC0495864D3CAD87E7CBC9A5780DDF94B27F85B388ACD5048608F10
            65B00FB6392276BA99981560351F70D27E0F3A43EFBA4A367AA1C32947EBCC9A
            70059C67B8ECDCF98EBF0D9E1031E264E202BEBB670558EADF47E5D5AE9AB764
            4D7B95720C46E535A1DDD1A052CC08B8CDC471B3BDC9DCE91C02AA711D8631FC
            3DB7B91B0CA7CCE40EF327627EC8F07B546E32DA6A4D39D47D19433FEC0575C4
            B5F89CB4526817688BAA59AD918036786AD76AAB5DCD31B80EF58CED255B6C9C
            EF8ACA5B54C73E09E8814E9B68C4EE4D8EC13FC21E7C7E706CD4AC5EDBDF5E09
            507D5A6002C3FA850CEED8AA85AB6D0F4A80B6DC5618C67857C2508236323F9C
            5770B37FC1D00CEF24408B41DBEF1117B43B465A307AE8AC8E2AEC8C5A83DB35
            7ACE1C82E94A0216337C82F53695129125B84F40A512284DCF60555244D6E0BE
            12545C843E11D09535B8F99CB308AB6E438F08956673C6E0A96D18D4883C226A
            0E6E7E528D28B815274464099E6EC5B53E8CB06DB0AC3DC0EE5B6870BB36FD30
            FA2F1EC76650DC0B891915FB4A66C6C5BD943A1715F75A9EC844311F268EB3E2
            3ECD3CD9F8F71FA71E210BF279FE078DE5D0E0186B2A230000000049454E44AE
            426082}
          Proportional = True
        end
        object btnConfirmar: TSpeedButton
          Left = 0
          Top = 0
          Width = 150
          Height = 30
          Cursor = crHandPoint
          Align = alClient
          Caption = 'Confirmar'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnConfirmarClick
          ExplicitLeft = -27
          ExplicitTop = -5
          ExplicitWidth = 177
          ExplicitHeight = 35
        end
      end
      object Panel5: TPanel
        Left = 326
        Top = 6
        Width = 150
        Height = 30
        BevelOuter = bvNone
        TabOrder = 1
        object Image3: TImage
          Left = 0
          Top = 0
          Width = 30
          Height = 30
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
            00200806000000737A7AF40000000473424954080808087C0864880000000970
            485973000001140000011401FB39E0FF0000001974455874536F667477617265
            007777772E696E6B73636170652E6F72679BEE3C1A0000016E4944415478DAB5
            97BB4AC450108627966B2D585AF81A963E8688E06555B410B4D07E8595EDD6CB
            DA88E05B2968A768ABA095FEC366211CCF6566CE39035FC8FDFF129233494344
            2BE016CC8353F040756B0D0CC027D86E307904CBEDC65FB00FAE2B85EF824BD0
            B4CB4F3CF30E163A3BD59270C3B93E786107DC383B9796F08573F5672B8EC0C8
            237108C699E15BED05CE39EBCFC0A06B5443221A4E9E5B52522219EE13282521
            0A0F09E44A88C36302560955784A402BA10E970848254CE1528194C48F355C23
            C0750C861E09DF794EC085E4A41A81D09D704B74E5568194842ADC2A107AE04C
            23A65620146E96D008F4C195E01896D8A3FF2D3E4B20F69E7F5346EF90084806
            1973EF480968463893444C60134C84E12989039A7E9289052CE126099F404EB8
            5AC2152811AE92E80A940C174BCC046A848B245880FFD5EE29A3A50A2AD4CAD7
            39F4152C560C8F49BCB1C03358AA1C1E927861815570077A34FD3D1735918CE2
            A6760EBEC0C61FE13D8CF22A5CD9AA0000000049454E44AE426082}
          Proportional = True
        end
        object btnCancelar: TSpeedButton
          Left = 0
          Top = 0
          Width = 150
          Height = 30
          Cursor = crHandPoint
          Align = alClient
          Caption = 'Cancelar'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnCancelarClick
          ExplicitLeft = -27
          ExplicitTop = -5
          ExplicitWidth = 177
          ExplicitHeight = 35
        end
      end
    end
  end
  object qryGrid: TFDQuery
    Left = 512
    Top = 112
  end
  object dsGrid: TDataSource
    DataSet = qryGrid
    Left = 512
    Top = 176
  end
end