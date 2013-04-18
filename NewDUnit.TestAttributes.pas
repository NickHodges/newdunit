unit NewDUnit.TestAttributes;

interface

type
  TestAttribute = class(TCustomAttribute);

  SetUpAttribute = class(TCustomAttribute);

  TearDownAttribute = class(TCustomAttribute);

  TestFixtureAttribute = class(TCustomAttribute);

  SetupFixtureAttribute = class(TCustomAttribute);
  TearDownFixtureAttribute = class(TCustomAttribute);

implementation

end.
