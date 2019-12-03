program cafe;

{$mode objfpc}{$H+}
{$interfaces corba}

uses
  SysUtils;

type
  Beverage = class
    private
      _description: string;
    public
      function GetDescription: string; virtual; //получить описание
      function Cost: real; virtual; abstract; //получить цену
  end;

  CondimentDecorator = class(Beverage)
    private
      _beverage: Beverage;
    public
      constructor Create(ABeverage: Beverage);
      function GetDescription: string; override; abstract;
  end;

  Milk = class(CondimentDecorator)
    constructor Create(ABeverage: Beverage);
    function GetDescription: string; override;
    function Cost: real; override;
  end;

  Whip = class(CondimentDecorator)
    constructor Create(ABeverage: Beverage);
    function GetDescription: string; override;
    function Cost: real; override;
  end;

  Espresso = class(Beverage)
    constructor Create();
    function Cost: real; override;
  end;

  HouseBlend = class(Beverage)
    constructor Create();
    function Cost: real; override;
  end;

  DarkRoast = class(Beverage)
    constructor Create();
    function Cost: real; override;
  end;

function Beverage.GetDescription: string;
begin
  Result := _description;
end;

constructor Espresso.Create();
begin
  _description := 'Espresso';
end;

function Espresso.Cost: real;
begin
  Result := 0.69;
end;

constructor HouseBlend.Create();
begin
  _description := 'House Blend Coffee';
end;

function HouseBlend.Cost: real;
begin
  Result := 0.89;
end;

constructor DarkRoast.Create();
begin
  _description := 'Dark Roasted Coffee';
end;

function DarkRoast.Cost: real;
begin
  Result := 1.99;
end;

constructor CondimentDecorator.Create(ABeverage: Beverage);
begin
  _beverage := ABeverage;
end;

constructor Milk.Create(ABeverage: Beverage);
begin
  inherited Create(ABeverage);
end;

function Milk.GetDescription: string;
begin
  Result := _beverage.GetDescription + ', Milk';
end;

function Milk.Cost: real;
begin
  Result := 0.2 + _beverage.Cost();
end;

constructor Whip.Create(ABeverage: Beverage);
begin
  inherited Create(ABeverage);
end;

function Whip.GetDescription: string;
begin
  Result := _beverage.GetDescription + ', Whip';
end;

function Whip.Cost: real;
begin
  Result := 0.05 + _beverage.Cost();
end;

var
  bev1: Beverage;
  bev2: Beverage;

begin
  bev1 := Espresso.Create();
  writeln(bev1.GetDescription + ' $' + FloatToStrF(bev1.Cost(), ffFixed, 0, 2));

  bev2 := DarkRoast.Create();
  bev2 := Milk.Create(bev2);
  bev2 := Milk.Create(bev2);
  bev2 := Whip.Create(bev2);
  writeln(bev2.GetDescription + ' $' + FloatToStrF(bev2.Cost(), ffFixed, 0, 2));

  writeln('Press Enter...');
  readln;
end.

