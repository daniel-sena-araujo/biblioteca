object FormularioCadastroLivro: TFormularioCadastroLivro
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Livros'
  ClientHeight = 333
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object GrupoRegistro: TGroupBox
    Left = 6
    Top = 8
    Width = 550
    Height = 300
    Caption = 'Registro'
    TabOrder = 0
    object TextoCodigo: TLabel
      Left = 25
      Top = 25
      Width = 39
      Height = 16
      Caption = 'C'#243'digo'
    end
    object TextoTitulo: TLabel
      Left = 25
      Top = 77
      Width = 32
      Height = 16
      Caption = 'T'#237'tulo'
    end
    object TextoEditora: TLabel
      Left = 25
      Top = 129
      Width = 40
      Height = 16
      Caption = 'Editora'
    end
    object TextoAutor: TLabel
      Left = 25
      Top = 181
      Width = 31
      Height = 16
      Caption = 'Autor'
    end
    object CampoCodigo: TEdit
      Left = 25
      Top = 47
      Width = 100
      Height = 24
      Color = clBtnFace
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object CampoTitulo: TEdit
      Left = 25
      Top = 99
      Width = 288
      Height = 24
      TabOrder = 1
    end
    object CampoEditora: TEdit
      Left = 25
      Top = 151
      Width = 288
      Height = 24
      TabOrder = 2
    end
    object CampoAutor: TEdit
      Left = 25
      Top = 203
      Width = 288
      Height = 24
      TabOrder = 3
    end
  end
  object GrupoAcoes: TGroupBox
    Left = 562
    Top = 8
    Width = 150
    Height = 300
    Caption = 'A'#231#245'es'
    TabOrder = 1
    object BotaoIncluir: TBitBtn
      Left = 25
      Top = 25
      Width = 100
      Height = 25
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = BotaoIncluirClick
    end
    object BotaoSalvar: TBitBtn
      Left = 25
      Top = 56
      Width = 100
      Height = 25
      Caption = 'Salvar'
      TabOrder = 1
      OnClick = BotaoSalvarClick
    end
    object BotaoCancelar: TBitBtn
      Left = 25
      Top = 87
      Width = 100
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = BotaoCancelarClick
    end
    object BotaoConsultar: TBitBtn
      Left = 25
      Top = 118
      Width = 100
      Height = 25
      Caption = 'Consultar'
      TabOrder = 3
      OnClick = BotaoConsultarClick
    end
    object BotaoEditar: TBitBtn
      Left = 25
      Top = 149
      Width = 100
      Height = 25
      Caption = 'Editar'
      TabOrder = 4
      OnClick = BotaoEditarClick
    end
    object BotaoExcluir: TBitBtn
      Left = 25
      Top = 180
      Width = 100
      Height = 25
      Caption = 'Excluir'
      TabOrder = 5
      OnClick = BotaoExcluirClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 314
    Width = 720
    Height = 19
    Panels = <>
  end
end
