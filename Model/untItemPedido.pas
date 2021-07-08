unit untItemPedido;

interface

uses
  untProduto;
type
  TItemPedido = class
  private
    FProduto: TProduto;
    FQuantidade: Double;
    FID: integer;
    procedure SetProduto(const Value: TProduto);
    procedure SetQuantidade(const Value: Double);
    procedure SetID(const Value: integer);
   public
     property ID : integer read FID write SetID;
     property Produto : TProduto read FProduto write SetProduto;
     property Quantidade : Double read FQuantidade write SetQuantidade;

     function GetValorTotal : Double;
  end;

implementation
uses
  Math;

{ TItemPedido }

function TItemPedido.GetValorTotal: Double;
begin
  Result := RoundTo(FProduto.PrecoUnitario * FQuantidade, -2);
end;

procedure TItemPedido.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TItemPedido.SetProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TItemPedido.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

end.
