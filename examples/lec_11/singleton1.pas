unit Singleton1;

 {$mode objfpc}{$H+}

 interface

 type
   TSingleton = class
     name: String;
     constructor create;
   end;

 implementation

 var
   Singleton: TSingleton = nil;

 constructor TSingleton.Create;
 begin
   if not(assigned(Singleton)) then begin
     inherited;
     (*... do initializations ...*)
     Singleton := self;
   end else begin
     self := Singleton;
   end;
 end;

 end.
