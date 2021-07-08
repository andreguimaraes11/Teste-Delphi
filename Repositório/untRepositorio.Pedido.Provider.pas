unit untRepositorio.Pedido.Provider;

interface

uses
  untRepositorio.Pedido.Intf;

var
  PedidoRepo : IPedidoRepo;

implementation

initialization
  PedidoRepo := nil;
end.
