unit unitPedidoVenda;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.WinXPanels, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Mask

  , System.Generics.Collections
  , untItemPedido
  , untPedido
  , untCliente
  , untProduto
;
type
  TStatusTela = (tstIncluindoPedido, tstAlterando, tstConsulta);

  TformPedidoVenda = class(TForm)
    Panel2: TPanel;
    Image5: TImage;
    Label17: TLabel;
    Image9: TImage;
    Label18: TLabel;
    Label19: TLabel;
    Panel1: TPanel;
    lblHora: TLabel;
    lblData: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    timerHora: TTimer;
    Image1: TImage;
    Panel6: TPanel;
    CardPanel2: TCardPanel;
    Card2: TCard;
    Panel8: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    lblTotalGeral: TLabel;
    pnlListaItens: TPanel;
    Panel5: TPanel;
    Panel3: TPanel;
    Shape2: TShape;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    lblClienteNaoEncontrado: TLabel;
    edtCodigoCliente: TEdit;
    edtNomeCliente: TEdit;
    edtCidadeCliente: TEdit;
    edtUFCliente: TEdit;
    cpOpcoes: TCardPanel;
    cardProdutos: TCard;
    Label5: TLabel;
    btnGravarPedido: TSpeedButton;
    cardBotoes: TCard;
    btnCarregarPedido: TSpeedButton;
    btnCancelarPedido: TSpeedButton;
    Label6: TLabel;
    edtNumeroDoPedido: TEdit;
    edtCodProduto: TEdit;
    edtDescricaoProd: TEdit;
    Label7: TLabel;
    pnlDadosProduto: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    edtVlrTotalProd: TEdit;
    Label10: TLabel;
    btnIncluirProduto: TSpeedButton;
    lblProdutoNaoEncontrado: TLabel;
    btnCancelarAlteracoes: TSpeedButton;
    dbGridProdutos: TDBGrid;
    Panel4: TPanel;
    Image2: TImage;
    btnCliente: TSpeedButton;
    Panel7: TPanel;
    Image3: TImage;
    btnPedido: TSpeedButton;
    memTabItens: TFDMemTable;
    dsItens: TDataSource;
    lblPedido: TLabel;
    Panel9: TPanel;
    Image4: TImage;
    btnProduto: TSpeedButton;
    edtQuantidade: TEdit;
    edtVlrUnt: TEdit;
    lblPedidoNaoEncontrado: TLabel;
    btnNovoPedido: TSpeedButton;
    procedure dbGridProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnClienteClick(Sender: TObject);
    procedure edtCodigoClienteChange(Sender: TObject);
    procedure edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure btnPedidoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnProdutoClick(Sender: TObject);
    procedure btnCarregarPedidoClick(Sender: TObject);
    procedure edtNumeroDoPedidoChange(Sender: TObject);
    procedure dbGridProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoChange(Sender: TObject);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirProdutoClick(Sender: TObject);
    procedure btnNovoPedidoClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure edtVlrUntKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
  private
    { Private declarations }
    FPedido : TPedido;
    FStatus : TStatusTela;

    procedure AfterScrollItens(ADataSet : TDataSet);
    procedure CarregarCamposMemTable;
    procedure ConfigurarGrid;

    procedure CarregarCliente(ACliente : TCliente);
    procedure CarregarProduto(AProduto : TProduto);
    procedure CarregarInfoPedido;
    procedure CarregarItens;

    procedure CalcularTotalItem;

    procedure LimparCliente;
    procedure LimparProduto;
    procedure HabilitarInsercaoProduto;

    function GetValor(AString : string) : Double;
    function ValidarProduto : boolean;
    function ValidarPedido : boolean;
  public
    { Public declarations }
  end;
var
  formPedidoVenda: TformPedidoVenda;
implementation
uses
  untLookUp
  , untCliente.LookUp
  , untExceptions
  , untRepositorio.Cliente.Provider
  , untProduto.LookUp
  , untPedido.LookUp
  , System.StrUtils
  , untRepositorio.Pedido.Provider
  , untRepositorio.Produto.Provider
  , System.UITypes
