unit untRepositorio.Cliente.Intf;

interface

uses
  untCliente;
type
  IClienteRepo = interface
    ['{A8ED0E96-4184-48D8-9FE3-1F9E41095665}']

    procedure Save(ACliente : TCliente);
    procedure Delete(AID : integer);
    function Load(AID : integer) : TCliente;
  end;

implementation

end.
