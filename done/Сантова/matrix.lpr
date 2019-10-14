// Квадратные матрицы размерностью 2.
Uses SysUtils;
  type TMatrix2x2 = class
    private
      a11, a12, a21, a22: double;
    public
      constructor Create ();
      constructor Create (other: integer);
      constructor Create (a, b, c, d: double);
      constructor Create (s: string);

      function GetElement(row, col: integer): double;

      procedure Add(const Other: TMatrix2x2);
      procedure Sub(const Other: TMatrix2x2);
      procedure Mul(const Other: TMatrix2x2);
      function Det(): double;
      procedure number();
  end;

constructor TMatrix2x2.Create ();
begin
randomize;
  a11 := random(20);
  a12 := random(20);
  a21 := random(20);
  a22 := random(20);
end;

constructor TMatrix2x2.Create (other: integer);
begin
  a11 := other;
  a12 := 0;
  a21 := 0;
  a22 := other;
end;

constructor TMatrix2x2.Create (a, b, c, d: double);
begin
  a11 := a;
  a12 := b;
  a21 := c;
  a22 := d;
end;


constructor TMatrix2x2.Create (s: string);

  procedure GetElem(var g: integer; s: string; var elem: double);
  type
    symbol = set of char;
    var
    a: string;
    mn : symbol;
  begin
    mn := ['0'..'9']+[',']+['.'];
    a := '';

    while not(s[g] in mn) do
      g := g + 1;

    while s[g] in mn do
      begin
        if s[g] = '.'then s[g] := ',';
        a := a + s[g];
        g := g + 1;
      end;
    elem := StrToFloat(a);
  end;

var
  i, ch: integer;
  element: double;
begin
 i  := 1;
 ch := 1;

 while i < length(s) do
 begin
   GetElem(i,s,element);
   case ch of
   1: a11 := element;
   2: a12 := element;
   3: a21 := element;
   4: a22 := element;
   end;
   ch := ch + 1;
 end;
 writeln(a11:4:2, a12:8:2);
 writeln(a21:4:2, a22:8:2)
end;

function TMatrix2x2.GetElement(row, col: integer): double;
begin
 if row = 1 then
    if col = 1 then    GetElement := a11
    else               GetElement := a12
 else  if col = 1 then GetElement := a21
       else            GetElement := a22

 end;



procedure TMatrix2x2.Add(const Other: TMatrix2x2);
 begin
   writeln('Sum of two matrices: ');
   a11 := a11 + Other.GetElement(1,1);
   a12 := a12 + Other.GetElement(1,2);
   a21 := a21 + Other.GetElement(2,1);
   a22 := a22 + Other.GetElement(2,2);
   writeln(a11:4:2, a12:8:2);
   writeln(a21:4:2, a22:8:2)
end;

procedure TMatrix2x2.Sub(const Other: TMatrix2x2);
begin
   writeln('Difference between two matrices: ');
   a11 := a11 - Other.GetElement(1,1);
   a12 := a12 - Other.GetElement(1,2);
   a21 := a21 - Other.GetElement(2,1);
   a22 := a22 - Other.GetElement(2,2);
   writeln(a11:4:2, a12:8:2);
   writeln(a21:4:2, a22:8:2)
end;

procedure TMatrix2x2.Mul(const Other: TMatrix2x2);
begin
   writeln('The multiplication of two matrices');
   a11 := a11 * Other.GetElement(1,1) + a12 * Other.GetElement(2,1);
   a12 := a11 * Other.GetElement(1,2) + a12 * Other.GetElement(2,2);
   a21 := a21 * Other.GetElement(1,1) + a22 * Other.GetElement(2,1);
   a22 := a21 * Other.GetElement(1,2) + a22 * Other.GetElement(2,2);
   writeln(a11:4:2, a12:8:2);
   writeln(a21:4:2, a22:8:2)
end;

function TMatrix2x2.Det(): double;
begin
  Det := a11 * a22 - a12 * a21;
end;



procedure TMatrix2x2.number();
var
  ch:double;
begin
Write('Enter the number: ');
readln(ch);
   a11 := a11 * ch;
   a12 := a12 * ch;
   a21 := a21 * ch;
   a22 := a22 * ch;
   writeln(a11:4:2, a12:8:2);
   writeln(a21:4:2, a22:8:2)
end;


var
  a: TMatrix2x2;
  b: TMatrix2x2;

begin
  Writeln('Matrix A:'); a := TMatrix2x2.Create('[[6,3;2.2][4.2;3.34]]'); Writeln;
  Writeln('Matrix B:'); b := TMatrix2x2.Create('[[2,5;1.2][-3.22;9.14]]'); Writeln;

  a.Add(b); Writeln;
  a.Sub(b); Writeln;
  a.Mul(b); Writeln;
  Writeln('Matrix determinant: ', a.Det:4:2); Writeln;
  a.number; Writeln;

  readln()
end.


