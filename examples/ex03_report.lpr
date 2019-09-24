program reports;

uses
  //подключаем модуль для работы со строками UTF8
  LazUTF8;

type
  //тип строки
  TString = string;

  //тип выравнивания текста в ячейке
  //alLeft   - по левому краю
  //alCenter - по центру
  //alRight  - по правому краю
  TAlign = (alLeft, alCenter, alRight);

  //тип границы ячейки
  //bsLeft   - левая граница
  //bsRight  - правая граница
  //bsTop    - верхняя граница
  //bsBottom - нижняя граница
  //bsNone   - отсутствие границ
  //bsAll    - все границы
  TBorderStyle = (bsLeft, bsRight, bsTop, bsBottom, bsNone, bsAll);

  //тип для задания границы
  TBorder = set of TBorderStyle;

  //опережающие описания
  TColumn = class;  //столбец отчета
  TRow = class;     //строка отчета
  TDataset = class; //набор данных
  TReport = class;  //отчет

  //класс ячейки
  TCell = class(TObject)
    private
      FBorder: TBorder;
      FValue: TString;
      FRow: TRow;
      FColumn: TColumn;

    public
      constructor Init(AValue: TString);
      constructor Init(AValue: TString; ABorder: TBorder);

      procedure DrawTop(var ReportFile: text);
      procedure DrawMiddle(var ReportFile: text);
      procedure DrawBottom(var ReportFile: text);

      procedure LeftTop(var ReportFile: text); virtual; abstract;
      procedure CenterTop(var ReportFile: text); virtual; abstract;
      procedure MiddleTop(var ReportFile: text); virtual; abstract;
      procedure RightTop(var ReportFile: text); virtual; abstract;
      procedure LeftSide(var ReportFile: text); virtual; abstract;
      procedure RightSide(var ReportFile: text); virtual; abstract;
      procedure LeftBottom(var ReportFile: text); virtual; abstract;
      procedure CenterBottom(var ReportFile: text); virtual; abstract;
      procedure MiddleBottom(var ReportFile: text); virtual; abstract;
      procedure RightBottom(var ReportFile: text); virtual; abstract;

      property Border: TBorder read FBorder write FBorder;
      property Value: TString read FValue write FValue;
      property Row: TRow read FRow write FRow;
      property Column: TColumn read FColumn write FColumn;
  end;

  //класс для генерации ячеек строки
  TCellBuilder = class
    public
      function CreateCell(): TCell; virtual; abstract;
  end;

  //класс ячеек с границей из символов "*"
  TAstericsCell = class(TCell)
    public
      procedure WriteAsterics(var ReportFile: text);

      procedure LeftTop(var ReportFile: text); override;
      procedure CenterTop(var ReportFile: text); override;
      procedure MiddleTop(var ReportFile: text); override;
      procedure RightTop(var ReportFile: text); override;
      procedure LeftSide(var ReportFile: text); override;
      procedure RightSide(var ReportFile: text); override;
      procedure LeftBottom(var ReportFile: text); override;
      procedure CenterBottom(var ReportFile: text); override;
      procedure MiddleBottom(var ReportFile: text); override;
      procedure RightBottom(var ReportFile: text); override;
  end;

  //класс для генерации ячеек с границей из звездочек
  TAstericsCellBuilder = class(TCellBuilder)
    public
      function CreateCell(): TCell; override;
  end;

  //класс ячеек с границей из символов "-", "|", "+"
  TPlusMinusCell = class(TCell)
    public
      procedure LeftTop(var ReportFile: text); override;
      procedure CenterTop(var ReportFile: text); override;
      procedure MiddleTop(var ReportFile: text); override;
      procedure RightTop(var ReportFile: text); override;
      procedure LeftSide(var ReportFile: text); override;
      procedure RightSide(var ReportFile: text); override;
      procedure LeftBottom(var ReportFile: text); override;
      procedure CenterBottom(var ReportFile: text); override;
      procedure MiddleBottom(var ReportFile: text); override;
      procedure RightBottom(var ReportFile: text); override;
  end;

  //класс для генерации ячеек TPlusMinusCell
  TPlusMinusCellBuilder = class(TCellBuilder)
    public
      function CreateCell(): TCell; override;
  end;

  //класс колонки
  TColumn = class(TObject)
    Width: byte;       // ширина столбца
    Align: TAlign;     // выравнивание данных
    Caption: TString;  // заголовок столбца
    Dataset: TDataset; // набор данных

    //конструктор класса
    //ACaption: TString - заголовок
    //AAlign: TAlign    - выравнивание
    //AWidth: byte      - ширина
    constructor Init(ACaption: TString; AAlign: TAlign; AWidth: byte);

    function GetIndex(): integer; // получение индекса стобца в отчете

    procedure DrawTop(var ReportFile: text);    // отображение верхней строки
    procedure DrawMiddle(var ReportFile: text); // отображение средней строки
    procedure DrawBottom(var ReportFile: text); // отображение нижней строки
  end;

  //класс строки отчета
  TRow = class(TObject)
    private
      FCells: array of TCell; // массив ячеек
      Dataset: TDataset;      // набор данных

    public
      //конструктор строки отчета
      constructor Init();

      //получение номера строки
      function GetIndex(): integer;

      //отображение строки
      procedure Draw(var ReportFile: text);

      //добавление ячейки в строку
      //  AValue: TString - значение в ячейки
      //  const ABorder: TBorder - граница
      function AddCell(AValue: TString; const ABorder: TBorder): TCell;

      //получение ячейки по номеру
      //  Index: Integer - номер ячейки
      function GetCell(Index: Integer): TCell;

      //установка значения ячейки по номеру
      //  Index: Integer - номер ячейки
      //  ACell:TCell - ячейка
      procedure SetCell(Index: Integer; ACell:TCell);

      //получение количества ячеек
      function Count():integer;

      //свойство для получения ячеек
      property Cells[Index: Integer]:TCell read GetCell write SetCell; default;
  end;

  TDataset = class(TObject)
    IsShowCaption: boolean;

    Rows: array of TRow;
    Columns: array of TColumn;

    Report: TReport;

    constructor Init(AIsShowCaption: boolean);

    procedure Draw(var ReportFile: text);
    procedure DrawCaption(var ReportFile: text);
    procedure DrawRows(var ReportFile: text);

    function AddColumn(ACaption: TString; AAlign: TAlign; AWidth: byte): TColumn;
    function AddRow: TRow;
  end;

  TReport = class(TObject)
    public
      Width: byte;
      Filename: TString;

      Data: array of TDataset;

      CellBuilder: TCellBuilder;
      ColumnCellBuilder: TCellBuilder;

      constructor Init(AWidth: byte;
        AFilename: TString;
        ACellBuilder, AColumnCellBuilder: TCellBuilder);

      procedure Save();

      function AddDataset(AIsShowCaption: Boolean): TDataset;
      procedure RemoveDataset(DatasetIdx: integer);
  end;

