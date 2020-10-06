unit figure_circle;

interface

uses
  figure_common,
  figure_point,
  figure_pixel;

type
  TCircle = class(TPixel)
  private
    _radius: TCoord;

  public
    //инициализация круга с центром 0,0 черного цвета, радиус 1
    constructor Create;

    //инициализация круга с центром APoint.X,APoint.Y черного цвета, радиус 1
    constructor Create(
      const AX: TCoord = 0;
      const AY: TCoord = 0;
      const AColor: TColor = CL_BLACK;
      const ARadius: TCoord = 1.0);

    //инициализация круга с центром APoint.X,APoint.Y черного цвета, радиус 1
    constructor Create(
      const APoint: TPoint;
      const AColor: TColor = CL_BLACK;
      const ARadius: TCoord = 1.0);

    //инициализация с точки с координатами APoint.X,APoint.Y цвета AColor
    constructor Create(
      const APixel:TPixel;
      const ARadius: TCoord = 1.0
      );

    //установка и получение радиуса
    procedure SetRadius(ARadius: TCoord);
    function GetRadius: TCoord;
    property Radius: TCoord read GetRadius write SetRadius;

  end;

implementation

//инициализация круга с центром 0,0 черного цвета, радиус 1
constructor TCircle.Create;
begin
  inherited Create();

  Radius := 1;
end;

//инициализация круга с центром APoint.X,APoint.Y черного цвета, радиус 1
constructor TCircle.Create(
  const AX: TCoord = 0;
  const AY: TCoord = 0;
  const AColor: TColor = CL_BLACK;
  const ARadius: TCoord = 1.0
  );
begin
  inherited Create(AX, AY, AColor);

  Radius := ARadius;
end;

//инициализация круга с центром APoint.X,APoint.Y черного цвета, радиус 1
constructor TCircle.Create(
  const APoint: TPoint;
  const AColor: TColor = CL_BLACK;
  const ARadius: TCoord = 1.0
  );
begin
  inherited Create(APoint, AColor);

  Radius := ARadius;
end;

//инициализация с точки с координатами APoint.X,APoint.Y цвета AColor
constructor TCircle.Create(
  const APixel:TPixel;
  const ARadius: TCoord = 1.0
  );
begin
  inherited Create(APixel);

  Radius := ARadius;
end;

//установка и получение радиуса
procedure TCircle.SetRadius(ARadius: TCoord);
begin
  _radius := ARadius;
end;

function TCircle.GetRadius: TCoord;
begin
  GetRadius := _radius;
end;

end.

