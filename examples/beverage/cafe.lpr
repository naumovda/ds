program cafe;

{$mode objfpc}{$H+}
{$interfaces corba}

type
  Begerage = class
    private
      _description: string;
    public
      function GetDescription: string; virtual; //получить описание
      function Cost: real; virtual; abstract; //получить цену
      //возможно, другие методы
  end;

  CondimentDecorator = class(Begerage)
    private
      _begerage: Begerage;
    public
      constructor Create(ABegerage: Begerage);
  end;

  Milk = class(CondimentDecorator)
    function GetDescription: string; override;
    function Cost: real; override;
  end;

  Espresso = class(Begerage)
    constructor Create();
    function Cost: real; override;
  end;

function Begerage.GetDescription: string;
begin
  Result := _description;
end;

constructor Espresso.Create();

constructor CondimentDecorator.Create(ABegerage: Begerage);
begin
  _begerage := ABegerage;
end;

begin

end.