function TAstericsCellBuilder.CreateCell(): TCell;
begin
  Result := TAstericsCell.Create;
end;

function TPlusMinusCellBuilder.CreateCell(): TCell;
begin
  Result := TPlusMinusCell.Create;
end;

//public str functions
function RepeatChar(AChar: Char; Count: byte): TString;
var
  str: TString;
  i: byte;
begin
  str := '';

  for i := 1 to Count do
    str := str + AChar;

  Result := str;
end;

function Space(Count: byte): TString;
begin
  Result := RepeatChar(' ', Count);
end;

//TCell
constructor TCell.Init(AValue: TString);
begin
  self.Value := AValue;
  self.Border := [bsAll];
end;

constructor TCell.Init(AValue: TString; ABorder: TBorder);
begin
  Value := AValue;
  Border := ABorder;
end;

procedure TCell.DrawTop(var ReportFile: text);
var
  i: byte;
begin
  if not (bsAll in Border) and not (bsTop in Border) then
  begin
     write(ReportFile, Space(Column.Width));

     exit;
  end;

  if Column.GetIndex() = 0 then
    LeftTop(ReportFile)
  else
    MiddleTop(ReportFile);

  for i := 1 to Column.Width - 2 do
    MiddleTop(ReportFile);

  RightTop(ReportFile);
end;

procedure TCell.DrawMiddle(var ReportFile: text);
var
  width, leng: integer;
  str: TString;
