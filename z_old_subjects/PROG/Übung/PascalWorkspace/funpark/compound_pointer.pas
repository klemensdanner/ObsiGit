program compoundTest;

type
  TPerson = record
   age: integer;
   name: string;
   end;

  PointToInt = ^integer; //variable zur Adressspeicherung eines ints
  
var
  person: TPerson;
  pointerVariable: PointToInt;


begin
  person.age := 21;
  person.name := 'klemens';
WriteLn(person.name, person.age:3);

  new(pointerVariable);
  


  Writeln('Adresse: ',ptruint(pointerVariable));
    pointerVariable^ := 25;
  Writeln('Inhalt: ', pointerVariable^);

  dispose(pointerVariable);
  Writeln('Inhalt: ', pointerVariable^);

end.