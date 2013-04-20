unit NewDUnit.Listeners.XML;

interface

uses
      NewDUnit.Listeners.Base
    , NewDUnit.TestInterfaces
    ;

type
  TConsoleTestListener = class(TTestListenerBase)
  public
    constructor Create;
    procedure OnStartTestingImpl; override;
    procedure OnSetupImpl(aTest: ITest); override;
    procedure OnTearDownImpl(aTest: ITest); override;
    procedure OnFinishTestingImpl; override;
    procedure OnTestResultImpl(aTestResult: ITestResult); override;
    procedure OnGetFixturesImpl(aFixtures: ITestFixtures); override;
  end;

implementation

{ TConsoleTestListener }

constructor TConsoleTestListener.Create;
begin

end;

procedure TConsoleTestListener.OnFinishTestingImpl;
begin
  inherited;

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

end;

procedure TConsoleTestListener.OnTearDownImpl(aTest: ITest);
begin
  inherited;

end;

procedure TConsoleTestListener.OnTestResultImpl(aTestResult: ITestResult);
begin
  inherited;

end;

end.
