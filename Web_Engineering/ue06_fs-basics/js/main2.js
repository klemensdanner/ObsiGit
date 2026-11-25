'use strict'; // verhindert manchmal unsauberen code?
// zum Beispiel wenn man Variablen falsch verwendet, vorher nicht deklariert
// das funktioniert ist aber nicht sauber, mit 'use strict' bekommt man eine warnung



function ctValues() {
        let ct = new Array(10).fill(0);
        while (true) {
                let value = Number(prompt("Enter your first value"));
                if (value == -1) {
                        console.log(ct);
                        return;
                }
                if ((value < 0) || (value > 9) || (value == NaN)) {
                        console.log("Enter a value between 0 and 9");
                }
                ct[value]++;
        }

}

ctValues();