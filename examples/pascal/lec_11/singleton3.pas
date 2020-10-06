unit Singleton3
;

 {$mode objfpc}{$H+}

 interface

 uses
   Classes, SysUtils;

 type
   TSingleton = class
     private
       constructor Init;
     public
       name: String;
       class function Create: TSingleton;
   end;

 implementation
 var
   Singleton : TSingleton = nil;

 constructor TSingleton.Init;
 begin
   inherited Create;
 end;

 class function TSingleton.Create: TSingleton;
 begin
   if Singleton = nil then
     Singleton := TSingleton.Init;
   Result := Singleton;
 end;

 end.
