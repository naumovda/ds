unit ex_04_derived;

interface

uses
  ex_04_base;

type
  TDerived = class(TBase)
  public
    procedure TestMethod();
  end;

implementation

procedure TDerived.TestMethod();
begin
  PublicMethod();

  ProtectedMethod();

  PrivateMethod();
end;

end.

