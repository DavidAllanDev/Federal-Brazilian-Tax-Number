library FederalBrazilianTaxNumber;

{$mode objfpc}{$H+}

uses
  Classes,
  TaxNumber in 'TaxNumber.pas',
  ITaxNumber in 'ITaxNumber.pas',
  TaxNumberDigits in 'TaxNumberDigits.pas';

function CheckTaxNumber(TaxNumber: string): Boolean;
var
 tax:TTaxNumber;
begin
  tax := TTaxNumber.Create(TTaxNumberDigits.Create);
  Result := tax.CheckTaxNumber(TaxNumber);
end;

function CheckBusinessTaxNumber(TaxNumber: string): Boolean;
var
 tax:TTaxNumber;
begin
  tax := TTaxNumber.Create(TTaxNumberDigits.Create);
  Result := tax.CheckBusinessTaxNumber(TaxNumber);
end;

exports
  CheckTaxNumber,
  CheckBusinessTaxNumber;
begin
end.

