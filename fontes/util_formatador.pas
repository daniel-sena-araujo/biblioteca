unit util_formatador;

interface

type
  TFormatador = class
  private
  public
    class function FormatarCpf(Cpf : string):string;
  end;

implementation

uses
  SysUtils;

class function TFormatador.FormatarCpf(Cpf: string): string;
begin
  if Trim(Cpf) = '' then
    Result := ''
  else
    Result := Copy(Cpf, 1, 3) + '.' + Copy(Cpf, 4, 3) + '.' + Copy(Cpf, 7, 3) +
      '-' + Copy(Cpf, 10, 2);
end;

end.
