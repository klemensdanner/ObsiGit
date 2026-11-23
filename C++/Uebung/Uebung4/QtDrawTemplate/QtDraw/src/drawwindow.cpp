#include "drawwindow.h"

#include <QApplication>
#include <QWidget>

int main (int argc, char* argv[])
{
    QApplication a  {argc, argv};
    QWidget w{};
    qDebug() << "drawwindow";
    w.setWindowTitle("Meine erste Qt-Anwendung");
    w.resize(800, 600);
    w.show();

    return a.exec();
}