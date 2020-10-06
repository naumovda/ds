unit order_products;

interface

uses
  order_common,
  order_units;

type
  TProductInfo = record
    Code: TCode;
    Name: TName;
    Price: double;
    UnitCode: TCode;
  end;

  TProduct = class(TItem)
  private
    _info: TProductInfo;
    _product_unit: TUnit;
  public
    constructor Create(AId: TId; ACode: word; AName: TName; APrice: double;
      AUnitCode: TCode; const AUnitList: TUnitList);

    function GetCode: TCode;
    function GetName: TName;
    function GetPrice: double;
    function GetProductUnit: TUnit;

    procedure SetCode(ACode: TCode);
    procedure SetName(AName: TName);
    procedure SetPrice(APrice: double);
    procedure SetProductUnit(AUnit: TUnit);

    property Code:TCode read GetCode write SetCode;
    property Name:TName read GetName write SetName;
    property Price:double read GetPrice write SetPrice;
    property ProductUnit:TUnit read GetProductUnit write SetProductUnit;

    procedure Print;
  end;

  TProductList = class(TItemList)
  private
    _UnitList: TUnitList;
  public
    //конструктор
    constructor Create(const AUnitList: TUnitList);

    //загрузка списка ЕИ
    procedure Load(FileName: string); override;

    //сохранение списка ЕИ
    procedure Save(FileName: string); override;
  end;

implementation

uses
  SysUtils,
  DOM,
  XMLRead,
  XMLWrite;

constructor TProduct.Create(AId: TId; ACode: word; AName: TName; APrice: double;
  AUnitCode: TCode; const AUnitList: TUnitList);
begin
  inherited Create(AId);

  Code := ACode;
  Name := AName;
  Price := APrice;

  ProductUnit := AUnitList.GetUnitByCode(AUnitCode);
end;

function TProduct.GetCode: TCode;
begin
  Result := _info.Code;
end;

function TProduct.GetName: TName;
begin
  Result := _info.Name;
end;

function TProduct.GetPrice: double;
begin
  Result := _info.Price;
end;

procedure TProduct.SetCode(ACode: TCode);
begin
  _info.Code := ACode;
end;

procedure TProduct.SetName(AName: TName);
begin
  _info.Name := AName;
end;

procedure TProduct.SetPrice(APrice: double);
begin
  _info.Price := APrice;
end;

procedure TProduct.Print;
begin
  writeln('(', _info.Code, ',', _info.Name, ',', _info.Price:0:2,')');
end;

function TProduct.GetProductUnit: TUnit;
begin
  Result := self._product_unit;
end;

procedure TProduct.SetProductUnit(AUnit: TUnit);
begin
  self._product_unit := AUnit;
  self._info.Code := AUnit.Code;
end;

//------------------------------------------------------------------------------
constructor TProductList.Create(const AUnitList: TUnitList);
begin
  _UnitList := AUnitList;
end;

procedure TProductList.Load(FileName: string);
var
  id: TId;
  count: integer;

  info: TProductInfo;

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
    info.Price := StrToFloat(Node.FindNode('price').TextContent);
    info.UnitCode := StrToInt(Node.FindNode('unitcode').TextContent);

    _items[count-1] := TProduct.Create(id, info.Code, info.Name, info.Price,
      info.UnitCode, _UnitList);

    Node := Node.NextSibling;
  end;

  Doc.Free;
end;

procedure TProductList.Save(FileName: string);
var
  i: integer;

  XMLDoc: TXMLDocument; // переменная документа
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
  ListNode := XMLDoc.CreateElement('products');
  RootNode.Appendchild(ListNode); // добавляем узел списка товаров

  for i := 0 to Length(_items)-1 do
  begin
    //Создаём дочерний узел
    Node := XMLDoc.CreateElement('product');

    ElementNode := XMLDoc.CreateElement('id');
    TextNode := XMLDoc.CreateTextNode(IntToStr(_items[i].Id));
    ElementNode.Appendchild(TextNode);
    Node.Appendchild(ElementNode);

    ElementNode := XMLDoc.CreateElement('code');
    TextNode := XMLDoc.CreateTextNode(IntToStr((_items[i] as TProduct).Code));
    ElementNode.Appendchild(TextNode);
    Node.Appendchild(ElementNode);

    ElementNode := XMLDoc.CreateElement('name');
    TextNode := XMLDoc.CreateTextNode((_items[i] as TProduct).Name);
    ElementNode.Appendchild(TextNode);
    Node.Appendchild(ElementNode);

    ElementNode := XMLDoc.CreateElement('unitcode');
    TextNode := XMLDoc.CreateTextNode(
      IntToStr((_items[i] as TProduct).ProductUnit.Code));

    ElementNode.Appendchild(TextNode);
    Node.Appendchild(ElementNode);

    ElementNode := XMLDoc.CreateElement('price');
    TextNode := XMLDoc.CreateTextNode(FloatToStrF((_items[i] as TProduct).Price,
      ffFixed, 10, 2));
    ElementNode.Appendchild(TextNode);
    Node.Appendchild(ElementNode);

    ListNode.AppendChild(Node);
  end;

  writeXMLFile(XMLDoc, FileName);  // записываем всё в XML-файл

  XMLdoc.free; // освобождаем память
end;

end.


