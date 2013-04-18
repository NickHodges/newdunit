unit NewDUnit.Types;

interface

uses
      System.SysUtils
    , System.Rtti
    , Spring
    , Spring.Collections
    , NewDUnit.TestInterfaces
    ;

type
  ENewDUnitException = class(Exception);
    ETestMethodHasArguments = class(ENewDUnitException);
    ENoTestFixturesFound = class(ENewDUnitException);

type

  TTest = class(TInterfacedObject, ITest)
  private
    FFixture: TObject;
    FMethod: TRttiMethod;
    FName: string;
    FResult: ITestResult;
    FEnabled: Boolean;
    function GetTestMethod: TRttiMethod;
    function GetEnabled: Boolean;
    procedure SetEnabled(aEnabled: Boolean);
  public
    constructor Create(aMethod: TRttiMethod);
    procedure SetTestResult(aResult: ITestResult);
    function Fixture: TObject;
    function TestName: string;
    function TestResult: ITestResult;
    property TestMethod: TRttiMethod read GetTestMethod;
    property Enabled: Boolean read GetEnabled write SetEnabled;
   end;

   TTests = class(TInterfacedObject, ITests)
   private
     FTests: IList<ITest>;
   public
     constructor Create;
     procedure AddTest(aTest: ITest);
     function Tests: IEnumerable<ITest>;
   end;

  TTestFixture = class(TInterfacedObject, ITestFixture)
  private
    FName: string;
    FClass: TClass;
    FInstance: TObject;
    FTests: ITests;
    FSetupMethods: IList<TRttiMethod>;
    FTearDownMethods: IList<TRttiMethod>;
    FSetupFixtureMethods: IList<TRttiMethod>;
    FTearDownFixtureMethods: IList<TRttiMethod>;
  public
    constructor Create(aClass: TClass);
    destructor Destroy; override;
    procedure AddSetupMethod(aValue: TRttiMethod);
    procedure AddTearDownMethod(aValue: TRttiMethod);
    function SetupMethods: IEnumerable<TRttiMethod>;
    function TearDownMethods: IEnumerable<TRttiMethod>;
    procedure AddSetupFixtureMethod(aValue: TRttiMethod);
    procedure AddTearDownFixtureMethod(aValue: TRttiMethod);
    function SetupFixtureMethods: IEnumerable<TRttiMethod>;
    function TearDownFixtureMethods: IEnumerable<TRttiMethod>;

    function Name: string;
    function FixtureClass: TClass;
    function FixtureInstance: TObject;
    procedure AddTest(aTest: ITest);
    function Tests: IEnumerable<ITest>;
  end;

  TTestFixtures = class(TInterfacedObject, ITestFixtures)
  private
    FFixtures: IList<ITestFixture>;
  public
    constructor Create;
    procedure AddFixture(aFixture: ITestFixture);
    function Fixtures: IEnumerable<ITestFixture>;
  end;

  TTestResult = class(TInterfacedObject, ITestResult)
  private
    FTestOutcome: TTestOutcome;
    FName: string;
    FErrorMessage: string;
    FFixtureName: string;
    function GetTestOutcome: TTestOutcome;
    procedure SetTestOutcome(const Value: TTestOutcome);
    function GetErrorMessage: string;
    procedure SetErrorMessage(const Value: string);
  public
    constructor Create(aName, aFixtureName: string; aTestOutcome: TTestOutcome; aErrorMessage: string);
    function FixtureName: string;
    function TestName: string;
    property TestOutcome: TTestOutcome read GetTestOutcome write SetTestOutcome;
    property ErrorMessage: string read GetErrorMessage write SetErrorMessage;
  end;

  TTestResults = class(TInterfacedObject, ITestResults)
  private
    FResults: IList<ITestResult>;
  public
    constructor Create;
    procedure AddResult(aResult: ITestResult);
    function Results: IEnumerable<ITestResult>;
  end;


implementation

uses
      System.TypInfo
    ;

{ TTest }

constructor TTest.Create(aMethod: TRttiMethod);
begin
  inherited Create;
  FMethod := aMethod;
  FName := FMethod.Name;
  FEnabled := True;
end;

function TTest.Fixture: TObject;
begin
  if FFixture = nil then
  begin
    FFixture := FMethod.Parent.AsInstance.MetaclassType.Create
  end;
  Result := FFixture;
end;

function TTest.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

function TTest.GetTestMethod: TRttiMethod;
begin
  Result := FMethod;
end;

function TTest.TestResult: ITestResult;
begin
  Result := FResult;
end;

procedure TTest.SetEnabled(aEnabled: Boolean);
begin
  FEnabled := aEnabled;
end;

