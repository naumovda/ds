program ex_01;

type
  Singleton = class
    private
      UniqueInstance: Singleton; static;
      constructor Create;
    public
      class function GetInstance(): Singleton;
  end;

constructor Singleton.Create;
begin
end;

class function Singleton.GetInstance(): Singleton;
begin
  if UniqueInstance = nil then
    UniqueInstance := Singleton.Create;
  Result := Singleton.Create;
end;

var
  MyObject: Singleton;

begin
  MyObject := Singleton.GetInstance();
end.

