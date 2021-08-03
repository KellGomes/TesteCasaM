program TesteCM;

uses
  Vcl.Forms,
  u_principal in 'u_principal.pas' {Form2},
  dm_teste in 'dm_teste.pas' {pdm_teste: TDataModule},
  u_CadPosts in 'u_CadPosts.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(Tpdm_teste, pdm_teste);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
