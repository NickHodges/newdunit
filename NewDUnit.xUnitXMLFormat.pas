
{**********************************************}
{                                              }
{               XML Data Binding               }
{                                              }
{         Generated on: 4/19/2013 9:47:24 PM   }
{       Generated from: C:\junk\xUnit.xsd      }
{   Settings stored in: C:\junk\xUnit.xdb      }
{                                              }
{**********************************************}

unit NewDUnit.xUnitXMLFormat;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLTestsuite = interface;
  IXMLTestsuite_testcase = interface;
  IXMLTestsuite_testcase_error = interface;
  IXMLTestsuite_testcase_failure = interface;
  IXMLTestsuite_testcase_skipped = interface;
  IXMLTestsuites = interface;
  IXMLTestsuites_testsuite = interface;

{ IXMLTestsuite }

  IXMLTestsuite = interface(IXMLNodeCollection)
    ['{9697A5F3-7689-4559-AE70-ED9FB26A7880}']
    { Property Accessors }
    function Get_Name: UnicodeString;
    function Get_Timestamp: UnicodeString;
    function Get_Hostname: UnicodeString;
    function Get_Tests: Integer;
    function Get_Failures: Integer;
    function Get_Errors: Integer;
    function Get_Skipped: Integer;
    function Get_Time: UnicodeString;
    function Get_Testcase(Index: Integer): IXMLTestsuite_testcase;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Timestamp(Value: UnicodeString);
    procedure Set_Hostname(Value: UnicodeString);
    procedure Set_Tests(Value: Integer);
    procedure Set_Failures(Value: Integer);
    procedure Set_Errors(Value: Integer);
    procedure Set_Skipped(Value: Integer);
    procedure Set_Time(Value: UnicodeString);
    { Methods & Properties }
    function Add: IXMLTestsuite_testcase;
    function Insert(const Index: Integer): IXMLTestsuite_testcase;
    property Name: UnicodeString read Get_Name write Set_Name;
    property Timestamp: UnicodeString read Get_Timestamp write Set_Timestamp;
    property Hostname: UnicodeString read Get_Hostname write Set_Hostname;
    property Tests: Integer read Get_Tests write Set_Tests;
    property Failures: Integer read Get_Failures write Set_Failures;
    property Errors: Integer read Get_Errors write Set_Errors;
    property Skipped: Integer read Get_Skipped write Set_Skipped;
    property Time: UnicodeString read Get_Time write Set_Time;
    property Testcase[Index: Integer]: IXMLTestsuite_testcase read Get_Testcase; default;
  end;

{ IXMLTestsuite_testcase }

  IXMLTestsuite_testcase = interface(IXMLNode)
    ['{92872DEA-11A2-4128-9D50-E90992F68590}']
    { Property Accessors }
    function Get_Name: UnicodeString;
    function Get_Classname: UnicodeString;
    function Get_Time: UnicodeString;
    function Get_Error: IXMLTestsuite_testcase_error;
    function Get_Failure: IXMLTestsuite_testcase_failure;
    function Get_Skipped: IXMLTestsuite_testcase_skipped;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Classname(Value: UnicodeString);
    procedure Set_Time(Value: UnicodeString);
    { Methods & Properties }
    property Name: UnicodeString read Get_Name write Set_Name;
    property Classname: UnicodeString read Get_Classname write Set_Classname;
    property Time: UnicodeString read Get_Time write Set_Time;
    property Error: IXMLTestsuite_testcase_error read Get_Error;
    property Failure: IXMLTestsuite_testcase_failure read Get_Failure;
    property Skipped: IXMLTestsuite_testcase_skipped read Get_Skipped;
  end;

{ IXMLTestsuite_testcase_error }

  IXMLTestsuite_testcase_error = interface(IXMLNode)
    ['{C94E5F49-2477-4F37-B46D-A0C52E36A61C}']
    { Property Accessors }
    function Get_Message: UnicodeString;
    function Get_Type_: UnicodeString;
    procedure Set_Message(Value: UnicodeString);
    procedure Set_Type_(Value: UnicodeString);
    { Methods & Properties }
    property Message: UnicodeString read Get_Message write Set_Message;
    property Type_: UnicodeString read Get_Type_ write Set_Type_;
  end;

{ IXMLTestsuite_testcase_failure }

  IXMLTestsuite_testcase_failure = interface(IXMLNode)
    ['{A7BFA6DE-1621-406B-9F92-E94E123945FA}']
    { Property Accessors }
    function Get_Message: UnicodeString;
    function Get_Type_: UnicodeString;
    procedure Set_Message(Value: UnicodeString);
    procedure Set_Type_(Value: UnicodeString);
    { Methods & Properties }
    property Message: UnicodeString read Get_Message write Set_Message;
    property Type_: UnicodeString read Get_Type_ write Set_Type_;
  end;

