//модуль реализующий класс точки
unit figure_point;

uses
  figure_common;

type
  TCoord = extended;

  TPoint = class(TObject)
    _x, _y: TCoord;

    //конструктор по умолчанию TPoint(0, 0)
    constructor Create();

    //конструктор TPoint(x, y)
    constructor Create(X, Y: TCoord);

    //конструктор копии
    constructor Create(P: TPoint);

    //деструктор
    destructor Destroy; override;

    //геттеры: функции получения значений координат
    function GetX(): TCoord;
    function GetY(): TCoord;

    //геттеры: функции установки значений координат
    procedure SetX(X: TCoord);
    procedure SetY(Y: TCoord);

    //свойства для доступа к атрибутам через геттеры и сеттеры
    property X: TCoord read GetX write SetX;
    property Y: TCoord read GetY write SetY;

    //метод перемещения точки в точку с норвыми координатами
    procedure MoveTo(NewX, NewY: TCoord);

    //метод перемещения точки в точку с норвыми координатами
    procedure MoveBy(OffX, OffY: TCoord);

    //масштабирование с коэффициентами RatioX, RatioY
    //относительно точки AnchorPoint
    procedure Scale(RatioX, RatioY: TCoord; const AnchorPoint: TPoint);

    //вращение отностительно точки AnchorPoint
    //на угол Angle
    procedure Rotate(Angle: TCoord; const AnchorPoint: TPoint);
  end;

//конструктор по умолчанию TPoint(0, 0)
constructor TPoint.Create();
begin
  _x := 0;
  _y := 0;
end;

//конструктор TPoint(x, y)
constructor TPoint.Create(X, Y: TCoord);
begin
  _x := X;
  _y := Y;
end;

//конструктор копии
constructor TPoint.Create(P: TPoint);
begin
  _x := P.X;
  _y := P.Y;
end;

//деструктор
destructor TPoint.Destroy;
begin
  //do nothing
end;

//геттеры: функции получения значений координат
function TPoint.GetX(): TCoord;
begin
  Result := self.X;
end;

function TPoint.GetY(): TCoord;
begin
  Result := self.Y;
end;

//геттеры: функции установки значений координат
procedure TPoint.SetX(X: TCoord);
begin
  self.X := X;
end;

procedure TPoint.SetY(Y: TCoord);
begin
  self.Y := Y;
end;

//метод перемещения точки в точку с норвыми координатами
procedure TPoint.MoveTo(NewX, NewY: TCoord);
begin
  X := NewX;
  Y := NewY;
end;

//метод перемещения точки в точку с норвыми координатами
procedure TPoint.MoveBy(OffX, OffY: TCoord);
begin
  X := X + OffX;
  Y := Y + OffY;
end;

//масштабирование с коэффициентами RatioX, RatioY
//относительно точки AnchorPoint
procedure TPoint.Scale(RatioX, RatioY: TCoord; const AnchorPoint: TPoint);
begin
  MoveBy(-AnchorPoint.X, -AnchorPoint.Y);

  X := X * RatioX;
  Y := Y * RatioY;

  MoveBy(AnchorPoint.X, AnchorPoint.Y);
end;

//вращение отностительно точки AnchorPoint
//на угол Angle
procedure TPoint.Rotate(Angle: TCoord; const AnchorPoint: TPoint);
begin
  MoveBy(-AnchorPoint.X, -AnchorPoint.Y);

  X := X*cos(Angle) - Y*sin(Angle);
  Y := X*sin(Angle) + Y*cos(Angle);

  MoveBy(AnchorPoint.X, AnchorPoint.Y);
end;

begin
end.

