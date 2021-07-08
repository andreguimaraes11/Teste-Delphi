unit untProduto;

interface
type
  TProduto = class
  strict private
    FDescricao: string;
    FCodigo: integer;
    FPrecoUnitario: Currency;
    procedure SetCodigo(const Value: integer);
    procedure SetDescricao(const Value: string);
    procedure SetPrecoUnitario(const Value: Currency);
  public
    property Codigo : integer read FCodigo write SetCodigo;
    property Descricao : string read FDescricao write SetDescricao;
    property PrecoUnitario : Currency read FPrecoUnitario write SetPrecoUnitario;
  end;

implementation

uses
  System.SysUtils;

{ TProduto }

procedure TProduto.SetCodigo(const Value: integer);
begin
  FCodigo := Value;
end;

procedure TProduto.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TProduto.SetPrecoUnitario(const Value: Currency);
begin
  FPrecoUnitario := Value;
end;

end.
