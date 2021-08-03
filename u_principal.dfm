object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Postagens'
  ClientHeight = 555
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Id: TLabel
    Left = 15
    Top = 17
    Width = 10
    Height = 13
    Caption = 'Id'
  end
  object Label2: TLabel
    Left = 120
    Top = 17
    Width = 63
    Height = 13
    Caption = 'Id do usu'#225'rio'
  end
  object Label1: TLabel
    Left = 15
    Top = 40
    Width = 26
    Height = 13
    Caption = 'T'#237'tulo'
  end
  object Título: TLabel
    Left = 15
    Top = 65
    Width = 47
    Height = 13
    Caption = 'Postagem'
  end
  object cxGrid1: TcxGrid
    Left = 13
    Top = 210
    Width = 559
    Height = 338
    Align = alCustom
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        Caption = 'Id'
        DataBinding.FieldName = 'id'
        Options.Editing = False
        Options.Focusing = False
        Options.AutoWidthSizable = False
        Width = 80
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        Caption = 'T'#237'tulo'
        DataBinding.FieldName = 'title'
        Options.Editing = False
        Options.Focusing = False
      end
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'Id do usu'#225'rio'
        DataBinding.FieldName = 'userId'
        Options.Editing = False
        Options.Focusing = False
        Options.AutoWidthSizable = False
        Width = 80
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Button1: TButton
    Left = 15
    Top = 179
    Width = 113
    Height = 25
    Caption = 'Buscar dados na API'
    TabOrder = 1
    OnClick = Button1Click
  end
  object btn_excluir: TButton
    Left = 494
    Top = 179
    Width = 78
    Height = 25
    Caption = 'Excluir'
    ImageAlignment = iaRight
    ImageIndex = 1
    Images = pdm_teste.cxImageList1
    TabOrder = 2
    OnClick = btn_excluirClick
  end
  object btn_editar: TButton
    Left = 411
    Top = 179
    Width = 78
    Height = 25
    Caption = 'Editar'
    ImageAlignment = iaRight
    ImageIndex = 0
    Images = pdm_teste.cxImageList1
    TabOrder = 3
    OnClick = btn_editarClick
  end
  object btn_add: TButton
    Left = 329
    Top = 179
    Width = 78
    Height = 25
    Caption = 'Adicionar'
    ImageAlignment = iaRight
    ImageIndex = 2
    Images = pdm_teste.cxImageList1
    TabOrder = 4
    OnClick = btn_addClick
  end
  object ed_id: TcxTextEdit
    Left = 47
    Top = 14
    Properties.ReadOnly = True
    Style.Color = clBtnFace
    TabOrder = 5
    Width = 55
  end
  object ed_titulo: TcxTextEdit
    Left = 47
    Top = 37
    Properties.MaxLength = 100
    TabOrder = 6
    Width = 525
  end
  object ed_post: TMemo
    Left = 15
    Top = 81
    Width = 557
    Height = 89
    Lines.Strings = (
      'ed_post')
    MaxLength = 300
    TabOrder = 7
  end
  object me_idUsuario: TcxMaskEdit
    Left = 189
    Top = 14
    Properties.EditMask = '9999'
    TabOrder = 8
    Text = '    '
    Width = 121
  end
  object btn_cancel: TcxButton
    Left = 494
    Top = 6
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    OptionsImage.ImageIndex = 4
    OptionsImage.Images = pdm_teste.cxImageList1
    TabOrder = 9
    OnClick = btn_cancelClick
  end
  object btn_ok: TcxButton
    Left = 413
    Top = 6
    Width = 75
    Height = 25
    Caption = 'OK'
    OptionsImage.ImageIndex = 3
    OptionsImage.Images = pdm_teste.cxImageList1
    TabOrder = 10
    OnClick = btn_okClick
  end
  object DataSource1: TDataSource
    DataSet = cds_posts
    Left = 96
    Top = 432
  end
  object cds_posts: TFDMemTable
    AfterScroll = cds_postsAfterScroll
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Adapter = pdm_teste.FDTableAdapter1
    Left = 240
    Top = 432
    object cds_postsuserId: TIntegerField
      FieldName = 'userId'
      Origin = 'userId'
      Required = True
    end
    object cds_postsid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_poststitle: TStringField
      FieldName = 'title'
      Origin = 'title'
      Size = 100
    end
    object cds_postsbody: TStringField
      FieldName = 'body'
      Origin = 'body'
      Size = 300
    end
  end
end
