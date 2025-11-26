// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program DeployMan;

uses
  Vcl.Forms,
  UFormMain in 'UFormMain.pas' {FormMain},
  Vcl.Themes,
  Vcl.Styles,
  UFCompare in 'UFCompare.pas' {FCompare};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Aqua Graphite');
  Application.Title := 'Deploy Manager';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFCompare, FCompare);
  Application.Run;
end.
