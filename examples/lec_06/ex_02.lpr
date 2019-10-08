program ex_02;

type
  //базовый класс
  TBase = class
    _x: integer;
  public
    constructor Create(x: integer); //конструктор базового класса
  end;

  //производный класс
  TDerived = class(TBase)
    _y: integer;
  public
    constructor Create(x, y: integer); //конструктор производного класса
  end;

constructor TBase.Create(x: integer); //конструктор базового класса
begin
  _x := x;

  writeln('Base initialized by value ', x);
end;

constructor TDerived.Create(x, y: integer); //конструктор производного класса
begin
  inherited Create(x);

  _y := y;

  writeln('Derived initialized by value ', y);
end;

var
  d: TDerived;

begin
  d := TDerived.Create(5, 10);
  readln;
end.

