{
//сведения о студенте
TStudent = class
public
  //...
  //метод базового класса
  procedure Print(); //печать информации о студенте
end;

//сведения об аспиранте
TGraduateStudent = class(TStudent)
public
  //...
  //переопределение метода в производном классе
  procedure Print(); //печать информации об аспиранте
end;

procedure TGraduateStudent.Print();
begin
  //обращение к методу базового класса
  inherited Print();

  //...
end;
}
