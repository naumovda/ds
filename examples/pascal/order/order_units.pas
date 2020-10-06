unit order_units;

interface

uses
  order_common;

type
  TUnitInfo = record
    Code: TCode;
    Name: TName;
    ShortName: TName;
  end;

  TUnitFile = file of TUnitInfo;

  TUnit = class
  private
    _info: TUnitInfo;
  public
    constructor Create(ACode: word; AName: TName; AShortName: TName = '');

    function GetCode: TCode;
    function GetName: TName;
    function GetShortName: TName;

    procedure SetCode(ACode: TCode);
    procedure SetName(AName: TName);
    procedure SetShortName(AShortName: TName);

    property Code:TCode read GetCode write SetCode;
    property Name:TName read GetName write SetName;
    property ShortName:TName read GetShortName write SetShortName;

    procedure Print;
  end;

  TUnitList = class
  private
    _file: TUnitFile;
    _filename: string;
    _items: array of TUnit;
  public
    constructor Create(AFileName: string);

    procedure Load;
    procedure Save;

    procedure Append(const AUnit: TUnit);

    procedure Edit(Index: integer; const AUnit: TUnit);

    procedure Delete(Index: integer);
    procedure Delete(const AUnit: TUnit);

    function GetUnitIndex(const AUnit:TUnit): integer;
    function GetUnitIndex(ACode: TCode): integer;

    function GetUnitByIndex(AIndex: integer): TUnit;
    function GetUnitByCode(ACode: TCode): TUnit;

    property Items[AIndex: integer]:TUnit read GetUnitByIndex;

    procedure Print;
  end;

implementation

constructor TUnit.Create(ACode: word; AName: TName; AShortName: TName = '');
begin
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
  writeln('(', _info.Code, ',', _info.Name, ',', _info.ShortName,')');
end;

//-------------------------------x-----------------------------------------------
constructor TUnitList.Create(AFileName: string);
begin
  _filename := AFileName;
end;

procedure TUnitList.Load;
var
  i, len: integer;
  info: TUnitInfo;
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

    _items[i] := TUnit.Create(info.Code, info.Name, info.ShortName);
  end;

  close(_file);
end;

procedure TUnitList.Save;
var
  i: integer;
begin
  assign(_file, _filename);
  rewrite(_file);

  for i := 0 to Length(_items)-1 do
    write(_file, _items[i]._info);

  close(_file);
end;

procedure TUnitList.Append(const AUnit: TUnit);
begin
  if GetUnitIndex(AUnit) = -1 then
  begin
    SetLength(_items, Length(_items)+1);
    _items[Length(_items)-1] := AUnit;
  end;
end;

procedure TUnitList.Edit(Index: integer; const AUnit: TUnit);
begin
  _items[Index] := AUnit;
end;

procedure TUnitList.Delete(Index: integer);
var
  i: integer;
begin
  for i := index to Length(_items)-2 do
    _items[i] := _items[i+1];

  SetLength(_items, Length(_items)-1);
end;

procedure TUnitList.Delete(const AUnit: TUnit);
var
  i: integer;
begin
  i := 0;

  while (i < length(_items)) and (_items[i].Code <> AUnit.Code) do
    i := i + 1;

  if i < length(_items) then
    Delete(i);
end;

function TUnitList.GetUnitIndex(const AUnit:TUnit): integer;
var
  i: integer;
begin
  i := 0;

  for i := 0 to Length(_items)-1 do
    if _items[i].Code = AUnit.Code then
    begin
      Result := i;
      exit;
    end;

  Result := -1;
end;

function TUnitList.GetUnitIndex(ACode: TCode): integer;
begin
  Result := GetUnitIndex(ACode);
end;

function TUnitList.GetUnitByIndex(AIndex: integer): TUnit;
begin
  if (AIndex < 0) or (AIndex >= Length(_items)) then
    Result := nil
  else
    Result := _items[AIndex];
end;

function TUnitList.GetUnitByCode(ACode: TCode): TUnit;
var
  i: integer;
begin
  i := GetUnitIndex(ACode);

  if i = -1 then
    Result := nil
  else
    Result := _items[i];
end;

procedure TUnitList.Print;
var
  i: integer;
begin
  for i := 0 to Length(_items)-1 do
    _items[i].Print;
end;

end.

