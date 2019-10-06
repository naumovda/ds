program figure_test;

//mode objfpc

uses
   figure_common,
   figure_point,
   figure_abstract, figure_pixel, figure_circle;

var
  p1: TPoint;

begin
  p1 := TPoint.Create(1, 2);

  write('ppint p1: ');
  PrintPoint(p1);

  writeln('Press enter to quit...');
  readln;
end.

