program prjTesteDelphi;
uses
  Vcl.Forms,
  fireDAC.dapt,
  unitPedidoVenda in 'unitPedidoVenda.pas' {formPedidoVenda},
  untCliente in 'Model\untCliente.pas',
  untCidade in 'Model\untCidade.pas',
  untProduto in 'Model\untProduto.pas',
  untPedido in 'Model\untPedido.pas',
  untItemPedido in 'Model\untItemPedido.pas',
  untRepositorio.Produto.Intf in 'Reposit�rio\untRepositorio.Produto.Intf.pas',
  untRepositorio.Produto in 'Reposit�rio\untRepositorio.Produto.pas',
  untProduto.Mapper in 'Mapper\untProduto.Mapper.pas',
  untDM in 'untDM.pas' {DM: TDataModule},
  untRepositorio.Produto.Provider in 'Reposit�rio\untRepositorio.Produto.Provider.pas',
  untInitialize in 'untInitialize.pas',
  untPedido.Mapper in 'Mapper\untPedido.Mapper.pas',
  untCliente.Mapper in 'Mapper\untCliente.Mapper.pas',
  untRepositorio.Cliente.Intf in 'Reposit�rio\untRepositorio.Cliente.Intf.pas',
  untRepositorio.Cliente in 'Reposit�rio\untRepositorio.Cliente.pas',
  untRepositorio.Cliente.Provider in 'Reposit�rio\untRepositorio.Cliente.Provider.pas',
  untRepositorio.Pedido.Intf in 'Reposit�rio\untRepositorio.Pedido.Intf.pas',
  untRepositorio.Pedido.Provider in 'Reposit�rio\untRepositorio.Pedido.Provider.pas',
  untRepositorio.Pedido in 'Reposit�rio\untRepositorio.Pedido.pas',
  untExceptions in 'Exceptions\untExceptions.pas',
  untLookUp in 'untLookUp.pas' {frmLookup},
  untCliente.LookUp in 'LookUp\untCliente.LookUp.pas',
  untPedido.LookUp in 'LookUp\untPedido.LookUp.pas',
  untItemPedido.Lista in 'Model\untItemPedido.Lista.pas',
  untProduto.LookUp in 'LookUp\untProduto.LookUp.pas';

{$R *.res}
begin
  Application.Initialize;
  InicializarRepositorios();

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TformPedidoVenda, formPedidoVenda);

  Application.Run;
end.
