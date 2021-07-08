unit untInitialize;

interface
  procedure InicializarRepositorios;

implementation

uses
  untRepositorio.Produto.Provider,
  untRepositorio.Produto,
  untRepositorio.Cliente,
  untRepositorio.Cliente.Provider,
  untRepositorio.Pedido,
  untRepositorio.Pedido.Provider;

procedure InicializarRepositorios;
begin
  ProdutoRepo := TProdutoRepo.Create;
  ClienteRepo := TClienteRepo.Create;
  PedidoRepo  := TPedidoRepo.Create;
end;


end.
