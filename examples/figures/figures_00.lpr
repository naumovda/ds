program figures_00;

type
  TShape = class
    procedure Show; virtual; abstract;
    procedure Hide; virtual; abstract;
  end;

  TCircle = class(TShape)
    procedure Show; override;
    procedure Hide; override;
  end;

  TTriangle = class(TShape)
    procedure Show; override;
    procedure Hide; override;
    procedure Rotate90; virtual;
  end;

procedure TCircle.Show;
begin
  writeln('TCircle.Show');
end;

procedure TCircle.Hide;
begin
  writeln('TCircle.Hide');
end;

procedure TTriangle.Show;
begin
  writeln('TTriangle.Show');
end;

procedure TTriangle.Hide;
begin
  writeln('TTriangle.Hide');
end;

procedure TTriangle.Rotate90;
begin
  writeln('TTriangle.Rotate');
end;

var
  i:integer;
  f: array[1..10] of TShape;

begin
  randomize;

  for i := 1 to 10 do
    if random < 0.5 then
      f[i] := TCircle.Create
    else
      f[i] := TTriangle.Create;

  for i := 1 to 10 do
  begin
    f[i].Show;

    if f[i] is TTriangle then
      (f[i] as TTriangle).Rotate90;
  end;

  readln;
end.

