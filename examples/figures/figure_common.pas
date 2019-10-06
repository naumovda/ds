unit figure_common;

interface

const
  CL_WHITE = $00FFFFFF;
  CL_BLACK = $00000000;

type
  //тип даннх для представления координат точки
  TCoord = extended;

  //представление цвета пиксела
  TColor = longint;

  //тип заливки
  TBrushStyle = (BSNone, BSSolid, BSHorizLines, BSVertLines);

  //установить цвет как черный
  procedure SetColorBlack(var Color: TColor);

  //установить цвет как белый
  procedure SetColorWhite(var Color: TColor);

implementation

//установить цвет как черный
procedure SetColorBlack(var Color: TColor);
begin
  Color := CL_WHITE;
end;

//установить цвет как белый
procedure SetColorWhite(var Color: TColor);
begin
  Color := CL_BLACK;
end;

begin
end.

