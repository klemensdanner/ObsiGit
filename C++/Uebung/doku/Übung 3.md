
static: nur innerhalb von file
namespace definieren mti
```
namespace swc3 {
    static int counter = 43;
    static int x = 40;
}
``` 

das :: ist der scope mechanismus
ohne :: nimmt er das aktuelle
mit einfachen :: nimmt er den globalen scope
mit swc3::counter nimmt er einen spezifischen namespace

z.b. std:printf nimmt den namespace std

mit using swc3::x "inportiert" man den namespace
wenn es im globalen scope ein x gibt, ersetzt der compiler das x td durch swc3::x, auf das globale x kann mit ::x zugegriffen werden

static: nur von dem file aus erreichbar

In C++ kann man Funktionen überladen

bei überladenen funktionen:
print(int i);
print(const char* s)

print(0);

char* s kann man auch 0 zuweisen, wird dann als nullptr interpretiert.
deshalb besser mit nullptr aufrufen wenn man den char print aufrufen möchte


---
man kann default werte in funktionsdecl angeben
print(int a = 5);
jetzt kann print() mit parameter oder ohne aufgerufen werden - ohne würde es 5 übernehmen
Interessant bei:
```
print(int a = 5);
print(int a, int b);
``` 
wenn man jetzt print(3) aufruft, welches der beiden wird aufgerufen? -- fehler!


### structs

// geht in C nicht mit Funktionen - man kann aber einen funktionspointer ins struct legen - braucht aber speicher und in c++ nicht
```
struct point {
    int x, y;
    void draw;
}
``` 
definiere die funktion mit
```
void point::draw {
    printf("balbalbal\n");
}
``` 

Werte zuweisen mit:
point p0 {};
p0.draw();

point p = {1, 2}
p.draw


### iostream in c++
```c++
cout << "hello, world!" << endl;
``` 
heißt der string wird in cout gestreamt und ausgegeben


```c++
static void test_iostream() {
    cout << "hello, world!" << endl;
    
    int i = 0;
    char s[10];
    
    cout << "Enter your name";
    cin >> s;
    
    cout << "Number is " << i << "and the string is " << s endl;

}
``` 

### Konstanten
```c++
int const ival 3;
// ival = 4; // geht nicht, const!
int* ivalptr = const_cast<int*>(&ival);
*ivalptr = 4;
// jetzt ist 4 in ival
```


```c++
int* const cpi = 0; // konstanter pointer auf integer
int const * pci; // pointer auf einen konstanten integer
int const * const pci = 3; // konstanter pointer auf einen konstanten integer
``` 

```c++
// gegeben ist ein int* i

*i += 1 // erhöht den int wert
*(i++); // erhöht den pointer und dereferenziert das !! problem

``` 


### call by value
immer call by value aber nice tricks:

```c++
inc_c(int* i) {}
inc_cpp(&int i) {}

// verwendung:
inc_c(&i) // referenz übergeben
inc_cpp(i) // int übergeben, aber übernimmt die referenz
``` 

### strings
std::string s1 {"Klemens"};
auto s2 = std::string {"Danner"};
std::println();
s1 = s2

strings werden kopiert, d.h. z.b. `s1 = s2` kopiert tatsächlich den Inhalt, es wird ein neues string objekt angelegt

s1.clear(); cleard den ersten string, den zweiten nicht
s1.push_back('c'); // fügt c hinten an

es gibt eine insert, an einer bestimmten stelle
-- string
in c++ ist der string NICHT immutable




### pragma
#pragma once macht: 


### structs und klassen
struct: variablen sind by default public
class: var sind by default private

#### Klassen
```c++

namespace swc3 {
    // Person::Person(const ----- anschauen was hier steht in seinem code
}


class Person {
public:
    explicit Person(blablatype name);
    virtual ~Person(); // aktiviert dynamische Bindung; standard erlaubt das nicht --schneller ohne dyn Bindung
    [[nodiscard]] const std::strings& get_name() const; // [[nodiscard]] gibt warning, falls der rückgabewert nicht verwendet wird



private:
    int m_var; // konvention: m für member var
}

``` 

#### Objekte erstellen:

```c++
static void test_person() {
    Person p1 {"p1"};
    Person p2; // default constructer is used

}
``` 

### codeblock
alles was am stack liegt wird nach dem codeblock destroyed - bei Objekten wird dazu der "Destructor" verwendet
wenn es auf dem heap liegt gibts einen memory leak
im destructor gibt man allokierten speicher frei z.B. 
```c++
{
// einfacher codeblock
}
``` 

### Rational Beispiel
mit der friend funktion erlaubt man einer anderen klasse zugriff auf seine eigenen private variablen

// drei varianten anschauen bei operator overloading
private heißt: in gleicher Klasse zugreifen (nicht nur im selben objekt!)

`return *this`: this ist ein Pointer auf das aktuelle Objekt, hier wird es mit dem * dereferenziert.
Oben in der Deklaration kann man verwenden:
`Rational& balbla`: hier ist Rational& der Rückgabewert. mit & wird die Referenz übergeben, ohne & wird der standard copy constructor aufgerufen, kann aber verwendet werden wie das normale Objekt


### konstante Funktionen - ändert den Wert von member-vaiablen nicht
```c++
// nach der funktionsdefinition schreibt man const dazu
// Beispiel:
class Rational {
private:
    int numerator;
    int denominator;

public:
    int getNumerator() const { // wird vom compiler geprüft
        numerator = 10; // compilerfehler - Funktion ist const
        return numerator;
    }
};
```



```c++

``` 


```c++

``` 