begin
  width := Column.Width;

  if Column.GetIndex() = 0 then
    if not (bsAll in Border) and not (bsLeft in Border) then
      write(ReportFile, Space(1))
    else
      LeftSide(ReportFile)
  else
    width := width + 1;

  str := self.Value;
  if UTF8Length(str) > width then
     str := Copy(str, 1, width);

  leng := UTF8Length(str);

  //if Center or Column caption (Row = nil)
  if (Column.Align = alCenter) or (Row = nil) then
    str := Space((width - leng) div 2 - 1)
           + str
           + Space(width - leng - (width - leng) div 2 - 1)
  else if Column.Align = alLeft then
    str := str + Space(Width - leng - 2)
  else if Column.Align = alRight then
    str := Space(Width - leng - 2) + str
  else //unknown
    str := str + Space(Width - leng - 2);

  write(ReportFile, str);

  if not (bsAll in Border) and not (bsRight in Border) then
    write(ReportFile, Space(1))
  else
    RightSide(ReportFile);
end;

procedure TCell.DrawBottom(var ReportFile: text);
var
  i: byte;
begin
  if not (bsAll in Border) and not (bsBottom in Border) then
  begin
     write(ReportFile, Space(Column.Width));

     exit;
  end;

  if Column.GetIndex() = 0 then
    LeftBottom(ReportFile)
  else
    MiddleBottom(ReportFile);

  for i := 1 to Column.Width - 2 do
    MiddleBottom(ReportFile);

  RightBottom(ReportFile);
end;

//TAstericsCell
procedure TAstericsCell.WriteAsterics(var ReportFile: text);
begin
  write(ReportFile, '*');
end;

procedure TAstericsCell.LeftTop(var ReportFile: text);
begin
  WriteAsterics(ReportFile);
end;

procedure TAstericsCell.CenterTop(var ReportFile: text);
begin
  WriteAsterics(ReportFile);
end;

procedure TAstericsCell.MiddleTop(var ReportFile: text);
begin
  WriteAsterics(ReportFile);
end;

procedure TAstericsCell.RightTop(var ReportFile: text);
begin
  WriteAsterics(ReportFile);
end;

procedure TAstericsCell.LeftSide(var ReportFile: text);
begin
  WriteAsterics(ReportFile);
end;

procedure TAstericsCell.RightSide(var ReportFile: text);
begin
  WriteAsterics(ReportFile);
end;

procedure TAstericsCell.LeftBottom(var ReportFile: text);
begin
  WriteAsterics(ReportFile);
end;

procedure TAstericsCell.CenterBottom(var ReportFile: text);
begin
  WriteAsterics(ReportFile);
end;

procedure TAstericsCell.MiddleBottom(var ReportFile: text);
begin
  WriteAsterics(ReportFile);
end;

procedure TAstericsCell.RightBottom(var ReportFile: text);
begin
  WriteAsterics(ReportFile);
end;

//TPlusMinusCell
procedure TPlusMinusCell.LeftTop(var ReportFile: text);
begin
  write(ReportFile, '+');
end;

procedure TPlusMinusCell.CenterTop(var ReportFile: text);
begin
  write(ReportFile, '-');
end;

procedure TPlusMinusCell.MiddleTop(var ReportFile: text);
begin
  write(ReportFile, '-');
end;

procedure TPlusMinusCell.RightTop(var ReportFile: text);
begin
  write(ReportFile, '+');
end;

procedure TPlusMinusCell.LeftSide(var ReportFile: text);
begin
  write(ReportFile, '|');
end;

procedure TPlusMinusCell.RightSide(var ReportFile: text);
begin
  write(ReportFile, '|');
end;

procedure TPlusMinusCell.LeftBottom(var ReportFile: text);
begin
  write(ReportFile, '+');
end;

procedure TPlusMinusCell.CenterBottom(var ReportFile: text);
begin
  write(ReportFile, '-');
end;

procedure TPlusMinusCell.MiddleBottom(var ReportFile: text);
begin
  write(ReportFile, '-');
end;

procedure TPlusMinusCell.RightBottom(var ReportFile: text);
begin
  write(ReportFile, '+');
end;

//TColumn
constructor TColumn.Init(ACaption: TString; AAlign: TAlign; AWidth: byte);
begin
  Caption := ACaption;

  Align := AAlign;

  Width := AWidth;
end;

function TColumn.GetIndex(): integer;
var
  i, idx: integer;
begin
  idx := -1;

  for i := 0 to Length(Dataset.Columns) do
    if Dataset.Columns[i] = self then
       begin
         idx := i;
         break;
       end;

  Result := idx;
end;

procedure TColumn.DrawTop(var ReportFile: text);
var
  Cell: TCell;
