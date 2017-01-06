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
      function GetFristPartBusinessTaxDigit(NoDigitTaxNumber: string): string;
      function GetSecondPartBusinessTaxDigit(NoDigitTaxNumber: string): string;
    end;

  implementation

const
NumberOfDigits = 2;
TaxNumberLength = 11;
BusinessTaxNumberLength = 14;

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

function TTaxNumber.GetBusinessTaxNumberDigit(NoDigitTaxNumber: string): string;
var
  digit:string;
begin
  digit := GetFristPartBusinessTaxDigit(NoDigitTaxNumber);
  NoDigitTaxNumber := NoDigitTaxNumber + digit;

  digit := digit + GetSecondPartBusinessTaxDigit(NoDigitTaxNumber);
  Result := digit;
end;

function TTaxNumber.GetDigits(taxNumber: string): string;
begin
 Result := Copy(taxNumber, Length(taxNumber)-1, NumberOfDigits);
end;

function TTaxNumber.GetFristPartBusinessTaxDigit(NoDigitTaxNumber: string): string;
var
  IntArInitialMultiplier: TArray<Integer>;
  IniTosum, sum, preCalc, I: Integer;
begin
  SetLength(IntArInitialMultiplier, BusinessTaxNumberLength-1);
  IntArInitialMultiplier := [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  sum := 0;
  for I := 0 to 11 do
  begin
    IniTosum := StrToInt(Copy(NoDigitTaxNumber, I + 1, 1));
    sum := sum + (IniTosum * IntArInitialMultiplier[I]);
  end;
  preCalc := sum MOD 11;

  if preCalc < 2 then
    preCalc := 0
  else
    preCalc := 11 - preCalc;
    Result := IntToStr(preCalc);
end;

function TTaxNumber.GetSecondPartBusinessTaxDigit(NoDigitTaxNumber: string): string;
var
  IntArFinalMultiplier: TArray<Integer>;
  EndTosum, sum, preCalc, I: Integer;
begin
  SetLength(IntArFinalMultiplier, BusinessTaxNumberLength-1);
  IntArFinalMultiplier   := [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  sum := 0;
  for I := 0 to 12 do
  begin
    EndTosum := StrToInt(Copy(NoDigitTaxNumber, I + 1, 1));
    sum := sum + (EndTosum * IntArFinalMultiplier[I]);
  end;
  preCalc := sum MOD 11;

  if preCalc < 2 then
    preCalc := 0
  else
    preCalc := 11 - preCalc;

  Result := IntToStr(preCalc);
end;

function TTaxNumber.GetTaxNumberDigit(NoDigitTaxNumber: string): string;
var
  IntArInitialMultiplier: TArray<Integer>;
  IntArFinalMultiplier: TArray<Integer>;
  IniTosum, EndTosum, sum, preCalc, I: Integer;
  digit:string;
begin
  SetLength(IntArInitialMultiplier, TaxNumberLength-1);
  IntArInitialMultiplier := [10, 9, 8, 7, 6, 5, 4, 3, 2];

  sum := 0;
  for I := 0 to 8 do
  begin
    IniTosum := StrToInt(Copy(NoDigitTaxNumber, I + 1, 1));
    sum := sum + (IniTosum * IntArInitialMultiplier[I]);
  end;
  preCalc := sum MOD 11;

  if preCalc < 2 then
    preCalc := 0
  else
    preCalc := 11 - preCalc;

  digit := IntToStr(preCalc);
  NoDigitTaxNumber := NoDigitTaxNumber + digit;

  SetLength(IntArFinalMultiplier, TaxNumberLength-1);
  IntArFinalMultiplier   := [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];
  sum := 0;
  for I := 0 to 9 do
  begin
    EndTosum := StrToInt(Copy(NoDigitTaxNumber, I + 1, 1));
    sum := sum + (EndTosum * IntArFinalMultiplier[I]);
  end;
  preCalc := sum MOD 11;

  if preCalc < 2 then
    preCalc := 0
  else
    preCalc := 11 - preCalc;

  digit := digit + IntToStr(preCalc);

  Result := digit;
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
