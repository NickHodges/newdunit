unit NewDUnit.TestRunner;

interface

uses
      NewDUnit.TestInterfaces
    , Spring
    , Spring.Collections
    , NewDUnit.Types
    ;

type
  TTestRunner = class
  private
    FListeners: IList<ITestListener>;
    // Listener methods
    procedure ListenerStartTests;
    procedure ListenerFinishTests;
    procedure ListenerTestFinished(aResult: ITestResult);
    procedure ListenerFixturesGotten(aFixtures: ITestFixtures);
    procedure ListenerRunningSetup(aTest: ITest);
    procedure ListenerRunningTearDown(aTest: ITest);
  public
    constructor Create(aListener: ITestListener);
    procedure AddListener(aListener: ITestListener);
    function GetTestFixtures: ITestFixtures;
    function RunTests: ITestFixtures;
  end;

implementation

uses
      RTTI
    , System.SysUtils
    , System.TypInfo
    , NewDUnit.TestAttributes
    , NewDUnit.Exceptions
    ;

{ TTestRunner }

procedure TTestRunner.AddListener(aListener: ITestListener);
begin
  TArgument.CheckNotNull(aListener, 'aListener');
  FListeners.Add(aListener);
end;

constructor TTestRunner.Create(aListener: ITestListener);
begin
  TArgument.CheckNotNull(aListener, 'aListener');
  inherited Create;
  FListeners := TCollections.CreateList<ITestListener>;
  FListeners.Add(aListener);
end;

procedure TTestRunner.ListenerFinishTests;
var
  TempListener: ITestListener;
begin
  for TempListener in FListeners do
  begin
    TempListener.OnFinishTesting;
  end;
end;

procedure TTestRunner.ListenerFixturesGotten(aFixtures: ITestFixtures);
var
  TempListener: ITestListener;
begin
  TArgument.CheckNotNull(aFixtures, 'aFixtures');
  for TempListener in FListeners do
  begin
    TempListener.OnGetFixtures(aFixtures);
  end;
end;

function TTestRunner.GetTestFixtures:  ITestFixtures;
// Gets all the classes with the [TestFixture] attribute
// and fills in all the tests for each one.
var
  TempContext: TRttiContext;
  TempType: TRttiType;
  TempAttribute: TCustomAttribute;
  TempFixture: ITestFixture;
begin
  Result := TTestFixtures.Create;
  for TempType in TempContext.GetTypes do
  begin
    if TempType.TypeKind = TTypeKind.tkClass then   // only check classes
    begin
      for TempAttribute in TempType.GetAttributes do
      begin
        if TempAttribute is TestFixtureAttribute then
        begin
          TempFixture := TTestFixture.Create(TempType.AsInstance.MetaclassType);
          Result.AddFixture(TempFixture);
        end;
      end;
    end;
  end;
  ListenerFixturesGotten(Result);
end;

function TTestRunner.RunTests: ITestFixtures;
var
  TempTest: ITest;
  TempFixture: ITestFixture;
  TempResult: ITestResult;
begin
  ListenerStartTests;
  Result := GetTestFixtures;
  if Result.Fixtures.Count <= 0 then
  begin
    raise ENoTestFixturesFound.Create('No Test Fixtures were found in this binary.');
  end;
  for TempFixture in Result.Fixtures do
  begin
    TempFixture.ExecuteFixtureSetup;
    for TempTest in TempFixture.Tests do
    begin
      // Setup
      TempFixture.ExecuteTestSetup;
      ListenerRunningSetup(TempTest);
      // Run
      TempResult := TempTest.Execute;
      ListenerTestFinished(TempResult);
      // TearDown
      TempFixture.ExecuteTestTearDown;
      ListenerRunningTearDown(TempTest);
    end;
    TempFixture.ExecuteFixtureTearDown
  end;
  ListenerFinishTests;
end;

procedure TTestRunner.ListenerStartTests;
var
  TempListener: ITestListener;
begin
  for TempListener in FListeners do
  begin
    TempListener.OnStartTesting;
  end;
end;

procedure TTestRunner.ListenerRunningSetup(aTest: ITest);
var
  TempListener: ITestListener;
begin
  TArgument.CheckNotNull(aTest, 'aTest');
  for TempListener in FListeners do
  begin
    TempListener.OnSetup(aTest);
  end;
end;


procedure TTestRunner.ListenerRunningTearDown(aTest: ITest);
var
  TempListener: ITestListener;
begin
  TArgument.CheckNotNull(aTest, 'aTest');
  for TempListener in FListeners do
  begin
    TempListener.OnTearDown(aTest);
  end;
end;

procedure TTestRunner.ListenerTestFinished(aResult: ITestResult);
var
  TempListener: ITestListener;
begin
  TArgument.CheckNotNull(aResult, 'aResult');
  for TempListener in FListeners do
  begin
    TempListener.OnTestResult(aResult);
  end;
end;

end.
