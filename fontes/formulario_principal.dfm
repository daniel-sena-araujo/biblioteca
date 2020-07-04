object FormularioPrincipal: TFormularioPrincipal
  Left = 0
  Top = 0
  Caption = 'Sistema de Controle de Biblioteca - Vers'#227'o 1.0'
  ClientHeight = 601
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MenuPrincipal
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 16
  object BarraStatus: TStatusBar
    Left = 0
    Top = 582
    Width = 784
    Height = 19
    Panels = <>
    ExplicitLeft = 360
    ExplicitTop = 448
    ExplicitWidth = 0
  end
  object MenuPrincipal: TMainMenu
    Left = 336
    Top = 288
    object MenuCadastros: TMenuItem
      Caption = '&Cadastros'
      object MenuCadastroLeitores: TMenuItem
        Caption = 'Leitores'
        OnClick = MenuCadastroLeitoresClick
      end
    end
  end
end
