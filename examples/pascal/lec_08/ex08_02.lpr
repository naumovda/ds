program ex08_02;

const
  NONE = 0;
  READ_OK = 0;
  ERROR_UNEXP_EOF = 1;
  ERROR_BAD_FORMAT = 2;

const
  ErrorCode: integer = NONE;  //код ошибки, начальное состояние NONE

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
    ErrorCode := ERROR_BAD_FORMAT;
    exit;
  end;

  ErrorCode := READ_OK;
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

  case ErrorCode of
    NONE:;
    ERROR_UNEXP_EOF: //обработка ошибки - EOF
    begin
       writeln('Error  - end of file ', FileName);
       readln;
       halt(2);
     end;
    ERROR_BAD_FORMAT: //обработка ошибки - неверные данные
    begin
       writeln('Error  - bad format in', FileName);
       readln;
       halt(2);
     end;
  end;

  ErrorCode := PASSED;

  writeln('X = ', InputData);
  writeln('Terminated succesfully');

  Close(InputFile);

  readln;
end.

