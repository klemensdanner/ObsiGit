(* SortPgm:                                                   DA, 2025-01-08 *)
(* ------                                                                    *)
(* Some sorting algorithms and their comparison:                             *)
(*                                                                           *)
(* ========================================================================= *)
PROGRAM SortPgm;

  USES
    Timer;

  CONST
    maxArrayLen = 10000;

  TYPE
    ArrayType = ARRAY[1..maxArrayLen] OF INTEGER;

    SortStatistics = RECORD
      comp: LONGINT;  (*number of comparisons*)
      ass: LONGINT;   (*number of assignments*)
    END; (* SortStatistics *)    

  VAR
    statistics: SortStatistics; 

  (* --- Helpers to provide statistics --- *)
  PROCEDURE InitSortStatistics;
  BEGIN (* InitSortStatistics *)
    statistics.comp := 0;
    statistics.ass := 0;    
  END; (* InitSortStatistics *)

  PROCEDURE WriteSortStatisticsHeader;
  BEGIN (* WriteSortStatisticsHeader *)
    WriteLn('                           ascending order                      decending order                          random ');
    WriteLn('              |     comps   assignments    time     |     comps   assignments    time     |     comps   assignments    time');   
    WriteLn('-------------------------------------------------------------------------------------------------------------------------------------');
  END; (* WriteSortStatisticsHeader *)

  PROCEDURE WriteSortStatisticsFirst(name: STRING);
  BEGIN (* WriteSortStatisticsFirst *)
    Write(name, '|', statistics.comp: 12, statistics.ass:12, '   ', ElapsedTime);   
  END; (* WriteSortStatisticsFirst *)

  PROCEDURE WriteSortStatistics;
  BEGIN (* WriteSortStatistics *)
    Write('  |', statistics.comp: 12, statistics.ass:12, '   ', ElapsedTime);   
  END; (* WriteSortStatistics *)

  PROCEDURE Swap(VAR a, b: INTEGER);
    VAR
      h: INTEGER;
  BEGIN (* Swap *)
    h := a;
    a := b;
    b := h;
    statistics.ass := statistics.ass + 3;
  END; (* Swap *)

  FUNCTION LT(v1, v2: INTEGER): BOOLEAN; (*less than*)
  BEGIN (* LT *)
    LT := v1 < v2;
    statistics.comp := statistics.comp + 1;
  END; (* LT *)

  FUNCTION GT(k1, k2: INTEGER): BOOLEAN; (*greater than*)
  BEGIN (* GT *)
    GT := k1 > k2;
    statistics.comp := statistics.comp + 1;
  END; (* GT *)

  PROCEDURE Assign(VAR dest: INTEGER; src: Integer);
  BEGIN (* Assign *)
    dest := src;
    statistics.ass := statistics.ass + 1;    
  END; (* Assign *)

  (* --- Helpers to generate test data --- *)
  CONST
    range = 2000;  (* range for random test data generation *)

  TYPE
    OrderType = (randomOrder, ascOrder, descOrder);

  PROCEDURE FillArray(order: OrderType; VAR a: ArrayType; n: INTEGER);
    VAR
      i: INTEGER;
  BEGIN (* FillArray *)
    CASE order OF
      randomOrder:
        FOR i:= 1 TO n DO BEGIN
          a[i] := Random(range);
        END; (* FOR *)
      ascOrder:
        FOR i:= 1 TO n DO BEGIN
          a[i] := i;
        END; (* FOR *)      
      descOrder:
        FOR i:= 1 TO n DO BEGIN
          a[i] := n-i;
        END; (* FOR *)      
    END; (* CASE *)
  END; (* FillArray *)

  (* -------------------------- *)  
  (* --- Sorting algorithms --- *)
  (* -------------------------- *) 

  
  (* --------------------------------------------------------------------------*) 
  (* SelectionSort: instable, O(n²)                                           *)
  (* --------------------------------------------------------------------------*) 
  PROCEDURE SelectionSort(VAR a: ArrayType; lft, rgt: INTEGER);
    var
      i, j, minPos, minKey: integer;
  BEGIN (* XxxSort *)
    for i := lft to rgt - 1 do begin
      minPos := i;
      minKey := a[minPos];
      for j := i + 1 to rgt do begin
        if LT(a[j], minKey) then begin
          minPos := j;
          minKey := a[minPos];
        end;
      end;
      Swap(a[i], a[minPos]);
    end;
  END; (* XxxSort *)
  
  (* --------------------------------------------------------------------------*) 
  (* SelectionSort: stable, O(n²)                                              *)
  (* --------------------------------------------------------------------------*) 
  procedure InsertionSort(var a: ArrayType; lft, rgt: integer);
    var
      i, j: integer;
      h: integer; //temp for curr value
  begin
    for i := lft to rgt - 1 do begin
      Assign(h, a[i + 1]);
      j := i;
      while (j >= lft) and (LT(h, a[j])) do begin
        //a[j + 1] := a[j];
        Assign(a[j + 1], a[j]);
        dec(j);
      end;
      //a[j + 1] := h;
      Assign(a[j + 1], h);
    end;
  end;


  (* --------------------------------------------------------------------------*) 
  (* ShellSort: unstable, O(n^1.226) acc to Shell                              *)
  (* --------------------------------------------------------------------------*) 
  procedure ShellSort(var a: ArrayType; lft, rgt: integer);
    var
      i, j: integer;
      h, n, m: integer; //temp for curr value
  begin
    n := rgt - lft + 1;
    m := n div 2; // step size

    while (m > 0) do begin
      for i := lft to rgt - m do begin
        Assign(h, a[i + m]);
        j := i;
        while (j >= lft) and (LT(h, a[j])) do begin
          //a[j + 1] := a[j];
          Assign(a[j + m], a[j]);
          j := j - m;
        end;
        //a[j + 1] := h;
        Assign(a[j + m], h);
      end;
      m := m div 2;
    end;
  end;


  procedure BubbleSort(var a: ArrayType; lft, rgt: integer);
    var
      i, j: integer;
  begin
    for i := rgt downto lft+1 do begin
      for j := lft to i-1 do begin
        if GT(a[j], a[j + 1]) then begin
          Swap(a[j], a[j + 1]);
        end;
      end;
    end;
  end;


  procedure QuickSort(var a: ArrayType; lft, rgt: integer);
    procedure Partition(l, r: integer);
      var
        i, j: integer;
        mKey: integer;
    begin
      i := l;
      j := r;
      mKey := a[(l + r) div 2]; //mittlerer Wert, hoffentlich in der Mitte
      repeat
        while LT(a[i], mKey) do begin
          inc(i);
        end;
        while LT(mKey, a[j]) do begin
          dec(j);
        end;
        if i <= j then begin
          if i <> j then begin
            Swap(a[i], a[j]);
          end;
          inc(i);
          dec(j);
        end;
      until (i > j);

      if (l < j) then begin
        Partition(l, j);
      end;
      if (i < r) then begin
        Partition(i, r);
      end;
    end;
  begin
    Partition(lft, rgt);
  end;


