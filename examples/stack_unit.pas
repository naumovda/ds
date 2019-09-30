unit stack_unit;

interface

const
  NONE = #0;

type
  TElem = char;

  TStack = class(TObject)
    private
      FName: string;

      function GetName(): string;
      procedure SetName(AName: string);

      FItems: array of TElem;

      function GetItem(AIndex: integer): TElem;
    public
      StackClassName: string; static;

      constructor Create();
      constructor Create(AName: string);

      destructor Destroy(); override;

      function IsEmpty(): boolean;
      function Count(): integer;
      function Peak(): TElem;

      procedure Push(AElem: TElem);
      function Pop(): TElem;

      property Name: string read GetName write SetName;
      property Items[AIndex: integer]: TElem read GetItem; default;

      procedure Clear();

      procedure WriteStack();
  end;

implementation

constructor TStack.Create();
begin
  Name := 'A stack';

  SetLength(FItems, 0);
end;

constructor TStack.Create(AName: string);
begin
  Name := AName;

  SetLength(FItems, 0);
end;

destructor TStack.Destroy();
begin
  writeln('now destroing ', Name);

  inherited Destroy();
end;

function TStack.GetName(): string;
begin
  Result := FName;
end;

procedure TStack.SetName(AName: string);
begin
  if AName <> '' then
    FName := AName;
end;

procedure TStack.Push(AElem: TElem);
begin
  writeln('push ', AElem);

  SetLength(FItems, Length(FItems) + 1);

  FItems[Length(FItems) - 1] := AElem;
end;

function TStack.Pop(): TElem;
begin
  Result := FItems[Length(FItems) - 1];

  writeln('pop ', FItems[Length(FItems) - 1]);

  SetLength(FItems, Length(FItems) - 1);
end;

function TStack.IsEmpty(): boolean;
begin
  Result := Length(FItems) = 0;
end;

function TStack.Peak(): TElem;
begin
  Result := FItems[Length(FItems) - 1];
end;

procedure TStack.Clear();
begin
  while not IsEmpty() do
    Pop();
end;

function TStack.GetItem(AIndex: integer): TElem;
begin
  if (AIndex >= 0) and (AIndex < Length(FItems)) then
    Result := FItems[AIndex]
  else
    Result := NONE;
end;

function TStack.Count(): integer;
begin
  Result := Length(FItems);
end;

procedure TStack.WriteStack();
var
  i: integer;
begin
  write(Name, ': ');

  for i := 0 to Count() - 1 do
     write(self[i]);

  writeln;
end;

begin
end.

