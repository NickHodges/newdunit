unit NewDUnit.Listeners.Base;

interface

uses
      NewDUnit.TestInterfaces
    ;

type
  TTestListenerBase = class(TInterfacedObject, ITestListener)
  private
    FTotalTests: integer;
    FTotalErrors: integer;
    FTotalPassed: integer;
    FTotalFailed: integer;
    procedure OnStartTesting;
    procedure OnSetup(aTest: ITest);
    procedure OnTearDown(aTest: ITest);
    procedure OnFinishTesting;
    procedure OnTestResult(aTestResult: ITestResult);
    procedure OnGetFixtures(aFixtures: ITestFixtures);
  protected
    constructor Create;
    procedure OnStartTestingImpl; virtual;
    procedure OnSetupImpl(aTest: ITest); virtual;
    procedure OnTearDownImpl(aTest: ITest); virtual;
    procedure OnFinishTestingImpl; virtual;
    procedure OnTestResultImpl(aTestResult: ITestResult); virtual;
    procedure OnGetFixturesImpl(aFixtures: ITestFixtures); virtual;
    property TotalTests: integer read FTotalTests;
    property TotalErrors: integer read FTotalErrors;
    property TotalPassed: integer read FTotalPassed;
    property TotalFailed: integer read FTotalFailed;
  end;

implementation

{ TTestListenerBase }

constructor TTestListenerBase.Create;
begin
  inherited Create;
  FTotalTests := 0;
  FTotalErrors := 0;
  FTotalPassed := 0;
  FTotalFailed := 0;
end;

procedure TTestListenerBase.OnFinishTesting;
begin
  OnFinishTestingImpl;
end;

procedure TTestListenerBase.OnFinishTestingImpl;
begin
  //
end;

procedure TTestListenerBase.OnGetFixtures(aFixtures: ITestFixtures);
begin
  OnGetFixturesImpl(aFixtures);
end;

procedure TTestListenerBase.OnGetFixturesImpl(aFixtures: ITestFixtures);
begin
  //
end;

procedure TTestListenerBase.OnSetup(aTest: ITest);
begin
  OnSetupImpl(aTest);
end;

procedure TTestListenerBase.OnSetupImpl(aTest: ITest);
begin
  //
end;

procedure TTestListenerBase.OnStartTesting;
begin
  OnStartTestingImpl;
end;

procedure TTestListenerBase.OnStartTestingImpl;
begin
  //
end;

procedure TTestListenerBase.OnTearDown(aTest: ITest);
begin
   OnTearDownImpl(aTest);
end;

procedure TTestListenerBase.OnTearDownImpl(aTest: ITest);
begin
  //
end;

procedure TTestListenerBase.OnTestResult(aTestResult: ITestResult);
begin
  Inc(FTotalTests);
  case aTestResult.TestOutcome of
    Passed: inc(FTotalPassed);
    Failed: inc(FTotalFailed);
    Error: inc(FTotalErrors);
  end;
  OnTestResultImpl(aTestResult);
end;

procedure TTestListenerBase.OnTestResultImpl(aTestResult: ITestResult);
begin
  //
end;

end.
