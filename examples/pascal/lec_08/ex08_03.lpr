program ex08_03;

const
  NONE = 0;

  READ_OK             = $0000;
  ERROR_UNEXP_EOF     = $0001;
  ERROR_BAD_FORMAT    = $0002;
  ERROR_READ_FAILED   = $0004;
  ERROR_WRUTE_FAILED  = $0008;

const
  ErrorState: integer = NONE;  //код ошибки, начальное состояние NONE

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
  Result := ErrorState and ERROR_UNEXP_EOF;
end;

function IsBadFormat(): boolean;
begin
  Result := ErrorState and ERROR_BAD_FORMAT;
end;

function IsReadFailed(): boolean;
begin
  Result := ErrorState and ERROR_READ_FAILED;
end;

var
  InputFile: Text;

  InputData: integer;

  FileName: string;

begin
  write('Enter file name: ');
  readln(FileName);

  assign(InputFile, FileName);

  {$I-}
  reset(InputFile);
  {$I+}

  if IOResult <> 0 then
  begin
    writeln('Error while opening file ', FileName);
    readln;
    halt(1);
  end;

  ReadData(InputFile, InputData);

  if IsEOF then
  begin
    writeln('Error  - end of file ', FileName);
    readln;
    halt(2);
  end
  else if IsBadFormat() then
  begin
    writeln('Error  - bad format in', FileName);
    readln;
    halt(2);
  end;

  ErrorState := 0;

  writeln('X = ', InputData);
  writeln('Terminated succesfully');

  Close(InputFile);

  readln;
end.

