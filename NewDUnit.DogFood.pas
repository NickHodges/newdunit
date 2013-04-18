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
  // Do nothing
end;

procedure TTestTTest.Setup;
begin

end;

procedure TTestTTest.TearDown;
begin

end;

procedure TTestTTest.TestCreation;
begin

end;

initialization
  TTestRegistry.RegisterTest(TTestTTest);

end.
