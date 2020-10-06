unit GlobalVariableSingleton;

 {$mode objfpc}{$H+}

 interface

 type
   TSingleton = class
     name: String;
     constructor create;
   end;

 var
   Singleton: TSingleton = nil;

 implementation
 {* Something happens out here *}

 initialization
   Singleton := TSingleton.Create;

 end.