;
{$R *.dfm}
procedure TformPedidoVenda.AfterScrollItens(ADataSet : TDataSet);
begin
  if memTabItens.IsEmpty then
    Exit;

  edtCodProduto.Text    := memTabItens.FieldByName('CodProd').AsString;
  edtDescricaoProd.Text := memTabItens.FieldByName('Descricao').AsString;
  edtQuantidade.Text    := FormatFloat('#,##0.00', memTabItens.FieldByName('Qtde').AsCurrency);
  edtVlrUnt.Text        := FormatFloat('#,##0.00', memTabItens.FieldByName('VlrUnt').AsCurrency);

  CalcularTotalItem();
end;

procedure TformPedidoVenda.btnCancelarPedidoClick(Sender: TObject);
var
  _pedido : TPedido;
begin
  if MessageDlg('Confirmar cancelamento do pedido? ',mtConfirmation,[mbyes,mbno],0)= mrNo then
    Exit;
  try
    _pedido := PedidoRepo.Load(StrToIntDef(edtNumeroDoPedido.Text, 0));
    try
      PedidoRepo.Delete(_pedido.Codigo);
    finally
      _pedido.Free;
    end;
  except
    on e:ERecordNotFound do
    begin
      lblPedidoNaoEncontrado.Visible := True;
      Application.ProcessMessages;
      Exit;
    end;
    on e:exception do
    begin
      ShowMessage(e.Message);
      Exit;
    end;
  end;

  ShowMessage('Pedido cancelado!');
end;

procedure TformPedidoVenda.btnCarregarPedidoClick(Sender: TObject);
var
  _pedido: TPedido;
begin
  try
    _pedido := PedidoRepo.Load(StrToIntDef(edtNumeroDoPedido.Text, 0));
  except
    on e:ERecordNotFound do
    begin
      lblPedidoNaoEncontrado.Visible := True;
      Application.ProcessMessages;
      Exit;
    end;
    on e:exception do
    begin
      ShowMessage('Erro ao carregar pedido. Erro : '+e.Message);
      Exit;
    end;
  end;

  if Assigned(FPedido) then
    FPedido.Free;

  FStatus := tstAlterando;
  FPedido := _pedido;

  CarregarInfoPedido();
  cpOpcoes.ActiveCard := cardProdutos;

  btnCliente.Cursor  := crNo;
  edtCodigoCliente.Enabled := False;
end;

procedure TformPedidoVenda.btnClienteClick(Sender: TObject);
var
  _cliente : TCliente;
begin
  if not edtCodigoCliente.Enabled then
    Exit;

  if edtCodigoCliente.ReadOnly then
    Exit;

  _cliente := TClienteLookUp.Choose();
  if not assigned(_cliente) then
  begin
    cardProdutos.Enabled := False;
    Exit;
  end;

  try
    CarregarCliente(_cliente);
    cardProdutos.Enabled := True;
  finally
    _cliente.Free;
  end;
end;

procedure TformPedidoVenda.btnGravarPedidoClick(Sender: TObject);
begin
  if not ValidarPedido() then
    Exit;

  if MessageDlg('Confirmar a grava??o do pedido? ',mtConfirmation,[mbyes,mbno],0)= mrNo then
    Exit;

  FPedido.Cliente := ClienteRepo.Load(edtCodigoCliente.Tag);
  FPedido.Data := Date();
  try
    PedidoRepo.Save(FPedido);
  except
    on e:exception do
    begin
      ShowMessage(e.Message);
      Exit;
    end;
  end;

  FreeAndNil(FPedido);

  if memTabItens.Active then
    memTabItens.EmptyDataSet;

  edtCodProduto.Clear;
  edtCodigoCliente.Clear;

  edtNumeroDoPedido.Clear;
  cpOpcoes.ActiveCard := cardBotoes;
  FStatus := tstConsulta;
end;

procedure TformPedidoVenda.btnIncluirProdutoClick(Sender: TObject);
var
  _item : TItemPedido;
