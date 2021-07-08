unit untPedido.Mapper;

interface

uses
  FireDAC.Comp.Client,
  untPedido;

type
  TPedidoMapper = class
  strict private
    class function MapToInstace(AQry: TFDQuery): TPedido;
    class procedure LoadItens(var APedido : TPedido);
    class procedure SaveItens(APedido : TPedido);
  public
    class procedure Save(APedido : TPedido);
    class procedure Delete(AID : integer);
    class function Load(AID : integer) : TPedido;
  end;

implementation
uses
  Sysutils
  , untDM
  , Data.DB
  , untRepositorio.Cliente.Provider
  , untItemPedido
  , untRepositorio.Produto.Provider
  , untExceptions
;

{ TProdutoMapper }

class procedure TPedidoMapper.Delete(AID: integer);
var
  _qry : TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  _qry.Connection := DM.conPrincipal;
  try
    _qry.SQL.Text := 'DELETE FROM pedido WHERE ped_id = '+AID.ToString;
    DM.conPrincipal.StartTransaction;
    try
      _qry.ExecSQL;
      DM.conPrincipal.Commit;
    except
      on e:exception do
      begin
        DM.conPrincipal.Rollback;
        raise Exception.Create('[TPedidoMapper] - Erro ao apagar pedido. '+e.Message);
      end;
    end;
  finally
    _qry.Free;
  end;
end;

class function TPedidoMapper.Load(AID : integer) : TPedido;
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
        ' pedido '+
      ' WHERE '+
        ' ped_id = '+AID.ToString;
    try
      _qry.Open;
    except
      on e:exception do
        raise Exception.Create('[TPedidoMapper] - Erro ao consultar pedido ['+AID.ToString+']');
    end;

    if _qry.IsEmpty then
      raise ERecordNotFound.Create('[TPedidoMapper] - Pedido não encontrado. ');

    Result := TPedidoMapper.MapToInstace(_qry);
  finally
    _qry.Free;
  end;
end;

class procedure TPedidoMapper.LoadItens(var APedido: TPedido);
var
  _itens : TFDQuery;
  _prod : TItemPedido;
begin
  _itens := TFDQuery.Create(nil);
  try
    _itens.Connection := DM.ConPrincipal;
    _itens.SQL.Text :=
      'SELECT '+
        ' * '+
      ' FROM '+
        ' pedido_itens '+
      ' WHERE '+
        ' pedi_pedido = '+APedido.Codigo.ToString;

    try
      _itens.Open;
    except
      on e:exception do
        raise Exception.Create('[TPedidoMapper] - Erro ao carregar os itens do pedido. '+e.Message);
    end;

    while not _itens.Eof do
    begin
      _prod := TItemPedido.Create;
      _prod.Produto := ProdutoRepo.Load(_itens.FieldByName('pedi_prod_id').AsInteger);
      _prod.ID := _itens.FieldByName('pedi_id').AsInteger;
      _prod.Produto.Codigo := _itens.FieldByName('pedi_prod_id').AsInteger;
      _prod.Produto.PrecoUnitario := _itens.FieldByName('pedi_vlr_unt').AsFloat;
      _prod.Quantidade := _itens.FieldByName('pedi_quantidade').AsFloat;

      APedido.Itens.Add(_prod);

      _itens.Next;
    end;
  finally
    _itens.Free;
  end;
end;

class function TPedidoMapper.MapToInstace(AQry: TFDQuery): TPedido;
begin
  Result := TPedido.Create;

  Result.Codigo := AQry.FieldByName('ped_id').AsInteger;
  Result.Data   := AQry.FieldByName('ped_data').AsDateTime;
  Result.Cliente := ClienteRepo.Load(AQry.FieldByName('ped_cliente_id').AsInteger);

  TPedidoMapper.LoadItens(Result);
end;

class procedure TPedidoMapper.Save(APedido : TPedido);
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
        ' pedido '+
      ' WHERE '+
        ' ped_id = '+APedido.Codigo.ToString;
    try
      _qry.Open;
    except
      on e:exception do
        raise Exception.Create('[TPedidoMapper] - Erro ao consultar pedido ['+APedido.Codigo.ToString+']. '+e.Message);
    end;

    DM.conPrincipal.StartTransaction;
    if _qry.IsEmpty then
      _qry.Append
    else
      _qry.Edit;

    _qry.FieldByName('ped_cliente_id').Value := APedido.Cliente.Codigo;
    _qry.FieldByName('ped_data').Value  := APedido.Data;
    _qry.FieldByName('ped_vlr_total').Value := APedido.GetValorTotalPedido();

    try
      _qry.Post;

      if APedido.Codigo <= 0 then
        APedido.Codigo := _qry.FieldByName('ped_id').AsInteger;

      TPedidoMapper.SaveItens(APedido);
      DM.conPrincipal.Commit;
    except
      on e:exception do
      begin
        DM.conPrincipal.Rollback;
        raise Exception.Create('[TPedidoMapper] - Erro ao salvar pedido. '+e.Message);
      end;
    end;
  finally
    _qry.Free;
  end;
end;

class procedure TPedidoMapper.SaveItens(APedido: TPedido);
  procedure DeletarItens(APedID : integer);
  var
    _qry : TFDQuery;
  begin
    _qry := TFDQuery.Create(nil);
    _qry.Connection := DM.conPrincipal;
    try
      _qry.SQL.Text :=
      ' DELETE FROM '+
        ' pedido_itens '+
      ' WHERE '+
        ' pedi_pedido = '+APedID.ToString;
      try
        _qry.ExecSQL;
      except
        on e:exception do
          raise Exception.Create('[TPedidoMapper] - Erro ao apagar itens do pedido. '+e.Message);
      end;
    finally
      _qry.Free;
    end;
  end;
var
  _itemPedido : TFDQuery;
begin
  DeletarItens(APedido.Codigo);

  APedido.Itens.Iterar(
    procedure (AItemPedido : TItemPedido)
    begin
      _itemPedido := TFDQuery.Create(nil);
      _itemPedido.Connection := DM.conPrincipal;
      _itemPedido.SQL.Text :=
        ' SELECT '+
          ' * '+
        ' FROM '+
          ' pedido_itens '+
        ' WHERE '+
          ' pedi_id = '+AItemPedido.ID.ToString;
      try
        try
          _itemPedido.Open;
        except
          on e:exception do
            raise Exception.Create('[TPedidoMapper] - Erro ao consultar item do pedido. '+e.Message);
        end;

        if _itemPedido.IsEmpty then
          _itemPedido.Append
        else
          _itemPedido.Edit;

        _itemPedido.FieldByName('pedi_pedido').Value := APedido.Codigo;
        _itemPedido.FieldByName('pedi_prod_id').Value := AItemPedido.Produto.Codigo;
        _itemPedido.FieldByName('pedi_quantidade').Value := AItemPedido.Quantidade;
        _itemPedido.FieldByName('pedi_vlr_unt').Value := AItemPedido.Produto.PrecoUnitario;

        try
          _itemPedido.Post;
        except
          on e:exception do
            raise Exception.Create('[TPedidoMapper] - Erro ao salvar item do pedido. '+e.Message);
        end;
      finally
        _itemPedido.Free;
      end;
    end
  );
end;

end.