{
  procedure ShellSort2(var a: ArrayType; lft, rgt: integer);
    var
      i, j: integer;
      h, n, m: integer; //temp for curr value
  begin
    n := rgt - lft + 1;
    m := n div 2; // step size

    while (m > 0) do begin
      for i := lft to rgt - m do begin
        Assign(h, a[i + m]);
        j := i;
        while (j >= lft) and (LT(h, a[j])) do begin
          //a[j + 1] := a[j];
          Assign(a[j + m], a[j]);
          j := j - m;
        end;
        //a[j + 1] := h;
        Assign(a[j + m], h);
      end;
      m := m div 3;
    end;
  end;}


  VAR
    a: ArrayType;

BEGIN (* SortPgm *)

  WriteLn('Comparison of sorting algorithms on array with ', maxArrayLen, ' elements');
  WriteLn('================================'); WriteLn;

  WriteSortStatisticsHeader;

  (* --------------------- *)  
  (* --- SelectionSort --- *)
  (* --------------------- *)  

  (* test data sorted in ascending order *) 
  InitSortStatistics;
  FillArray(ascOrder, a, maxArrayLen);
  StartTimer;
  SelectionSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatisticsFirst('SelectionSort');  (* Namenslänge - 14 Zeichen *)

  (* test data sorted in descending order *)
  InitSortStatistics;
  FillArray(descOrder, a, maxArrayLen);
  StartTimer;
  SelectionSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatistics; 

  (* test data not sorted - random order *)
  InitSortStatistics;
  FillArray(randomOrder, a, maxArrayLen);
  StartTimer;
  SelectionSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatistics; 
  WriteLn;





  (* test data sorted in ascending order *) 
  InitSortStatistics;
  FillArray(ascOrder, a, maxArrayLen);
  StartTimer;
  InsertionSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatisticsFirst('InsertionSort');  (* Namenslänge - 14 Zeichen *)

  (* test data sorted in descending order *)
  InitSortStatistics;
  FillArray(descOrder, a, maxArrayLen);
  StartTimer;
  InsertionSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatistics; 

  (* test data not sorted - random order *)
  InitSortStatistics;
  FillArray(randomOrder, a, maxArrayLen);
  StartTimer;
  InsertionSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatistics; 
  WriteLn;
 







   (* test data sorted in ascending order *) 
  InitSortStatistics;
  FillArray(ascOrder, a, maxArrayLen);
  StartTimer;
  ShellSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatisticsFirst('ShellSort');  (* Namenslänge - 14 Zeichen *)

  (* test data sorted in descending order *)
  InitSortStatistics;
  FillArray(descOrder, a, maxArrayLen);
  StartTimer;
  ShellSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatistics; 

  (* test data not sorted - random order *)
  InitSortStatistics;
  FillArray(randomOrder, a, maxArrayLen);
  StartTimer;
  ShellSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatistics; 
  WriteLn;
  WriteLn;



     (* test data sorted in ascending order *) 
  InitSortStatistics;
  FillArray(ascOrder, a, maxArrayLen);
  StartTimer;
  BubbleSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatisticsFirst('BubbleSort');  (* Namenslänge - 14 Zeichen *)

  (* test data sorted in descending order *)
  InitSortStatistics;
  FillArray(descOrder, a, maxArrayLen);
  StartTimer;
  BubbleSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatistics; 

  (* test data not sorted - random order *)
  InitSortStatistics;
  FillArray(randomOrder, a, maxArrayLen);
  StartTimer;
  BubbleSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatistics; 
  WriteLn;
  WriteLn;






  
     (* test data sorted in ascending order *) 
  InitSortStatistics;
  FillArray(ascOrder, a, maxArrayLen);
  StartTimer;
  QuickSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatisticsFirst('QuickSort');  (* Namenslänge - 14 Zeichen *)

  (* test data sorted in descending order *)
  InitSortStatistics;
  FillArray(descOrder, a, maxArrayLen);
  StartTimer;
  QuickSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatistics; 

  (* test data not sorted - random order *)
  InitSortStatistics;
  FillArray(randomOrder, a, maxArrayLen);
  StartTimer;
  QuickSort(a, 1, maxArrayLen);
  StopTimer;
  WriteSortStatistics; 
  WriteLn;
  WriteLn;

END. (* SortPgm *)