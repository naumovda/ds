program XmlTest03;

uses
  SysUtils, DOM, XMLRead;

const
  SPACES = 4;

procedure ProcessNode(Node: TDOMNode; Level: integer);
var
  cNode: TDOMNode;
  s: string;
begin
  if Node = nil then
    Exit; // выходим, если достигнут конец документа

  // вывводим узел
  s := Node.TextContent;

  //if Node.HasAttributes and (Node.Attributes.Length > 0) then
  // s := s + ' ' + Node.Attributes[0].NodeValue;

  WriteLn(s:level*SPACES);

  // переходим к дочернему узлу
  cNode := Node.FirstChild;

  // проходим по всем дочерним узлам
  while cNode <> nil do
  begin
    ProcessNode(cNode, level + 1);

    cNode := cNode.NextSibling;
  end;
end;

var
  XMLDoc: TXMLDocument;
  iNode: TDOMNode;

begin
  ReadXMLFile(XMLDoc, 'ex02.xml');

  iNode := XMLDoc.DocumentElement.FirstChild;

  // проходим по всем дочерним узлам
  while iNode <> nil do
  begin
    ProcessNode(iNode, 0);

    iNode := iNode.NextSibling;
  end;

  readln;
end.

