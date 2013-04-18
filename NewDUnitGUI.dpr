program NewDUnitGUI;

uses
  Vcl.Forms,
  NewDUnit.Listeners.GUIForm in 'NewDUnit.Listeners.GUIForm.pas' {Form10},
  Tests in 'Tests.pas',
  NewDUnit.Types in 'NewDUnit.Types.pas',
  NewDUnit.TestRunner in 'NewDUnit.TestRunner.pas',
  NewDUnit.TestRegistry in 'NewDUnit.TestRegistry.pas',
  NewDUnit.TestInterfaces in 'NewDUnit.TestInterfaces.pas',
  NewDUnit.TestAttributes in 'NewDUnit.TestAttributes.pas',
  NewDUnit.Listeners.TextFile in 'NewDUnit.Listeners.TextFile.pas',
  NewDUnit.Listeners.GUI in 'NewDUnit.Listeners.GUI.pas',
  NewDUnit.Listeners.Console in 'NewDUnit.Listeners.Console.pas',
  NewDUnit.Assert in 'NewDUnit.Assert.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TGUIFormRunner, GUIFormRunner);
  Application.Run;
end.
