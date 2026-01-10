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

  (* ------------------------------------------------------------ *)
  (* --- Derecursivation of recursive algorithm using a stack --- *)
  (* ------------------------------------------------------------ *)

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