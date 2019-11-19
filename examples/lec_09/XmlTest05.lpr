uses
  SysUtils, DOM, XMLWrite;


var
  XMLDoc: TXMLDocument;                                  // переменная документа

  RootNode, ParentNode, TextNode: TDOMNode;             // переменная узла документа

begin
  //Создаём документ
  XMLDoc := TXMLDocument.create;

  //Создаём корневой узел
  RootNode := XMLDoc.CreateElement('register');
  XMLDoc.Appendchild(RootNode);                              // Добавляем корневой узел в документ

  //Создаём родительский узел
  RootNode:= XMLDoc.DocumentElement;
  ParentNode := XMLDoc.CreateElement('user');
  TDOMElement(ParentNode).SetAttribute('id', '001');       // создаём атрибуты родительского узла
  RootNode.Appendchild(parentNode);                        // добавляем родительский узел

  //Создаём дочерний узел
  ParentNode := XMLDoc.CreateElement('name');
  TDOMElement(ParentNode).SetAttribute('gender', 'M');     // создаём его атрибуты
  TextNode := XMLDoc.CreateTextNode('Fernando');              // вставляем значение в узел
  ParentNode.Appendchild(TextNode);                         // сохраняем узел
  RootNode.ChildNodes.Item[0].AppendChild(ParentNode);     // вставляем дочерний узел в соответствующий родительский

  //Создаём ещё один дочерний узел
  ParentNode := XMLDoc.CreateElement('age');
  TDOMElement(ParentNode).SetAttribute('year', '1976');   // создаём его атрибуты
  TextNode := XMLDoc.CreateTextNode('32');                    // вставляем значение в узел
  ParentNode.Appendchild(TextNode);                         // сохраняем узел
  RootNode.ChildNodes.Item[0].AppendChild(ParentNode);    // вставляем дочерний узел в соответствующий родительский

  writeXMLFile(XMLDoc, 'test.xml');                          // записываем всё в XML-файл

  XMLdoc.free;                                               // освобождаем память

  readln;
end.
