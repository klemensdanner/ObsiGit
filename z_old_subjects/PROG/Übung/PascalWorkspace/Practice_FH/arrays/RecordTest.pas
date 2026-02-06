(* recordTest:                                                da, 2025-11-05 *)
(* ------                                                                    *)
(* studentlist using record                                                  *)
(* ========================================================================= *)

PROGRAM RecordTest;

  CONST
    max = 20;
  
  Type
    Student = record
      name: string;
      studentID: integer;
      snr: integer; (*first numbers only*)
    end;
  


Procedure NewStudent(name: string; studentID: integer; snr: integer; var s: Student);
  BEGIN
    s.name := name;
    s.studentID := studentID;
    s.snr := snr;
  end;

var
  s: Student;
  g1List: array[1..max] of Student;



BEGIN
  s.name := 'Klemens Danner';

  Writeln('students name: ', s.name);

  s.snr := 1234;
  s.studentID := 4321;


END.