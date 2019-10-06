//модуль реализующий класс точки
unit figure_point;

interface

uses
  figure_common; // подключаем

type
  //класс точки в двумерном пространстве координат
  TPoint = class(TObject)
  private
    _x, _y: TCoord;

  protected
    //геттеры: функции получения значений координат
    function GetX(): TCoord;
    function GetY(): TCoord;

    //геттеры: функции установки значений координат
    procedure SetX(NewX: TCoord);
    procedure SetY(NewY: TCoord);
  public
    //конструктор по умолчанию TPoint(0, 0)
    constructor Create();

    //конструктор TPoint(x, y)
    constructor Create(NewX, NewY: TCoord);

    //конструктор копии
    constructor Create(P: TPoint);

    //деструктор
    destructor Destroy; override;

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

//печать точки
procedure PrintPoint(const P: TPoint);

implementation

//печать точки
procedure PrintPoint(const P: TPoint);
begin
  writeln('Point(',P.X:0:4, ';', P.Y:0:4, ')');
end;

//конструктор по умолчанию TPoint(0, 0)
constructor TPoint.Create();
begin
  _x := 0;
  _y := 0;
end;

//конструктор TPoint(x, y)
constructor TPoint.Create(NewX, NewY: TCoord);
begin
  _x := NewX;
  _y := NewY;
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
  GetX := _x;
end;

function TPoint.GetY(): TCoord;
begin
  GetY := _y;
end;

//геттеры: функции установки значений координат
procedure TPoint.SetX(NewX: TCoord);
begin
  X := NewX;
end;

procedure TPoint.SetY(NewY: TCoord);
begin
  Y := NewY;
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

