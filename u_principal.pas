unit u_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, dm_teste,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IdTCPConnection, IdTCPClient, IdHTTP, IdBaseComponent, IdComponent,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  System.JSON, IdSSLOpenSSLHeaders, cxContainer, cxMaskEdit, cxTextEdit,
  Vcl.Menus, cxButtons;

type
  TForm2 = class(TForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    Button1: TButton;
    btn_excluir: TButton;
    btn_editar: TButton;
    btn_add: TButton;
    DataSource1: TDataSource;
    cds_posts: TFDMemTable;
    cds_postsuserId: TIntegerField;
    cds_postsid: TIntegerField;
    cds_poststitle: TStringField;
    cds_postsbody: TStringField;
    ed_id: TcxTextEdit;
    Id: TLabel;
    Label2: TLabel;
    ed_titulo: TcxTextEdit;
    ed_post: TMemo;
    me_idUsuario: TcxMaskEdit;
    Label1: TLabel;
    Título: TLabel;
    btn_cancel: TcxButton;
    btn_ok: TcxButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure cds_postsAfterScroll(DataSet: TDataSet);
    procedure btn_okClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
  private
    { Private declarations }
    wp_ProximoId : Integer;
    Procedure BuscarDadosApi;
    Function ExecutaWebServiceUrl(p_url : String): String;
    Procedure Salvar(p_edicao : Boolean);
    Procedure PegarUltimoId;
    Procedure StatusTela;
    Function Validar : Boolean;

  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}


procedure TForm2.btn_addClick(Sender: TObject);
begin
  cds_posts.Insert;
  StatusTela;
end;

procedure TForm2.btn_cancelClick(Sender: TObject);
begin
  cds_posts.Cancel;
  StatusTela;
end;

procedure TForm2.btn_editarClick(Sender: TObject);
begin
  cds_posts.Edit;
  StatusTela;
end;

procedure TForm2.btn_excluirClick(Sender: TObject);
begin
  if cds_posts.Eof then
    wp_ProximoId := cds_posts.FieldByName('id').AsInteger;
  cds_posts.Delete;
  StatusTela;
end;

procedure TForm2.btn_okClick(Sender: TObject);
begin
  if Validar then
    Salvar(False);
  StatusTela;
end;

procedure TForm2.BuscarDadosApi;
var
  wl_Text : string;
  jsonObj: TJSONObject;
  jsonArray: TJSONArray;
  i: Integer;
begin
  cds_posts.Active := False;
  cds_posts.Active := true;
  Try
    try
//      jsonArray := TJSONArray.Create;
      wl_Text := ExecutaWebServiceUrl('http://jsonplaceholder.typicode.com/posts');
      jsonArray := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(wl_Text),0) as TJSONArray;
      for i := 0 to jsonArray.Size - 1 do
        begin
          jsonObj := (jsonArray.Get(i) as TJSONObject);
          if not cds_posts.Locate('id', jsonObj.GetValue<integer>('id'), []) then
            begin
              cds_posts.Insert;
              cds_posts.FieldByName('userId').AsInteger   := jsonObj.GetValue<integer>('userId');
              cds_posts.FieldByName('id').AsInteger   := jsonObj.GetValue<integer>('id');
              cds_posts.FieldByName('title').AsString := jsonObj.GetValue<String>('title');
              cds_posts.FieldByName('body').AsString := jsonObj.GetValue<String>('body');
              cds_posts.Post;
            end;
        end;
    Except on e:Exception do
      begin
        pdm_teste.gerarLog(e.Message);
        if Assigned(jsonArray) then
        jsonArray.Free;
      end;
    end;

    cds_posts.ApplyUpdates(0);
    cds_posts.IndexFieldNames := 'id';
    PegarUltimoId;
  FINALLY
    jsonObj.Free;
    cds_posts.Active := False;
  END;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  cds_posts.AfterScroll := Nil;
  Try
    BuscarDadosApi;
  Finally
    cds_posts.AfterScroll := cds_postsAfterScroll;
    StatusTela;
  End;

end;

