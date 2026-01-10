PROGRAM StringTest;

  var
  s: string;
BEGIN (* StringTest *)

s := 'Hallo, ' + 'sind im Labor 1';

WriteLn(s);
WriteLn(s[3]);
WriteLn(Length(s));

WriteLn(s[0]);
WriteLn(Ord(s[0]));

  
END. (* StringTest *)