{ IXMLTestsuite_testcase_skipped }

  IXMLTestsuite_testcase_skipped = interface(IXMLNode)
    ['{D090C7B5-8881-4C46-929E-B511FE84D91D}']
    { Property Accessors }
    function Get_Type_: UnicodeString;
    procedure Set_Type_(Value: UnicodeString);
    { Methods & Properties }
    property Type_: UnicodeString read Get_Type_ write Set_Type_;
  end;

{ IXMLTestsuites }

  IXMLTestsuites = interface(IXMLNodeCollection)
    ['{BBC5A127-CF60-4293-A4CD-2B04C6D13F96}']
    { Property Accessors }
    function Get_Testsuite(Index: Integer): IXMLTestsuites_testsuite;
    { Methods & Properties }
    function Add: IXMLTestsuites_testsuite;
    function Insert(const Index: Integer): IXMLTestsuites_testsuite;
    property Testsuite[Index: Integer]: IXMLTestsuites_testsuite read Get_Testsuite; default;
  end;

{ IXMLTestsuites_testsuite }

  IXMLTestsuites_testsuite = interface(IXMLTestsuite)
    ['{F5534BB6-1552-469A-B84E-5A8139E49586}']
    { Property Accessors }
    function Get_Package: UnicodeString;
    function Get_Id: Integer;
    procedure Set_Package(Value: UnicodeString);
    procedure Set_Id(Value: Integer);
    { Methods & Properties }
    property Package: UnicodeString read Get_Package write Set_Package;
    property Id: Integer read Get_Id write Set_Id;
  end;

{ Forward Decls }

  TXMLTestsuite = class;
  TXMLTestsuite_testcase = class;
  TXMLTestsuite_testcase_error = class;
  TXMLTestsuite_testcase_failure = class;
  TXMLTestsuite_testcase_skipped = class;
  TXMLTestsuites = class;
  TXMLTestsuites_testsuite = class;

{ TXMLTestsuite }

  TXMLTestsuite = class(TXMLNodeCollection, IXMLTestsuite)
  protected
    { IXMLTestsuite }
    function Get_Name: UnicodeString;
    function Get_Timestamp: UnicodeString;
    function Get_Hostname: UnicodeString;
    function Get_Tests: Integer;
    function Get_Failures: Integer;
    function Get_Errors: Integer;
    function Get_Skipped: Integer;
    function Get_Time: UnicodeString;
    function Get_Testcase(Index: Integer): IXMLTestsuite_testcase;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Timestamp(Value: UnicodeString);
    procedure Set_Hostname(Value: UnicodeString);
    procedure Set_Tests(Value: Integer);
    procedure Set_Failures(Value: Integer);
    procedure Set_Errors(Value: Integer);
    procedure Set_Skipped(Value: Integer);
    procedure Set_Time(Value: UnicodeString);
    function Add: IXMLTestsuite_testcase;
    function Insert(const Index: Integer): IXMLTestsuite_testcase;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTestsuite_testcase }

  TXMLTestsuite_testcase = class(TXMLNode, IXMLTestsuite_testcase)
  protected
    { IXMLTestsuite_testcase }
    function Get_Name: UnicodeString;
    function Get_Classname: UnicodeString;
    function Get_Time: UnicodeString;
    function Get_Error: IXMLTestsuite_testcase_error;
    function Get_Failure: IXMLTestsuite_testcase_failure;
    function Get_Skipped: IXMLTestsuite_testcase_skipped;
    procedure Set_Name(Value: UnicodeString);
    procedure Set_Classname(Value: UnicodeString);
    procedure Set_Time(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTestsuite_testcase_error }

  TXMLTestsuite_testcase_error = class(TXMLNode, IXMLTestsuite_testcase_error)
  protected
    { IXMLTestsuite_testcase_error }
    function Get_Message: UnicodeString;
    function Get_Type_: UnicodeString;
    procedure Set_Message(Value: UnicodeString);
    procedure Set_Type_(Value: UnicodeString);
  end;

{ TXMLTestsuite_testcase_failure }

  TXMLTestsuite_testcase_failure = class(TXMLNode, IXMLTestsuite_testcase_failure)
  protected
    { IXMLTestsuite_testcase_failure }
    function Get_Message: UnicodeString;
    function Get_Type_: UnicodeString;
    procedure Set_Message(Value: UnicodeString);
    procedure Set_Type_(Value: UnicodeString);
  end;

