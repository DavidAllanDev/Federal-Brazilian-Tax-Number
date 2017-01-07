library FederalBrazilianTaxNumber;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  TaxNumber in 'TaxNumber.pas',
  ITaxNumber in 'ITaxNumber.pas',
  TaxNumberDigits in 'TaxNumberDigits.pas';

{$R *.res}

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
