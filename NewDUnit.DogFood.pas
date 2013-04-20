unit NewDUnit.DogFood;

interface

uses
      NewDUnit.Types
    , System.Rtti
    , NewDUnit.TestAttributes
    , NewDUnit.TestInterfaces
    ;

type
  [TestFixture]
  TCreationTest = class
  private
    FObject: TObject;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestCreation;
  end;

  [TestFixture]
  TAssertTest = class
    [Test]
    procedure TestIsTrue;
    [Test]
    procedure TestIsFalse;
  end;

  [TestFixture]
  TSample = class
    [Test]
    procedure SomeTest;
  end;

  [TestFixture]
  TEmptyTearDown = class
    [Test]
    procedure SomeTest;
    [TearDown]
    procedure EmptyTearDown;
  end;

    [TestFixture]
  TTestTTestFixtures = class
  private
    FTestFixtures: TTestFixtures;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestCreation;
  end;


implementation

uses
      NewDUnit.Assert
    , NewDUnit.TestRegistry
    ;

{ TTestTTest }

procedure TCreationTest.Setup;
begin
  FObject := TObject.Create;
end;

procedure TCreationTest.TearDown;
begin
  FObject.Free;
end;

procedure TCreationTest.TestCreation;
begin
  Assert.IsTrue(FObject <> nil, 'FObject is nil and it should not be');
end;

{ TAssertTest }

procedure TAssertTest.TestIsFalse;
begin
  Assert.IsFalse(False, 'IsFalse failed');
end;

procedure TAssertTest.TestIsTrue;
begin
  Assert.IsTrue(True, 'IsTrue failed');
end;

{ TFixtureSample }

procedure TSample.SomeTest;
begin
  Assert.IsTrue(True);
end;

{ TEmptyTearDown }

procedure TEmptyTearDown.EmptyTearDown;
begin

end;

procedure TEmptyTearDown.SomeTest;
begin
  Assert.IsFalse(False);
end;


{ TTestTTestFixtures }

procedure TTestTTestFixtures.Setup;
begin
  FTestFixtures := TTestFixtures.Create;
end;

procedure TTestTTestFixtures.TearDown;
begin
  FTestFixtures.Free;
end;

procedure TTestTTestFixtures.TestCreation;
begin
  Assert.IsNotNil(FTestFixtures);
end;

initialization
  TTestRegistry.RegisterTest(TSample);
  TTestRegistry.RegisterTest(TCreationTest);
  TTestRegistry.RegisterTest(TAssertTest);
  TTestRegistry.RegisterTest(TEmptyTearDown);
  TTestRegistry.RegisterTest(TTestTTestFixtures);

end.
