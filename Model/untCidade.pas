unit untCidade;

interface
type
  TCidade = class
  strict private
    FUF: string;
    FNome: string;
    procedure SetNome(const Value: string);
    procedure SetUF(const Value: string);
  public
    property Nome : string read FNome write SetNome;
    property UF : string read FUF write SetUF;
  end;

implementation

{ Tcidade }

procedure TCidade.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TCidade.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