begin
  Cell := Dataset.Report.ColumnCellBuilder.CreateCell(); //TCell.Create;

  Cell.Row := nil;
  Cell.Column := self;

  Cell.Init(self.Caption, [bsAll]);

  Cell.DrawTop(ReportFile);
end;

procedure TColumn.DrawMiddle(var ReportFile: text);
var
  Cell: TCell;
begin
  Cell := Dataset.Report.ColumnCellBuilder.CreateCell(); //TCell.Create;

  Cell.Row := nil;
  Cell.Column := self;

  Cell.Init(self.Caption, [bsAll]);

  Cell.DrawMiddle(ReportFile);
end;

procedure TColumn.DrawBottom(var ReportFile: text);
var
  Cell: TCell;
begin
  Cell := Dataset.Report.ColumnCellBuilder.CreateCell(); //TCell.Create;

  Cell.Row := nil;
  Cell.Column := self;

  Cell.Init(self.Caption, [bsAll]);

  Cell.DrawBottom(ReportFile);
end;

//TRow
constructor TRow.Init();
begin
  //do nothing
end;

function TRow.GetCell(Index: integer):TCell;
begin
  Result := FCells[Index];
end;

procedure TRow.SetCell(Index: integer; ACell: TCell);
begin
  FCells[Index] := ACell;
end;

function TRow.GetIndex(): integer;
var
  i, idx: integer;
begin
  idx := -1;

  for i := 0 to Length(Dataset.Rows) do
    if Dataset.Rows[i] = self then
    begin
      idx := i;
      break;
    end;

  Result := idx;
end;

function TRow.Count():integer;
begin
  Result := Length(FCells);
end;

procedure TRow.Draw(var ReportFile: text);
var
  i: integer;
begin
  if not Dataset.IsShowCaption and (GetIndex() = 0) then
  begin
    for i := 0 to Count()-1 do
      Cells[i].DrawTop(ReportFile);
    writeln(ReportFile);
  end;

  for i := 0 to Count()-1 do
    Cells[i].DrawMiddle(ReportFile);
  writeln(ReportFile);

  for i := 0 to Count()-1 do
    Cells[i].DrawBottom(ReportFile);
  writeln(ReportFile);
end;

function TRow.AddCell(AValue: TString; const ABorder: TBorder): TCell;
var
  Cell: TCell;
  CellIdx: integer;
begin
  Cell := Dataset.Report.CellBuilder.CreateCell(); //TCell.Create;

  Cell.Init(AValue, ABorder);

  Cell.Row := self;

  CellIdx := Count();
  SetLength(FCells, CellIdx + 1);
  Cells[CellIdx] := Cell;

  Cell.Column := self.Dataset.Columns[CellIdx];

  Result := Cell;
end;

//TDataset
constructor TDataset.Init(AIsShowCaption: boolean);
begin
  IsShowCaption := AIsShowCaption;

  SetLength(Columns, 0);

  SetLength(Rows, 0);
end;

function TDataset.AddColumn(ACaption: TString; AAlign: TAlign;
  AWidth: byte): TColumn;
var
  Column: TColumn;
begin
  Column := TColumn.Create;

  Column.Init(ACaption, AAlign, AWidth);

  Column.Dataset := self;

  SetLength(Columns, Length(Columns)+1);

  Columns[Length(Columns)-1] := Column;

  Result := Column;
end;

function TDataset.AddRow: TRow;
var
  Row: TRow;
begin
  Row := TRow.Create;

  Row.Init();

  Row.Dataset := self;

  SetLength(Rows, Length(Rows)+1);

  Rows[Length(Rows)-1] := Row;

  Result := Row;
end;

procedure TDataset.DrawCaption(var ReportFile: text);
var
  i: integer;
begin
  for i := 0 to Length(Columns)-1 do
    Columns[i].DrawTop(ReportFile);
  writeln(ReportFile);

  for i := 0 to Length(Columns)-1 do
    Columns[i].DrawMiddle(ReportFile);
  writeln(ReportFile);

  for i := 0 to Length(Columns)-1 do
    Columns[i].DrawBottom(ReportFile);
  writeln(ReportFile);
end;

procedure TDataset.DrawRows(var ReportFile: text);
var
  i: integer;
begin
  for i := 0 to Length(Rows)-1 do
    Rows[i].Draw(ReportFile);
end;

