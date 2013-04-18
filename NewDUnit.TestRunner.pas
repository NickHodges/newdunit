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
    procedure GetMethodsForFixture(aFixture: ITestFixture);
    procedure InvokeSetup(aFixture: ITestFixture);
    procedure InvokeTearDown(aFixture: ITestFixture);
    procedure InvokeSetupFixture(aFixture: ITestFixture);
    procedure InvokeTearDownFixture(aFixture: ITestFixture);

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
          GetMethodsForFixture(TempFixture);
          Result.AddFixture(TempFixture);
        end;
      end;
    end;
  end;
  ListenerFixturesGotten(Result);
end;

procedure TTestRunner.GetMethodsForFixture(aFixture: ITestFixture);
// Pass in a fixture, it fills in the tests that the fixture has
var
  Context: TRttiContext;
  TempType: TRttiType;
  TempMethod: TRttiMethod;
  TempAttribute: TCustomAttribute;
begin
  TArgument.CheckNotNull(aFixture, 'aFixture');
  TempType := Context.GetType(aFixture.FixtureInstance);
  for TempMethod in TempType.GetMethods do
  begin
    for TempAttribute in TempMethod.GetAttributes do
    begin
      if TempAttribute is TestAttribute then
      begin
        aFixture.AddTest(TTest.Create(TempMethod));
      end else
      begin
        if TempAttribute is SetupAttribute then
        begin
          aFixture.AddSetupMethod(TempMethod);
        end else
        begin
          if TempAttribute is TearDownAttribute then
          begin
            aFixture.AddTearDownMethod(TempMethod);
          end else
          begin
            if TempAttribute is SetupFixtureAttribute then
            begin
              aFixture.AddSetupFixtureMethod(TempMethod);
            end else
            begin
              if TempAttribute is TearDownFixtureAttribute then
              begin
                aFixture.AddTearDownFixtureMethod(TempMethod);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
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
    raise ENoTestFixturesFoune.Create('No Test Fixtures were found in this binary.');
  end;
  for TempFixture in Result.Fixtures do
  begin
    InvokeSetupFixture(TempFixture);
    for TempTest in TempFixture.Tests do
    begin
      try
        InvokeSetup(TempFixture);
        ListenerRunningSetup(TempTest);
        TempTest.TestMethod.Invoke(TempTest.Fixture, []);
        TempResult := TTestResult.Create(TempTest.TestName, TempTest.Fixture.ClassName, Passed, '');
        TempTest.SetTestResult(TempResult);
        ListenerTestFinished(TempResult);
      except
        on E: Exception do
        begin
          if E is ENewDUnitException then
          begin
            TempResult := TTestResult.Create(TempTest.TestName, TempTest.Fixture.ClassName, Failed, E.Message);
          end else
          begin
            // Exception was unexpected
            TempResult := TTestResult.Create(TempTest.TestName, TempTest.Fixture.ClassName, Error, E.Message);
          end;
          TempTest.SetTestResult(TempResult);
          ListenerTestFinished(TempResult);
        end;
      end;
      InvokeTearDown(TempFixture);
      ListenerRunningTearDown(TempTest);
    end;
    InvokeTearDownFixture(TempFixture);
  end;
  ListenerFinishTests;
end;

procedure TTestRunner.InvokeSetupFixture(aFixture: ITestFixture);
var
  TempObj: TObject;
  TempMethod: TRttiMethod;
begin
  TArgument.CheckNotNull(aFixture, 'aFixture');
  if aFixture.SetupFixtureMethods <> nil then
  begin
    TempObj := aFixture.FixtureInstance.Create;
    try
      for TempMethod in aFixture.SetupFixtureMethods do
      begin
        TempMethod.Invoke(TempObj, []);
      end;
    finally
      TempObj.Free;
    end;
  end;
end;

procedure TTestRunner.InvokeSetup(aFixture: ITestFixture);
var
  TempObj: TObject;
  TempMethod: TRttiMethod;
begin
  TArgument.CheckNotNull(aFixture, 'aFixture');
  if aFixture.SetupMethods <> nil then
  begin
    TempObj := aFixture.FixtureInstance.Create;
    try
      for TempMethod in aFixture.SetupMethods do
      begin
        TempMethod.Invoke(TempObj, []);
      end;
    finally
      TempObj.Free;
    end;
  end;
end;

procedure TTestRunner.InvokeTearDownFixture(aFixture: ITestFixture);
var
  TempObj: TObject;
  TempMethod: TRttiMethod;
begin
  TArgument.CheckNotNull(aFixture, 'aFixture');
  if aFixture.TearDownFixtureMethods <> nil then
  begin
    TempObj := aFixture.FixtureInstance.Create;
    try
      for TempMethod in aFixture.TearDownFixtureMethods do
      begin
        TempMethod.Invoke(TempObj, [])
      end;
    finally
      TempObj.Free;
    end;
  end;
end;

procedure TTestRunner.InvokeTearDown(aFixture: ITestFixture);
var
  TempObj: TObject;
  TempMethod: TRttiMethod;
begin
  TArgument.CheckNotNull(aFixture, 'aFixture');
  if aFixture.TearDownMethods <> nil then
  begin
    TempObj := aFixture.FixtureInstance.Create;
    try
      for TempMethod in aFixture.TearDownMethods do
      begin
        TempMethod.Invoke(TempObj, [])
      end;
    finally
      TempObj.Free;
    end;
  end;
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
