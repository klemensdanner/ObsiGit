```pascal

Checkvalue(value, timestamp: integer): bool;

static var
	preTimestamp: integer := timestamp; //funktioniert aber nicht schön
	preValue: real := value;

if |(value-preValue)/(timestamp-preTimestamp)| <= 2 then
	preValue := value;
	preTimestamp := timestamp;
	Checkvalue := true;
else
	preValue := value;
	preTimestamp := timestamp;
	Checkvalue := false;
```


```pascal
Checkvalue(value, timestamp: integer): bool;

static var
	preTimestamp: integer := 0; //besser, weil manchmal solche Variablen schon am Programmbeginn deklariert werden, welche da aber noch keinen Wert haben
	preValue: real := 0;

begin
	if preTimestamp = 0 then
		preValue := value
		preTimeStamp := timestamp
		return true
	else

		if |(value-preValue)/(timestamp-preTimestamp)| <= 2 then
			preValue := value;
			preTimestamp := timestamp;
			Checkvalue := true;
		else
			preValue := value;
			preTimestamp := timestamp;
			Checkvalue := false;
	
end.
```