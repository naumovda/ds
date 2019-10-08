unit unit2;
interface

uses
  Classes, SysUtils;
type
  TFraction = class
  private
  public
  Procedure turnOn(var s1:string);
  Procedure turnOff(s1,s2,s3,s4:string);
  Procedure Plus(s1,s2:string; Var s3:string); //пргоцедура сложения
  Procedure Minus(s1,s2:string; Var s3:string); //процедура вычитания
  Procedure Ymnoj(s1,s2:string; Var s3:string); //процедура умножение
  Procedure Delit(s1,s2:string; Var s3:string); //процедура деления
  Procedure Sokr(Var s:string); // процедура сокращения
end;
var
   s,s1,s2,s3,s4:string;
Implementation
  Procedure TFraction.turnOn(var s1:string);
  begin
    Writeln('Vvedite chislo v formate chislitel/znamenatel');
    Readln(s1);
  end;
   // процедура сокращения
  Procedure TFraction.Sokr(Var s:string);
  var
  min:string;
  minindex:integer;
  slesh,chislitel,znamenatel:string;
  sleshindex,code,dlina,chisl,chisl1,znam,znam1,nod:integer;
  begin
    min:='-';
    minindex:=Pos(min,s);
    if minindex<>0 then
      begin
           delete(s,1,1);
           minindex:=7;
      end;
    slesh:='/';
    sleshindex:=Pos(slesh,s);
    chislitel:=Copy(s,1,sleshindex-1);
    Val(chislitel,chisl,code);
    dlina:=length(s);
    znamenatel:=Copy(s,sleshindex+1,dlina-sleshindex);
    Val(znamenatel,znam,code);
    chisl1:=chisl;
    znam1:=znam;
    while ((chisl<>0)and(znam<>0)) do
      begin
        if chisl>znam then
          chisl := chisl mod znam
        else
          znam:=znam mod chisl;
      end;
    nod:=chisl+znam;
    chisl1:=chisl1 div nod;
    znam1:=znam1 div nod;
    Str(chisl1,chislitel);
    Str(znam1,znamenatel);
    s:=chislitel+'/'+znamenatel;
    if minindex=7 then
      s:=min+s;
  end;


  Procedure TFraction.turnOff(s1,s2,s3,s4:string);
  begin
    Sokr(s4);
    Writeln('Rezyltat');
    Writeln(s1,' ',s3,' ',s2,'=',s4);
  end;

   //процедура умножения
  Procedure TFraction.Ymnoj(s1,s2:string; Var s3:string);
  var
  slesh:string;
  sleshindex,code,dlina:integer;
  chislitel:string;
  znamenatel:string;
  chisl1,chisl2,chisl3:integer;
  znam1,znam2,znam3:integer;
  begin
    slesh:='/';
    sleshindex:=Pos(slesh,s1);
    chislitel:=Copy(s1,1,sleshindex-1);
    Val(chislitel,chisl1,code);
    dlina:=length(s1);
    znamenatel:=Copy(s1,sleshindex+1,dlina-sleshindex);
    Val(znamenatel,znam1,code);
    sleshindex:=Pos(slesh,s2);
    chislitel:=Copy(s2,1,sleshindex-1);
    Val(chislitel,chisl2,code);
    dlina:=length(s2);
    znamenatel:=Copy(s2,sleshindex+1,dlina-sleshindex);
    Val(znamenatel,znam2,code);
    chisl3:=chisl1*chisl2;
    znam3:=znam1*znam2;
    Str(chisl3,chislitel);
    Str(znam3,znamenatel);
    s3:=chislitel+'/'+znamenatel;
  end;

   //процедура сложения
  Procedure TFraction.Plus(s1,s2:string; Var s3:string);
  var
  helpstr:string;
  s11,s22:string;
  slesh:string;
  sleshindex,code,dlina:integer;
  chislitel:string;
  znamenatel:string;
  chisl1,chisl2,chisl11,chisl22,chisl3:integer;
  znam1,znam2,znam11,znam22,znam3:integer;
  begin
    slesh:='/';
    sleshindex:=Pos(slesh,s1);
    chislitel:=Copy(s1,1,sleshindex-1);
    Val(chislitel,chisl1,code);
    dlina:=length(s1);
    znamenatel:=Copy(s1,sleshindex+1,dlina-sleshindex);
    Val(znamenatel,znam1,code);
    sleshindex:=Pos(slesh,s2);
    chislitel:=Copy(s2,1,sleshindex-1);
    Val(chislitel,chisl2,code);
    dlina:=length(s2);
    znamenatel:=Copy(s2,sleshindex+1,dlina-sleshindex);
    Val(znamenatel,znam2,code);
    znam11:=znam2;
    chisl11:=znam2;
    znam22:=znam1;
    chisl22:=znam1;

    Str(chisl11,chislitel);
    Str(znam11,znamenatel);
    helpstr:=chislitel+'/'+znamenatel;
    Ymnoj(s1,helpstr,s11);

    Str(chisl22,chislitel);
    Str(znam22,znamenatel);
    helpstr:=chislitel+'/'+znamenatel;
    Ymnoj(s2,helpstr,s22);
    s1:=s11;
    s2:=s22;

    sleshindex:=Pos(slesh,s1);
    chislitel:=Copy(s1,1,sleshindex-1);
    Val(chislitel,chisl1,code);
    dlina:=length(s1);
    znamenatel:=Copy(s1,sleshindex+1,dlina-sleshindex);
    Val(znamenatel,znam1,code);
    sleshindex:=Pos(slesh,s2);
    chislitel:=Copy(s2,1,sleshindex-1);
    Val(chislitel,chisl2,code);
    dlina:=length(s2);
    znamenatel:=Copy(s2,sleshindex+1,dlina-sleshindex);
    Val(znamenatel,znam2,code);

    chisl3:=chisl1+chisl2;
    znam3:=znam1;
    Str(chisl3,chislitel);
    Str(znam3,znamenatel);
    s3:=chislitel+'/'+znamenatel;
  end;

   //процедура вычитания
  Procedure TFraction.Minus(s1,s2:string; Var s3:string);
  var
  helpstr:string;
  s11,s22:string;
  slesh:string;
  sleshindex,code,dlina:integer;
  chislitel:string;
  znamenatel:string;
  chisl1,chisl2,chisl11,chisl22:integer;
  chisl3:real;
  znam1,znam2,znam11,znam22,znam3:integer;
  begin
    slesh:='/';
    sleshindex:=Pos(slesh,s1);
    chislitel:=Copy(s1,1,sleshindex-1);
    Val(chislitel,chisl1,code);
    dlina:=length(s1);
    znamenatel:=Copy(s1,sleshindex+1,dlina-sleshindex);
    Val(znamenatel,znam1,code);
    sleshindex:=Pos(slesh,s2);
    chislitel:=Copy(s2,1,sleshindex-1);
    Val(chislitel,chisl2,code);
    dlina:=length(s2);
    znamenatel:=Copy(s2,sleshindex+1,dlina-sleshindex);
    Val(znamenatel,znam2,code);
    znam11:=znam2;
    chisl11:=znam2;
    znam22:=znam1;
    chisl22:=znam1;

    Str(chisl11,chislitel);
    Str(znam11,znamenatel);
    helpstr:=chislitel+'/'+znamenatel;
    Ymnoj(s1,helpstr,s11);

    Str(chisl22,chislitel);
    Str(znam22,znamenatel);
    helpstr:=chislitel+'/'+znamenatel;
    Ymnoj(s2,helpstr,s22);
    s1:=s11;
    s2:=s22;

    sleshindex:=Pos(slesh,s1);
    chislitel:=Copy(s1,1,sleshindex-1);
    Val(chislitel,chisl1,code);
    dlina:=length(s1);
    znamenatel:=Copy(s1,sleshindex+1,dlina-sleshindex);
    Val(znamenatel,znam1,code);
    sleshindex:=Pos(slesh,s2);
    chislitel:=Copy(s2,1,sleshindex-1);
    Val(chislitel,chisl2,code);
    dlina:=length(s2);
    znamenatel:=Copy(s2,sleshindex+1,dlina-sleshindex);
    Val(znamenatel,znam2,code);

    chisl3:=chisl1-chisl2;
    znam3:=znam1;
    Str(chisl3:0:0,chislitel);
    Str(znam3,znamenatel);
    s3:=chislitel+'/'+znamenatel;
  end;

    //процедура деления
  Procedure TFraction.Delit(s1,s2:string; Var s3:string);
  var
  slesh:string;
  sleshindex,code,dlina:integer;
  chislitel:string;
  znamenatel:string;
  chisl1,chisl2,chisl3:integer;
  znam1,znam2,znam3:integer;
  begin
    slesh:='/';
    sleshindex:=Pos(slesh,s1);
    chislitel:=Copy(s1,1,sleshindex-1);
    Val(chislitel,chisl1,code);
    dlina:=length(s1);
    znamenatel:=Copy(s1,sleshindex+1,dlina-sleshindex);
    Val(znamenatel,znam1,code);
    sleshindex:=Pos(slesh,s2);
    chislitel:=Copy(s2,1,sleshindex-1);
    Val(chislitel,chisl2,code);
    dlina:=length(s2);
    znamenatel:=Copy(s2,sleshindex+1,dlina-sleshindex);
    Val(znamenatel,znam2,code);
    chisl3:=chisl1*znam2;
    znam3:=znam1*chisl2;
    Str(chisl3,chislitel);
    Str(znam3,znamenatel);
    s3:=chislitel+'/'+znamenatel;
  end;
end.
