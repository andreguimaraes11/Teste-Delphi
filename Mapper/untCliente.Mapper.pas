unit untCliente.Mapper;

interface

uses
  untCliente, FireDAC.Comp.Client;
type
  TClienteMapper = class
  strict private
    class function MapToInstance(AQry: TFDQuery): TCliente;
  public
    class procedure Save(ACliente : TCliente);
    class procedure Delete(AID : integer);
    class function Load(AID : integer) : TCliente;
  end;

implementation

uses
  untDM,
  System.Classes,
  System.SysUtils, untCidade, untExceptions;

{ TClienteMapper }

class procedure TClienteMapper.Delete(AID: integer);
var
  _qry : TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  _qry.Connection := DM.conPrincipal;
  try
    _qry.SQL.Text := 'DELETE FROM cliente WHERE cli_id = '+AID.ToString;
    DM.conPrincipal.StartTransaction;
    try
      _qry.ExecSQL;
      DM.conPrincipal.Commit;
    except
      on e:exception do
      begin
        DM.conPrincipal.Rollback;
        raise Exception.Create('[TClienteMapper] - Erro ao apagar cliente. '+e.Message);
      end;
    end;
  finally
    _qry.Free;
  end;
end;

class function TClienteMapper.Load(AID: integer): TCliente;
var
  _qry : TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  _qry.Connection := DM.conPrincipal;
  try
    _qry.SQL.Text :=
      ' SELECT '+
        ' * '+
      ' FROM '+
        ' cliente '+
      ' WHERE '+
        ' cli_id = '+AID.ToString;
    try
      _qry.Open;
    except
      on e:exception do
        raise Exception.Create('[TClienteMapper] - Erro ao consultar cliente ['+AID.ToString+']');
    end;

    if _qry.IsEmpty then
      raise ERecordNotFound.Create('[TClienteMapper] - Cliente não encontrado. ');

    Result := TClienteMapper.MapToInstance(_qry);
  finally
    _qry.Free;
  end;
end;

class function TClienteMapper.MapToInstance(AQry: TFDQuery): TCliente;
begin
  Result := TCliente.Create;

  Result.Codigo := AQry.FieldByName('cli_id').AsInteger;
  Result.Nome := AQry.FieldByName('cli_nome').AsString;

  Result.Cidade := TCidade.Create;
  Result.Cidade.Nome := AQry.FieldByName('cli_cidade').AsString;
  Result.Cidade.UF := AQry.FieldByName('cli_uf').AsString;
end;

class procedure TClienteMapper.Save(ACliente: TCliente);
var
  _qry : TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  _qry.Connection := DM.conPrincipal;
  try
    _qry.SQL.Text :=
      ' SELECT '+
        ' * '+
      ' FROM '+
        ' cliente '+
      ' WHERE '+
        ' cli_id = '+ACliente.Codigo.ToString;
    try
      _qry.Open;
    except
      on e:exception do
        raise Exception.Create('[TClienteMapper] - Erro ao consultar cliente ['+ACliente.Codigo.ToString+']. '+e.Message);
    end;


    DM.conPrincipal.StartTransaction;
    if _qry.IsEmpty then
      _qry.Append
    else
      _qry.Edit;

    _qry.FieldByName('cli_nome').Value := ACliente.Nome;
    _qry.FieldByName('cli_cidade').Value  := ACliente.Cidade.Nome;
    _qry.FieldByName('cli_uf').Value  := ACliente.Cidade.UF;

    try
      _qry.Post;
      DM.conPrincipal.Commit;
    except
      on e:exception do
      begin
        DM.conPrincipal.Rollback;
        raise Exception.Create('[TClienteMapper] - Erro ao salvar cliente. '+e.Message);
      end;
    end;

    if ACliente.Codigo <= 0 then
      ACliente.Codigo := _qry.FieldByName('cli_id').AsInteger;
  finally
    _qry.Free;
  end;
end;

end.
