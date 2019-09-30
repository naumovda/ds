program queue;

const
  EMPTY = -1;
  MAXSIZE = 100;

type
  //класс для работы с очередью целых чисел
  PQueueInt = ^QueueInt;

  // class QueueInt
  //
  // Обеспечивает функциональность для хранения целых чисел
  // в стандартной очереди, обрабатываемой по принципу:
  // "первым пришел - первым обслужен".
  //
  // Определен в модуле queue.pas
  //
  // Конструктор (является конструктором по умолчанию):
  //   Queuelnt( int customSize = 100 );
  //     Инициализирует очередь указанного размера.
  //     Если аргумент имеет некорректное значение,
  //     печатается диагностическое сообщение
  //     и устанавливается значение по умолчанию.
  //
  //     Аргументы конструктора:
  //       customSize - задаваемый предельный размер очереди,
  //       Значение по умолчанию: 100
  //       Предельное разрешенное значение: 100
  //
  // Открытые функции-члены класса:
  //   procedure Enqueue(item: integer);
  //     Обеспечивает занесение элемента в очередь.
  //     Если очередь полна, печатает сообщение об ошибке.
  //   Аргументы:
  //     item - элемент, заносимый в очередь
  //     Возвращаемое значение:
  //       Нет
  //
  //   function Dequeue(): integer;
  //     Обеспечивает извлечение элемента из очереди.
  //     Если очередь пуста, печатает сообщение об ошибке.
  //   Аргументы:
  //     Нет
  //   Возвращаемое значение:
  //     Значение извлекаемого элемента
  //
  //   void Print{);
  //     Обеспечивает печать на консоль содержимого очереди.
  //     Если очередь пуста, печатает диагностическое сообщение.
  //   Аргументы:
  //     Нет
  //   Возвращаемое значение:
  //     Нет

  QueueInt = class(TObject)
    private
      //массив для хранения данных
      body: array[0..MAXSIZE] of integer;

      size: integer;   //Предельный размер
      length: integer; //Текущая длина очереди
      last: integer;   //Индекесы первого и
      next: integer;   //последнего элементов

    public
      constructor Create(CustomSize: integer); //Инициализация

      procedure Enqueue(Elem: integer); //Записать элемент
      function Dequeue(): integer; //Извлечь элемент
      procedure Print; //Печать содержимого
  end;

//Инициализация очереди при помощи конструктора
constructor QueueInt.Create(CustomSize: integer);
begin
  if (CustomSize < 1) or (CustomSize > MAXSIZE) then
  begin
    writeln('Incorrect size. Using default value');
    size := MAXSIZE;
  end
  else
    size := CustomSize;

  last := EMPTY;
  next := 0;
  length := 0;
end;

procedure QueueInt.Enqueue(Elem: integer); //Записать элемент
begin
  if length = size then
  begin
    write('Enqueue error. ');
    writeln('Queue is full.');
    exit;
  end;

  last := (last+1) mod size;
  inc(length);
  body[last] := Elem;
end;

function QueueInt.Dequeue(): integer; //Извлечь элемент
var
  copy: integer;
begin
  if length = 0 then
  begin
    write('Dequeue error.');
    writeln('Queue is empty.');

    Result := EMPTY;
    exit;
  end;

  copy := body[next];
  next := (next+1) mod size;
  dec(length);

  Result := copy;
end;

procedure QueueInt.Print; //Печать содержимого очереди
var
  coint, ix: integer;
begin
  if length = 0 then
  begin
    writeln('Queue is empty');
    exit;
  end;

  ix := next mod size;

  for count := 1 to length do
  begin
    ix := (ix+1) mod size;

    write(body[ix], ' ');
  end;

  writeln;
end;

procedure TestQueue;
var
  q: QueueInt;    //объект, размещенный в стеке
begin
  // Автоматическое размещение объекта в стеке
  // => Вызов конструктора при попадании объектной
  // переменной в область видимости

  // Создание объектаа
  q := QueueInt.Create(10);

  // Занесение элемента в очередь
  q.Enqueue(50);

  // Вывод очереди
  q.Print;
end;


begin
  TestQueue();
end.

