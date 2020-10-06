program ex08_04;

const
  NONE = 0;

  READ_OK             = $0000;
  ERROR_UNEXP_EOF     = $0001;
  ERROR_BAD_FORMAT    = $0002;
  ERROR_READ_FAILED   = $0004;
  ERROR_WRUTE_FAILED  = $0008;

const
  ErrorState: integer = NONE;  //код ошибки, начальное состояние NONE

type
  TCallbackProc = procedure;
  TErrors = array[0..4] of string;

const
  ERROR_MSG: TErrors = (
    {0} '',
    {1} 'Error while opening input file',
    {2} 'Error while opening output file',
    {3} 'Input file contains no data',
    {4} 'Wrong input data format'
  );

procedure Error(ErrorCode: integer; CallbackProc: TCallbackProc);
begin
  writeln('Error No', ErrorCode, ' ', ERROR_MSG[ErrorCode]);

  if CallbackProc = nil then
    halt(0)
  else
    CallbackProc();   //Вызов внешнего обработчика
end;

var
  InputFile: Text;
  InputData: integer;
  FileName: string;

// Реализация первого варианта завершения программы
procedure Terminatel();
begin
  writeln('Unexpected end of input file');
  writeln('Terminated with error');
  Close(InputFile);
  halt(1);
end;

// Реализация второго варианта завершения программы
procedure Terminate2();
begin
  writeln('Input data wrong format');
  writeln('Terminated with error');
  Close(InputFile);
  halt(2);
end;

procedure Terminate0();
begin
  writeln('File not found');
  writeln('Terminated with error');
  halt(3);
end;

//функция чтения (считывает символ из текстового файла)
//var F: Text - файл входных данных
//var X: integer - считываемые данные
//var ErrorCode: integer - признак ошибки
procedure ReadData(var F: Text; var X: integer);
begin
  if EOF(F) then
  begin
    ErrorCode := ERROR_UNEXP_EOF;
    exit;
  end;

  {$I-}
  read(F, X);
  {$I+}
  if IOResult <> 0 then
  begin
    ErrorCode := ERROR_BAD_FORMAT or ERROR_READ_FAILED;
    exit;
  end;

  ErrorCode := READ_OK;
end;

function IsEOF(): boolean;
begin
  Result := (ErrorState and ERROR_UNEXP_EOF) <> 0;
end;

function IsBadFormat(): boolean;
begin
  Result := (ErrorState and ERROR_BAD_FORMAT) <> 0;
end;

function IsReadFailed(): boolean;
begin
  Result := (ErrorState and ERROR_READ_FAILED) <> 0;
end;

begin
  write('Enter file name: ');
  readln(FileName);

  assign(InputFile, FileName);

  {$I-} reset(InputFile); {$I+}

  if IOResult <> 0 then
    Error(2, @Terminate0);

  ReadData(InputFile, InputData);

  if IsEOF then
    Error(3, @Terminatel)
  else if IsBadFormat() then
    Error(4, @Terminate2);

  writeln('X = ', InputData);
  writeln('Terminated succesfully');

  Close(InputFile);

  Error(0, nil);

  readln;
end.

