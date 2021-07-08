unit untCliente;

interface

uses
  untCidade;
type
  TCliente = class
  strict private
    FCodigo: integer;
    FNome: string;
    FCidade: TCidade;
    procedure SetCidade(const Value: TCidade);
    procedure SetCodigo(const Value: integer);
    procedure SetNome(const Value: string);
  public
    property Codigo : integer read FCodigo write SetCodigo;
    property Nome : string read FNome write SetNome;
    property Cidade : TCidade read FCidade write SetCidade;

    destructor Destroy; override;
  end;

implementation

{ TCliente }

destructor TCliente.Destroy;
begin
  if Assigned(FCidade) then
    FCidade.Free;
  inherited;
end;

procedure TCliente.SetCidade(const Value: TCidade);
begin
  FCidade := Value;
end;

procedure TCliente.SetCodigo(const Value: integer);
begin
  FCodigo := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  FNome := Value;
end;

end.
