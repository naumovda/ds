program ex_ratio;

{$MODE OBJFPC}

type
  //класс для работы с рациональными числами
  TRatio = class(TObject)
    const
      MAXVALUES = 100;

    private
      //n - числитель числа
      //d - знаменатель числа
      n, d: integer;

    public
      //статическое поле класса для подсчета числа экземпляров
      counter: integer; static;

      //конструктор класса
      class constructor Create;
      //деструктор класса
      class destructor Destroy;

      class function GetCounter():integer; static;
      class procedure IncCounter(); static;
      class procedure DecCounter(); static;

      //конструктор по-умолчанию
      constructor Create;
      //конструктор c одним параметром
      constructor Create(other: double);
      //конструктор с двумя параметрами
      constructor Create(InN, InD: integer);
      //конструктор копии
      constructor Create(other: TRatio);

      //ввод числа
      procedure RatioOut(s:string);
      //вывод числа
      procedure RatioIn(s:string);

      //сокращение дроби
      procedure Reduce;

      //Деструктор
      destructor Destroy; override;
  end;

//Преобразования между Double и Ratio
function DtoR(v:double):TRatio; forward;
//Преобразования между Ratio и Double
function RtoD(x:TRatio):Double; forward;

// ВычислениеНОД
function gcd(x, y:integer):integer;
begin
  if y=0 then
  begin
    Result:=x;
    exit;
  end;
  Result := gcd(y, x mod y);
end;

// Сокращение дроби
procedure TRatio.Reduce();
var
  n1, d1:integer;
begin
  n1 := abs(n);

  if n1=0 then
  begin
    d:=1;
    exit;
  end;

  d1 := gcd(n1, d);

  if d1 > 1 then
  begin
    n := n div d1;
    d := d div d1;
  end;
end;

//конструктор класса
class constructor TRatio.Create;
begin
  writeln('class TRatio has been created');

  counter := 0;
end;

//деструктор класса
class destructor TRatio.Destroy;
begin
  writeln('class TRatio has been destroyed');
end;

//конструктор по умолчанию
constructor TRatio.Create();
begin
  n := 0;
  d := 1;

  IncCounter();

  writeln('=', n, d);
end;

//конструктор c одним параметром
constructor TRatio.Create(other: double);
var
  conv: TRatio;
begin
  conv := DtoR(other);

  n := conv.n;
  d := conv.d;

  conv.Destroy;

  IncCounter();

  writeln('=', n, d);
end;

// Конструктор по заданным числителю и знаменателю
constructor TRatio.Create(InN, InD: integer);
begin
  n := InN;
  d := InD;

  if d=0 then
  begin
    d:=1;

    exit;
  end;

  Reduce;

  IncCounter();

  writeln('=', n, d);
end;

// Конструктор копирования
constructor TRatio.Create(Other: TRatio);
begin
  n := Other.n;
  d := Other.d;

  IncCounter();
end;

procedure TRatio.RatioOut(s:string);
var
  k:integer;
begin
  write(s);

  if n=0 then
  begin
    writeln('0');
    exit;
  end;

  k:=(n div abs(n))* d;
  if k<0 then
    write('-');

  writeln(abs(n),'/',abs(d));
end;

// Метод объекта - ввод дроби
procedure TRatio.RatioIn(s:string);
var
  s1,s2:string[20];
  i,j:integer;
begin
  d:=1;

  write(s);
  readln(s1);

  i:=pos('/',s1);

  if i<>0 then
  begin
    s2:=copy(s1,i+1,10);
    val(s2,d,j);
    delete(s1,i,10);
  end;

  if s1[1]='-' then
  begin
    delete(s1,1,1);
    val(s1,n,j);
    n:=-n;
  end
  else
    val(s1,n,j);

  Reduce;
end;

operator + (x,y:TRatio): TRatio;
begin
  Result := TRatio.Create;

  Result.n := x.n * y.d + x.d * y.n;
  Result.d := x.d * y.d;

  Result.Reduce();
end;

operator - (x,y:TRatio):TRatio;
begin
  Result := TRatio.Create;

  Result.n := x.n*y.d -  x.d*y.n;
  Result.d := x.d*y.d;

  Result.Reduce();
end;

operator * (x,y:TRatio):TRatio;
begin
  Result := TRatio.Create;

  Result.n := x.n * y.n;
  Result.d := x.d * y.d;

  Result.Reduce
end;

operator / (x,y:TRatio):TRatio;
begin
  Result := TRatio.Create;

  if y.n=0 then
  begin
    writeln('Деление на 0');
    readln;

    halt;
  end;

  Result.n := x.n * y.d;
  Result.d := x.d * y.n;

  Result.Reduce();
end;

destructor TRatio.Destroy;
begin
  DecCounter();

  writeln('ratio has been destroyed');
end;

class function TRatio.GetCounter():integer; static;
begin
  Result := counter;
end;

class procedure TRatio.IncCounter(); static;
begin
  Inc(counter);
end;

class procedure TRatio.DecCounter(); static;
begin
  Dec(counter);
end;

//Преобразования между Double и Ratio
function DtoR(v:double):TRatio;
begin
  Result := TRatio.Create;

  Result.n:=round(v*9e7);

  Result.d:=90000000;

  Result.Reduce;
end;

//Преобразования между Ratio и Double
function RtoD(x:TRatio):Double;
begin
  Result := x.n / x.d;
end;

var
  x, y, z: TRatio;

begin
  TRatio.counter := 0;

  x := TRatio.Create; //вызываем конструктор по-умолчанию

  y := TRatio.Create(2, 10);  //вызываем конструктор с двумя
                              //паараметрами (дробь 2/10)
  x.RatioOut('x=');
  y.RatioOut('y=');

  z := TRatio.Create(1.2);    //вызываем конструктор с одним параметром
                              //для преобразования типа double в TRatio
  z := z + x + y;

  writeln('now we have ', TRatio.counter, ' rational values');

  z.RatioOut('z=');

  writeln('value of z is ', RtoD(z));

  readln;

  x.Destroy;
  y.Destroy;
  z.Destroy;
end.

