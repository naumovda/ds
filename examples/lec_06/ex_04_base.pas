unit ex_04_base;

interface

type
  TBase = class
  public
    procedure PublicMethod();
  protected
    procedure ProtectedMethod();
  private
    procedure PrivateMethod();
  end;

implementation

procedure TBase.PublicMethod();
begin
end;

procedure TBase.ProtectedMethod();
begin
end;

procedure TBase.PrivateMethod();
begin
end;

end.

