unit NewDUnit.TestRegistry;

interface

type
  TTestRegistry = class
    class procedure RegisterTest(aClass: TClass);
  end;

implementation

{ TTestRegistry }

class procedure TTestRegistry.RegisterTest(aClass: TClass);
begin
  aClass.ClassName;
end;

end.
