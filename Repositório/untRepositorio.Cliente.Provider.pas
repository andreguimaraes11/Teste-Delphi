unit untRepositorio.Cliente.Provider;

interface

uses
  untRepositorio.Cliente.Intf;

var
  ClienteRepo : IClienteRepo;

implementation

initialization
  ClienteRepo := nil;
end.
