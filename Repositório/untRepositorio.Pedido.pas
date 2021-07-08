unit untRepositorio.Pedido;

interface

uses
  untRepositorio.Pedido.Intf, untPedido;
type
  TPedidoRepo = class(TInterfacedObject, IPedidoRepo)
  public
    procedure Save(APedido : TPedido);
    procedure Delete(AID : integer);
    function Load(AID : integer) : TPedido;
  end;

implementation

uses
  untPedido.Mapper;

{ TPedidoRepo }

procedure TPedidoRepo.Delete(AID: integer);
begin
  TPedidoMapper.Delete(AID);
end;

function TPedidoRepo.Load(AID: integer): TPedido;
begin
  Result := TPedidoMapper.Load(AID);
end;

procedure TPedidoRepo.Save(APedido: TPedido);
begin
  TPedidoMapper.Save(APedido);
end;

end.
