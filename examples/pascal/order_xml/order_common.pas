unit order_common;

interface

type
  //тип идентификатора объекта
  TId   = integer;
  //тип кода объекта
  TCode = word;
  //тип наименования объекта
  TName = string;

  //тип для операций с датами
  TDate = record
    Day: 1..31;
    Month: 1..12;
    Year: word;
  end;

  //абстрактный класс - элемент данных
  TItem = class
    private
      // идентификатор объекта
      // по идентификатору будет осуществляться поиск объекта в списке
      _id: TId;
    public
      // конструктор
      constructor Create(AId: TId);

      // геттеры и сеттеры для идентификатора
      function GetId: TId;
      procedure SetId(AId: TId);

      //свойство-идентификатор
      property Id:TId read GetId write SetId;

      //абстрактный метод печати
      procedure Print; virtual; abstract;
  end;

  //абстрактный клсс - список элементов
  TItemList = class
    protected
      //массив элементов
      _items: array of TItem;
    public
      //конструктор
      constructor Create();

      //добавить элемент в список
      procedure Append(const AItem: TItem);

      //изменить элемент
      procedure Edit(Index: integer; const AItem: TItem);

      //удалить элемент по индексу
      procedure Delete(Index: integer);
      //удалить элемент
      procedure Delete(const AItem: TItem);

      //получить индекс по идентификатору
      function GetIndex(const AId:TId): integer;
      //получить индекс элемента
      function GetIndex(const AItem: TItem): integer;

      //получить элемент
      function GetItem(AIndex: integer): TItem;

      //индексатор элементов
      property Items[AIndex: integer]:TItem read GetItem write Edit; default;

      //вывод на печать всех элементов
      procedure Print;

      //загрузка данных из файла
      procedure Load(FileName: string); virtual; abstract;
      //загрузка данных из файла
      procedure Save(FileName: string); virtual; abstract;
    end;

implementation

//------------------------------------------------------------------------------
constructor TItem.Create(AId: TId);
begin
  _id := AId;
end;

function TItem.GetId: TId;
begin
  Result := _id;
end;

procedure TItem.SetId(AId: TId);
begin
  _id := AId;
end;

//------------------------------------------------------------------------------
constructor TItemList.Create();
begin
  SetLength(_items, 0);
end;

procedure TItemList.Append(const AItem: TItem);
begin
  if GetIndex(AItem) = -1 then
  begin
    SetLength(_items, Length(_items)+1);
    _items[Length(_items)-1] := AItem;
  end;
end;

procedure TItemList.Edit(Index: integer; const AItem: TItem);
begin
  _items[Index] := AItem;
end;

procedure TItemList.Delete(Index: integer);
var
  i: integer;
begin
  if Index < 0 then
    exit;

  for i := Index to Length(_items)-2 do
    _items[i] := _items[i+1];

  SetLength(_items, Length(_items)-1);
end;

procedure TItemList.Delete(const AItem: TItem);
begin
  Delete(GetIndex(AItem));
end;

function TItemList.GetIndex(const AId:TId): integer;
var
  i: integer;
begin
  for i := 0 to Length(_items)-1 do
    if _items[i].Id = AId then
    begin
      Result := i;
      exit;
    end;

  Result := -1;
end;

function TItemList.GetIndex(const AItem: TItem): integer;
begin
  Result := GetIndex(AItem.Id);
end;

function TItemList.GetItem(AIndex: integer): TItem;
begin
  if (AIndex < 0) or (AIndex >= Length(_items)) then
    Result := nil
  else
    Result := _items[AIndex];
end;

procedure TItemList.Print;
var
  i: integer;
begin
  for i := 0 to Length(_items)-1 do
    _items[i].Print;
end;

end.

