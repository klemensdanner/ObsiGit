#pragma once
#include <string>

struct Point final
{
    int x {};
    int y {};
    Point(int x = 0, int y = 0) : x{x}, y{y} {}
};

struct Size final {
    int width {};
    int height {};
};

class Shape {
public:
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
    // wird das virutal hier von der Basisklassse übernommen?
};
