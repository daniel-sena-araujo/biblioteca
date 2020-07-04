program biblioteca;

uses
  Vcl.Forms,
  formulario_principal in 'formulario_principal.pas' {FormularioPrincipal},
  formulario_cadastro_leitor in 'formulario_cadastro_leitor.pas' {FormularioCadastroLeitor},
  entidade_leitor in 'entidade_leitor.pas',
  constante_estado_civil in 'constante_estado_civil.pas',
  constante_escolaridade in 'constante_escolaridade.pas',
  constante_ativo in 'constante_ativo.pas',
  util_dialogo in 'util_dialogo.pas',
  dao_leitor in 'dao_leitor.pas',
  data_module in 'data_module.pas' {ConexaoBancoDados: TDataModule},
  formulario_consulta_leitor in 'formulario_consulta_leitor.pas' {FormularioConsultaLeitor},
  util_formatador in 'util_formatador.pas',
  util_validador in 'util_validador.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormularioPrincipal, FormularioPrincipal);
  Application.CreateForm(TConexaoBancoDados, ConexaoBancoDados);
  Application.CreateForm(TFormularioConsultaLeitor, FormularioConsultaLeitor);
  Application.Run;
end.
