program ex_03;

type
  //базовый класс
  TRoot = class
    constructor Create; //конструктор базового класса
    destructor Destroy; override; //деструктор
  end;

  //базовый класс
  TBase = class(TRoot)
    constructor Create(); //конструктор производного  класса
    destructor Destroy; override; //деструктор
  end;

  //производный класс
  TDerived = class(TBase)
    constructor Create(); //конструктор производного класса
    destructor Destroy; override; //деструктор
  end;

  //производный класс
  TMostDerived = class(TDerived)
    constructor Create(); //конструктор производного класса
    destructor Destroy; override; //деструктор
  end;

constructor TRoot.Create();
begin
  writeln('Root constructor called');
end;

destructor TRoot.Destroy;
begin
  writeln('Root destroyed');
  inherited Destroy;
end;

constructor TBase.Create();
begin
  inherited Create;
  writeln('Base constructor called');
end;

destructor TBase.Destroy;
begin
  writeln('Base destroyed');
  inherited Destroy;
end;

constructor TDerived.Create();
begin
  inherited Create();
  writeln('Derived constructor called');
end;

destructor TDerived.Destroy;
begin
  writeln('Derived destroyed');
  inherited Destroy;
end;

constructor TMostDerived.Create();
begin
  inherited Create();
  writeln('Most derived constructor called');
end;

destructor TMostDerived.Destroy;
begin
  writeln('Most derived destroyed');
  inherited Destroy;
end;

var
  d: TMostDerived;

begin
  d := TMostDerived.Create;

  d.Free;

  readln;
end.