procedure TDataset.Draw(var ReportFile: text);
begin
  if IsShowCaption then
    DrawCaption(ReportFile);

  DrawRows(ReportFile);

  writeln(ReportFile);
end;

//TReport
constructor TReport.Init(AWidth: byte; AFilename: TString;
  ACellBuilder, AColumnCellBuilder: TCellBuilder);
begin
  Width := AWidth;
  Filename := AFilename;
  CellBuilder := ACellBuilder;
  ColumnCellBuilder := AColumnCellBuilder;
end;

procedure TReport.Save();
var
  i: integer;
  ReportFile: text;
begin
  assign(ReportFile, FileName);
  rewrite(ReportFile);

  for i := 0 to Length(Data)-1 do
    Data[i].Draw(ReportFile);

  close(ReportFile);
end;

function TReport.AddDataset(AIsShowCaption: Boolean): TDataset;
var
  Dataset: TDataset;
begin
  Dataset := TDataset.Create;

  Dataset.Init(AIsShowCaption);

  Dataset.Report := self;

  SetLength(Data, Length(Data) + 1);

  Data[Length(Data)-1] := Dataset;

  Result := Dataset;
end;

procedure TReport.RemoveDataset(DatasetIdx: integer);
var
  i: integer;
begin
  for i := DatasetIdx to Length(Data)-2 do
    Data[i] := Data[i+1];

  SetLength(Data, Length(Data) - 1);
end;

var
  Report: TReport;
  Dataset: TDataset;
  Row: TRow;

begin
  //настройка параметров отчета
  Report := TReport.Create;
  Report.Init(80, 'result.txt',
    TPlusMinusCellBuilder.Create(),
    TAstericsCellBuilder.Create()
  );

  //задание заголовка отчета
  Dataset := Report.AddDataset(true);
  Dataset.AddColumn('ОТЧЕТ ПО СВОДНОЙ СТАТИСТИКЕ', alCenter, Report.Width);

  //секции параметров отчета
  Dataset := Report.AddDataset(false);
  Dataset.AddColumn('ПАРАМЕТР', alLeft, 50);
  Dataset.AddColumn('ЗНАЧЕНИЕ', alLeft, Report.Width - 50);

  Row := Dataset.AddRow();
  Row.AddCell('Пользователь', [bsNone]);
  Row.AddCell('Ivanov', [bsNone]);

  Row := Dataset.AddRow();
  Row.AddCell('Группа', [bsNone]);
  Row.AddCell('748', [bsNone]);

  //основная табличная часть
  Dataset := Report.AddDataset(true);
  Dataset.AddColumn('№', alCenter, 5);
  Dataset.AddColumn('ТЕСТ', alLeft, 45);
  Dataset.AddColumn('ДАТА', alCenter, 15);
  Dataset.AddColumn('РЕЗУЛЬТАТ', alRight, 15);

  Row := Dataset.AddRow();
  Row.AddCell('1', [bsAll]);
  Row.AddCell('Основы компьютерных наук', [bsAll]);
  Row.AddCell('12.03.2019', [bsAll]);
  Row.AddCell('75%', [bsAll]);

  Row := Dataset.AddRow();
  Row.AddCell('2', [bsAll]);
  Row.AddCell('Программирование и алгоритмические языки', [bsAll]);
  Row.AddCell('14.03.2019', [bsAll]);
  Row.AddCell('85%', [bsAll]);

  Row := Dataset.AddRow();
  Row.AddCell('3', [bsAll]);
  Row.AddCell('Программирование и алгоритмические языки', [bsAll]);
  Row.AddCell('14.03.2019', [bsAll]);
  Row.AddCell('55%', [bsAll]);

  //подвал отчета
  Dataset := Report.AddDataset(false);
  Dataset.AddColumn('ПАРАМЕТР', alLeft, 50);
  Dataset.AddColumn('ЗНАЧЕНИЕ', alLeft, Report.Width - 50);

  Row := Dataset.AddRow();
  Row.AddCell('Лучший результат тестирования:', [bsTop, bsBottom]);
  Row.AddCell('98%', [bsTop, bsBottom]);

  Row := Dataset.AddRow();
  Row.AddCell('Результат получен в тесте:', [bsTop, bsBottom]);
  Row.AddCell('тест по ОКН', [bsTop, bsBottom]);

  //сохраняем отчет
  Report.Save();
end.

