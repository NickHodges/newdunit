unit Tests;

interface

uses
      NewDUnit.TestAttributes
    , NewDUnit.Assert
    ;

type
  [TestFixture]
  TWhatever = class
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestAgain;
    [Test]
    procedure TestEqualsInt;
    [Test]
    procedure TestEqualsStr;
  end;

  [TestFixture]
  TTester = class
    [Test]
    procedure Blah;
    [Test]
    procedure RaiseException;

  end;


implementation

uses
      NewDUnit.TestRegistry
    , System.SysUtils
    ;

{ TWhatever }


procedure TWhatever.Setup;
begin

end;

procedure TWhatever.TearDown;
begin
end;

procedure TWhatever.TestAgain;
begin
  Assert.IsTrue(True, 'Holy crap!  True is not true!');
end;

procedure TWhatever.TestEqualsInt;
begin
  Assert.AreEquals<integer>(4, 2+2, 'Addition of 2+2 failed');
end;

procedure TWhatever.TestEqualsStr;
begin
  Assert.AreEquals<string>('this', 'th'+'is', 'String concatenation failed');
end;

{ TTester }

procedure TTester.Blah;
begin
  Assert.IsTrue(5=3+2, 'Somehow, addition failed');
end;

procedure TTester.RaiseException;
begin
  raise Exception.Create('Error Message');
end;


initialization
  TTestRegistry.RegisterTest(TTester);
  TTestRegistry.RegisterTest(TWhatever);



end.
