unit untPedido;
interface
uses
  untCliente
  , System.Generics.Collections
  , untItemPedido
  , untItemPedido.Lista
;
type
  TPedido = class
  strict private
    FCodigo: integer;
    FItems: TItemPedidoLista;
    FCliente: TCliente;
    FData: TDate;
    procedure SetCliente(const Value: TCliente);
    procedure SetData(const Value: TDate);
    procedure SetCodigo(const Value: integer);
  public
    property Codigo : integer read FCodigo write SetCodigo;
    Property Cliente : TCliente read FCliente write SetCliente;
    property Itens : TItemPedidoLista read FItems;
    property Data : TDate read FData write SetData;
    function GetValorTotalPedido : Currency;
    constructor Create;
    destructor Destroy; override;
  end;
implementation

{ TPedido }
constructor TPedido.Create;
begin
  FItems := TItemPedidoLista.Create;
end;
destructor TPedido.Destroy;
begin
  FItems.Free;
  inherited;
end;
function TPedido.GetValorTotalPedido: Currency;
var
  _aux : Currency;
begin
  Result := 0;
  self.FItems.Iterar(
    procedure (AProd : TItemPedido)
    begin
      _aux := _aux + AProd.GetValorTotal;
    end
  );
  Result := _aux;
end;
procedure TPedido.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;
procedure TPedido.SetCodigo(const Value: integer);
begin
  FCodigo := Value;
end;
procedure TPedido.SetData(const Value: TDate);
begin
  FData := Value;
end;
end.
