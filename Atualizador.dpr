program Atualizador;

uses
  Forms,
  frmAtualizador in 'frmAtualizador.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
