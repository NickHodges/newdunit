unit NewDUnit.Listeners.Console;

interface

uses
      NewDUnit.TestInterfaces
    , NewDUnit.Listeners.Base
    ;

type
  TExitBehavior = (Continue, Pause, HaltOnFailure);


type
  TConsoleTestListener = class(TTestListenerBase)
  private
    FExitBehavior: TExitBehavior;
  public
    constructor Create(const aExitBehavior: TExitBehavior);
    procedure OnStartTestingImpl; override;
    procedure OnSetupImpl(aTest: ITest); override;
    procedure OnTearDownImpl(aTest: ITest); override;
    procedure OnFinishTestingImpl; override;
    procedure OnTestResultImpl(aTestResult: ITestResult); override;
    procedure OnGetFixturesImpl(aFixtures: ITestFixtures); override;
  end;

implementation

{ TConsoleTestListener }

constructor TConsoleTestListener.Create(const aExitBehavior: TExitBehavior);
begin
  inherited Create;
  FExitBehavior := aExitBehavior;
end;

procedure TConsoleTestListener.OnFinishTestingImpl;
begin
  inherited;
  WriteLn;
  WriteLn('Total Tests: ', TotalTests, '; Total Failed: ', TotalFailed, '; Total Errors: ', TotalErrors );
  case FExitBehavior of
    Continue: ; // Just continue;
    Pause: begin
             ReadLn;
           end;
    HaltOnFailure:
           begin
             Halt(TotalErrors + TotalFailed);
           end;
  end;



end;

procedure TConsoleTestListener.OnGetFixturesImpl(aFixtures: ITestFixtures);
begin
  inherited;

end;

procedure TConsoleTestListener.OnSetupImpl(aTest: ITest);
begin
  inherited;

end;

procedure TConsoleTestListener.OnStartTestingImpl;
begin
  inherited;
  Writeln('NewDUnit Console Application Version 0.1 Copyright (c) 2013 by Nick Hodges');
end;

procedure TConsoleTestListener.OnTearDownImpl(aTest: ITest);
begin
  inherited;

end;

procedure TConsoleTestListener.OnTestResultImpl(aTestResult: ITestResult);
begin
  inherited;
  case aTestResult.TestOutcome of
    Passed: Write('.');
    Failed: Write('F');
    Error:  Write('E');
  end;
end;

end.