begin
  if not ValidarProduto() then
    Exit; 

  {$REGION 'Salvar altera??o produto'}
  if btnIncluirProduto.Caption = 'Salvar altera??es' then
  begin
    _item := FPedido.Itens.GetByIDProd(StrToIntDef(edtCodProduto.Text,0));
    _item.Produto.PrecoUnitario := GetValor(edtVlrUnt.Text);
    _item.Quantidade := GetValor(edtQuantidade.Text);
    HabilitarInsercaoProduto();
    CarregarItens();

    ShowMessage('Altera??es salvas!');
    Exit;
  end;
  {$ENDREGION}

  if MessageDlg('Confirmar inclus?o do produto? ',mtConfirmation,[mbyes,mbno],0)= mrNo then
    Exit;

  _item := TItemPedido.Create;
  _item.Produto := ProdutoRepo.Load(StrToIntDef(edtCodProduto.Text, 0));
  _item.Produto.PrecoUnitario := GetValor(edtVlrUnt.Text);
  _item.Quantidade := GetValor(edtQuantidade.Text);

  if not (FPedido <> nil) then
    FPedido := TPedido.Create;

  try
    FPedido.Itens.Add(_item);
  except
    on e:EProdutoJaAdicionado do
    begin
      _item.free;
      showmessage('Produto j? adicionado na lista.');
      Exit;
    end;
  end;

  CalcularTotalItem();

  CarregarItens();
  edtCodProduto.Clear;
end;

procedure TformPedidoVenda.btnNovoPedidoClick(Sender: TObject);
begin
  FStatus := tstIncluindoPedido;
  edtCodigoCliente.ReadOnly := False;
  edtCodigoCliente.Color := clWindow;

  cpOpcoes.ActiveCard := cardProdutos;
  cardProdutos.Enabled := False;
end;

procedure TformPedidoVenda.btnPedidoClick(Sender: TObject);
var
  _pedido: TPedido;
begin
  _pedido := TPedidoLookup.Choose();
  if not Assigned(_pedido) then
    Exit;

  try
    edtNumeroDoPedido.Text := _pedido.Codigo.ToString;
  finally
    _pedido.Free;
  end;
end;

procedure TformPedidoVenda.btnProdutoClick(Sender: TObject);
var
  _prod : TProduto;
begin
  _prod := TProdutoLookUp.Choose();
  if not Assigned(_prod) then
    Exit;

  try
    CarregarProduto(_prod);
    pnlDadosProduto.Enabled := True;
  finally
    _prod.Free;
  end;
end;

procedure TformPedidoVenda.CalcularTotalItem;
var
  _tot: Double;
begin
  _tot := GetValor(edtVlrUnt.Text) * GetValor(edtQuantidade.Text);
  edtVlrTotalProd.Text := FormatFloat('#,##0.00', _tot);
end;

procedure TformPedidoVenda.CarregarCamposMemTable;
begin
  dbGridProdutos.Columns.Clear;
  if not memTabItens.Active then
  begin
    memTabItens.FieldDefs.Add('CodProd', ftInteger);
    memTabItens.FieldDefs.Add('Descricao', ftString, 200, True);
    memTabItens.FieldDefs.Add('Qtde', ftFloat);
    memTabItens.FieldDefs.Add('VlrUnt', ftFloat);
    memTabItens.FieldDefs.Add('VlrTotal', ftFloat);

    memTabItens.CreateDataSet;
    memTabItens.Open;
  end;

  memTabItens.AfterScroll := AfterScrollItens;
end;

procedure TformPedidoVenda.CarregarCliente(ACliente: TCliente);
begin
  if not assigned(ACliente) then
    Exit;

  edtCodigoCliente.Text := ACliente.Codigo.ToString;
  edtCodigoCliente.Tag  := ACliente.Codigo;
  edtNomeCliente.Text   := ACliente.Nome;
  edtCidadeCliente.Text := ACliente.Cidade.Nome;
  edtUFCliente.Text     := ACliente.Cidade.UF;
end;

procedure TformPedidoVenda.CarregarInfoPedido;
begin
  CarregarCliente(Fpedido.Cliente);
  lblPedido.Caption := 'PEDIDO : '+FPedido.Codigo.ToString+' - '+FPedido.Cliente.Nome;

  CarregarItens();
end;

procedure TformPedidoVenda.CarregarItens;
begin
  if memTabItens.Active then
    memTabItens.EmptyDataSet;

  FPedido.Itens.Iterar(
    procedure (AItem : TItemPedido)
    begin
      memTabItens.AppendRecord(
        [
          AItem.Produto.Codigo,
          AItem.Produto.Descricao,
          AItem.Quantidade,
          AItem.Produto.PrecoUnitario,
          AItem.GetValorTotal
        ]
      );
    end
  );

  memTabItens.First;
  if memTabItens.isEmpty then
    LimparProduto();
  lblTotalGeral.Caption := FormatFloat('#,##0.00', FPedido.GetValorTotalPedido());
