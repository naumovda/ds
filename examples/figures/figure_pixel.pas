unit figure_pixel;

interface

uses
  figure_common,
  figure_abstract,
  figure_point;

type
  TPixel = class(TAbstractFigure)
  private
    _color: TColor; //цвет точки
    _point: TPoint; //координаты точки

  protected
    //геттеры: функции получения значений координат
    function GetX(): TCoord;
    function GetY(): TCoord;

    //геттеры: функции установки значений координат
    procedure SetX(NewX: TCoord);
    procedure SetY(NewY: TCoord);
  public
    //инициализация с точки с координатами 0,0 черного цвета
    constructor Create;
    //инициализация с точки с координатами
    //APoint.X,APoint.Y черного цвета
    constructor Create(const APoint: TPoint);
    //инициализация с точки с координатами APoint.X,APoint.Y цвета AColor
    constructor Create(const APoint: TPoint; const AColor: TColor);
    //инициализация с точки с координатами X, Y цвета AColor
    constructor Create(X, Y: TCoord; const AColor: TColor);
    //инициализация с точки с координатами APoint.X,APoint.Y цвета AColor
    constructor Create(const APixel:TPixel);

    //установка и получение цвета
    procedure SetColor(AColor: TColor);
    function GetColor: TColor;
    property Color: TColor read GetColor write SetColor;

    //установка и получение точки
    procedure SetPoint(APoint: TPoint);
    function GetPoint: TPoint;
    property Point: TPoint read GetPoint write SetPoint;
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

implementation

//геттеры: функции получения значений координат
function TPixel.GetX(): TCoord;
begin
  GetX := self._point.X;
end;

function TPixel.GetY(): TCoord;
begin
  GetY := self._point.Y;
end;

//геттеры: функции установки значений координат
procedure TPixel.SetX(NewX: TCoord);
begin
  self._point.X := NewX;
end;

procedure TPixel.SetY(NewY: TCoord);
begin
  self._point.Y := NewY;
end;

//инициализация с точки с координатами 0,0 черного цвета
constructor TPixel.Create;
begin
  _point := TPoint.Create();

  SetColorBlack(self._color);
end;

//инициализация с точки с координатами APoint.X,APoint.Y черного цвета
constructor TPixel.Create(const APoint: TPoint);
begin
  self._point := TPoint.Create(APoint);

  SetColorBlack(self._color);
end;

//инициализация с точки с координатами APoint.X,APoint.Y цвета AColor
constructor TPixel.Create(const APoint: TPoint; const AColor: TColor);
begin
  self._point := TPoint.Create(APoint);

  self._color := AColor;
end;

//инициализация с точки с координатами X, Y цвета AColor
constructor TPixel.Create(X, Y: TCoord; const AColor: TColor);
begin
  self._point := TPoint.Create(X, Y);

  self._color := AColor;
end;

//конструктор копии
constructor TPixel.Create(const APixel:TPixel);
begin
  self._point := TPoint.Create(APixel.GetPoint());
  self._color := APixel.GetColor();
end;

//установка и получение цвета
procedure TPixel.SetColor(AColor: TColor);
begin
  self._color := AColor;
end;

function TPixel.GetColor: TColor;
begin
  GetColor := self._color;
end;

//установка и получение точки
procedure TPixel.SetPoint(APoint: TPoint);
begin
  self._point := TPoint.Create(APoint);
end;

function TPixel.GetPoint: TPoint;
begin
  GetPoint := self._point;
end;

//метод перемещения точки в точку с норвыми координатами
procedure TPixel.MoveTo(NewX, NewY: TCoord);
begin
  self._point.MoveTo(NewX, NewY);
end;

//метод перемещения точки в точку с норвыми координатами
procedure TPixel.MoveBy(OffX, OffY: TCoord);
begin
  self._point.MoveBy(OffX, OffY);
end;

//масштабирование с коэффициентами RatioX, RatioY
//относительно точки AnchorPoint
procedure TPixel.Scale(RatioX, RatioY: TCoord; const AnchorPoint: TPoint);
begin
  self._point.Scale(RatioX, RatioY, AnchorPoint);
end;

//вращение отностительно точки AnchorPoint
//на угол Angle
procedure TPixel.Rotate(Angle: TCoord; const AnchorPoint: TPoint);
begin
  self._point.Rotate(Angle, AnchorPoint);
end;

end.

