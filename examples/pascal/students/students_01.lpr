program students_01;

type
  //дата
  TDate = record Day, Month, Year: integer; end;

  //сведения о студенте
  TStudent = class
    Name,                     //имя
    Surname: string[80];      //фамилия
    DisplayName: string[255]; //имя для печати
    Birth: TDate;             //дата рождения
  end;

  //сведения об аспиранте
  TGraduantStudent = class
    StudentInfo: TStudent;    //аспирант как студент
    //только для аспиранта
    These: string[255];       //тема диссертации
    SpecCode: string[10];     //код специальности
  end;

begin
end.

