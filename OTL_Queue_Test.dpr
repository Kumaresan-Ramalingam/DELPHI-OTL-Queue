program OTL_Queue_Test;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {frmTestOmniQueue};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTestOmniQueue, frmTestOmniQueue);
  Application.Run;
end.
