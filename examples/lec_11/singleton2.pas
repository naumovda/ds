unit Singleton2;

 {$mode objfpc}{$H+}

 interface

 uses
   Classes, SysUtils;

 type
   TSingleton = class
     private
       constructor Create;
     public
       name: String;
       class function GetInstance : TSingleton;
   end;

 implementation
 var
   Singleton : TSingleton = nil;

 constructor TSingleton.Create;
 begin
   inherited Create;
 end;

 class function TSingleton.GetInstance : TSingleton;
 begin
   if Singleton = nil then
     Singleton := TSingleton.Create;
   Result := Singleton;
 end;

 end.
