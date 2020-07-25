unit dao_livro;

interface

uses entidade_livro;

type
  TLivroDAO = class
    private
      class procedure Inserir(var Livro : TLivro);
      class procedure Atualizar(var Livro : TLivro);
    public
      class procedure Gravar(var Livro : TLivro);
      class procedure Excluir(Codigo : Integer);
      class function RecuperarPorCodigo(Codigo : Integer):TLivro;
  end;

implementation

uses data_module, FireDAC.Comp.Client, FireDAC.Stan.Param, SysUtils, DB,
  Variants;

class procedure TLivroDAO.Inserir(var Livro: TLivro);
var
  Query : TFDQuery;
begin
  ConexaoBancoDados.CriarQuery(Query);

  Query.SQL.Add('INSERT INTO tb_livro ');
  Query.SQL.Add('            (titulo  ');
  Query.SQL.Add('            ,autor   ');
  Query.SQL.Add('            ,editora)');
  Query.SQL.Add('     VALUES          ');
  Query.SQL.Add('           (:titulo  ');
  Query.SQL.Add('           ,:autor   ');
  Query.SQL.Add('           ,:editora)');

  Query.ParamByName('titulo').AsString := Livro.Titulo;
  Query.ParamByName('autor').AsString := Livro.Autor;
  Query.ParamByName('editora').AsString := Livro.Editora;

  Query.ExecSQL;

  Query.SQL.Clear();

  Query.SQL.Add('SELECT MAX(codigo)     ');
  Query.SQL.Add('  FROM tb_livro        ');
  Query.SQL.Add(' WHERE titulo = :titulo');

  Query.ParamByName('titulo').AsString := Livro.Titulo;

  Query.Open();

  Livro.Codigo := Query.Fields[0].AsInteger;

  Query.Close();

  FreeAndNil(Query);

end;

class procedure TLivroDAO.Gravar(var Livro: TLivro);
begin
  if Livro.Codigo > 0 then
    TLivroDAO.Atualizar(Livro)
  else
    TLivroDAO.Inserir(Livro);
end;

class procedure TLivroDAO.Atualizar(var Livro: TLivro);
var
  Query : TFDQuery;
begin
  ConexaoBancoDados.CriarQuery(Query);

  Query.SQL.Add('UPDATE tb_livro          ');
  Query.SQL.Add('   SET titulo  = :titulo ');
  Query.SQL.Add('      ,editora = :editora');
  Query.SQL.Add('      ,autor   = :autor  ');
  Query.SQL.Add(' WHERE codigo  = :codigo ');

  Query.ParamByName('codigo').AsInteger := Livro.Codigo;
  Query.ParamByName('titulo').AsString := Livro.Titulo;
  Query.ParamByName('editora').AsString := Livro.Editora;
  Query.ParamByName('autor').AsString := Livro.Autor;

  Query.ExecSQL();

  FreeAndNil(Query);
end;


class procedure TLivroDAO.Excluir(Codigo: Integer);
var
  Query : TFDQuery;
begin
  ConexaoBancoDados.CriarQuery(Query);

  Query.SQL.Add('DELETE tb_livro        ');
  Query.SQL.Add(' WHERE codigo = :codigo');

  Query.ParamByName('codigo').AsInteger := Codigo;

  Query.ExecSQL();

  FreeAndNil(Query);
end;


class function TLivroDAO.RecuperarPorCodigo(Codigo: Integer): TLivro;
var
  Query : TFDQuery;
  Livro : TLivro;
begin
  ConexaoBancoDados.CriarQuery(Query);

  Query.SQL.Add('SELECT codigo          ');
  Query.SQL.Add('      ,titulo          ');
  Query.SQL.Add('      ,editora         ');
  Query.SQL.Add('      ,autor           ');
  Query.SQL.Add('  FROM tb_livro      ');
  Query.SQL.Add(' WHERE codigo = :codigo');

  Query.ParamByName('codigo').AsInteger := Codigo;

  Query.Open();

  if Query.IsEmpty then
  begin
    Result := nil;
  end
  else
  begin
    Livro := TLivro.Create();

    Livro.Codigo  := Query.FieldByName('codigo').AsInteger;
    Livro.Titulo  := Query.FieldByName('titulo').AsString;
    Livro.Editora := Query.FieldByName('editora').AsString;
    Livro.Autor   := Query.FieldByName('autor').AsString;

    Result := Livro;
  end;

  FreeAndNil(Query);
end;

end.
