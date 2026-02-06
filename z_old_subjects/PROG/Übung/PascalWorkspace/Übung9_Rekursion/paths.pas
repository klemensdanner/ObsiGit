(* Paths:                                                 DA, 2025-12-10 *)
(* ------                                                                    *)
(* Determine the number of paths from starting Point A (0,0) to B (m,n)      *)
(* Paths(m, 1) = m + 1      *)
(* Paths(1, n) = 1 + n      *)
(* Paths(m, n) = Paths(m-1, n) + Paths(m, n-1)                               *)
(* ========================================================================= *)

program Paths;
//------------------------
  VAR
    calls: LONGINT;
    depth, maxDepth: LONGINT;

  PROCEDURE InitStatistics;
  BEGIN (* InitStatistics *)
    calls := 0;
    depth := 0;
    maxDepth := 0;
  END; (* InitStatistics *)

  PROCEDURE WriteStatistics;
  BEGIN (* WriteStatistics *)
    WriteLn('Statistics');
    WriteLn('  Number of calls = ', calls);
    WriteLn('  Max depth       = ', maxDepth);   
    WriteLn('  depth           = ', depth);    
  END; (* WriteStatistics *)

  //-----------------

  function PathsRec(m, n: longint): longint;
  begin
    if ((m = 1) or (n = 1)) then begin
      PathsRec := m + n;
    end else begin
      PathsRec := PathsRec(m-1, n) + PathsRec(m, n-1);
    end;
  end;


  function PathsRec2(m, n: longint): longint;
  begin
    inc(calls);
    inc(depth);
    if depth > maxDepth then
      maxDepth := depth;
    if ((m = 1) or (n = 1)) then begin
      PathsRec2 := m + n;
    end else begin
      PathsRec2 := PathsRec2(m-1, n) + PathsRec2(m, n-1);
    end;
    depth := depth - 1;
  end;



    (* --- Stack --- *)
  CONST 
    max = 1000;
    
  VAR
    a: ARRAY[1..max] OF LONGINT;
    top: INTEGER;
    
  PROCEDURE InitStack;
  BEGIN (* InitStack *)
    top := 0;    
  END; (* InitStack *)
  
  PROCEDURE Push(x: LONGINT);
  BEGIN (* Push *)
    (*assert stack not full*)
    top := top + 1;
    a[top] := x;
  END; (* Push *)
  
  PROCEDURE Pop(VAR x: LONGINT);
  BEGIN (* Pop *)
    (*assert stack not empty*)
    x := a[top];
    top := top - 1;
  END; (* Pop *)
  
  FUNCTION Empty: BOOLEAN;
  BEGIN (* Empty *)
    Empty := top = 0;
  END; (* Empty *)

  (* --- Stack --- *)






  //prep algo for derecursion
  function PathsRec3(m, n: longint): longint;
    var
      p1, p2: LONGINT;
  begin
    //start
    if ((m = 1) or (n = 1)) then begin
      PathsRec3 := m + n;
    end else begin
      p1 := PathsRec3(m-1, n); (*R1 - back from 1. rec call*)
      p2 := PathsRec3(m, n-1); (*R2 - back from 2. rec call*)
      PathsRec3 := p1 + p2;
    end;
  end;


  //derec
  function PathsDerec(m, n: longint): longint;
    CONST
      START = 0;
      R1 = 1;
      R2 = 2;
    var
      p1, p2: longint;
      result: longint;
      lab: longint;
  begin
    InitStack;
    Push(START);
    While (not Empty) do begin
      Pop(lab);
      case lab of
        START: begin
                if (m = 1) or (n = 1)
              end;

        R1: begin
    end;
  end;

  var
    m, n: longint;
  
begin
  InitStatistics;
  Write('m > '); ReadLn(m);
  Write('n > '); ReadLn(n);
  WriteLn(PathsRec2(m, n));
  WriteLn;
  WriteStatistics;
end.