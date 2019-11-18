program XmlTest;

{$mode objfpc}{$H+}

//https://wiki.freepascal.org/XML_Tutorial/ru

uses
  SysUtils,
  laz2_DOM,
  laz2_XMLRead
  //XMLWrite,
  //XMLConf,
  //XMLUtils,
  //XMLStreaming
  ;

var
  PassNode: TDOMNode;
  Doc:      TXMLDocument;

 begin
  // Читаем xml файл с жесткого диска
  ReadXMLFile(Doc, 'ex01.xml');

  // Запрашиваем узел с именем "password"
  PassNode := Doc.DocumentElement.FindNode('password');

  // Выводим значение выбранного узла
  //Неправильный способ
  WriteLn(PassNode.NodeValue); // вывод будет пустым

  //Правильный способ
  // Текст узла - это отдельный дочерний узел
  WriteLn(PassNode.FirstChild.NodeValue); // правильно выведет "abc"

  // Альтернативный способ
  WriteLn(PassNode.TextContent);

  // В завершении делаем Free для документа
  Doc.Free;

  WriteLn('Press enter to quit...');
  readln;
end.

