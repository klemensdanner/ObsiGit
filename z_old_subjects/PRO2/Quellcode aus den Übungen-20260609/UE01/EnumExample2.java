enum DayOfWeek { MON, TUE, WED, THU, FRI, SAT, SUN };

boolean isWeekend(DayOfWeek d) {
    return (d == DayOfWeek.SAT) || (d == DayOfWeek.SUN);
}

DayOfWeek nextDay(DayOfWeek d) {
    switch (d) {
        case DayOfWeek.MON: return DayOfWeek.TUE;
        case DayOfWeek.TUE: return DayOfWeek.WED;

        //...
        default: return DayOfWeek.MON;
    }

}

void main() {

    for (DayOfWeek d = DayOfWeek.MON; d != DayOfWeek.SAT; d = nextDay(d)) {
       // ...
    }

}
