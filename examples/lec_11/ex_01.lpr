program ex_01;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  {$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}
  {$ENDIF}
  Classes,
  Singleton3;

var
  s1, s2: TSingleton;

begin
  s1:= TSingleton.Create;

  s1.name := 'one';
  writeln('name of s1: '+s1.name);

  s2:= TSingleton.Create;

  s2.name := 'two';

  writeln('name of s1: '+s1.name);
  writeln('name of s2: '+s2.name);

  //writeln('name of singleton: ' + Singleton.name);

  writeln('Press Enter');
  readln;
end.