end;

procedure TformPedidoVenda.CarregarProduto(AProduto: TProduto);
begin
  if not assigned(AProduto) then
    Exit;

  edtCodProduto.Text    := AProduto.Codigo.ToString;
  edtDescricaoProd.Text := AProduto.Descricao;
  edtQuantidade.Text    := '1,00';
  edtVlrUnt.Text        := FormatFloat('#,##0.00', AProduto.PrecoUnitario);

  CalcularTotalItem();
end;

procedure TformPedidoVenda.ConfigurarGrid;
begin
  dbGridProdutos.Columns.Items[0].Title.Caption := 'C?digo';
  dbGridProdutos.Columns.Items[1].Title.Caption := 'Descri??o';
  dbGridProdutos.Columns.Items[2].Title.Caption := 'Quantidade';
  dbGridProdutos.Columns.Items[3].Title.Caption := 'Vlr. Unit?rio';
  dbGridProdutos.Columns.Items[4].Title.Caption := 'Vlr. Total';

  TFloatField(dbGridProdutos.Fields[2]).DisplayFormat := '###,###,##0.00';
  TFloatField(dbGridProdutos.Fields[3]).DisplayFormat := '###,###,##0.00';
  TFloatField(dbGridProdutos.Fields[4]).DisplayFormat := '###,###,##0.00';

  dbGridProdutos.Columns.Items[0].Width := 80;
  dbGridProdutos.Columns.Items[1].Width := 400;
  dbGridProdutos.Columns.Items[2].Width := 170;
  dbGridProdutos.Columns.Items[3].Width := 170;
  dbGridProdutos.Columns.Items[4].Width := 170;
end;

procedure TformPedidoVenda.LimparCliente;
begin
  edtCodigoCliente.Tag := 0;
  edtNomeCliente.Clear;
  edtCidadeCliente.Clear;
  edtUFCliente.Clear;
end;

procedure TformPedidoVenda.LimparProduto;
begin
  edtDescricaoProd.Clear;
  edtVlrTotalProd.Clear;
  edtVlrUnt.Clear;
  edtQuantidade.Clear;
end;

function TformPedidoVenda.ValidarPedido: boolean;
begin
  Result := False;
  if FPedido = nil then
  begin
    ShowMessage('Preencha as informa??es do pedido');
    Exit;
  end;

  if FPedido.Itens.Count <= 0 then
  begin
    ShowMessage('O pedido deve conter ao menos um item.');
    Exit;
  end;

  Result := True;
end;

function TformPedidoVenda.ValidarProduto: boolean;
begin
  Result := False;

  try
    if GetValor(edtVlrUnt.Text) <= 0 then
    begin
      ShowMessage('O valor unit?rio deve ser maior que 0.');
      Exit;
    end;
    if GetValor(edtQuantidade.Text) <= 0 then
    begin
      ShowMessage('A quantidade deve ser maior que 0.');
      Exit;
    end;
  except
    on e:exception do
    begin
      showmessage('Verifique o preenchimento dos valores.');
      Exit;
    end;
  end;
  Result := True;
end;

procedure TformPedidoVenda.dbGridProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if FStatus = tstConsulta then
    Exit;

  if Key = vk_delete then
  begin
    if Shift = [ssCtrl] then
      Abort;

    if MessageDlg('Confirmar exclus?o do item? ',mtConfirmation,[mbyes,mbno],0)= mrNo then
      Exit;

    FPedido.Itens.RemoveByID(memTabItens.FieldByName('CodProd').AsInteger);
    CarregarItens();
  end;
end;

procedure TformPedidoVenda.dbGridProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    Key := #0;
    if memTabItens.IsEmpty then
      Exit;

    if MessageDlg('Desejar alterar o item? ',mtConfirmation,[mbyes,mbno],0)= mrNo then
      Exit;

    FStatus := tstAlterando;  

    edtCodProduto.Text    := memTabItens.FieldByName('CodProd').AsString;
    edtVlrUnt.Text        := memTabItens.FieldByName('VlrUnt').AsString;
    edtQuantidade.Text    := memTabItens.FieldByName('Qtde').AsString;
    edtVlrTotalProd.Text  := memTabItens.FieldByName('VlrTotal').AsString;
    edtDescricaoProd.Text := memTabItens.FieldByName('Descricao').AsString;

    edtCodigoCliente.ReadOnly := True;
    edtCodProduto.ReadOnly    := True;
    pnlDadosProduto.Enabled   := True;

    cpOpcoes.ActiveCard := cardProdutos;

    btnIncluirProduto.Caption := 'Salvar Altera??es';
    btnIncluirProduto.Hint    := btnIncluirProduto.Caption;
    btnGravarPedido.Enabled := False;
    btnCancelarAlteracoes.Visible := True;
  end;
