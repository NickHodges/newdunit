unit NewDUnit.DogFood;

interface

uses
      NewDUnit.Types
    , System.Rtti
    , NewDUnit.TestAttributes
    ;

type
  [TestFixture]
  TTestTTest = class
  private
    FObject: TObject;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure Blah;
    [Test]
    procedure TestCreation;
  end;

implementation

uses
      NewDUnit.Assert
    , NewDUnit.TestRegistry
    ;

{ TTestTTest }

procedure TTestTTest.Blah;
begin
  Assert.IsTrue(False, 'Blah');
end;

procedure TTestTTest.Setup;
begin
  FObject := TObject.Create;
end;

procedure TTestTTest.TearDown;
begin
  FObject.Free;
end;

procedure TTestTTest.TestCreation;
begin
  Assert.IsTrue(FObject <> nil, 'FObject is nil and it should not be');
end;

initialization
  TTestRegistry.RegisterTest(TTestTTest);

end.
