program ex08_05;

{$mode objfpc}

uses
  SysUtils;

type
  // Тип-исключение "пустой файл"
  EmptyFileException = class(Exception)
  end;

  // Тип-исключение "ошибка формата данных
  BadFormatException = class(Exception)
  end;

//функция чтения (считывает число из текстового файла)
//var F: Text - файл входных данных
//var X: integer - считываемые данные
//var ErrorCode: integer - признак ошибки
procedure ReadData(var F: Text; var X: integer);
begin
  if EOF(F) then
    raise EmptyFileException.Create('EmptyFileException');

  try
    read(F, X);
  except
    raise EmptyFileException.Create('EmptyFileException');
  end;
end;

var
  InputFile: Text;
  InputData: integer;
  FileName: string;

begin
  write('Enter file name: ');
  readln(FileName);

  try
    assign(InputFile, FileName);
    reset(InputFile);
  except
    //обработка ошибки открытия файла
    on EInOutError do
      begin
        writeln('Cannot open file');
        readln;
        halt(1);
      end;
  end;

  try
    ReadData(InputFile, InputData);
  except
    on EmptyFileException do
      begin
        // Обработка ошибки пустого файла
      end;
    on BadFormatException do
      begin
        // Обработка ошибки формата данных файла
      end;
  end;

  writeln('X = ', InputData);
  writeln('Terminated succesfully');

  Close(InputFile);

  readln;
end.

