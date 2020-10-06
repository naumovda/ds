program XmlTest04;

{$mode objfpc}{$H+}

uses
  SysUtils,
  DOM,
  XMLRead,
  XMLWrite
  //XMLConf,
  //XMLUtils,
  //XMLStreaming
  ;

var
  XMLDoc: TXMLDocument;

  RootNode: TDOMNode;
  NewNode: TDomNode;

begin
  ReadXMLFile(XMLDoc, 'ex01.xml');

  RootNode := XMLDoc.DocumentElement;

  NewNode := XMLDoc.CreateElement('item');

  TDOMElement(NewNode).SetAttribute('name', 'student');
  TDOMElement(NewNode).SetAttribute('password', 'sa');

  //XMLDoc.DocumentElement.AppendChild(NewNode);
  RootNode.AppendChild(NewNode);

  WriteXMLFile(XMLDoc, 'new.xml');

  XMLDoc.Free;

  readln;
end.

