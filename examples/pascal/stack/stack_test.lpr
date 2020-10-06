program stack_01;

uses
  stack_unit;

function GetClosedBracket(AOpenBracket: char): char;
begin
  case AOpenBracket of
  '(': Result := ')';
  '[': Result := ']';
  '{': Result := '}';
  '<': Result := '>';
  else
    Result := #0;
  end;
end;

function IsOpenBracket(AChar: char): boolean;
begin
  Result := AChar in ['(', '[', '{', '<'];
end;

function IsClosedBracket(AChar: char): boolean;
begin
  Result := AChar in [')', ']', '}', '>'];
end;

var
  s: TStack;

  InputString: string;

  i: integer;

  IsBalance: boolean;

  c: char;

begin
  TStack.StackClassName := 'My TStack Class';

  InputString := '(1+2)*(3+4/[3-5*<6+7>])';

  IsBalance := true;

  s := TStack.Create('Stack1');

  for i := 1 to Length(InputString) do
  begin
    writeln('current = ', InputString[i]);

    if IsOpenBracket(InputString[i]) then
      s.Push(InputString[i])
    else
      if IsClosedBracket(InputString[i]) then
        if s.IsEmpty() then
        begin
          IsBalance := false;
          break;
        end
        else
        begin
          c := s.Pop();

          if GetClosedBracket(c) <> InputString[i] then
          begin
            IsBalance := false;
            break;
          end;
        end;
  end;

  IsBalance := IsBalance and s.IsEmpty();

  writeln('InputString = ', InputString);
  writeln('Is bracket balance? ', IsBalance);

  s.Destroy;

  writeln('end of example of ', TStack.StackClassName);
  readln;
end.

