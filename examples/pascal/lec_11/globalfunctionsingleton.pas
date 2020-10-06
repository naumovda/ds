unit GlobalFunctionSingleton;

 {$mode objfpc}{$H+}

 interface

 uses
   Classes, SysUtils;
 type
   TSingleton = class
   public
     name : String;
     constructor Create;
   end;

 function GetSingleton : TSingleton;

 implementation
 var
   Singleton : TSingleton = nil;

   constructor TSingleton.Create;
   begin
     assert(Singleton=nil, 'illegal recreation of Singleton.');
     inherited Create;
     Singleton := self;
   end;

 function GetSingleton : TSingleton;
 Begin
   If(Singleton = nil) then
     raise Exception.Create('Singleton not created during initialization.');
   Result := Singleton;
 end;

 initialization
   Singleton := TSingleton.Create;
 end.
