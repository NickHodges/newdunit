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
    procedure TestMe;
    [Test]
    procedure TestAgain;
    [Test]
    procedure NegativeTest;
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
    procedure WillFail;
    [Setup]
    procedure DoingSetup;
    [SetupFixture]
    procedure DoSetupFixture;
    [TearDownFixture]
    procedure DoTearDownFixture;
    [Test]
    procedure RaiseException;

  end;


implementation

uses
      NewDUnit.TestRegistry
    , System.SysUtils
    ;

{ TWhatever }

procedure TWhatever.NegativeTest;
begin
  Assert.IsFalse(True, 'Failed on purpose');
end;

procedure TWhatever.Setup;
begin

end;

procedure TWhatever.TearDown;
begin
end;

procedure TWhatever.TestAgain;
begin
  Assert.IsTrue(True);
end;

procedure TWhatever.TestEqualsInt;
begin
  Assert.AreEquals<integer>(4, 2+2, 'Addition of 2+2 failed');
end;

procedure TWhatever.TestEqualsStr;
begin
  Assert.AreEquals<string>('this', 'th'+'is');
end;

procedure TWhatever.TestMe;
begin
  Assert.IsTrue(False, 'This is the error message');
end;

{ TTester }

procedure TTester.Blah;
begin
  Assert.IsTrue(5=3+2, 'Somehow, addition failed');
end;

procedure TTester.DoingSetup;
begin
  //WriteLn('DoingSetup');
end;

procedure TTester.DoSetupFixture;
begin
  //WriteLn('Doing SetupFixture');
end;

procedure TTester.DoTearDownFixture;
begin
  //Writeln('Doing TearDownFixture');
end;

procedure TTester.RaiseException;
begin
  raise Exception.Create('Error Message');
end;

procedure TTester.WillFail;
begin
  Assert.IsTrue(False, 'Failed on purpose');
end;

initialization
  TTestRegistry.RegisterTest(TWhatever);
  TTestRegistry.RegisterTest(TTester);

end.
