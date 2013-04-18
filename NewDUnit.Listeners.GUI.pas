unit NewDUnit.Listeners.GUI;

interface

uses
      NewDUnit.TestInterfaces
    , NewDUnit.Listeners.GUIForm
    ;

type
  TGUIListener = class(TInterfacedObject, ITestListener)
  private
    FForm: TGUIFormRunner;
    procedure OnStartTesting;
    procedure OnSetup(aTest: ITest);
    procedure OnTearDown(aTest: ITest);
    procedure OnTestResult(aTestResult: ITestResult);
    procedure OnFinishTesting;
    procedure OnGetFixtures(aFixtures: ITestFixtures);
    procedure WriteToMemo(aString: string);
  public
    constructor Create(aGUIFormRunner: TGUIFormRunner);
    destructor Destroy; override;
  end;

implementation

uses
       System.SysUtils
     ;

{ TGUIListener }

constructor TGUIListener.Create(aGUIFormRunner: TGUIFormRunner);
begin
  inherited Create;
  FForm := aGUIFormRunner;
  FForm.Show;
end;

destructor TGUIListener.Destroy;
begin
 // FForm.Free;
  inherited;
end;

procedure TGUIListener.OnFinishTesting;
begin
  WriteToMemo('Testing Complete');
end;

procedure TGUIListener.OnGetFixtures(aFixtures: ITestFixtures);
var
  TempFixture: ITestFixture;
  TempTest: ITest;
begin
  WriteToMemo('A total of ' + IntToStr(aFixtures.Fixtures.Count) + ' fixtures have been gotten');

  for TempFixture in aFixtures.Fixtures do
  begin
    WriteToMemo('The ' + TempFixture.Name + ' fixture has ' + IntToStr(TempFixture.Tests.Count) + ' tests');
    for TempTest in TempFixture.Tests do
    begin
      WriteToMemo('    ' + TempTest.TestName);
    end;
  end;
end;

procedure TGUIListener.OnSetup(aTest: ITest);
begin
  WriteToMemo('Set up for ' + aTest.TestName);
end;

procedure TGUIListener.OnStartTesting;
begin
  WriteToMemo('Testing started.');
end;

procedure TGUIListener.OnTearDown(aTest: ITest);
begin
  WriteToMemo('Tear down for ' + aTest.TestName);
end;

procedure TGUIListener.OnTestResult(aTestResult: ITestResult);
begin
  if aTestResult.TestOutcome = Passed then
  begin
    WriteToMemo(aTestResult.FixtureName +'.' + aTestResult.TestName + ': Passed!');
  end else
  begin
    WriteToMemo(aTestResult.FixtureName + '.' + aTestResult.TestName + ': failed -- "' + aTestResult.ErrorMessage + '"');
  end;
end;

procedure TGUIListener.WriteToMemo(aString: string);
begin
  FForm.Memo1.Lines.Add(aString);
end;

end.
