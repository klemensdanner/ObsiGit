(* StringTest:                                            Author, 2025-11-12 *)
(* ------                                                                    *)
(* Tests for different string functions and procedures                       *)
(* ========================================================================= *)

program StringTest;

var
  s, s1, s2: string;
  i: integer;
  r: real;
  code: integer;


procedure InsertAt(var s: string; s2: string; at: integer);
begin
  s := copy(s, 1, at-1) + s2 + copy(s, at, Length(s)-at+1);
end;



begin

  s1 := 'Wir haben heute ';
  s2 := 'Pro-Uebung.';
  s := Concat(s1,s2);
  WriteLn(s);

  s := Copy(s1, 5, 2); //Am 5. char 2 Zeichen
  WriteLn(s);
  s := Copy(s1, Length(s1), 2); //Wenn außerhalb von Wertebereich macht er nichts

  InsertAt(s, s2, 5);
  WriteLn(s);

  WriteLn;
  WriteLn('Pos: ', Pos('23',s)); //liefert Startindex im String, wo der gesuchte string vorkommt, ansonsten 0


  Str(123.4556:10:2, s);
  WriteLn(s);

  Val('1b3', i, code);
  WriteLn('i = ', i, ' code = ',code)


end.