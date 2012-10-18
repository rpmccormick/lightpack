program RPMlight;

uses
  Forms,
  Controller in 'Controller.pas' {RPMForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'RPM Light';
  Application.CreateForm(TRPMForm, RPMForm);
  Application.Run;
end.
