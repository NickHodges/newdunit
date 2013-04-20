unit NewDUnit.Assert;

interface

type
  Assert = class
    class procedure IsTrue(const aCondition: Boolean; const aErrorMessage: string = '');
    class procedure IsFalse(const aCondition: Boolean; const aErrorMessage: string = '');

    class procedure AreEquals<T>(const aExpected: T; const aActual: T; const aErrorMessage: string = '');

    class procedure IsNotNil(aObject: TObject; const aErrorMessage: string = '');

  private
    class procedure AreSame(const aExptected, aActual: TObject; const aErrorMessage: string = ''); static;
  end;

implementation

uses
       NewDUnit.Types
     , Spring.Collections
     , System.Rtti
     , System.Generics.Defaults
     , NewDUnit.Exceptions
     ;

{ Assert }

class procedure Assert.AreEquals<T>(const aExpected, aActual: T; const aErrorMessage: string);
var
  EqualityComparer : IEqualityComparer<T>;
  TempExpected, TempActual : TValue;
begin
  EqualityComparer := TEqualityComparer<T>.Default;
  if not EqualityComparer.Equals(aExpected, aActual) then
  begin
    TempExpected := TValue.From<T>(aExpected);
    TempActual := TValue.From<T>(aActual);
    raise ENewDUnitException.CreateFmt('Expected %s but actual was %s',[TempExpected.AsString, TempActual.AsString]);
  end;
end;

class procedure Assert.IsFalse(const aCondition: Boolean; const aErrorMessage: string);
begin
  if aCondition then
  begin
    raise ENewDUnitException.CreateFmt('Expected False but condition was True: "%s"', [aErrorMessage]);
  end;
end;

class procedure Assert.IsNotNil(aObject: TObject; const aErrorMessage: string);
begin
  if aObject = nil then
  begin
    raise ENewDUnitException.Create('aObject is nil and it should not be.');
  end;
end;

class procedure Assert.IsTrue(const aCondition: Boolean; const aErrorMessage: string);
begin
  if not aCondition then
  begin
    raise ENewDUnitException.CreateFmt('Expected True but condition was False: "%s"', [aErrorMessage]);
  end;
end;

class procedure Assert.AreSame(const aExptected, aActual: TObject; const aErrorMessage: string = '');
begin
  if not aExptected.Equals(aActual) then
    raise ENewDUnitException.CreateFmt('Object [%s] Not Object [%s] %s',[aExptected.ToString, aActual.ToString, aErrorMessage]);
end;


end.
