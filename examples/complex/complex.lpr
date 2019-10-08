program complex;

type
  TComplex = class
  private
    _Re, _Im: extended;
  public
    constructor Create(Re, Im: extended);

    function GetRe: extended;
    function GetIm: extended;

    procedure SetRe(Re: extended);
    procedure SetIm(Im: extended);

    function Add(const Other: TComplex): TComplex;
    function Add(const Other: extended): TComplex;
  end;

function TComplex.Add(const Other: TComplex): TComplex;
begin
  _Re := _Re + Other.GetRe;
  _Im := _Im + Other.GetIm;

  Result := self;
end;

function TComplex.Add(const Other: extended): TComplex;
begin
  _Re := _Re + Other;

  Result := self;
end;

constructor TComplex.Create(Re, Im: extended);
begin
  _Re := Re;
  _Im := Im;
end;

function TComplex.GetRe: extended;
begin
  GetRe := _Re;
end;

function TComplex.GetIm: extended;
begin
  GetIm := _Im;
end;

procedure TComplex.SetRe(Re: extended);
begin
  _Re := Re;
end;

procedure TComplex.SetIm(Im: extended);
begin
  _Im := Im;
end;

operator + (x, y: TComplex)r: TComplex;
begin
  r := TComplex.Create(x.GetRe + y.GetRe, x.GetIm + y.GetIm);
end;

var
  a, b, c: TComplex;

begin
  a := TComplex.Create(2, -3);
  b := TComplex.Create(4, 3);
  c := TComplex.Create(1, -1);

  //a.Add(b).Add(c);
  a := a + b + c;

  writeln('re:', a.GetRe:0:4, ' im:', a.GetIm:0:4);
  writeln('re:', b.GetRe:0:4, ' im:', b.GetIm:0:4);

  a := b;
  b.SetIm(0);

  writeln('re:', a.GetRe:0:4, ' im:', a.GetIm:0:4);
  writeln('re:', b.GetRe:0:4, ' im:', b.GetIm:0:4);

  readln;
end.

