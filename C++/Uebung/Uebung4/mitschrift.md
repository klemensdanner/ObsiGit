### struct vs. class
In einer struct sind datenkomponenten by default public
in einer class private

#### Beispielklasse
```cpp
class Shape {
public: // default mem-vars sind private

    Shape(Point pos = {}, Size size = {}) : m_pos{pos}, m_size{size} {}
    virtual ~Shape() = default; // dynamischer Speicher wird nicht durch den default Konstruktor freigegeben

    [[nodiscard]] Point pos() const { return m_pos; } // nodiscard: Rückgabewert soll nicht ignoriert werden
                                                    // const: nichts in der Klasse wird verändert, nur lesender Zugriff
    [[nodiscard]] Size size() const { return m_size; }

    [[nodiscard]] virtual std::string name() const = 0; // abstrakte methode, standardkonstruktur, damit abgeleitete Klassen diesen aufrufen können
    virtual void setEnd(Point end)
    {
        m_size = end - m_pos; // dazu muss der Operator überschrieben werden
    }
protected:
    Point m_pos {};
    Size m_size {};
};


class Line final : public Shape {// das public übernimmt alle Sichtbarkeiten von der Basisklasse, ansonsten kann man auch mit protected oder private alles einschränken
[[nodiscard]] std::string name() const override { return "line"; }
    // wird das virtual hier von der Basisklassse übernommen?
};
```

Operator überschreiben geht mit:
```cpp
Point operator+(Point p, Size s) {
    return Point {
        // ergebnis von p + s
    }
}
```

wenn vor einem Konstruktor nichts steht, akzeptiert es implizite Aufrufe, ansonsten explicit davor schreiben

### erweiterte For schleife

```cpp
for (const Shape* s : shapes) {
    // iteriert über alle shapes, wenn der iterator dazu vorhanden ist.
}
```

### dynamic casts
```cpp
if (auto e = dynamic_cast<const Oval*>(s)) {
    // wenn s instanceof Oval ist
    // dann bekommt e einen Pointer-Wert von Oval
    // wenn s nicht instanceof Oval ist, wird e null und es wird false
}
```
Warum wird hier const Oval* verwendet? (Pointer auf einen const Oval)
Das Oval wird nicht verändert. Damit man es nicht versehentlich verändert, z.B. mit dem Aufruf einer nicht-const-Methode, verwenden wir const

# Qt
doc.qt.io

graphische overflächen framework for cpp
einfache Speicherverwaltung (wenn Elternobjekt freigegeben wird, werden kindelemente automatisch freigegeben werden)
Meta-Objekt Präprozessor: macht so art Reflections: d.h. man hat zur Laufzeit Metainformationen

alle erben von QObject
```cpp
QWidget w;
QPushButton* b = new QPushButton(&w);
```
QPushButton muss jetzt nicht freigegeben werden, wird automatisch freigegeben, wenn w freigegeben wird

mousePressEvent
signal und slot

Inkludiert wird QApplication und QWidget

Erzeugt wird ein QApplication Objekt (args übergeben)


QMainWindow hat bereits 

```cpp
class DrawWindow final : public QMainWindow {
    Q_OBJECT // Information an den Compiler, Metainformationen zu erhalten
}
```

es gibt mousePressEvent, mouseMoveEvent, mouseReleaseEvent
Es gibt einen qDebug() stream: wenn eine Konsole vorhanden ist, wird sie verwendet, sonst nicht


QWidget w{};
w.setWindowTitle("Meine erste Qt-Anwendung");
w.resize(800, 600);
w.show();

auf methoden und datenkomponenten die teil eines objekts sind, auf die ein pointer existiert, kann man zugreifen durch
`objPtr->methName()` bzw. `objPtr->m_var`


mit QPainter.setMouseTracking(true) im Konstrkutor wird nur bei drüberhovern schon ein mouseMoveEvent angezeigt

einen Cast-Operator kann man überschreiben:
```cpp
Point p;
QPoint q = (QPoint) p; // hier wird der cast-Operator in point aufgerufen
```

QPen, QBrush

setRenderHint(Antialiasing, true); // Kanten wirken dadurch runder


#### Pointer direkt für if verwenden
```cpp
if (ptr) { // nur wenn der !null ist
}
```

mit `update()` kann man dem Framework auftragen, dass es die Methode aufruft, wenn es Zeit hat, es ruft eine Neuzeichnung auf

ShapeType ist eine enum
Q_ENUM(ShapeType): damit kann man zur Laufzeit wissen, welche ShapeType ausgewählt ist



es gibt nicht nur den dynamic_cast<> sondern auch den static_cast<>.
meta.valueToKey(nr) // hier wird die Metainformation ausgenutzt


in addMenu("&Bezeichnung") steht das & dafür, dass sich das menü durch [Alt] + [S] aufruft

qDeleteApp(collection) // Qt helper function: gibt den ganzen speicher in der collection frei

jeder Eintrag im Menü ist ein menu, jeder einzelne dropdown ist direkt mit einer Funktion verbunden, es ist eine QueueAction.
Wenn es mehrere QueueActions gibt, kann man das zu einer QueueActionGroup zusammenfassen

QueueColor
QueueSpinBox (auswahl von zahlen)
QueueColorDialogue

man setzt manues, slots und dann connectet man welche Methode aufgerufen wird (mittels funktionspointer)

```cpp

```
```cpp

```
