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

  TProductFile = file of TProductInfo;

  TProduct = class
  private
    _info: TProductInfo;

    _product_unit: TUnit;
  public
    constructor Create(ACode: word; AName: TName; APrice: double;
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

  TProductList = class
  private
    _file: TProductFile;
    _filename: string;
    _items: array of TProduct;
  public
    constructor Create(AFileName: string);

    procedure Load(const AUnitList: TUnitList);
    procedure Save;

    procedure Append(const AProduct: TProduct);
    procedure Edit(Index: integer; const AProduct: TProduct);
    procedure Delete(Index: integer);
    procedure Delete(const AProduct: TProduct);

    function GetProductIndex(const AProduct:TProduct): integer;
    function GetProductIndex(ACode: TCode): integer;

    function GetProductByIndex(AIndex: integer): TProduct;
    function GetProductByCode(ACode: TCode): TProduct;

    property Items[AIndex: integer]:TProduct read GetProductByIndex;

    procedure Print;
  end;

implementation

constructor TProduct.Create(ACode: word; AName: TName; APrice: double;
  AUnitCode: TCode; const AUnitList: TUnitList);
var
  idx: integer;
begin
  Code := ACode;
  Name := AName;
  Price := APrice;

  idx := AUnitList.GetUnitIndex(Code);

  if idx = -1 then
    ProductUnit := nil
  else
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
constructor TProductList.Create(AFileName: string);
begin
  _filename := AFileName;
end;

procedure TProductList.Load(const AUnitList: TUnitList);
var
  i, len: integer;
  info: TProductInfo;
begin
  assign(_file, _filename);

  try
    reset(_file);
  except
    len := 0;

    SetLength(_items, len);

    exit;
  end;

  len := filesize(_file);

  SetLength(_items, len);

  for i := 0 to Length(_items)-1 do
  begin
    read(_file, info);

    _items[i] := TProduct.Create(info.Code, info.Name, info.Price,
      info.UnitCode, AUnitList);
  end;

  close(_file);
end;

procedure TProductList.Save;
var
  i: integer;
begin
  assign(_file, _filename);
  rewrite(_file);

  for i := 0 to Length(_items)-1 do
    write(_file, _items[i]._info);

  close(_file);
end;

procedure TProductList.Append(const AProduct: TProduct);
begin
  if GetProductIndex(AProduct) = -1 then
  begin
    SetLength(_items, Length(_items)+1);

    _items[Length(_items)-1] := AProduct;
  end;
end;

procedure TProductList.Edit(Index: integer; const AProduct: TProduct);
begin
  _items[Index] := AProduct;
end;

procedure TProductList.Delete(Index: integer);
var
  i: integer;
begin
  for i := index to Length(_items)-2 do
    _items[i] := _items[i+1];

  SetLength(_items, Length(_items)-1);
end;

procedure TProductList.Delete(const AProduct: TProduct);
var
  i: integer;
begin
  i := 0;

  while (i < length(_items)) and (_items[i].Code <> AProduct.Code) do
    i := i + 1;

  if i < length(_items) then
    Delete(i);
end;

function TProductList.GetProductIndex(const AProduct:TProduct): integer;
var
  i: integer;
begin
  i := 0;

  for i := 0 to Length(_items)-1 do
    if _items[i].Code = AProduct.Code then
    begin
      Result := i;
      exit;
    end;

  Result := -1;
end;

function TProductList.GetProductIndex(ACode: TCode): integer;
begin
  Result := GetProductIndex(ACode);
end;

function TProductList.GetProductByIndex(AIndex: integer): TProduct;
begin
  if (AIndex < 0) or (AIndex >= Length(_items)) then
    Result := nil
  else
    Result := _items[AIndex];
end;

function TProductList.GetProductByCode(ACode: TCode): TProduct;
var
  i: integer;
begin
  i := GetProductIndex(ACode);

  if i = -1 then
    Result := nil
  else
    Result := _items[i];
end;

procedure TProductList.Print;
var
  i: integer;
begin
  for i := 0 to Length(_items)-1 do
    _items[i].Print;
end;

end.


