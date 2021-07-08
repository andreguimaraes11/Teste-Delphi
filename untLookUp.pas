unit untLookUp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons;

  function LookUpGenerico(ASql : string; ANomeConsulta : string; ACampoRetorno : integer; ATamanhoColunas : TArray<integer> = []) : string;
type
  TfrmLookup = class(TForm)
    Panel1: TPanel;
    dbGridPesquisa: TDBGrid;
    Panel2: TPanel;
    Image1: TImage;
    cmbFiltro: TComboBox;
    Label1: TLabel;
    edtFiltro: TEdit;
    Label2: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    btnConfirmar: TSpeedButton;
    Panel5: TPanel;
    btnCancelar: TSpeedButton;
    Image2: TImage;
    Image3: TImage;
    qryGrid: TFDQuery;
    dsGrid: TDataSource;
    procedure dbGridPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure edtFiltroKeyPress(Sender: TObject; var Key: Char);
    procedure edtFiltroChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure dbGridPesquisaDblClick(Sender: TObject);
  strict private
    FSelecionado : string;
    FTamanhoColunas : TArray<integer>;
    FCampoRetorno : integer;
  private
    { Private declarations }
    procedure ConfigurarGrid;
  public
    { Public declarations }
    property Selecionado : string read FSelecionado;
    constructor Create(AOwner: TComponent; ASql: string;
  ACampoRetorno: integer; ATamanhoColunas : TArray<integer> = []); overload;
  end;

implementation
uses
  untDM;

function LookUpGenerico(ASql : string; ANomeConsulta : string; ACampoRetorno : integer; ATamanhoColunas : TArray<integer> = []) : string;
var
  _frm : TfrmLookup;
begin
  result := emptystr;
  _frm := TfrmLookup.Create(nil, ASql, ACampoRetorno, ATamanhoColunas);
  try
    _frm.Caption := ANomeConsulta;
    _frm.ShowModal;
    result := _frm.Selecionado;
  finally
    _frm.Free;
  end;
end;

{$R *.dfm}

procedure TfrmLookup.btnCancelarClick(Sender: TObject);
begin
  FSelecionado := EmptyStr;
  Self.Close;
end;

procedure TfrmLookup.btnConfirmarClick(Sender: TObject);
begin
  if qryGrid.RecordCount = 0 then
  begin
    ShowMessage('Nenhum registro selecionado.');
    Exit;
  end;

  FSelecionado := qryGrid.Fields[FCampoRetorno].AsString;
  Self.Close;
end;

procedure TfrmLookup.ConfigurarGrid;
var
  I: Integer;
begin
  if Length(FTamanhoColunas) = 0 then
    Exit;

  for I := 0 to pred(Length(FTamanhoColunas)) do
  begin
    if i > dbGridPesquisa.Columns.Count then
      Break;

    dbGridPesquisa.Columns[i].Width := FTamanhoColunas[i];
  end;
end;

constructor TfrmLookup.Create(AOwner: TComponent; ASql: string;
  ACampoRetorno: integer; ATamanhoColunas : TArray<integer> = []);
var
  _field: TField;
begin
  inherited Create(AOwner);
  FTamanhoColunas := ATamanhoColunas;

  try
    qryGrid.FilterOptions := [foCaseInsensitive];
    qryGrid.Connection := DM.conPrincipal;
    qryGrid.SQL.Text := ASql;
    qryGrid.Open
  except
    on e:exception do
    begin
      ShowMessage('Erro ao abrir consulta. Erro: '+e.Message);
      Exit;
    end;
  end;

  cmbFiltro.Clear;
  for _field in qryGrid.Fields do
    cmbFiltro.Items.Add(_field.DisplayName);

  cmbFiltro.ItemIndex := 0;
  FCampoRetorno := ACampoRetorno;
end;

procedure TfrmLookup.dbGridPesquisaDblClick(Sender: TObject);
begin
  if btnConfirmar.Enabled then
    btnConfirmar.Click;
end;

procedure TfrmLookup.dbGridPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_delete then
    Abort;
end;

procedure TfrmLookup.edtFiltroChange(Sender: TObject);
begin
  if Trim(edtFiltro.Text).IsEmpty then
    qryGrid.Filtered := False;
end;

procedure TfrmLookup.edtFiltroKeyPress(Sender: TObject; var Key: Char);
var
  _filtro: string;
begin
  FormKeyPress(Sender, key);

  if (key = #13) and (Trim(edtFiltro.Text) <> emptystr) then
  begin
    Key := #0;
    try
      qryGrid.Filtered := False;
      _filtro := 'TRUE AND '+cmbFiltro.Text+' LIKE '+QuotedStr(Trim(edtFiltro.Text)+'%');

      qryGrid.Filter := _filtro;
      qryGrid.Filtered := True;
    except
      on e:exception do
        ShowMessage('Erro ao filtrar grid. Erro: '+e.Message);
    end;
  end;
end;

procedure TfrmLookup.FormActivate(Sender: TObject);
begin
  ConfigurarGrid();
end;

procedure TfrmLookup.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    Key := #0;
    FSelecionado := EmptyStr;
    Self.Close;
  end;
end;

end.
