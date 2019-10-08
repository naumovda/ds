program Project1;
Uses
Classes, Unit2;
var
  G:TFraction;
  a1,a2,a3,a4:string;
begin
  G:=TFraction.Create;
  G.turnOn(a1);
  G.turnOn(a2);
  Writeln('Vvedite znak (+ - * /)');
  Readln(a4);
  case a4 of
       '+':G.Plus(a1,a2,a3);
       '-':G.Minus(a1,a2,a3);
       '*':G.Ymnoj(a1,a2,a3);
       '/':G.Delit(a1,a2,a3);
  end;
  G.turnOff(a1,a2,a4,a3);
  Readln;
end.

