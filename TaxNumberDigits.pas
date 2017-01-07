unit TaxNumberDigits;

interface

uses
  System.SysUtils, ITaxNumber;

type
  TTaxNumberDigits = class(TObject)
    public
      function GetBusinessTaxNumberDigit(NoDigitTaxNumber: string): string;
      function GetTaxNumberDigit(NoDigitTaxNumber: string): string;
      function GetFirstPartBusinessTaxDigit(NoDigitTaxNumber: string): string;
      function GetSecondPartBusinessTaxDigit(NoDigitTaxNumber: string): string;
      function GetFirstPartTaxDigit(NoDigitTaxNumber: string): string;
      function GetSecondPartTaxDigit(NoDigitTaxNumber: string): string;
      function DigitIterator(NoDigitTaxNumber: string; iterations :Integer; MultiplierList :TArray<Integer>):string;
  end;

implementation

const
  TaxNumberLength = 11;
  BusinessTaxNumberLength = 14;
  BaseCaulculation =11;

{ TTaxNumberDigits }

function TTaxNumberDigits.DigitIterator(NoDigitTaxNumber: string;
  iterations: Integer; MultiplierList: TArray<Integer>): string;
var
I, sum, aNumberOnTaxtNumber,preCalc:Integer;
begin
 sum := 0;
  for I := 0 to iterations do
  begin
    aNumberOnTaxtNumber := StrToInt(Copy(NoDigitTaxNumber, I + 1, 1));
    sum := sum + (aNumberOnTaxtNumber * MultiplierList[I]);
  end;

  preCalc := sum MOD BaseCaulculation;

  if preCalc < 2 then
    preCalc := 0
  else
    preCalc := BaseCaulculation - preCalc;

  Result := IntToStr(preCalc);
end;

function TTaxNumberDigits.GetBusinessTaxNumberDigit(
  NoDigitTaxNumber: string): string;
var
  digit:string;
begin
  digit := GetFirstPartBusinessTaxDigit(NoDigitTaxNumber);
  NoDigitTaxNumber := NoDigitTaxNumber + digit;

  Result := digit + GetSecondPartBusinessTaxDigit(NoDigitTaxNumber);
end;

function TTaxNumberDigits.GetFirstPartBusinessTaxDigit(
  NoDigitTaxNumber: string): string;
var
  IntArInitialMultiplier: TArray<Integer>;
begin
  SetLength(IntArInitialMultiplier, BusinessTaxNumberLength-1);
  IntArInitialMultiplier := [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  Result := DigitIterator(NoDigitTaxNumber,11,IntArInitialMultiplier);
end;

function TTaxNumberDigits.GetFirstPartTaxDigit(
  NoDigitTaxNumber: string): string;
var
  IntArInitialMultiplier: TArray<Integer>;
begin
  SetLength(IntArInitialMultiplier, TaxNumberLength-1);
  IntArInitialMultiplier := [10, 9, 8, 7, 6, 5, 4, 3, 2];

  Result := DigitIterator(NoDigitTaxNumber,8,IntArInitialMultiplier);
end;

function TTaxNumberDigits.GetSecondPartBusinessTaxDigit(
  NoDigitTaxNumber: string): string;
var
  IntArFinalMultiplier: TArray<Integer>;
begin
  SetLength(IntArFinalMultiplier, BusinessTaxNumberLength-1);
  IntArFinalMultiplier   := [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  Result := DigitIterator(NoDigitTaxNumber,12,IntArFinalMultiplier);
end;

function TTaxNumberDigits.GetSecondPartTaxDigit(
  NoDigitTaxNumber: string): string;
var
  IntArFinalMultiplier: TArray<Integer>;
begin
  SetLength(IntArFinalMultiplier, TaxNumberLength-1);
  IntArFinalMultiplier   := [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];

  Result := DigitIterator(NoDigitTaxNumber,9,IntArFinalMultiplier);
end;

function TTaxNumberDigits.GetTaxNumberDigit(NoDigitTaxNumber: string): string;
var
  digit:string;
begin
  digit := GetFirstPartTaxDigit(NoDigitTaxNumber);
  NoDigitTaxNumber := NoDigitTaxNumber + digit;

  Result := digit +  GetSecondPartTaxDigit(NoDigitTaxNumber);
end;

end.
