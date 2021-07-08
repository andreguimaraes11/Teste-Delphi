unit untItemPedido.Lista;

interface

uses
  System.Generics.Collections
  , untItemPedido, System.SysUtils
;
type
  TItemPedidoLista = class
  strict private
    FItems: TObjectList<TItemPedido>;
  public
    procedure Iterar(AProc : TProc<TItemPedido>);
    procedure Add(AProd : TItemPedido);

    procedure Remove(AProd : TItemPedido);
    procedure RemoveByID(AID : integer);

    function Count : integer;
    function GetByIDProd(AID : integer) : TItemPedido;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  untExceptions;

{ TItemPedidoLista }

procedure TItemPedidoLista.Add(AProd: TItemPedido);
begin
  self.Iterar(
    procedure (AProdJaIncluido : TItemPedido)
    begin
      if AProd.Produto.Codigo = AProdJaIncluido.Produto.Codigo then
        raise EProdutoJaAdicionado.Create('[TItemPedidoLista] - Produto já incluído na lista.');
    end
  );

  FItems.Add(AProd);
  FItems.TrimExcess;
end;

function TItemPedidoLista.Count: integer;
begin
  result := FItems.Count;
end;

constructor TItemPedidoLista.Create;
begin
  FItems := TObjectList<TItemPedido>.Create;
  FItems.OwnsObjects := True;
end;

destructor TItemPedidoLista.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TItemPedidoLista.GetByIDProd(AID: integer): TItemPedido;
var
  _ok : boolean;
  _item : TItemPedido;
begin
  Result := nil;
  _ok    := false;

  self.Iterar(
    procedure (AProdJaIncluido : TItemPedido)
    begin
      if AID <> AProdJaIncluido.Produto.Codigo then
        Exit;

      _item := AProdJaIncluido;
      _ok   := True;
    end
  );

  if not _ok then
    raise Exception.Create('[TItemPedidoLista] - Produto ['+AID.ToString+'] não encontrado na lista.');

  Result := _item;
end;

procedure TItemPedidoLista.Iterar(AProc: TProc<TItemPedido>);
var
  I: Integer;
begin
  if not Assigned(AProc) then
    raise Exception.Create('[TItemPedidoLista] - Procedure de Iteração não instanciada.');

  for I := 0 to pred(FItems.Count) do
    AProc(FItems[i]);
end;

procedure TItemPedidoLista.Remove(AProd: TItemPedido);
begin
  FItems.Remove(AProd);
end;

procedure TItemPedidoLista.RemoveByID(AID: integer);
begin
  self.Iterar(
    procedure (AProdJaIncluido : TItemPedido)
    begin
      if AID <> AProdJaIncluido.Produto.Codigo then
        Exit;

      FItems.Remove(AProdJaIncluido);
    end
  );
end;

end.
