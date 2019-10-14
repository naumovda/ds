program students_04;

//uses comment;

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

    procedure Print(); virtual;
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

    procedure Print(); override;
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
  //Print();

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

procedure CallPrint(s: TStudent);
begin
   s.Print();
end;

var
  s: TStudent;
  gs1, gs2: TGraduateStudent;

  parr: array[1..3] of TStudent;
  i: integer;

begin
  s := TStudent.Create;
  s.SetBioData('Ivan', 'Petrov', 1, 1, 1980);

  gs1 := TGraduateStudent.Create;
  gs1.SetBioData('Oleg', 'Sidorov', 2, 2, 1981,
    'Space objects detection', '09.04.01');

  gs2 := TGraduateStudent.Create;
  gs2.SetBioData('Alex', 'Ivanov', 3, 3, 1982,
    'Image classification', '09.04.02');

  writeln;

  parr[1] := s;
  parr[2] := gs1;
  parr[3] := gs2;

  for i := 1 to 3 do
    CallPrint(parr[i]); //вызывается процедура TStudent.Print

  readln;
end.

