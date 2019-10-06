unit figure_abstract;

interface

uses
  figure_common; // подключаем общие типы данных

type
  //класс точки в двумерном пространстве координат
  TAbstractFigure = class
  private
    is_visible: boolean; //признак того, что фигура видима
  public
    //отобразить фигруру
    procedure Show; virtual; abstract;
    //скрыть фигуру
    procedure Hide; virtual; abstract;

    //перерисовать
    procedure Repaint;

    //доступ к полю видимости
    function GetVisible: boolean;
    procedure SetVisible(AVisible: boolean);

    //свойства для доступа к атрибутам через геттеры и сеттеры
    property Visible: boolean read GetVisible write SetVisible;
  end;

implementation

//перерисовать
procedure TAbstractFigure.Repaint;
begin
  Hide;
  Show;
end;

//доступ к полю видимости
function TAbstractFigure.GetVisible: boolean;
begin
  GetVisible := is_visible;
end;

//установка значения поля видимости
procedure TAbstractFigure.SetVisible(AVisible: boolean);
begin
  //если видимость меняется, то...
  if Visible <> AVisible then
    if Visible then
      Show
    else
      Hide;

  Visible := AVisible;
end;

end.
