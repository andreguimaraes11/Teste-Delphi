unit untRepositorio.Produto;

interface

uses
  untRepositorio.Produto.Intf,
  untProduto;
type
  TProdutoRepo = class(TInterfacedObject, IProdutoRepo)
    procedure Save(AProduto : TProduto);
    procedure Delete(AID : integer);
    function Load(AID : integer) : TProduto;
  end;

implementation

uses
  untProduto.Mapper;

{ TProdutoRepo }

procedure TProdutoRepo.Delete(AID: integer);
begin
  TProdutoMapper.Delete(AID);
end;

function TProdutoRepo.Load(AID: integer): TProduto;
begin
  Result := TProdutoMapper.Load(AID);
end;

procedure TProdutoRepo.Save(AProduto: TProduto);
begin
  TProdutoMapper.Save(AProduto);
end;

end.