{ TXMLTestsuite_testcase_skipped }

  TXMLTestsuite_testcase_skipped = class(TXMLNode, IXMLTestsuite_testcase_skipped)
  protected
    { IXMLTestsuite_testcase_skipped }
    function Get_Type_: UnicodeString;
    procedure Set_Type_(Value: UnicodeString);
  end;

{ TXMLTestsuites }

  TXMLTestsuites = class(TXMLNodeCollection, IXMLTestsuites)
  protected
    { IXMLTestsuites }
    function Get_Testsuite(Index: Integer): IXMLTestsuites_testsuite;
    function Add: IXMLTestsuites_testsuite;
    function Insert(const Index: Integer): IXMLTestsuites_testsuite;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTestsuites_testsuite }

  TXMLTestsuites_testsuite = class(TXMLTestsuite, IXMLTestsuites_testsuite)
  protected
    { IXMLTestsuites_testsuite }
    function Get_Package: UnicodeString;
    function Get_Id: Integer;
    procedure Set_Package(Value: UnicodeString);
    procedure Set_Id(Value: Integer);
  end;

{ Global Functions }

function GetTestSuite(Doc: IXMLDocument): IXMLTestsuite;
function LoadTestSuite(const FileName: string): IXMLTestsuite;
function NewTestSuite: IXMLTestsuite;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function Gettestsuite(Doc: IXMLDocument): IXMLTestsuite;
begin
  Result := Doc.GetDocBinding('testsuite', TXMLTestsuite, TargetNamespace) as IXMLTestsuite;
end;

function Loadtestsuite(const FileName: string): IXMLTestsuite;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('testsuite', TXMLTestsuite, TargetNamespace) as IXMLTestsuite;
end;

function Newtestsuite: IXMLTestsuite;
begin
  Result := NewXMLDocument.GetDocBinding('testsuite', TXMLTestsuite, TargetNamespace) as IXMLTestsuite;
end;

{ TXMLTestsuite }

procedure TXMLTestsuite.AfterConstruction;
begin
  RegisterChildNode('testcase', TXMLTestsuite_testcase);
  ItemTag := 'testcase';
  ItemInterface := IXMLTestsuite_testcase;
  inherited;
end;

function TXMLTestsuite.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLTestsuite.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLTestsuite.Get_Timestamp: UnicodeString;
begin
  Result := AttributeNodes['timestamp'].Text;
end;

procedure TXMLTestsuite.Set_Timestamp(Value: UnicodeString);
begin
  SetAttribute('timestamp', Value);
end;

function TXMLTestsuite.Get_Hostname: UnicodeString;
begin
  Result := AttributeNodes['hostname'].Text;
end;

procedure TXMLTestsuite.Set_Hostname(Value: UnicodeString);
begin
  SetAttribute('hostname', Value);
end;

function TXMLTestsuite.Get_Tests: Integer;
begin
  Result := AttributeNodes['tests'].NodeValue;
end;

procedure TXMLTestsuite.Set_Tests(Value: Integer);
begin
  SetAttribute('tests', Value);
end;

function TXMLTestsuite.Get_Failures: Integer;
begin
  Result := AttributeNodes['failures'].NodeValue;
end;

procedure TXMLTestsuite.Set_Failures(Value: Integer);
begin
  SetAttribute('failures', Value);
end;

function TXMLTestsuite.Get_Errors: Integer;
begin
  Result := AttributeNodes['errors'].NodeValue;
end;

procedure TXMLTestsuite.Set_Errors(Value: Integer);
begin
  SetAttribute('errors', Value);
end;

function TXMLTestsuite.Get_Skipped: Integer;
begin
  Result := AttributeNodes['skipped'].NodeValue;
end;

procedure TXMLTestsuite.Set_Skipped(Value: Integer);
begin
  SetAttribute('skipped', Value);
end;

function TXMLTestsuite.Get_Time: UnicodeString;
begin
  Result := AttributeNodes['time'].Text;
end;

procedure TXMLTestsuite.Set_Time(Value: UnicodeString);
begin
  SetAttribute('time', Value);
end;

function TXMLTestsuite.Get_Testcase(Index: Integer): IXMLTestsuite_testcase;
begin
  Result := List[Index] as IXMLTestsuite_testcase;
end;

function TXMLTestsuite.Add: IXMLTestsuite_testcase;
begin
  Result := AddItem(-1) as IXMLTestsuite_testcase;
end;

function TXMLTestsuite.Insert(const Index: Integer): IXMLTestsuite_testcase;
begin
  Result := AddItem(Index) as IXMLTestsuite_testcase;
end;

{ TXMLTestsuite_testcase }

