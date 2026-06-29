(* :                                                 Author, 2025-10-29 *)
(* ------                                                                    *)
(* Description                                                               *)
(* ========================================================================= *)

PROGRAM ScalarTypes;

  Type
    //Explizite Typdeklaration
    SmallLetters = 'a'..'z'; // macht man, um den Unterbereich einzuschränken //subrange
    TrafficLight = (red, orange, green); //ennumeration




  VAR
    i: integer;
    ch: char;
    b: boolean;
    sl: SmallLetters;
    smallInt: 0..20; //implizite Typendeklaration //Wirklich idente Typen gibts nur bei expliziter Deklaration
    tl: TrafficLight;


BEGIN (* ScalarTypes *)
  
  i := 65;

  // Integer:
  WriteLn('Pred(i) = ', Pred(i));
  WriteLn('Secc(i) = ', Succ(i));
  WriteLn('Ord(i) = ', Ord(i));
  WriteLn('Low(i) = ', Low(i));
  WriteLn('High(i) = ', High(i));
  WriteLn('Chr(i) = ', Chr(i));


  ch := 'm';

  WriteLn('Pred(ch) = ', Pred(ch));
  WriteLn('Secc(ch) = ', Succ(ch));
  WriteLn('Ord(ch) = ', Ord(ch));
  WriteLn('Low(ch) = ', Low(Low(ch)));
  WriteLn('High(ch) = ', High(High(ch)));
  WriteLn('Chr(ch) = ', Chr(Ord(ch)+5));


  For ch:= 'a' to 'f' do //geht mit den Ordinalzahlen
    Write(ch, ' ');


  //Boolean
  b:= false;
  //WriteLn('Pred(b) = ', Pred(b));
  WriteLn('Secc(b) = ', Succ(b));
  WriteLn('Ord(b) = ', Ord(b));
  WriteLn('Low(b) = ', Low(b));
  WriteLn('High(b) = ', High(b));



  For sl := Low(sl) to high(sl) do BEGIN
    Write(sl);
  END;

  tl:=red;
  WriteLn(tl);


  



END. (* ScalarTypes *)