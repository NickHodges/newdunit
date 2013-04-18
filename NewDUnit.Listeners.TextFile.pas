unit NewDUnit.Listeners.TextFile;

interface

uses
      NewDUnit.TestInterfaces
    , System.Classes
    ;

type
  TTextFileTestListener = class(TInterfacedObject, ITestListener)
  private
    FFilename: string;
    FSL: TStrings;
  public
    constructor Create(aFilename: string);
    destructor Destroy; override;
    procedure OnStartTesting;
    procedure OnSetup(aTest: ITest);
    procedure OnTearDown(aTest: ITest);
    procedure OnFinishTesting;
    procedure OnTestResult(aTestResult: ITestResult);
    procedure OnGetFixtures(aFixtures: ITestFixtures);
  end;


implementation

uses
       System.SysUtils
     ;

{ TConsoleTestListener }

constructor TTextFileTestListener.Create(aFilename: string);
begin
  inherited Create;
  FFilename := aFilename;
  FSL := TStringList.Create;
end;

destructor TTextFileTestListener.Destroy;
begin
  FSL.SaveToFile(FFilename);
  FSL.Free;
  inherited;
end;

procedure TTextFileTestListener.OnFinishTesting;
begin
  FSL.Add('Testing has completed');
end;

procedure TTextFileTestListener.OnGetFixtures(aFixtures: ITestFixtures);
var
  TempFixture: ITestFixture;
  TempTest: ITest;
begin
  FSL.Add('A total of ' + IntToStr(aFixtures.Fixtures.Count) + ' fixtures have been gotten');

  for TempFixture in aFixtures.Fixtures do
  begin
    FSL.Add('The ' + TempFixture.Name + ' fixture has ' + IntToStr(TempFixture.Tests.Count) + ' tests');
    for TempTest in TempFixture.Tests do
    begin
      FSL.Add('    ' + TempTest.TestName);
    end;
  end;
end;

procedure TTextFileTestListener.OnSetup(aTest: ITest);
var
  TempName: string;
  TempClassName: string;
begin
  TempName := aTest.TestName;
  TempClassName := aTest.Fixture.ClassName;
  FSL.Add('Setting up ' + TempClassName + '.' + TempName);
end;

procedure TTextFileTestListener.OnStartTesting;
begin
  FSL.Add('Testing is beginning.');
end;

procedure TTextFileTestListener.OnTearDown(aTest: ITest);
var
  TempName: string;
  TempClassName: string;
begin
  TempName := aTest.TestName;
  TempClassName := aTest.Fixture.ClassName;
  FSL.Add('Tearing down ' + TempClassName + '.' + TempName);
end;

procedure TTextFileTestListener.OnTestResult(aTestResult: ITestResult);
begin
  if aTestResult.TestOutcome = Passed then
  begin
    FSL.Add(aTestResult.FixtureName + '.' + aTestResult.TestName + ': Passed!');
  end else
  begin
    FSL.Add(aTestResult.FixtureName + '.' + aTestResult.TestName + ': failed -- "' + aTestResult.ErrorMessage + '"');
  end;
end;

end.
