{$codepage utf8}

program orders;

{$mode objfpc}{$H+}

uses
  order_common,
  order_units,
  order_products
  ;

var
  u: TUnit;
  ul: TUnitList;

  name, shortname: string;

begin
  ul := TUnitList.Create();

  ul.Load('data.xml');

  writeln('Loaded list:');
  ul.Print;

  name := AnsiToUtf8('килограмм');
  shortname := AnsiToUtf8('кг');

  u := TUnit.Create(2, 187, name, shortname);

  ul.Append(u);

  writeln('After append');
  ul.Print;

  ul.Save('data1.xml');;

  writeln('Press enter');
  readln;
end.

