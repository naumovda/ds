unit SingletonUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  Singleton = class
    private
      UniqueInstance: Singleton; static;
      constructor Create;
    public
      name: String;
      class function GetInstance(): Singleton;
  end;

implementation

constructor Singleton.Create;
begin
end;

class function Singleton.GetInstance(): Singleton;
begin
  if UniqueInstance = nil then
    UniqueInstance := Singleton.Create;
  Result := Singleton.Create;
end;

end.