end;

procedure TformPedidoVenda.edtCodigoClienteChange(Sender: TObject);
var
  _cliente: TCliente;
begin
  cardProdutos.Enabled := False;
  if Trim(edtCodigoCliente.Text).IsEmpty then
  begin
    LimparCliente();
    Exit;
  end;

  try
    _cliente := ClienteRepo.Load(StrToIntDef(edtCodigoCliente.Text,0));
  except
    on e:ERecordNotFound do
    begin
      LimparCliente();
      Exit;
    end;
    on e:exception do
    begin
      LimparCliente();
      showmessage('Erro ao carregar cliente. Erro: '+e.Message);
      Exit;
    end;
  end;

  try
    CarregarCliente(_cliente);
    cardProdutos.Enabled := True;
  finally
    _cliente.Free;
  end;
end;

procedure TformPedidoVenda.edtCodigoClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #27 then
  begin
    Key := #0;
    Self.Close;
  end;
end;

procedure TformPedidoVenda.edtCodProdutoChange(Sender: TObject);
begin
  lblProdutoNaoEncontrado.Visible := False;
  if Trim(edtCodProduto.Text) = EmptyStr then
  begin
    pnlDadosProduto.Enabled := False;
    edtVlrUnt.Clear;
    edtQuantidade.Clear;
    edtDescricaoProd.Clear;
    edtVlrTotalProd.Text := '0,00';
    Exit;
  end;
  lblProdutoNaoEncontrado.Visible := False;
end;

procedure TformPedidoVenda.edtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
var
  _prod : TProduto;
begin
  edtCodigoClienteKeyPress(Sender, Key);
  if Key = #13 then
  begin
    key := #0;
    try
      _prod := ProdutoRepo.Load(StrToIntDef(edtCodProduto.text, 0));
      try
        CarregarProduto(_prod);
      finally
        _prod.free;
      end;
      pnlDadosProduto.Enabled := True;
    except
      on e:ERecordNotFound do
      begin
        LimparProduto();
        lblProdutoNaoEncontrado.Visible := True;
        Exit;
      end;
      on e:exception do
      begin
        showmessage('Erro ao carregar produto. Erro: '+e.message);
        Exit;
      end;
    end;
  end;
end;

procedure TformPedidoVenda.edtNumeroDoPedidoChange(Sender: TObject);
begin
  lblPedidoNaoEncontrado.Visible := False;
  Application.ProcessMessages;
end;

procedure TformPedidoVenda.edtQuantidadeExit(Sender: TObject);
begin
  CalcularTotalItem();
end;

procedure TformPedidoVenda.edtQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    Key := #0;
    CalcularTotalItem();
  end;
  edtVlrUntKeyPress(Sender, Key);
end;

procedure TformPedidoVenda.edtVlrUntKeyPress(Sender: TObject; var Key: Char);
begin
  if ((key in ['0'..'9', ','] = false) and (word(key) <> vk_back)) then
    Key := #0;
end;

procedure TformPedidoVenda.FormActivate(Sender: TObject);
begin
  FStatus := tstConsulta;
  lblPedido.Caption := EmptyStr;
  CarregarCamposMemTable();
  ConfigurarGrid();
end;

function TformPedidoVenda.GetValor(AString: string): Double;
var
  _aux : string;
begin
  _aux := AnsireplaceStr(AString, ' ', '');
  _aux := AnsireplaceStr(_aux, '.', '');
  Result := StrToFloatDef(_aux, 0);
end;

procedure TformPedidoVenda.HabilitarInsercaoProduto;
begin
  dbGridProdutos.Enabled := True;
  edtCodigoCliente.ReadOnly := False;
  edtCodProduto.ReadOnly := False;
  edtCodProduto.Clear;
  btnIncluirProduto.Caption := 'Incluir Produto';
  btnGravarPedido.Enabled := True;
  btnCancelarAlteracoes.Visible := False;
end;

end.
