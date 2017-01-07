unit TaxNumber;

interface

uses
  System.SysUtils, ITaxNumber;

type
    TTaxNumber = class(TInterfacedObject, Tax)
    public
      function CheckTaxNumber(TaxNumber: string): Boolean;
      function CheckBusinessTaxNumber(TaxNumber: string): Boolean;
      function RemoveDigits(value: string; digits: byte): string;
      function RemoveSpecialChars(text: string): string;
    private
      function GetBusinessTaxNumberDigit(NoDigitTaxNumber: string): string;
      function GetTaxNumberDigit(NoDigitTaxNumber: string): string;
      function GetDigits(taxNumber: string):string;
      function GetFirstPartBusinessTaxDigit(NoDigitTaxNumber: string): string;
      function GetSecondPartBusinessTaxDigit(NoDigitTaxNumber: string): string;
      function GetFirstPartTaxDigit(NoDigitTaxNumber: string): string;
      function GetSecondPartTaxDigit(NoDigitTaxNumber: string): string;
      function DigitIterator(NoDigitTaxNumber: string; iterations :Integer; MultiplierList :TArray<Integer>):string;
    end;

  implementation

const
NumberOfDigits = 2;
TaxNumberLength = 11;
BusinessTaxNumberLength = 14;
BaseCaulculation =11;

{ TTaxNumber }

function TTaxNumber.CheckTaxNumber(TaxNumber: string): Boolean;
begin
  TaxNumber := RemoveSpecialChars(TaxNumber);

  if Length(TaxNumber) < TaxNumberLength then
  begin
    Result := False;
    Exit;
  end;

  if (GetDigits(TaxNumber) = GetTaxNumberDigit(RemoveDigits(TaxNumber, NumberOfDigits))) then
    Result := True
  else
    Result := False;
end;

function TTaxNumber.DigitIterator(NoDigitTaxNumber: string; iterations: Integer; MultiplierList: TArray<Integer>): string;
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

function TTaxNumber.GetBusinessTaxNumberDigit(NoDigitTaxNumber: string): string;
var
  digit:string;
begin
  digit := GetFirstPartBusinessTaxDigit(NoDigitTaxNumber);
  NoDigitTaxNumber := NoDigitTaxNumber + digit;

  Result := digit + GetSecondPartBusinessTaxDigit(NoDigitTaxNumber);
end;

function TTaxNumber.GetDigits(taxNumber: string): string;
begin
 Result := Copy(taxNumber, Length(taxNumber)-1, NumberOfDigits);
end;

function TTaxNumber.GetFirstPartBusinessTaxDigit(NoDigitTaxNumber: string): string;
var
  IntArInitialMultiplier: TArray<Integer>;
begin
  SetLength(IntArInitialMultiplier, BusinessTaxNumberLength-1);
  IntArInitialMultiplier := [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  Result := DigitIterator(NoDigitTaxNumber,11,IntArInitialMultiplier);
end;

function TTaxNumber.GetFirstPartTaxDigit(NoDigitTaxNumber: string): string;
var
  IntArInitialMultiplier: TArray<Integer>;
begin
  SetLength(IntArInitialMultiplier, TaxNumberLength-1);
  IntArInitialMultiplier := [10, 9, 8, 7, 6, 5, 4, 3, 2];

  Result := DigitIterator(NoDigitTaxNumber,8,IntArInitialMultiplier);
end;

function TTaxNumber.GetSecondPartBusinessTaxDigit(NoDigitTaxNumber: string): string;
var
  IntArFinalMultiplier: TArray<Integer>;
begin
  SetLength(IntArFinalMultiplier, BusinessTaxNumberLength-1);
  IntArFinalMultiplier   := [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  Result := DigitIterator(NoDigitTaxNumber,12,IntArFinalMultiplier);
end;

function TTaxNumber.GetSecondPartTaxDigit(NoDigitTaxNumber: string): string;
var
  IntArFinalMultiplier: TArray<Integer>;
begin
  SetLength(IntArFinalMultiplier, TaxNumberLength-1);
  IntArFinalMultiplier   := [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];

  Result := DigitIterator(NoDigitTaxNumber,9,IntArFinalMultiplier);
end;

function TTaxNumber.GetTaxNumberDigit(NoDigitTaxNumber: string): string;
var
  digit:string;
begin
  digit := GetFirstPartTaxDigit(NoDigitTaxNumber);
  NoDigitTaxNumber := NoDigitTaxNumber + digit;

  Result := digit +  GetSecondPartTaxDigit(NoDigitTaxNumber);
end;

function TTaxNumber.RemoveDigits(value: string; digits: byte): string;
begin
  Result := Copy(value,0,Length(value)-digits);
end;

function TTaxNumber.RemoveSpecialChars(text: string): string;
begin
  Result := text.Replace('.','').Replace('-','').Replace('/','');
end;

function TTaxNumber.CheckBusinessTaxNumber(TaxNumber: string): Boolean;
begin
  TaxNumber := RemoveSpecialChars(TaxNumber);

  if Length(TaxNumber) < BusinessTaxNumberLength then
  begin
    Result := False;
    Exit;
  end;

  if(GetDigits(TaxNumber) = GetBusinessTaxNumberDigit(RemoveDigits(TaxNumber, NumberOfDigits)))then
    Result := True
  else
    Result := False;
end;

end.
