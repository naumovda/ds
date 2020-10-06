unit order_document;

interface

uses
  order_common,
  order_units,
  order_products;

type
  TDocumentInfo = record
    Code: TCode;
    Date: TDate;
  end;

  TDocumentRowInfo = record
    Product: TProduct;
    Count: double;
  end;

  TDocumentFile = file of TDocumentInfo;
  TDocumentContentFile = file of TDocumentRowInfo;

{
  TDocumentRowList = class
  private
    _file: TDocumentContentFile;
    _filename: string;
    _items: array of TDocumentRowInfo;
  public
    constructor Create(AFileName: string);

    procedure Load(
      const AUnitList: TUnitList;
      const AProductList: TProductList);

    procedure Save;

    procedure Append(const ADocumentRowInfo: TDocumentRowInfo);
    procedure Edit(Index: integer; const TDocumentRowInfo: TProduct);
    procedure Delete(Index: integer);
    procedure Delete(const ADocumentRowInfo: TDocumentRowInfo);

    function GetRow(AIndex: integer): TDocumentRowInfo;

    property Items[AIndex: integer]:TDocumentRowInfo read GetRow;

    procedure Print;
  end;

  TDocument = class
  private
    _info: TDocumentInfo;
    _content: TDocumentRowList;
    _file: TDocumentFile;
    _filename: string;
  public
    constructor Create(ACode: TCode; ADay, AMonth, AYear: TCode);

    function GetCode: TCode;
    function GetDate: TDate;

    procedure SetCode(ACode: TCode);
    procedure SetDate(AName: TDate);

    property Code:TCode read GetCode write SetCode;
    property Date:TDate read GetDate write SetDate;

    procedure Load(
      const AUnitList: TUnitList;
      const AProductList: TProductList);

    procedure Save;

    procedure Print;
  end;

  TDocumentList = class
    private
      _info: TDocumentInfo;
      _documents: TDocumentList;
      _file: TDocumentFile;
    public
      constructor Create(AFileName: string);

      procedure Load(
        const AUnitList: TUnitList;
        const AProductList: TProductList);

      procedure Save;

      procedure Append(const ADocument: TDocument);
      procedure Edit(Index: integer; const ADocument: TDocument);
      procedure Delete(Index: integer);
      procedure Delete(const ADocument: TDocument);

      function GetDocumentIndex(const ADocument:TDocument): integer;

      function GetDocument(AIndex: integer): TDocument;

      property Items[AIndex: integer]:TDocument read GetDocument;

      procedure Print;
    end;
}

implementation

end.

