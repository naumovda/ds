program stack;

type
  TElem = char;

  TStack = class
    private
      FItems: array of TElem;

      procedure SetSize(ASize: integer);
      procedure IncreaseSize();
      procedure DecreaseSize();

    protected
      function Count: integer;
      function GetMaxIndex(): integer;

    public
      constructor Create;

      function IsEmpty: Boolean;
      procedure Clear;

      function Pop: TElem;
      procedure Push(AElem: TElem);
      function  Peak: TElem;
  end;

constructor TStack.Create;
begin
  SetSize(0);
end;

function TStack.GetMaxIndex(): integer;
begin
  Result := Count - 1;
end;

procedure TStack.SetSize(ASize: integer);
begin
  if ASize >= 0 then
     SetLength(FItems, ASize);
end;

procedure TStack.IncreaseSize();
begin
  SetLength(FItems, Count() + 1);
end;

procedure TStack.DecreaseSize();
begin
  SetLength(FItems, Count() - 1);
end;

function TStack.IsEmpty: Boolean;
begin
  Result := Length(FItems) = 0;
end;

procedure TStack.Clear;
begin
  SetLength(FItems, 0);
end;

function TStack.Count: integer;
begin
  Result := Length(FItems);
end;

procedure TStack.Push(AElem: TElem);
begin
  IncreaseSize();

  FItems[GetMaxIndex()] := AElem;
end;

function TStack.Peak: TElem;
begin
  Result := FItems[GetMaxIndex()];
end;

function TStack.Pop: TElem;
begin
  Result := Peak();

  DecreaseSize();
end;

function IsOpenBracet(AChar: char): boolean;
begin
  Result := AChar in ['(', '[', '{'];
end;

function IsCloseBracet(AChar: char): boolean;
begin
  Result := AChar in [')', ']', '}'];
end;

function IsBracet(AChar: char): boolean;
begin
  Result := IsOpenBracet(AChar) or IsOpenBracet(AChar);
end;

function GetClosetBracet(AOpenBracet: char): char;
begin
  if not IsBracet(AOpenBracet) then
     Result := ''
  else
    case OpenBracet of
    '(': Result := ')';
    '[': Result := ']';
    '{': Result := '}';
    else
      Result := '';
    end;
end;

var
  S: TStack;

  InputString: string;

  i: integer;

  IsBalance: Boolean;

begin
  InputString := '[[()]]{([][]())}';

  S := TStack.Create;

  for i := 1 to Length(InputString) do
  begin

  end;
end.

