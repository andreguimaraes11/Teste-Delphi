unit untRepositorio.Cliente;

interface

uses
  untRepositorio.Cliente.Intf,
  untCliente;
type
  TClienteRepo = class(TInterfacedObject, IClienteRepo)
    procedure Save(ACliente: TCliente);
    procedure Delete(AID : integer);
    function Load(AID : integer) : TCliente;
  end;

implementation

uses
  untCliente.Mapper;

{ TClienteRepo }

procedure TClienteRepo.Delete(AID: integer);
begin
  TClienteMapper.Delete(AID);
end;

function TClienteRepo.Load(AID: integer): TCliente;
begin
  Result := TClienteMapper.Load(AID);
end;

procedure TClienteRepo.Save(ACliente: TCliente);
begin
  TClienteMapper.Save(ACliente);
end;

end.