procedure TXMLTestsuite_testcase.AfterConstruction;
begin
  RegisterChildNode('error', TXMLTestsuite_testcase_error);
  RegisterChildNode('failure', TXMLTestsuite_testcase_failure);
  RegisterChildNode('skipped', TXMLTestsuite_testcase_skipped);
  inherited;
end;

function TXMLTestsuite_testcase.Get_Name: UnicodeString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLTestsuite_testcase.Set_Name(Value: UnicodeString);
begin
  SetAttribute('name', Value);
end;

function TXMLTestsuite_testcase.Get_Classname: UnicodeString;
begin
  Result := AttributeNodes['classname'].Text;
end;

procedure TXMLTestsuite_testcase.Set_Classname(Value: UnicodeString);
begin
  SetAttribute('classname', Value);
end;

function TXMLTestsuite_testcase.Get_Time: UnicodeString;
begin
  Result := AttributeNodes['time'].Text;
end;

procedure TXMLTestsuite_testcase.Set_Time(Value: UnicodeString);
begin
  SetAttribute('time', Value);
end;

function TXMLTestsuite_testcase.Get_Error: IXMLTestsuite_testcase_error;
begin
  Result := ChildNodes['error'] as IXMLTestsuite_testcase_error;
end;

function TXMLTestsuite_testcase.Get_Failure: IXMLTestsuite_testcase_failure;
begin
  Result := ChildNodes['failure'] as IXMLTestsuite_testcase_failure;
end;

function TXMLTestsuite_testcase.Get_Skipped: IXMLTestsuite_testcase_skipped;
begin
  Result := ChildNodes['skipped'] as IXMLTestsuite_testcase_skipped;
end;

{ TXMLTestsuite_testcase_error }

function TXMLTestsuite_testcase_error.Get_Message: UnicodeString;
begin
  Result := AttributeNodes['message'].Text;
end;

procedure TXMLTestsuite_testcase_error.Set_Message(Value: UnicodeString);
begin
  SetAttribute('message', Value);
end;

function TXMLTestsuite_testcase_error.Get_Type_: UnicodeString;
begin
  Result := AttributeNodes['type'].Text;
end;

procedure TXMLTestsuite_testcase_error.Set_Type_(Value: UnicodeString);
begin
  SetAttribute('type', Value);
end;

{ TXMLTestsuite_testcase_failure }

function TXMLTestsuite_testcase_failure.Get_Message: UnicodeString;
begin
  Result := AttributeNodes['message'].Text;
end;

procedure TXMLTestsuite_testcase_failure.Set_Message(Value: UnicodeString);
begin
  SetAttribute('message', Value);
end;

function TXMLTestsuite_testcase_failure.Get_Type_: UnicodeString;
begin
  Result := AttributeNodes['type'].Text;
end;

procedure TXMLTestsuite_testcase_failure.Set_Type_(Value: UnicodeString);
begin
  SetAttribute('type', Value);
end;

{ TXMLTestsuite_testcase_skipped }

function TXMLTestsuite_testcase_skipped.Get_Type_: UnicodeString;
begin
  Result := AttributeNodes['type'].Text;
end;

procedure TXMLTestsuite_testcase_skipped.Set_Type_(Value: UnicodeString);
begin
  SetAttribute('type', Value);
end;

{ TXMLTestsuites }

procedure TXMLTestsuites.AfterConstruction;
begin
  RegisterChildNode('testsuite', TXMLTestsuites_testsuite);
  ItemTag := 'testsuite';
  ItemInterface := IXMLTestsuites_testsuite;
  inherited;
end;

function TXMLTestsuites.Get_Testsuite(Index: Integer): IXMLTestsuites_testsuite;
begin
  Result := List[Index] as IXMLTestsuites_testsuite;
end;

function TXMLTestsuites.Add: IXMLTestsuites_testsuite;
begin
  Result := AddItem(-1) as IXMLTestsuites_testsuite;
end;

function TXMLTestsuites.Insert(const Index: Integer): IXMLTestsuites_testsuite;
begin
  Result := AddItem(Index) as IXMLTestsuites_testsuite;
end;

{ TXMLTestsuites_testsuite }

function TXMLTestsuites_testsuite.Get_Package: UnicodeString;
begin
  Result := AttributeNodes['package'].Text;
end;

procedure TXMLTestsuites_testsuite.Set_Package(Value: UnicodeString);
begin
  SetAttribute('package', Value);
end;

function TXMLTestsuites_testsuite.Get_Id: Integer;
begin
  Result := AttributeNodes['id'].NodeValue;
end;

procedure TXMLTestsuites_testsuite.Set_Id(Value: Integer);
begin
  SetAttribute('id', Value);
end;

end.