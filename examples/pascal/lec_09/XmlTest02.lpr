program XmlTest02;

{$mode objfpc}{$H+}

uses
  SysUtils,
  DOM,
  XMLRead
  //XMLWrite,
  //XMLConf,
  //XMLUtils,
  //XMLStreaming
  ;

var
   Document: TXMLDocument;
   Child: TDOMNode;
   j: Integer;

 begin
  ReadXMLFile(Document, 'ex02.xml');

  // Используем свойства FirstChild и NextSibling
  Child := Document.DocumentElement.FirstChild;

  while Assigned(Child) do
  begin
    WriteLn(Child.NodeName + ' ' + Child.Attributes.Item[0].NodeValue);

    // Используем свойство ChildNodes
    with Child.ChildNodes do
    try
      for j := 0 to (Count - 1) do
        WriteLn(Item[j].NodeName + ' ' + Item[j].FirstChild.NodeValue);
    finally
      Free;
    end;

    Child := Child.NextSibling;
  end;

  Document.Free;

  readln;
end.

