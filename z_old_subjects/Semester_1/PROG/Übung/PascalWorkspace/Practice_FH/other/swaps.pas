(* Swaps:                                                     DA, 2025-10-22 *)
(* ------                                                                    *)
(* swap the value                                                            *)
(* ========================================================================= *)


PROGRAM Swaps;

    PROCEDURE Swap(VAR value1, value2: INTEGER);
        VAR
            h: INTEGER;
    BEGIN
        h := value1;
        value1:= value2;
        value2 := h;
    
    END;

    VAR
        v1, v2: INTEGER;

BEGIN (* Swaps *)
    v1 := 3;
    v2 := 7;
    
    Swap(v1,v2); (*'Aktualparameter: müssen mit den Parametern übereinstimmen - gleicher Datentyp und Speichergröße'*)

    Writeln('Swap result: ', v1, v2);

END. (* Swaps *)