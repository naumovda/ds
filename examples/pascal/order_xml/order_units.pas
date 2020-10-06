unit order_units;

interface

uses
  order_common;

type
  //структура информации об единице измерения (ЕИ)
  TUnitInfo = record
    Code: TCode;        // код
    Name: TName;        // наименование
    ShortName: TName;   // сокращенное наименование
  end;

  //класс - единица измерения
  TUnit = class(TItem)
  private
    _info: TUnitInfo;
  public
    // конструктор класса
    //   AId - идентификатор объекта
    //   ACode - код ЕИ
    //   AName - наименование ЕИ
    constructor Create(AId: TId; ACode: word; AName: TName;
      AShortName: TName = '');

    //получение кода
    function GetCode: TCode;
    //получение наименования
    function GetName: TName;
    //получение сокращенного наименования
    function GetShortName: TName;

    //установка кода
    procedure SetCode(ACode: TCode);
    //установка наименования
    procedure SetName(AName: TName);
    //установка сокращенного наименования
    procedure SetShortName(AShortName: TName);

    //свойство - код ЕИ
    property Code:TCode read GetCode write SetCode;
    //свойство - наименование ЕИ
    property Name:TName read GetName write SetName;
    //свойство - сокращенное наименование
    property ShortName:TName read GetShortName write SetShortName;

    //печать ЕИ
    procedure Print; override;
  end;

  //класс - список единиц измерения
  TUnitList = class(TItemList)
  public
    //загрузка списка ЕИ
    procedure Load(FileName: string); override;
    //сохранение списка ЕИ
    procedure Save(FileName: string); override;

    //поиск ЕИ по коду
    function GetUnitByCode(ACode: TCode): TUnit;
  end;

implementation

uses
  SysUtils,
  DOM,
  XMLRead,
  XMLWrite;

//------------------------------------------------------------------------------
constructor TUnit.Create(AId: TId; ACode: word; AName: TName;
      AShortName: TName = '');
begin
  inherited Create(AId);

  Code := ACode;
  Name := AName;
  ShortName := AShortName;
end;

function TUnit.GetCode: TCode;
begin
  Result := _info.Code;
end;

function TUnit.GetName: TName;
begin
  Result := _info.Name;
end;

function TUnit.GetShortName: TName;
begin
  Result := _info.ShortName;
end;

procedure TUnit.SetCode(ACode: TCode);
begin
  _info.Code := ACode;
end;

procedure TUnit.SetName(AName: TName);
begin
  _info.Name := AName;
end;

procedure TUnit.SetShortName(AShortName: TName);
begin
  _info.ShortName := AShortName;
end;

procedure TUnit.Print;
begin
  writeln('(unit: ', _info.Code, ',', _info.Name, ',', _info.ShortName,')');
end;

//------------------------------------------------------------------------------
procedure TUnitList.Load(FileName: string);
var
  id: TId;
  count: integer;

  info: TUnitInfo;

  Doc:      TXMLDocument;
  ListNode: TDOMNode;
  Node: TDOMNode;

begin
  ReadXMLFile(Doc, filename);

  // Запрашиваем узел с именем "units"
  ListNode := Doc.DocumentElement.FindNode('units');

  Node := ListNode.FirstChild;
  count := 0;

  // проходим по всем дочерним узлам
  while Node <> nil do
  begin
    count := count + 1;
    SetLength(_items, count);

    id := StrToInt(Node.FindNode('id').TextContent);
    info.Code := StrToInt(Node.FindNode('code').TextContent);
    info.Name := Node.FindNode('name').TextContent;
    info.ShortName := Node.FindNode('shortname').TextContent;

    _items[count-1] := TUnit.Create(id, info.Code, info.Name, info.ShortName);

    Node := Node.NextSibling;
  end;

  Doc.Free;
end;

procedure TUnitList.Save(FileName: string);
var
  i: integer;

  XMLDoc: TXMLDocument;                                  // переменная документа
  RootNode,
  ListNode,
  Node,
  ElementNode,
  TextNode: TDOMNode; // переменная узла документа
begin
  //Создаём документ
  XMLDoc := TXMLDocument.create;

  //Создаём корневой узел
  RootNode := XMLDoc.CreateElement('data');
  XMLDoc.Appendchild(RootNode);  // Добавляем корневой узел в документ

  RootNode:= XMLDoc.DocumentElement;

  //Создаём родительский узел
  ListNode := XMLDoc.CreateElement('units');
  RootNode.Appendchild(ListNode); // добавляем узел списка единиц измерения

  for i := 0 to Length(_items)-1 do
  begin
    //Создаём дочерний узел
    Node := XMLDoc.CreateElement('unit');

    ElementNode := XMLDoc.CreateElement('id');
    TextNode := XMLDoc.CreateTextNode(IntToStr(_items[i].Id));
    ElementNode.Appendchild(TextNode);
    Node.Appendchild(ElementNode);

    ElementNode := XMLDoc.CreateElement('code');
    TextNode := XMLDoc.CreateTextNode(IntToStr((_items[i] as TUnit).Code));
    ElementNode.Appendchild(TextNode);
    Node.Appendchild(ElementNode);

    ElementNode := XMLDoc.CreateElement('name');
    TextNode := XMLDoc.CreateTextNode((_items[i] as TUnit).Name);
    ElementNode.Appendchild(TextNode);
    Node.Appendchild(ElementNode);

    ElementNode := XMLDoc.CreateElement('shortname');
    TextNode := XMLDoc.CreateTextNode((_items[i] as TUnit).ShortName);
    ElementNode.Appendchild(TextNode);
    Node.Appendchild(ElementNode);

    ListNode.AppendChild(Node);
  end;

  writeXMLFile(XMLDoc, FileName);  // записываем всё в XML-файл

  XMLdoc.free; // освобождаем память
end;

function TUnitList.GetUnitByCode(ACode: TCode): TUnit;
var
  i: integer;
begin
  for i := 0 to Length(_items)-1 do
    if (_items[i] is TUnit) then
      if (_items[i] as TUnit).Code = ACode then
      begin
        Result := _items[i] as TUnit;
        exit;
      end;

  Result := nil;
end;

end.

