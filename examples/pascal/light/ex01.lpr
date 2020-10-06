program project2;

const
  LastColor = 4;

  WHITE = 0;
  RED = 1;
  GREEN = 2;
  YELLOW = 3;
  BLUE = 4;

type

  TLight = class
    private
      isTurned: boolean;
    public
      procedure TurnOn();
      procedure TurnOff();
      function IsTurnedOn: boolean;
  end;

  TColoredLight = class(TLight)
    private
      color: integer;
    public
      procedure SetColor(AColor:integer);
      function GetColor: integer;
      function ToString(): string;
  end;

  TLightArray = array of TColoredLight;

  TGarland = class
    private
      size: integer;
      cl: TLightArray;

      procedure RandomLight(var ALight: TColoredLight);
    public
      procedure CreateGarland(ASize: integer);
      procedure DestroyGarland();

      procedure TurnOn();
      procedure TurnOff();

      function GetLight(Index: integer): TColoredLight;
      function GetSize: integer;
  end;

procedure TLight.TurnOn();
begin
  isTurned := true;
end;

procedure TLight.TurnOff();
begin
  isTurned := false;
end;

function TLight.IsTurnedOn: boolean;
begin
  Result := true;
end;

procedure TColoredLight.SetColor(AColor:integer);
begin
  if (AColor < 0) or (AColor > LastColor) then
  begin
    writeln('Incorrect color');
  end;

  color := AColor;
end;

function TColoredLight.GetColor: integer;
begin
  Result := color;
end;

function TColoredLight.ToString(): string;
begin
  case color of
  WHITE : Result := 'white';
  RED   : Result := 'red';
  GREEN : Result := 'green';
  YELLOW: Result := 'yellow';
  BLUE  : Result := 'blue';
  end;
end;

procedure TGarland.CreateGarland(ASize: integer);
var
  i: integer;
begin
  Size := ASize;

  SetLength(cl, Size);

  for i := 0 to Size - 1 do
    RandomLight(cl[i]);
end;

procedure TGarland.DestroyGarland();
var
  i: integer;
begin
  for i := 0 to Size - 1 do
    cl[i].Destroy;

  SetLength(cl, 0);
end;

procedure TGarland.TurnOn();
var
  i: integer;
begin
  for i := 0 to Size - 1 do
    cl[i].TurnOn();
end;

procedure TGarland.TurnOff();
var
  i: integer;
begin
  for i := 0 to Size - 1 do
    cl[i].TurnOff();
end;

function TGarland.GetLight(Index: integer): TColoredLight;
begin
  Result := cl[Index];
end;

procedure TGarland.RandomLight(var ALight: TColoredLight);
var
  color: integer;
begin
  ALight := TColoredLight.Create;

  color := random(LastColor+1);

  ALight.SetColor(color);
end;

function TGarland.GetSize: integer;
begin
  Result := size;
end;

var
  g: TGarland;

  light: TColoredLight;

  i: integer;

begin
  randomize;

  g := TGarland.Create;
  g.CreateGarland(10);

  for i := 0 to g.GetSize() - 1 do
  begin
    light := g.GetLight(i);
    writeln(light.ToString())
  end;

  g.DestroyGarland();

  readln;
end.

