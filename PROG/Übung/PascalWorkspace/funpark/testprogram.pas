program Testprogram;

var
 i: integer;
moreValues: boolean; 
interAct: char;



begin
moreValues := true;

 while moreValues do begin 

   WriteLn('Enter an integer value');
   ReadLn(i);
   
   WriteLn('your value > ', i);
   
   WriteLn('wanna display another value? (y/n)');
   ReadLn(interAct);
   
   if interAct='y' then
     moreValues := true
   else
     moreValues := false;
 end; (*while*)
end.