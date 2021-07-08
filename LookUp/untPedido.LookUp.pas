unit untPedido.LookUp;

interface
uses
  untPedido;
type
  TPedidoLookup = class
    class function Choose : TPedido;
  end;

implementation
uses
  untLookUp
  , untRepositorio.Pedido.Provider
  , System.SysUtils
;

{ TPedidoLookup }

class function TPedidoLookup.Choose: TPedido;
var
  _pedSelecionado: string;
begin
  Result := nil;

  _pedSelecionado :=
    LookUpGenerico(
      ' SELECT '+
        ' ped_id AS ID, '+
        ' cli_nome AS Cliente, '+
        ' ped_data AS Data, '+
        ' ped_vlr_total AS Valor '+
      ' FROM '+
        ' pedido '+
      ' LEFT JOIN '+
        ' cliente ON ped_cliente_id = cli_id ',
      'Pesquisar Pedidos',
      0,
      [50, 400, 100, 150]
    );

  if _pedSelecionado.isEmpty then
    Exit;

  Result := PedidoRepo.Load(StrToInt(_pedSelecionado));
end;

end.
