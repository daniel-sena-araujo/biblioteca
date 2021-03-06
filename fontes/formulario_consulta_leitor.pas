unit formulario_consulta_leitor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, entidade_leitor, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls;

type
  TFormularioConsultaLeitor = class(TForm)
    GrupoFiltros: TGroupBox;
    TextoNomeCpf: TLabel;
    CampoNomeCpf: TEdit;
    BotaoConsultar: TBitBtn;
    GrupoResultado: TGroupBox;
    BarraStatus: TStatusBar;
    ListaLeitores: TListView;
    procedure FormCreate(Sender: TObject);
    procedure BotaoConsultarClick(Sender: TObject);
    procedure ListaLeitoresDblClick(Sender: TObject);
    procedure CampoNomeCpfKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FLeitor: TLeitor;
  public
    property Leitor : TLeitor read FLeitor;
  end;

var
  FormularioConsultaLeitor: TFormularioConsultaLeitor;

implementation

{$R *.dfm}

uses
  Generics.Collections, dao_leitor, util_formatador, util_dialogo;

procedure TFormularioConsultaLeitor.BotaoConsultarClick(Sender: TObject);
var
  Lista : TObjectList<TLeitor>;
  Indice : Integer;
  Item : TListItem;
begin
  Lista := TLeitorDAO.RecuperarPorNomeOuCpf(CampoNomeCpf.Text);

  ListaLeitores.Items.Clear();

  for Indice := 0 to Pred(Lista.Count) do
  begin
    Item := ListaLeitores.Items.Add();
    Item.Caption := Lista.Items[Indice].Codigo.ToString();
    Item.SubItems.Add(Lista.Items[Indice].Nome);
    Item.SubItems.Add(TFormatador.FormatarCpf(Lista.Items[Indice].Cpf));
    Item.Data := Lista.Items[Indice];
  end;

  if ListaLeitores.Items.Count = 0 then
    TDialogo.Informar('A consulta n�o obteve resultados');
end;

procedure TFormularioConsultaLeitor.CampoNomeCpfKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    BotaoConsultar.Click();
end;

procedure TFormularioConsultaLeitor.FormCreate(Sender: TObject);
begin
  FLeitor := TLeitor.Create();
end;

procedure TFormularioConsultaLeitor.FormShow(Sender: TObject);
begin
  CampoNomeCpf.Text := '';
  ListaLeitores.Items.Clear();
end;

procedure TFormularioConsultaLeitor.ListaLeitoresDblClick(Sender: TObject);
begin
  if ListaLeitores.Selected = nil then
    Exit;

  Fleitor := ListaLeitores.Selected.Data;
  Close();
end;

end.
