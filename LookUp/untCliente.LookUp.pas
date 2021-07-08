unit untCliente.LookUp;

interface

uses
  untCliente;
type
  TClienteLookup = class
    class function Choose : TCliente;
  end;
implementation
uses
  untLookUp
  , System.SysUtils
  , untRepositorio.Cliente.Provider
;

{ TClienteLookup }

class function TClienteLookup.Choose: TCliente;
var
  _cliSelecionado: string;
begin
  Result := nil;

  _cliSelecionado :=
    LookUpGenerico(
      ' SELECT '+
        ' cli_id AS ID, '+
        ' cli_nome AS Nome, '+
        ' cli_cidade AS Cidade '+
      ' FROM '+
        ' cliente ',
      'Pesquisar Clientes',
      0,
      [50, 400, 200]
    );

  if _cliSelecionado.isEmpty then
    Exit;

  Result := ClienteRepo.Load(StrToInt(_cliSelecionado));
end;

end.
