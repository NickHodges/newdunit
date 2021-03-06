program NewDUnitConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  NewDUnit.Types in 'NewDUnit.Types.pas',
  NewDUnit.TestRunner in 'NewDUnit.TestRunner.pas',
  NewDUnit.TestRegistry in 'NewDUnit.TestRegistry.pas',
  NewDUnit.TestInterfaces in 'NewDUnit.TestInterfaces.pas',
  NewDUnit.TestAttributes in 'NewDUnit.TestAttributes.pas',
  NewDUnit.Listeners.Console in 'NewDUnit.Listeners.Console.pas',
  NewDUnit.Assert in 'NewDUnit.Assert.pas',
  NewDUnit.Listeners.Base in 'NewDUnit.Listeners.Base.pas',
  Tests in 'Tests.pas',
  NewDUnit.DogFood in 'NewDUnit.DogFood.pas',
  NewDUnit.Exceptions in 'NewDUnit.Exceptions.pas',
  NewDUnit.xUnitXMLFormat in 'NewDUnit.xUnitXMLFormat.pas',
  NewDUnit.Listeners.XML in 'NewDUnit.Listeners.XML.pas';

procedure RunTests;
var
  TestRunner: TTestRunner;
begin
  TestRunner := TTestRunner.Create(TConsoleTestListener.Create(Pause));
  try
    TestRunner.RunTests;
  finally
    TestRunner.Free;
  end;
end;


begin
  try
    RunTests;
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      Readln;
    end;
  end;

end.
