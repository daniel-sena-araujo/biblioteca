unit formulario_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls;

type
  TFormularioPrincipal = class(TForm)
    BarraStatus: TStatusBar;
    MenuPrincipal: TMainMenu;
    MenuCadastros: TMenuItem;
    MenuCadastroLeitores: TMenuItem;
    procedure MenuCadastroLeitoresClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormularioPrincipal: TFormularioPrincipal;

implementation

{$R *.dfm}

uses formulario_cadastro_leitor;

procedure TFormularioPrincipal.MenuCadastroLeitoresClick(Sender: TObject);
begin
  if FormularioCadastroLeitor = nil then
    Application.CreateForm(TFormularioCadastroLeitor, FormularioCadastroLeitor);

  FormularioCadastroLeitor.Show();
end;

end.
