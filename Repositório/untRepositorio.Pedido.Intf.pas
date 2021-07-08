unit untRepositorio.Pedido.Intf;

interface

uses
  untPedido;
type
  IPedidoRepo = interface
    ['{CDF5E1B8-8E80-4FDD-9255-C5FD1514D9F7}']

    procedure Save(APedido : TPedido);
    procedure Delete(AID : integer);
    function Load(AID : integer) : TPedido;
  end;

implementation

end.
