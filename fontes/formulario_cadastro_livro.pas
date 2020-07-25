unit formulario_cadastro_livro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons,
  Vcl.ComCtrls, entidade_livro;

type
  TFormularioCadastroLivro = class(TForm)
    GrupoRegistro: TGroupBox;
    TextoCodigo: TLabel;
    CampoCodigo: TEdit;
    TextoTitulo: TLabel;
    CampoTitulo: TEdit;
    TextoEditora: TLabel;
    CampoEditora: TEdit;
    GrupoAcoes: TGroupBox;
    BotaoIncluir: TBitBtn;
    BotaoSalvar: TBitBtn;
    BotaoCancelar: TBitBtn;
    BotaoConsultar: TBitBtn;
    BotaoEditar: TBitBtn;
    BotaoExcluir: TBitBtn;
    StatusBar1: TStatusBar;
    TextoAutor: TLabel;
    CampoAutor: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
    procedure BotaoExcluirClick(Sender: TObject);
    procedure BotaoCancelarClick(Sender: TObject);
    procedure BotaoIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BotaoEditarClick(Sender: TObject);
    procedure BotaoConsultarClick(Sender: TObject);
  private
    procedure LimparFormulario;
    procedure HabilitarEdicao;
    procedure DesabilitarEdicao;
    procedure CarregarLivro(Livro : TLivro);
  public

  end;

var
  FormularioCadastroLivro: TFormularioCadastroLivro;

implementation

{$R *.dfm}

uses util_dialogo, dao_livro;

procedure TFormularioCadastroLivro.BotaoCancelarClick(Sender: TObject);
var
  Livro : TLivro;
begin
  if Trim(CampoCodigo.Text) = '' then
  begin
    LimparFormulario();
  end
  else
  begin
    Livro := TLivroDAO.RecuperarPorCodigo(StrToIntDef(CampoCodigo.Text, 0));

    if Livro <> nil then
      CarregarLivro(Livro);
  end;

  DesabilitarEdicao();
end;

procedure TFormularioCadastroLivro.BotaoConsultarClick(Sender: TObject);
begin
  TDialogo.Informar('Esta função estará disponível na próxima versão, aguarde.');
end;

procedure TFormularioCadastroLivro.BotaoEditarClick(Sender: TObject);
begin
  HabilitarEdicao();
end;

procedure TFormularioCadastroLivro.BotaoExcluirClick(Sender: TObject);
begin
  if TDialogo.Confirmar('Confirma a exclusão do livro?') then
    begin
      TLivroDAO.Excluir(StrToIntDef(CampoCodigo.Text, 0));
      LimparFormulario();
      TDialogo.Informar('Livro excluído com sucesso.');
    end;
end;

procedure TFormularioCadastroLivro.BotaoIncluirClick(Sender: TObject);
begin
  LimparFormulario();
  HabilitarEdicao();
end;

procedure TFormularioCadastroLivro.BotaoSalvarClick(Sender: TObject);
var Livro : TLivro;
begin
  Livro := TLivro.Create();

  Livro.Codigo  := StrToIntDef(CampoCodigo.Text, 0);
  Livro.Titulo  := CampoTitulo.Text;
  Livro.Editora := CampoEditora.Text;
  Livro.Autor   := CampoAutor.Text;

  if Livro.IsValido() then
    begin
      TLivroDAO.Gravar(Livro);
      CampoCodigo.Text := Livro.Codigo.ToString();
      TDialogo.Informar('Livro gravado com sucesso.');
      DesabilitarEdicao;
    end;

  FreeAndNil(Livro);
end;

procedure TFormularioCadastroLivro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormularioCadastroLivro.FormDestroy(Sender: TObject);
begin
  FormularioCadastroLivro := nil;
end;

procedure TFormularioCadastroLivro.FormShow(Sender: TObject);
begin
  DesabilitarEdicao();
end;

procedure TFormularioCadastroLivro.LimparFormulario;
begin
  CampoCodigo.Text  := '';
  CampoTitulo.Text  := '';
  CampoEditora.Text := '';
  CampoAutor.Text   := '';
end;

procedure TFormularioCadastroLivro.HabilitarEdicao;
begin
  GrupoRegistro.Enabled := True;
  BotaoSalvar.Enabled := True;
  BotaoCancelar.Enabled := True;

  BotaoIncluir.Enabled := False;
  BotaoConsultar.Enabled := False;
  BotaoEditar.Enabled := False;
  BotaoExcluir.Enabled := False;

  CampoTitulo.SetFocus();
end;

procedure TFormularioCadastroLivro.DesabilitarEdicao;
begin
  GrupoRegistro.Enabled := False;
  BotaoSalvar.Enabled := False;
  BotaoCancelar.Enabled := False;

  BotaoIncluir.Enabled := True;
  BotaoConsultar.Enabled := True;
  BotaoEditar.Enabled := Trim(CampoCodigo.Text) <> '';
  BotaoExcluir.Enabled := Trim(CampoCodigo.Text) <> '';
end;

procedure TFormularioCadastroLivro.CarregarLivro(Livro: TLivro);
begin
  CampoCodigo.Text  := Livro.Codigo.ToString();
  CampoTitulo.Text  := Livro.Titulo;
  CampoEditora.Text := Livro.Editora;
  CampoAutor.Text   := Livro.Autor;
end;

end.
