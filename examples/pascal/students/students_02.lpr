program students_02;

type
  //дата
  TDate = record Day, Month, Year: integer; end;

  //сведения о студенте
  TStudent = class
  public
    Name,                     //имя
    Surname: string[80];      //фамилия
    DisplayName: string[255]; //имя для печати
    Birth: TDate;             //дата рождения

    procedure SetBioData(AName, ASurname: string; ADay, AMonth, AYear: integer);

    procedure Print();
  end;

  //сведения об аспиранте
  TGraduateStudent = class(TStudent)
  public
    //только для аспиранта
    These: string[255];       //тема диссертации
    SpecCode: string[10];     //код специальности

    procedure SetBioData(
      AName, ASurname: string;
      ADay, AMonth, AYear: integer;
      AThese: string;
      ASpecCode: string);

    procedure Print();
  end;

procedure TStudent.SetBioData(AName, ASurname: string; ADay, AMonth,
  AYear: integer);
begin
  Name := AName;
  Surname := ASurname;
  DisplayName := AName + ' ' + ASurname;
  Birth.Day := ADay;
  Birth.Month := AMonth;
  Birth.Year := AYear;
end;

procedure TStudent.Print();
begin
  writeln('From TStudent.Print => Name: ', DisplayName);
end;

procedure TGraduateStudent.SetBioData(
  AName, ASurname: string;
  ADay, AMonth, AYear: integer;
  AThese: string;
  ASpecCode: string);
begin
  inherited SetBioData(AName, ASurname, ADay, AMonth, AYear);

  These := AThese;
  SpecCode := ASpecCode;
end;

procedure TGraduateStudent.Print();
begin
  inherited Print();

  writeln('From TGraduateStudent.Print => These: ', These);
end;

procedure PrintBirthDay(const s: TStudent);
begin
  write('From PrintBirthDay() => ');
  writeln(s.Birth.Day, '.', s.Birth.Month, '.', s.Birth.Year);
end;

procedure InformGarduate(const gs: TGraduateStudent);
begin
  //получение gs типа TGraduateStudent
  //...
  write('From InformGarduate() => ');

  //и передача его дальше как TStudent
  PrintBirthDay(gs);
end;

var
  s: TStudent;
  gs: TGraduateStudent;

begin
  s := TStudent.Create;
  s.SetBioData('Ivan', 'Petrov', 1, 1, 1980);
  PrintBirthDay(s);
  s.Free;

  gs := TGraduateStudent.Create;
  gs.SetBioData('Oleg', 'Sidorov', 2, 2, 1981,
    'Space objects detection', '09.04.01');
  InformGarduate(gs);
  gs.Free;

  readln;
end.

