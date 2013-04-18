unit NewDUnit.Assert;

interface

type
  Assert = class
    class procedure IsTrue(const aCondition: Boolean; const aErrorMessage: string = '');
    class procedure IsFalse(const aCondition: Boolean; const aErrorMessage: string = '');

    class procedure AreEquals<T>(const aExpected: T; const aActual: T; const aErrorMessage: string = '');

  end;

implementation

uses
       NewDUnit.Types
     , Spring.Collections
     , System.Rtti
     , System.Generics.Defaults
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

class procedure Assert.IsTrue(const aCondition: Boolean; const aErrorMessage: string);
begin
  if not aCondition then
  begin
    raise ENewDUnitException.CreateFmt('Expected True but condition was False: "%s"', [aErrorMessage]);
  end;
end;

end.
