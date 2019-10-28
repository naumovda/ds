program ex08_07;

{$mode objfpc}

uses
  SysUtils;

type
  EMyError = class(Exception) end;

  TMyClass = class
    private
      _p: ^longint;
    public
      constructor Create;
      destructor Destroy; override;
  end;

constructor TMyClass.Create;
begin
  //New(_p);
end;

destructor TMyClass.Destroy;
begin
  //raise exception in... destructor
  raise EMyError.Create('MyException in Destructor');

  //Dispose(_p);
  //_p := nil;
end;

var
  HPs : THeapStatus;
  HPe : THeapStatus;

  lost: integer;

  MyObject: TMyClass;

begin
  HPs := getHeapStatus;

  //some actions
  MyObject := TMyClass.Create;

  try
    MyObject.Free;
  except
    on E: Exception do
      writeln('caught Exception ', E.Message);
  end;

  HPe := getHeapStatus;

  Lost:= HPe.TotalAllocated - HPs.TotalAllocated;

  writeln('Start heap memory: ', HPs.TotalAllocated);
  writeln('End   heap memory: ', HPe.TotalAllocated);

  if lost >  0 then
     writeln('lostMem: ', lost );

  readln;
end.

