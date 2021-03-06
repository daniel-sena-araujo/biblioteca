unit dao_leitor;

interface

uses
  entidade_leitor, Generics.Collections;

type
  TLeitorDAO = class
  private
    class procedure Inserir(var Leitor : TLeitor);
    class procedure Atualizar(var Leitor : TLeitor);
  public
    class procedure Gravar(var Leitor : TLeitor);
    class function RecuperarPorCodigo(Codigo : Integer):TLeitor;
    class function RecuperarPorNomeOuCpf(NomeOuCpf : string):TObjectList<TLeitor>;
    class procedure Excluir(Codigo : Integer);
  end;

implementation

uses data_module, FireDAC.Comp.Client, FireDAC.Stan.Param, SysUtils, DB,
  Variants;

class procedure TLeitorDAO.Atualizar(var Leitor: TLeitor);
var
  Query : TFDQuery;
begin
  ConexaoBancoDados.CriarQuery(Query);

  Query.SQL.Add('UPDATE tb_leitor                         ');
  Query.SQL.Add('   SET nome = :nome                      ');
  Query.SQL.Add('      ,endereco = :endereco              ');
  Query.SQL.Add('      ,telefone = :telefone              ');
  Query.SQL.Add('      ,cpf = :cpf                        ');
  Query.SQL.Add('      ,data_nascimento = :data_nascimento');
  Query.SQL.Add('      ,estado_civil = :estado_civil      ');
  Query.SQL.Add('      ,ativo = :ativo                    ');
  Query.SQL.Add('      ,escolaridade = :escolaridade      ');
  Query.SQL.Add(' WHERE codigo = :codigo                  ');

  Query.ParamByName('nome').AsString := Leitor.Nome;
  Query.ParamByName('endereco').AsString := Leitor.Endereco;
  Query.ParamByName('telefone').AsString := Leitor.Telefone;
  Query.ParamByName('cpf').AsString := Leitor.Cpf;

  if Leitor.DataNascimento = 0 then
  begin
    Query.ParamByName('data_nascimento').DataType := ftDateTime;
    Query.ParamByName('data_nascimento').Clear();
  end
  else
  begin
    Query.ParamByName('data_nascimento').AsDateTime := Leitor.DataNascimento;
  end;

  Query.ParamByName('estado_civil').AsInteger := Leitor.EstadoCivil;
  Query.ParamByName('ativo').AsInteger := Leitor.Ativo;
  Query.ParamByName('escolaridade').AsInteger := Leitor.Escolaridade;
  Query.ParamByName('codigo').AsInteger := Leitor.Codigo;

  Query.ExecSQL();

  FreeAndNil(Query);
end;

class procedure TLeitorDAO.Excluir(Codigo: Integer);
var
  Query : TFDQuery;
begin
  ConexaoBancoDados.CriarQuery(Query);

  Query.SQL.Add('DELETE tb_leitor       ');
  Query.SQL.Add(' WHERE codigo = :codigo');

  Query.ParamByName('codigo').AsInteger := Codigo;

  Query.ExecSQL();

  FreeAndNil(Query);
end;

class procedure TLeitorDAO.Gravar(var Leitor: TLeitor);
begin
  if Leitor.Codigo > 0 then
    TLeitorDAO.Atualizar(Leitor)
  else
    TLeitorDAO.Inserir(Leitor);
end;

class procedure TLeitorDAO.Inserir(var Leitor: TLeitor);
var
  Query : TFDQuery;
begin
  ConexaoBancoDados.CriarQuery(Query);

  Query.SQL.Add('INSERT INTO tb_leitor       ');
  Query.SQL.Add('           (nome            ');
  Query.SQL.Add('           ,endereco        ');
  Query.SQL.Add('           ,telefone        ');
  Query.SQL.Add('           ,cpf             ');
  Query.SQL.Add('           ,data_nascimento ');
  Query.SQL.Add('           ,estado_civil    ');
  Query.SQL.Add('           ,ativo           ');
  Query.SQL.Add('           ,escolaridade)   ');
  Query.SQL.Add('     VALUES                 ');
  Query.SQL.Add('           (:nome           ');
  Query.SQL.Add('           ,:endereco       ');
  Query.SQL.Add('           ,:telefone       ');
  Query.SQL.Add('           ,:cpf            ');
  Query.SQL.Add('           ,:data_nascimento');
  Query.SQL.Add('           ,:estado_civil   ');
  Query.SQL.Add('           ,:ativo          ');
  Query.SQL.Add('           ,:escolaridade)  ');

  Query.ParamByName('nome').AsString := Leitor.Nome;
  Query.ParamByName('endereco').AsString := Leitor.Endereco;
  Query.ParamByName('telefone').AsString := Leitor.Telefone;
  Query.ParamByName('cpf').AsString := Leitor.Cpf;

  if Leitor.DataNascimento = 0 then
  begin
    Query.ParamByName('data_nascimento').DataType := ftDateTime;
    Query.ParamByName('data_nascimento').Clear();
  end
  else
  begin
    Query.ParamByName('data_nascimento').AsDateTime := Leitor.DataNascimento;
  end;

  Query.ParamByName('estado_civil').AsInteger := Leitor.EstadoCivil;
  Query.ParamByName('ativo').AsInteger := Leitor.Ativo;
  Query.ParamByName('escolaridade').AsInteger := Leitor.Escolaridade;

  Query.ExecSQL();

  Query.SQL.Clear();

  Query.SQL.Add('SELECT MAX(codigo) ');
  Query.SQL.Add('  FROM tb_leitor   ');
  Query.SQL.Add(' WHERE nome = :nome');

  Query.ParamByName('nome').AsString := Leitor.Nome;

  Query.Open();

  Leitor.Codigo := Query.Fields[0].AsInteger;

  Query.Close();

  FreeAndNil(Query);
