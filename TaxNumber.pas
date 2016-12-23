unit TaxNumber;

interface

uses
  System.SysUtils;

type
  TTaxNumber = class
    public
      function CheckTaxNumber(TaxNumber: string): Boolean;
      function CheckBusinessTaxNumber(TaxNumber: string): Boolean;
    private
      function RemoveDigits(value: string; digits: byte):string;
      function RemoveSpecialChars(text :string): string;
  end;

implementation

{ TTaxNumber }

function TTaxNumber.CheckTaxNumber(TaxNumber: string): Boolean;
Var
  IntArInitialMultiplier: TArray<Integer>;
  IntArFinalMultiplier: TArray<Integer>;
  digit, NoDigitTaxNumber: string;
  IniTosum, EndTosum, sum, preCalc, I: Integer;
begin
  TaxNumber := RemoveSpecialChars(TaxNumber);

  if Length(TaxNumber) < 11 then
  begin
    Result := False;
    Exit;
  end;
  NoDigitTaxNumber := RemoveDigits(TaxNumber, 2);

  SetLength(IntArInitialMultiplier, 10);
  SetLength(IntArFinalMultiplier, 10);

  IntArInitialMultiplier := [10, 9, 8, 7, 6, 5, 4, 3, 2];
  IntArFinalMultiplier   := [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];

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
  digit := StringReplace(digit, '-', '', [rfReplaceAll, rfIgnoreCase]);
  NoDigitTaxNumber := NoDigitTaxNumber + digit;

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

  if (Copy(TaxNumber, 10, 2) = digit) then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
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
Var
  IntArInitialMultiplier: TArray<Integer>;
  IntArFinalMultiplier: TArray<Integer>;
  digit, NoDigitTaxNumber: string;
  IniTosum, EndTosum, sum, preCalc, I: Integer;
begin
  TaxNumber := RemoveSpecialChars(TaxNumber);

  if Length(TaxNumber) < 14 then
  begin
    Result := False;
    Exit;
  end;

  NoDigitTaxNumber := RemoveDigits(TaxNumber, 2);

  SetLength(IntArInitialMultiplier, 13);
  SetLength(IntArFinalMultiplier, 13);

  IntArInitialMultiplier := [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  IntArFinalMultiplier   := [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

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

  digit := IntToStr(preCalc);
   digit := StringReplace(digit, '-', '', [rfReplaceAll, rfIgnoreCase]);
  NoDigitTaxNumber := NoDigitTaxNumber + digit;

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

  digit := digit + IntToStr(preCalc);

  if (Copy(TaxNumber, 13, 2) = digit) then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

end.
