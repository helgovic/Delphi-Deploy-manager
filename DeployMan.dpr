program DeployMan;

uses
  Vcl.Forms,
  UFormMain in 'UFormMain.pas' {FormMain},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Deploy Manager';
  TStyleManager.TrySetStyle('Charcoal Dark Slate');
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
