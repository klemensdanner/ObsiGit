'use strict'; // verhindert manchmal unsauberen code?
// zum Beispiel wenn man Variablen falsch verwendet, vorher nicht deklariert
// das funktioniert ist aber nicht sauber, mit 'use strict' bekommt man eine warnung


function helloWorld() {
        console.log('Hello world');
        // alert("Hello world");
        // document.write("Hello world1"); // wird einfach in das Dokument reingeschrieben
}

helloWorld();

// Variablen
let x = 10; // das ist eine globale variable, der Bereich ist alle scripts die in html inkludiert wurden
        // wenn es mehrere x gibt kommt fehler 'has already been declared'
console.log(x);

// Datentypen
let y;
console.log(typeof y); // undefined
y = 17;

console.log(typeof y); // number
y="Servus";

console.log(typeof y); // string


// Scopes


function f1() {
        let y = "Test";
        console.log(x);
}

function changeGlobalY() {

}

console.log(x);
f1();

x = 17;
// temporary death zone
function testTempDeathZone() {
        console.log(x); // Fehler: cannot access x before initialisation
                        // obwohl es global ein x gibt
                        // d.h. er sucht zuerst im lokalen scope nach einem x und deklariert das.
                        // dann beginnt er oben mit der Ausführung. das x ist beim zweiten Durchlauf also deklariert
                        // aber nicht initialisiert -- daher die Fehlermeldung
                        // das nennt man temporary death zone
        let x = 18;
        console.log(x);
}

// prompt -- etwas einlesen
let e1 = Number(prompt("Enter your first value"));
let e2 = Number(prompt("Enter your second value"));

if (Number.isInteger(e1, e2)) {
        let sum = e1 + e2;
        console.log(sum);
} else {
        console.log('geht net chef');
}


let a = 5;
let b = "5";
console.log(a == b); // true -- value ist gleich, versucht umzuwandeln
console.log(a === b); // false -- prüft zuerst den typ


// Vergleichsoperatoren
console.log("13" < "5"); // true, weil lexikographisch verglichen wird
// ansonsten, falls die typen nicht gleich ist, wird versucht, alles in eine number umzuwandeln
console.log("5" == 5); //  gibt also true;


let s = "Servus";
// s ist true wenn s ein gültiger string ist:
if (s) {
        console.log("s ist ein gültiger string");
} else {
        console.log("s ist kein gültiger string");
}



// template string, um auf variablen zugreifen zu können
let s2 = "Test";

let div = `
        <div>
                <p>${s2}</p>
        </div>`;


// funktionen auf strings (strings sind objekte in js)
console.log('johannes'.includes('han')); // true


// arrays
// let a = []; ??
let ab = new Array(10).fill(0);
let arr = [1, 2, 3, 4, 5];
console.log(arr);

console.log(arr[2]);
arr.push(6);
console.log(arr);
arr[6] = 'Hannes'; // Zuweisung außerhalb de bounds, kein problem

// Schleifen
for (let i = 0; i < arr.length; i++) {
        console.log(arr[i]);
}


// arr.forEach nimmt eine Funktion als Parameter. das unten ist eine anonyme funktion, die jeden value nimmt und den printet
// übergabe erfolgt call by value, d.h. änderungen an val werden nicht ins array übernommen
arr.forEach(function(val) {
        console.log(val);
})


let arr2 = arr.map(function(val) {
        return val.toUpperCase();
})

console.log(arr2);

// let keyValMap[] = // anschauen


let obj = {
        key1: "value1",
        "key 2": "value2"
};
let z = {...obj}; // kopiert das Objekt; das ... splittet es auf in die einzelnen Elemente und legt durch die {} wieder ein Objekt an

// functions
function add(x, y) {
        return x + y;
}

function add(x, y, z, ...args) {
        function add2(x, y) { // innere Funktion, innerhalb des scopes
                return x + y;
        }
        console.log("Fct2");
        console.log(arguments); // alle Werte
        console.log(args);
        return x + y + z;
}

let func = function add2(a, b) {
        return a + b;
}


console.log(add(1, 2));
console.log(add("1", "2")); // das gibt den string "12"
console.log(add(1)); //  NaN, intern ist das y undefined
console.log(add(1, 2, 3));


// zahlen zwischen 0 und 9 engeben, 

// schleife, wenn -1 dann aufhören
// wenn außerhalb bereich, aufforderung in den wertebereich
// sonst mitzählen wie oft (im array)

function ctValues() {
        let ct = new Array(10).fill(0);
        while (true) {
                let value = Number(prompt("Enter your first value"));
                if (value == -1) {
                        console.log(ct);
                        return;
                }
                if ((value < 0) || (value > 9)) {
                        console.log("Enter a value between 0 and 9");
                }
                ct[value]++;
        }

}

ctValues();