unit untProduto.LookUp;

interface

uses
  untProduto;
type
  TProdutoLookup = class
    class function Choose : TProduto;
  end;

implementation

uses
  untLookUp
  , untRepositorio.Produto.Provider
  , SysUtils
;

{ TProdutoLookup }

class function TProdutoLookup.Choose: TProduto;
var
  _prodSelecionado: string;
begin
  Result := nil;

  _prodSelecionado :=
    LookUpGenerico(
      ' SELECT '+
        ' prod_id AS ID, '+
        ' prod_descricao AS Descrição, '+
        ' prod_preco AS Valor '+
      ' FROM '+
        ' produto ',
      'Pesquisar Produtos',
      0,
      [50, 400, 200]
    );

  if _prodSelecionado.isEmpty then
    Exit;

  Result := ProdutoRepo.Load(StrToInt(_prodSelecionado));
end;

end.
