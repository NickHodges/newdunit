unit NewDUnit.TestInterfaces;

interface

uses
      System.Rtti
    , Spring.Collections
    ;

type

  TTestOutcome = (Passed, Failed, Error);

  ITestResult = interface
  ['{C76C3040-5595-42AA-AB04-F150548C0CEB}']
    function GetTestOutcome: TTestOutcome;
    procedure SetTestOutcome(const Value: TTestOutcome);
    function GetErrorMessage: string;
    procedure SetErrorMessage(const Value: string);
    function TestName: string;
    function FixtureName: string;
    property TestOutcome: TTestOutcome read GetTestOutcome write SetTestOutcome;
    property ErrorMessage: string read GetErrorMessage write SetErrorMessage;
  end;

  ITestResults = interface
  ['{0D6541B2-3F81-4F60-96BA-C5164B0CAEF9}']
    procedure AddResult(aResult: ITestResult);
    function Results: IEnumerable<ITestResult>;
  end;

  ITestFixture = interface;

  ITest = interface
  ['{01630F7C-4EC7-4E6A-A1E9-0C032E0DF2E4}']
    function GetEnabled: Boolean;
    procedure SetEnabled(aEnabled: Boolean);
    function GetTestMethod: TRttiMethod;
    function Fixture: ITestFixture;
    function TestName: string;
    procedure SetTestResult(aResult: ITestResult);
    function TestResult: ITestResult;
    property TestMethod: TRttiMethod read GetTestMethod;
    property Enabled: Boolean read GetEnabled write SetEnabled;
  end;

  ITests = interface
  ['{95A4B753-76A7-4E13-9D2A-07A4D1E0FA0A}']
    procedure AddTest(aTest: ITest);
    function Tests: IEnumerable<ITest>;
  end;

  ITestFixture = interface
  ['{F5B4E1DD-1DB5-416A-BF47-482BD94A5146}']
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

  ITestFixtures = interface
  ['{80DD40E4-C938-413F-8564-0ADB414BBF24}']

    procedure AddFixture(aFixture: ITestFixture);
    function Fixtures: IEnumerable<ITestFixture>;
  end;

  ITestListener = interface
  ['{97AD256E-FD9F-4AAC-ACCF-70A9FC8907AB}']
    procedure OnStartTesting;
    procedure OnSetup(aTest: ITest);
    procedure OnTearDown(aTest: ITest);
    procedure OnTestResult(aTestResult: ITestResult);
    procedure OnFinishTesting;
    procedure OnGetFixtures(aFixtures: ITestFixtures);
  end;



implementation

end.
