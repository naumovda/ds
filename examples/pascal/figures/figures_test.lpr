program figures_test;

{$mode objfpc}{$H+}

uses
   figure_common,
   figure_point;

var
  p1: TPoint;
begin
  p1 := TPoint.Create(1, 2);

  writeln('p = ', p1.X, p1.Y);

  readln;
end.

