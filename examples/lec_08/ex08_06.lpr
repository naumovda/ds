program ex08_06;

{$mode objfpc}

uses
  SysUtils;

type
  EMemoryException = class(Exception) end;
  EInitializationException = class(Exception) end;

  TVector = array[1..1000] of real;
  PVector = ^TVector;

function f(x: integer): integer;
begin
  //Функция выполняет какие-то сложные вычисления,
  //причем значение 0 нас не устраивает
  //...
  Result := 0;
end;

type
  PArray = ^TArray;
  TArray = class
    private
      _data: PVector;
      _size: integer;
    public
      constructor Create(ASize: integer);
      destructor Destroy; override;
  end;

constructor TArray.Create(ASize: integer);
var
  i: integer;
begin
  try
    if ASize <= 0 then
      //это искючение не требует дополнительных действий
      raise EMemoryException.Create('Ошибка: неверный размер массива');

    _size := ASize;
    New(_data);

    if _data = nil then
      //это искючение не требует дополнительных действий
      raise EMemoryException.Create('Ошибка: невозможно выделить память');

    for i := 1 to _size do
    begin
      _data^[i] := f(i);
      if _data^[i] = 0 then
        //это исключение требует освободить занятые ресурсы
        raise EInitializationException.Create('Ошибка инициализации массива');
    end;
  except
    on EInitializationException do
      begin
        Dispose(_data);
        _data := nil;
        raise;
      end;
    else
      raise;
  end;
end;

destructor TArray.Destroy;
begin
  writeln('Destructor called');
  if _data <> nil then
    Dispose(_data);
end;

var
  arr: TArray;

begin
  try
    arr := TArray.Create(3);
  except
    on EMemoryException do
      begin
        writeln('EMemoryException caugth');
        //...
      end;
    on EInitializationException do
      begin
        writeln('EInitializationException caugth');
        //...
      end;
  end;

  readln;
end.