procedure TTest.SetTestResult(aResult: ITestResult);
begin
  FResult := aResult;
end;

function TTest.TestName: string;
begin
  Result := FName;
end;

{ TTestFixture }

procedure TTestFixture.AddTest(aTest: ITest);
begin
  FTests.AddTest(aTest);
end;

constructor TTestFixture.Create(aClass: TClass);
begin
  TArgument.CheckNotNull(aClass, 'aClass');
  inherited Create;
  FName := aClass.ClassName;
  FClass := aClass;
  FInstance := aClass.Create;
  FTests := TTests.Create;
  FSetupMethods := TCollections.CreateList<TRttiMethod>;
  FTearDownMethods := TCollections.CreateList<TRttiMethod>;
  FSetupFixtureMethods := TCollections.CreateList<TRttiMethod>;
  FTearDownFixtureMethods := TCollections.CreateList<TRttiMethod>;
end;

destructor TTestFixture.Destroy;
begin
  FInstance.Free;
  inherited Destroy;
end;

procedure TTestFixture.AddSetupFixtureMethod(aValue: TRttiMethod);
begin
  FSetupFixtureMethods.Add(aValue);
end;

procedure TTestFixture.AddSetupMethod(aValue: TRttiMethod);
begin
  FSetupMethods.Add(aValue);
end;

procedure TTestFixture.AddTearDownFixtureMethod(aValue: TRttiMethod);
begin
  FTearDownFixtureMethods.Add(aValue);
end;

procedure TTestFixture.AddTearDownMethod(aValue: TRttiMethod);
begin
  FTearDownMethods.Add(aValue);
end;

function TTestFixture.SetupFixtureMethods: IEnumerable<TRttiMethod>;
begin
  Result := FSetupFixtureMethods;
end;

function TTestFixture.SetupMethods: IEnumerable<TRttiMethod>;
begin
  Result := FSetupMethods;
end;

function TTestFixture.TearDownFixtureMethods: IEnumerable<TRttiMethod>;
begin
  Result := FTearDownFixtureMethods;
end;

function TTestFixture.TearDownMethods: IEnumerable<TRttiMethod>;
begin
  Result := FTearDownMethods;
end;

function TTestFixture.FixtureClass: TClass;
begin
  Result := FClass;
end;

function TTestFixture.FixtureInstance: TObject;
begin
  Result := FInstance;
end;

function TTestFixture.Name: string;
begin
  Result := FName;
end;

function TTestFixture.Tests: IEnumerable<ITest>;
begin
  Result := FTests.Tests;
end;

{ TTestResult }

constructor TTestResult.Create(aName, aFixtureName: string; aTestOutcome: TTestOutcome; aErrorMessage: string);
begin
  inherited Create;
  FTestOutcome := aTestOutcome;
  FErrorMessage := aErrorMessage;
  FFixtureName := aFixtureName;
  FName := aName;
end;

function TTestResult.FixtureName: string;
begin
  Result := FFixtureName;
end;

function TTestResult.GetErrorMessage: string;
begin
  Result := '';
  if FTestOutcome = Failed then
  begin
    Result := FErrorMessage;
  end;
end;

function TTestResult.GetTestOutcome: TTestOutcome;
begin
  Result := FTestOutcome;
end;

procedure TTestResult.SetErrorMessage(const Value: string);
begin
  FErrorMessage := Value;
end;

procedure TTestResult.SetTestOutcome(const Value: TTestOutcome);
begin
  FTestOutcome := Value;
end;

function TTestResult.TestName: string;
begin
  Result := FName;
end;

{ TTestResults }

procedure TTestResults.AddResult(aResult: ITestResult);
begin
  FResults.Add(aResult);
end;

constructor TTestResults.Create;
begin
  inherited Create;
  FResults := TCollections.CreateList<ITestResult>;
end;


function TTestResults.Results: IEnumerable<ITestResult>;
begin
  Result := FResults;
end;

{ TTestFixtures }

procedure TTestFixtures.AddFixture(aFixture: ITestFixture);
begin
  FFixtures.Add(aFixture);
end;

constructor TTestFixtures.Create;
begin
  inherited Create;
  FFixtures := TCollections.CreateList<ITestFixture>;
end;

function TTestFixtures.Fixtures: IEnumerable<ITestFixture>;
begin
  Result := FFixtures;
end;


{ TTests }

procedure TTests.AddTest(aTest: ITest);
begin
  FTests.Add(aTest);
end;

constructor TTests.Create;
begin
  inherited Create;
  FTests := TCollections.CreateList<ITest>;
end;

function TTests.Tests: IEnumerable<ITest>;
begin
  Result := FTests;
end;

end.
