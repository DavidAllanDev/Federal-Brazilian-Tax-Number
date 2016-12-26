unit ITaxNumber;

interface

uses
  Classes;

 type
   Tax = interface
      function CheckTaxNumber(TaxNumber: string): Boolean;
      function CheckBusinessTaxNumber(TaxNumber: string): Boolean;
      function RemoveDigits(value: string; digits: byte): string;
      function RemoveSpecialChars(text: string): string;
    end;

implementation
end.
