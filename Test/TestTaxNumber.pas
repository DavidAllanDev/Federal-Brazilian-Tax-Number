unit TestTaxNumber;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, TaxNumber, System.SysUtils;

type
  // Test methods for class TTaxNumber

  TestTTaxNumber = class(TTestCase)
  strict private
    FTaxNumber: TTaxNumber;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCheckTaxNumber;
    procedure TestCheckBusinessTaxNumber;
  end;

implementation

procedure TestTTaxNumber.SetUp;
begin
  FTaxNumber := TTaxNumber.Create;
end;

procedure TestTTaxNumber.TearDown;
begin
  FTaxNumber.Free;
  FTaxNumber := nil;
end;

procedure TestTTaxNumber.TestCheckTaxNumber;
var
  ReturnValue: Boolean;
  TaxNumber: string;
begin
  // TODO: Setup method call parameters
  ReturnValue := FTaxNumber.CheckTaxNumber(TaxNumber);
  // TODO: Validate method results
end;

procedure TestTTaxNumber.TestCheckBusinessTaxNumber;
var
  ReturnValue: Boolean;
  TaxNumber: string;
begin
  // TODO: Setup method call parameters
  ReturnValue := FTaxNumber.CheckBusinessTaxNumber(TaxNumber);
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTTaxNumber.Suite);
end.
