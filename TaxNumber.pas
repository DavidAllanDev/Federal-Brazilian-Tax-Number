unit TaxNumber;

interface

uses
  SysUtils, ITaxNumber, TaxNumberDigits;

type
    TTaxNumber = class(TInterfacedObject,Tax)
    strict private
      _digit: TTaxNumberDigits;

    public
      constructor Create(Digit :TTaxNumberDigits);
      function CheckTaxNumber(TaxNumber: string): Boolean;
      function CheckBusinessTaxNumber(TaxNumber: string): Boolean;
      function RemoveDigits(value: string; digits: byte): string;
      function RemoveSpecialChars(text: string): string;
    private
      function GetDigits(taxNumber: string):string;
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

  if (GetDigits(TaxNumber) = _digit.GetTaxNumberDigit(RemoveDigits(TaxNumber, NumberOfDigits))) then
    Result := True
  else
    Result := False;
end;

constructor TTaxNumber.Create(Digit :TTaxNumberDigits);
begin
  _digit := Digit;
end;

function TTaxNumber.GetDigits(taxNumber: string): string;
begin
 Result := Copy(taxNumber, Length(taxNumber)-1, NumberOfDigits);
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

  if(GetDigits(TaxNumber) = _digit.GetBusinessTaxNumberDigit(RemoveDigits(TaxNumber, NumberOfDigits)))then
    Result := True
  else
    Result := False;
end;

end.
