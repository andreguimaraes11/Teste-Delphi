unit untRepositorio.Produto.Intf;

interface

uses
  untProduto;
type
  IProdutoRepo = interface
    ['{AE15DF6A-2C92-4FC4-8EFD-71C5AD1DB303}']

    procedure Save(AProduto : TProduto);
    procedure Delete(AID : integer);
    function Load(AID : integer) : TProduto;
  end;

implementation

end.
