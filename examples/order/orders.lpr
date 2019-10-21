program orders;

uses
  order_common,
  order_units,
  order_products,
  order_document;

var
  u: TUnit;
  ul: TUnitList;

begin
  ul := TUnitList.Create('units.d');

  ul.Load;

  writeln('Loaded list:');
  ul.Print;

  u := TUnit.Create(1, 'штуки', 'шт.');
  ul.Append(u);

  u := TUnit.Create(2, 'килограммы', 'кг');
  ul.Append(u);

  writeln('After append');
  ul.Print;

  ul.Save;

  writeln('Press enter');
  readln;
end.