end;

class function TLeitorDAO.RecuperarPorCodigo(Codigo: Integer): TLeitor;
var
  Query : TFDQuery;
  Leitor : TLeitor;
begin
  ConexaoBancoDados.CriarQuery(Query);

  Query.SQL.Add('SELECT codigo          ');
  Query.SQL.Add('      ,nome            ');
  Query.SQL.Add('      ,endereco        ');
  Query.SQL.Add('      ,telefone        ');
  Query.SQL.Add('      ,cpf             ');
  Query.SQL.Add('      ,data_nascimento ');
  Query.SQL.Add('      ,estado_civil    ');
  Query.SQL.Add('      ,ativo           ');
  Query.SQL.Add('      ,escolaridade    ');
  Query.SQL.Add('  FROM tb_leitor       ');
  Query.SQL.Add(' WHERE codigo = :codigo');

  Query.ParamByName('codigo').AsInteger := Codigo;

  Query.Open();

  if Query.IsEmpty then
  begin
    Result := nil;
  end
  else
  begin
    Leitor := TLeitor.Create();

    Leitor.Codigo := Query.FieldByName('codigo').AsInteger;
    Leitor.Nome := Query.FieldByName('nome').AsString;
    Leitor.Endereco := Query.FieldByName('endereco').AsString;
    Leitor.Telefone := Query.FieldByName('telefone').AsString;
    Leitor.Cpf := Query.FieldByName('cpf').AsString;
    Leitor.DataNascimento := 0;

    if Query.FieldByName('data_nascimento').AsString <> '' then
    begin
      Leitor.DataNascimento := Query.FieldByName('data_nascimento').AsDateTime;
    end;

    Leitor.EstadoCivil := Query.FieldByName('estado_civil').AsInteger;
    Leitor.Ativo := Query.FieldByName('ativo').AsInteger;
    Leitor.Escolaridade := Query.FieldByName('escolaridade').AsInteger;

    Result := Leitor;
  end;

  FreeAndNil(Query);
end;

class function TLeitorDAO.RecuperarPorNomeOuCpf(
  NomeOuCpf: string): TObjectList<TLeitor>;
var
  Query : TFDQuery;
  Leitor : TLeitor;
begin
  ConexaoBancoDados.CriarQuery(Query);

  Query.SQL.Add('SELECT codigo          ');
  Query.SQL.Add('      ,nome            ');
  Query.SQL.Add('      ,endereco        ');
  Query.SQL.Add('      ,telefone        ');
  Query.SQL.Add('      ,cpf             ');
  Query.SQL.Add('      ,data_nascimento ');
  Query.SQL.Add('      ,estado_civil    ');
  Query.SQL.Add('      ,ativo           ');
  Query.SQL.Add('      ,escolaridade    ');
  Query.SQL.Add('  FROM tb_leitor       ');
  Query.SQL.Add(' WHERE nome LIKE :nome ');
  Query.SQL.Add('    OR cpf LIKE :cpf   ');

  Query.ParamByName('nome').AsString := '%' + NomeOuCpf + '%';
  Query.ParamByName('cpf').AsString := '%' + NomeOuCpf + '%';

  Query.Open();

  Result := TObjectList<TLeitor>.Create();

  while not Query.Eof do
  begin
    Leitor := TLeitor.Create();

    Leitor.Codigo := Query.FieldByName('codigo').AsInteger;
    Leitor.Nome := Query.FieldByName('nome').AsString;
    Leitor.Endereco := Query.FieldByName('endereco').AsString;
    Leitor.Telefone := Query.FieldByName('telefone').AsString;
    Leitor.Cpf := Query.FieldByName('cpf').AsString;
    Leitor.DataNascimento := 0;

    if Query.FieldByName('data_nascimento').AsString <> '' then
    begin
      Leitor.DataNascimento := Query.FieldByName('data_nascimento').AsDateTime;
    end;

    Leitor.EstadoCivil := Query.FieldByName('estado_civil').AsInteger;
    Leitor.Ativo := Query.FieldByName('ativo').AsInteger;
    Leitor.Escolaridade := Query.FieldByName('escolaridade').AsInteger;

    Result.Add(Leitor);

    Query.Next();
  end;

  FreeAndNil(Query);
  //FreeAndNil(Leitor);
end;

end.
