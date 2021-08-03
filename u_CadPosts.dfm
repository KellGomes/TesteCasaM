object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Posts'
  ClientHeight = 274
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 10
    Height = 13
    Caption = 'Id'
  end
  object Label2: TLabel
    Left = 204
    Top = 16
    Width = 63
    Height = 13
    Caption = 'Id do usu'#225'rio'
  end
  object cxDBTextEdit1: TcxDBTextEdit
    Left = 204
    Top = 35
    TabOrder = 0
    Width = 121
  end
  object cxDBTextEdit2: TcxDBTextEdit
    Left = 8
    Top = 35
    TabOrder = 1
    Width = 121
  end
  object cxDBMemo1: TcxDBMemo
    Left = 8
    Top = 72
    Properties.MaxLength = 300
    TabOrder = 2
    Height = 161
    Width = 317
  end
  object Panel1: TPanel
    Left = 0
    Top = 233
    Width = 333
    Height = 41
    Align = alBottom
    TabOrder = 3
    ExplicitLeft = -8
    ExplicitTop = 239
    object Button4: TButton
      Left = 79
      Top = 6
      Width = 78
      Height = 25
      Caption = 'Salvar'
      ImageAlignment = iaRight
      ImageIndex = 3
      Images = pdm_teste.cxImageList1
      TabOrder = 0
    end
    object Button3: TButton
      Left = 247
      Top = 6
      Width = 78
      Height = 25
      Caption = 'Sair'
      ImageAlignment = iaRight
      ImageIndex = 5
      Images = pdm_teste.cxImageList1
      TabOrder = 1
    end
    object Button2: TButton
      Left = 163
      Top = 6
      Width = 78
      Height = 25
      Caption = 'Cancelar'
      ImageAlignment = iaRight
      ImageIndex = 4
      Images = pdm_teste.cxImageList1
      TabOrder = 2
    end
  end
end
