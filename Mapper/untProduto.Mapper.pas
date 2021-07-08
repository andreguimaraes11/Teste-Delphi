unit untProduto.Mapper;

interface

uses
  untProduto,
  FireDAC.Comp.Client;
type
  TProdutoMapper = class
  strict private
    class function MapToInstance(AQry : TFDQuery) : TProduto;
  public
    class procedure Save(AProduto : TProduto);
    class procedure Delete(AID : integer);
    class function Load(AID : integer) : TProduto;
  end;

implementation
uses
  Sysutils,
  untDM, untExceptions;

{ TProdutoMapper }

class procedure TProdutoMapper.Delete(AID: integer);
var
  _qry : TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  _qry.Connection := DM.conPrincipal;
  try
    _qry.SQL.Text := 'DELETE FROM produto WHERE prod_id = '+AID.ToString;
    _qry.ExecSQL;
  finally
    _qry.Free;
  end;
end;

class function TProdutoMapper.Load(AID: integer): TProduto;
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
        ' produto '+
      ' WHERE '+
        ' prod_id = '+AID.ToString;
    try
      _qry.Open;
    except
      on e:exception do
        raise Exception.Create('[TProdutoMapper] - Erro ao consultar produto ['+AID.ToString+']');
    end;

    if _qry.IsEmpty then
      raise ERecordNotFound.Create('[TProdutoMapper] - Produto não encontrado. ');

    Result := TProdutoMapper.MapToInstance(_qry);
  finally
    _qry.Free;
  end;
end;

class function TProdutoMapper.MapToInstance(AQry: TFDQuery): TProduto;
begin
  Result := TProduto.Create;

  Result.Codigo := AQry.FieldByName('prod_id').AsInteger;
  Result.Descricao := AQry.FieldByName('prod_descricao').AsString;
  Result.PrecoUnitario := AQry.FieldByName('prod_preco').AsCurrency;
end;

class procedure TProdutoMapper.Save(AProduto: TProduto);
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
        ' produto '+
      ' WHERE '+
        ' prod_id = '+AProduto.Codigo.ToString;
    try
      _qry.Open;
    except
      on e:exception do
        raise Exception.Create('[TProdutoMapper] - Erro ao consultar produto ['+AProduto.Codigo.ToString+']. '+e.Message);
    end;

    DM.conPrincipal.StartTransaction;
    if _qry.IsEmpty then
      _qry.Append
    else
      _qry.Edit;

    _qry.FieldByName('prod_descricao').Value := AProduto.Descricao;
    _qry.FieldByName('prod_preco').Value  := AProduto.PrecoUnitario;

    try
      _qry.Post;
      DM.conPrincipal.Commit;
    except
      on e:exception do
      begin
        DM.conPrincipal.Rollback;
        raise Exception.Create('[TProdutoMapper] - Erro ao salvar produto. '+e.Message);
      end;
    end;

    if AProduto.Codigo <= 0 then
      AProduto.Codigo := _qry.FieldByName('prod_id').AsInteger;
  finally
    _qry.Free;
  end;
end;

end.
