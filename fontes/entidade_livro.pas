unit entidade_livro;

interface

type
  TLivro = class
  private
    FCodigo: Integer;
    FTitulo: string;
    FEditora: string;
    FAutor: string;
    procedure SetCodigo(const Value: Integer);
    procedure SetTitulo(const Value: string);
    procedure SetEditora(const Value: string);
    procedure SetAutor(const Value: string);
  public
    property Codigo : Integer read FCodigo write SetCodigo;
    property Titulo : string read FTitulo write SetTitulo;
    property Editora : string read FEditora write SetEditora;
    property Autor : string read FAutor write SetAutor;
    function IsValido : Boolean;
  end;

implementation

uses
  SysUtils, util_dialogo, util_validador;

function TLivro.IsValido: Boolean;
begin
  Result := False;

  if Trim(FTitulo) = '' then
  begin
    TDialogo.Informar('O campo título é de preenchimento obrigatório.');
    Exit;
  end;

  if Trim(FEditora) = '' then
  begin
    TDialogo.Informar('O campo editora é de preenchimento obrigatório.');
    Exit;
  end;

  if Trim(FAutor) = '' then
  begin
    TDialogo.Informar('O campo autor é de preenchimento obrigatório.');
    Exit;
  end;

  Result := True;
end;

procedure TLivro.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TLivro.SetTitulo(const Value: string);
begin
  FTitulo := Value;
end;


procedure TLivro.SetEditora(const Value: string);
begin
  FEditora := Value;
end;

procedure TLivro.SetAutor(const Value: string);
begin
  FAutor := Value;
end;

end.