procedure TForm2.cds_postsAfterScroll(DataSet: TDataSet);
begin
  me_idUsuario.Text := cds_posts.FieldByName('userId').AsString;
  ed_id.Text :=  cds_posts.FieldByName('id').AsString;
  ed_titulo.Text :=  cds_posts.FieldByName('title').AsString;
  ed_post.Text :=  cds_posts.FieldByName('body').AsString ;
end;

function TForm2.ExecutaWebServiceUrl(p_url: String): String;
var
  wl_idSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
  wl_IdHTTP : TIdHTTP;
begin
try
    try
      wl_idSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      wl_idSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv3;
      wl_idSSLIOHandlerSocket.SSLOptions.Mode :=   sslmClient;
      wl_IdHTTP           := TIdHTTP.Create(Application);
      wl_idHttp.IOHandler := wl_idSSLIOHandlerSocket;
      wl_IdHTTP.Request.BasicAuthentication := True;

      result := wl_IdHTTP.get(p_url);

    Except on E:Exception do
      raise
    end;
  finally
    wl_idSSLIOHandlerSocket.free;
    wl_IdHTTP.free;
  end;

end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  wp_ProximoId := 0;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  cds_posts.Open;
  PegarUltimoId;
  StatusTela;
end;

procedure TForm2.Salvar(p_edicao : Boolean);
begin
  Try

    cds_posts.FieldByName('userId').AsInteger   := StrToInt(Trim(me_idUsuario.Text));
    cds_posts.FieldByName('id').AsInteger   := wp_ProximoId;
    cds_posts.FieldByName('title').AsString := ed_titulo.Text;
    cds_posts.FieldByName('body').AsString := ed_post.Text;
    cds_posts.Post;

    if (cds_posts.ApplyUpdates(0) = 0) and (not p_edicao) then
      Inc(wp_ProximoId);

  Except on e:Exception do
    pdm_teste.gerarLog(e.Message);
  end;
end;

procedure TForm2.PegarUltimoId;
begin
  if not cds_posts.IsEmpty then
      begin
        cds_posts.Last;
        wp_ProximoId := cds_posts.FieldByName('id').AsInteger + 1;
        cds_posts.First;
      end;
end;

procedure TForm2.StatusTela;
begin
  btn_excluir.Enabled := (not cds_posts.IsEmpty) and (not (cds_posts.State in dsEditModes));
  btn_editar.Enabled := (not cds_posts.IsEmpty) and (not (cds_posts.State in dsEditModes));
  btn_editar.Enabled := not (cds_posts.State in dsEditModes);

  btn_ok.Enabled := (cds_posts.State in dsEditModes);
  btn_cancel.Enabled := (cds_posts.State in dsEditModes);

  me_idUsuario.Properties.ReadOnly :=  not (cds_posts.State = dsInsert);
  ed_titulo.Properties.ReadOnly :=  not (cds_posts.State in dsEditModes);
  ed_post.ReadOnly :=  not (cds_posts.State in dsEditModes);

  if (me_idUsuario.Properties.ReadOnly) then
    me_idUsuario.Style.Color := clBtnFace
  else
    me_idUsuario.Style.Color := clWindow;

  if (ed_titulo.Properties.ReadOnly) then
    ed_titulo.Style.Color := clBtnFace
  else
    ed_titulo.Style.Color := clWindow;

  if (ed_post.ReadOnly) then
    ed_post.Color := clBtnFace
  else
    ed_post.Color := clWindow;
end;

function TForm2.Validar: Boolean;
begin
  Result := True;

  if me_idUsuario.Text = '' then
    begin
      Result := False;
      ShowMessage('Informe o Id do usuário.');
      me_idUsuario.SetFocus;
    end;

  if ed_titulo.Text = '' then
    begin
      Result := False;
      ShowMessage('Informe o título do post.');
      ed_titulo.SetFocus;
    end;

  if ed_post.Text = '' then
    begin
      Result := False;
      ShowMessage('Digite a postagem.');
      ed_titulo.SetFocus;
    end;

end;

end.
