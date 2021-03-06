unit entidade_leitor;

interface

type
  TLeitor = class
  private
    FDataNascimento: TDateTime;
    FAtivo: Integer;
    FEstadoCivil: Integer;
    FCodigo: Integer;
    FEscolaridade: Integer;
    FCpf: string;
    FNome: string;
    FEndereco: string;
    FTelefone: string;
    procedure SetAtivo(const Value: Integer);
    procedure SetCodigo(const Value: Integer);
    procedure SetCpf(const Value: string);
    procedure SetDataNascimento(const Value: TDateTime);
    procedure SetEndereco(const Value: string);
    procedure SetEscolaridade(const Value: Integer);
    procedure SetEstadoCivil(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetTelefone(const Value: string);
  public
    property Codigo : Integer read FCodigo write SetCodigo;
    property Nome : string read FNome write SetNome;
    property Endereco : string read FEndereco write SetEndereco;
    property Telefone : string read FTelefone write SetTelefone;
    property Cpf : string read FCpf write SetCpf;
    property DataNascimento : TDateTime read FDataNascimento write SetDataNascimento;
    property EstadoCivil : Integer read FEstadoCivil write SetEstadoCivil;
    property Ativo : Integer read FAtivo write SetAtivo;
    property Escolaridade : Integer read FEscolaridade write SetEscolaridade;
    function IsValido:Boolean;
  end;

implementation

uses
  SysUtils, util_dialogo, util_validador;

function TLeitor.IsValido: Boolean;
begin
  Result := False;

  if Trim(FNome) = '' then
  begin
    TDialogo.Informar('O campo nome � de preenchimento obrigat�rio.');
    Exit;
  end;

  if FDataNascimento > Date() then
  begin
    TDialogo.Informar('A data de nascimento n�o pode ser maior que a data atual.');
    Exit;
  end;

  if FCpf <> '' then
  begin
    if not TValidador.ValidarCpf(FCpf) then
    begin
      TDialogo.Informar('O CPF informado � inv�lido.');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TLeitor.SetAtivo(const Value: Integer);
begin
  FAtivo := Value;
end;

procedure TLeitor.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TLeitor.SetCpf(const Value: string);
begin
  FCpf := Value;
end;

procedure TLeitor.SetDataNascimento(const Value: TDateTime);
begin
  FDataNascimento := Value;
end;

procedure TLeitor.SetEndereco(const Value: string);
begin
  FEndereco := Value;
end;

procedure TLeitor.SetEscolaridade(const Value: Integer);
begin
  FEscolaridade := Value;
end;

procedure TLeitor.SetEstadoCivil(const Value: Integer);
begin
  FEstadoCivil := Value;
end;

procedure TLeitor.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TLeitor.SetTelefone(const Value: string);
begin
  FTelefone := Value;
end;

end.
