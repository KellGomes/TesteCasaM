unit dm_teste;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls,
  cxGraphics, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet,
  Vcl.Forms;

type
  Tpdm_teste = class(TDataModule)
    cxImageList1: TcxImageList;
    FDCommand1: TFDCommand;
    FDTableAdapter1: TFDTableAdapter;
    fdq_query: TFDQuery;
    fdc_Conexao: TFDConnection;
    fdq_queryuserId: TIntegerField;
    fdq_queryid: TIntegerField;
    fdq_querytitle: TStringField;
    fdq_querybody: TStringField;
    MemT_Posts: TFDMemTable;
    MemT_PostsuserId: TIntegerField;
    MemT_Postsid: TIntegerField;
    MemT_Poststitle: TStringField;
    MemT_Postsbody: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure gerarLog (p_texto :string);
  end;

var
  pdm_teste: Tpdm_teste;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tpdm_teste }

procedure Tpdm_teste.DataModuleCreate(Sender: TObject);
begin
  fdc_Conexao.open;
  MemT_Posts.Active := False;
end;

procedure Tpdm_teste.DataModuleDestroy(Sender: TObject);
begin
  fdc_Conexao.Close;
end;

procedure Tpdm_teste.gerarLog(p_texto: string);
var
  NomeDoLog: string;
  Arquivo: TextFile;
begin
  NomeDoLog := ChangeFileExt(Application.Exename, '.log');
  AssignFile(Arquivo, NomeDoLog);

  if FileExists(NomeDoLog) then
  Append(arquivo) { se existir, apenas adiciona linhas }
  else
    ReWrite(arquivo); { cria um novo se não existir }
  try
    WriteLn(arquivo, DateTimeToStr(Now) + ':' + p_texto);
    WriteLn(arquivo,'----------------------------------------------------------------------');
  finally
    CloseFile(arquivo)
  end;

end;

end.
