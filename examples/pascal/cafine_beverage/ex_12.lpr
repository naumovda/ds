program ex_12;

type
  Coffee = class
    public
      procedure prepareRecipe();

      procedure boilWater();
      procedure brewCoffeeGrinds();
      procedure pourInCup();
      procedure addSugarAndMilk();
  end;

procedure Coffee.prepareRecipe();
begin
  boilWater();
  brewCoffeeGrinds();
  pourInCup();
  addSugarAndMilk();
end;

procedure Coffee.boilWater();
begin
  writeln('Boiling Water');
end;

procedure Coffee.brewCoffeeGrinds();
begin
  writeln('Dripping Coffee throught filter');
end;

procedure Coffee.pourInCup();
begin
  writeln('Pouring into cup');
end;

procedure Coffee.addSugarAndMilk();
begin
  writeln('Adding sugar and milk');
end;

begin
end.

