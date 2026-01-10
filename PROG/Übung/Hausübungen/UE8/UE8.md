# 1 Laufzeitkomplexität




|                                                                                                                                                                                                                                                    |     |     |     |     |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- | --- | --- | --- |
| ``` pascal<br>FUNCTION SumSquares1(a, b: LONGINT): LONGINT;<br>	VAR<br>		sum, i: LONGINT;<br>BEGIN<br>	sum := 0;<br>	FOR i := a TO b DO BEGIN<br>		sum := sum + i * i;<br>	END; (* FOR *)<br>	SumSquares1 := sum;<br>END; (* SumSquares1 *)<br>``` |     |     |     |     |

``` pascal
FUNCTION SumSquares1(a, b: LONGINT): LONGINT;
	VAR
		sum, i: LONGINT;
BEGIN
	sum := 0;
	FOR i := a TO b DO BEGIN
		sum := sum + i * i;
	END; (* FOR *)
	SumSquares1 := sum;
END; (* SumSquares1 *)
```


| Code                                                                                                                         |                                                                                                                              |
| ---------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| <pre><code>FUNCTION SumSquares1(a, b: LONGINT): LONGINT;<br>VAR<br>  sum, i: LONGINT;<br>BEGIN<br>  ...<br>END;</code></pre> | <pre><code>FUNCTION SumSquares1(a, b: LONGINT): LONGINT;<br>VAR<br>  sum, i: LONGINT;<br>BEGIN<br>  ...<br>END;</code></pre> |
|                                                                                                                              |                                                                                                                              |



| FUNCTION SumSquares1(a, b: LONGINT): LONGINT;<br>	VAR<br>		sum, i: LONGINT;<br>BEGIN<br>	sum := 0;<br>	FOR i := a TO b DO BEGIN<br>		sum := sum + i \* i;<br>	END; (\* FOR \*)<br>	SumSquares1 := sum;<br>END; (\* SumSquares1 \*) |     |     |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- | --- |
|                                                                                                                                                                                                                                    |     |     |



In Abhängigkeit von Problemgröße n:

| FUNCTION SumSquares1(a, b: LONGINT): LONGINT; | Anz. | Gewicht |     |
| --------------------------------------------- | ---- | ------- | --- |
| &nbsp;&nbsp;VAR<br>                           |      |         |     |
| &nbsp;&nbsp;&nbsp;&nbsp;sum, i: LONGINT;      |      |         |     |
| BEGIN                                         |      |         |     |
| &nbsp;&nbsp;sum := 0;                         | 1    | 1       |     |
| &nbsp;&nbsp;FOR i := a TO b DO BEGIN          |      |         |     |
| &nbsp;&nbsp;&nbsp;&nbsp;sum := sum + i * i;   |      |         |     |
| &nbsp;&nbsp;END;                              |      |         |     |
| &nbsp;&nbsp;SumSquares1 := sum                |      |         |     |
| END;                                          |      |         |     |


| FUNCTION SumSquares1(a, b: LONGINT): LONGINT; | Anz. | Gewicht |     |
| --------------------------------------------- | ---- | ------- | --- |
| &nbsp;&nbsp;VAR<br>                           |      |         |     |
| &nbsp;&nbsp;&nbsp;&nbsp;sum, i: LONGINT;      |      |         |     |
| BEGIN                                         |      |         |     |
| &nbsp;&nbsp;sum := 0;                         | 1    | 1       |     |
| &nbsp;&nbsp;WHILE                             |      |         |     |
| &nbsp;&nbsp;&nbsp;&nbsp;sum := sum + i * i;   |      |         |     |
| &nbsp;&nbsp;END;                              |      |         |     |
| &nbsp;&nbsp;SumSquares1 := sum                |      |         |     |
| END;                                          |      |         |     |