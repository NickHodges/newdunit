program NewDUnit;

{ $APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  NewDUnit.TestAttributes in 'NewDUnit.TestAttributes.pas',
  NewDUnit.TestInterfaces in 'NewDUnit.TestInterfaces.pas',
  NewDUnit.Assert in 'NewDUnit.Assert.pas',
  NewDUnit.Types in 'NewDUnit.Types.pas',
  NewDUnit.TestRunner in 'NewDUnit.TestRunner.pas',
  Tests in 'Tests.pas',
  NewDUnit.Listeners.Console in 'NewDUnit.Listeners.Console.pas',
  NewDUnit.Listeners.TextFile in 'NewDUnit.Listeners.TextFile.pas',
  NewDUnit.TestRegistry in 'NewDUnit.TestRegistry.pas',
  NewDUnit.Listeners.GUIForm in 'NewDUnit.Listeners.GUIForm.pas' {GUIFormRunner},
  NewDUnit.Listeners.GUI in 'NewDUnit.Listeners.GUI.pas';

var
  TempFixtures: ITestFixtures;
  TestRunner: TTestRunner;

begin
  try
//    TestRunner := TTestRunner.Create(TConsoleTestListener.Create);
//    TestRunner := TTestRunner.Create(TTextFileTestListener.Create('c:\junk\testresults.txt'));
    TestRunner := TTestRunner.Create(TGUIListener.Create(TGUIFormRunner.Create(nil)));


   // TestRunner.AddListener(TConsoleTestListener.Create);
    try
      TempFixtures := TestRunner.RunTests;
    finally
      TestRunner.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
