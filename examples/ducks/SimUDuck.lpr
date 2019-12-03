program SimUDuck;

{$mode objfpc}{$H+}
{$interfaces corba}

type
  //----------------------------------------------------------------------------
  //инкапсуляция fly
  FlyBehavior = interface
    procedure fly();
  end;

  FlyWithWings = class(FlyBehavior)
    procedure fly();
  end;

  FlyNoWay = class(FlyBehavior)
    procedure fly();
  end;

  //----------------------------------------------------------------------------
  //инкапсуляция quack
  QuackBehavior = interface
    procedure quack();
  end;

  Quack = class(QuackBehavior)
    procedure quack(); //крякает!
  end;

  Squeak = class(QuackBehavior)
    procedure quack(); //пищит
  end;

  MuteQuack = class(QuackBehavior)
    procedure quack(); //не издает звука
  end;

  //----------------------------------------------------------------------------
  // клиент использует инкапсулированные алгоритмы
  Duck = class
    private
      _flyBehaviour: FlyBehavior;
      _quackBehaviour: QuackBehavior;

    public
      procedure swim();   //все утки умеют плавать
      procedure display; virtual; abstract; //подтипы отображаются по-разному

      procedure performFly();   //летать
      procedure performQuack(); //крякать
  end;

  MallardDuck = class(Duck)
    constructor Create();
    procedure display; override; // конкретная реализация для MallardDuck
  end;

  RedheadDuck = class(Duck)
    constructor Create();
    procedure display; override; // конкретная реализация для RedheadDuck
  end;

  RubberDuck = class(Duck)
    constructor Create();
    procedure display; override; // конкретная реализация для RubberDuck
  end;

//------------------------------------------------------------------------------
procedure FlyWithWings.fly();
begin
  //реализация полета
  writeln('Duck fly with wings!');
end;

procedure FlyNoWay.fly();
begin
  //Не летает!
end;

//------------------------------------------------------------------------------
procedure Quack.quack(); //крякает!
begin
   writeln('Quack!');
end;

procedure Squeak.quack(); //пищит
begin
   writeln('Squeak...');
end;

procedure MuteQuack.quack(); //не издает звука
begin
end;

//------------------------------------------------------------------------------
procedure Duck.performFly();
begin
  _flyBehaviour.fly();
end;

procedure Duck.performQuack();
begin
  _quackBehaviour.quack();
end;

procedure Duck.swim();
begin
  writeln('Swim');
end;
//------------------------------------------------------------------------------
constructor MallardDuck.Create();
begin
  _flyBehaviour := FlyWithWings.Create;
  _quackBehaviour := Quack.Create;
end;

procedure MallardDuck.display();
begin
  writeln('Mallard Duck');
end;

//------------------------------------------------------------------------------
constructor RedheadDuck.Create();
begin
  _flyBehaviour := FlyWithWings.Create;
  _quackBehaviour := Quack.Create;
end;

procedure RedheadDuck.display();
begin
  writeln('Redhead Duck');
end;

//------------------------------------------------------------------------------
constructor RubberDuck.Create();
begin
  _flyBehaviour := FlyNoWay.Create;
  _quackBehaviour := Squeak.Create;
end;

procedure RubberDuck.display;
begin
  writeln('Rubber Duck');
end;

//------------------------------------------------------------------------------
var
  rhd: RedheadDuck;
  rd: RubberDuck;

begin
  //утра, которая умеет и летать, и крякать
  rhd := RedheadDuck.Create();
  rhd.display;
  rhd.swim();
  rhd.performFly();
  rhd.performQuack();
  writeln;

  //утра, которая пищит и не летает
  rd := RubberDuck.Create();
  rd.display;
  rd.swim();
  rd.performFly();
  rd.performQuack();
  writeln;

  writeln('Press Enter');
  readln;
end.

