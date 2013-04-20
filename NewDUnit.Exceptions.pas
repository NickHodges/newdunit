unit NewDUnit.Exceptions;

interface

uses
      System.SysUtils
    ;

type
  ENewDUnitException = class(Exception);
    ETestMethodHasArguments = class(ENewDUnitException);
    ENoTestFixturesFound = class(ENewDUnitException);

implementation

end.
