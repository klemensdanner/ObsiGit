
```dataviewjs
// 1. Konfiguration: Ordner anpassen!
const folder = '"_DailyNotes"'; 

// --- HILFSFUNKTIONEN & INITIALISIERUNG ---

// Berechne das Datum des letzten Montags (Start der Woche) um 00:00 Uhr
const today = new Date();
const dayOfWeek = today.getDay(); // 0 (So) - 6 (Sa)
// Wir wollen den Montag (1). Wenn heute Sonntag (0) ist, müssen wir 6 Tage zurück.
// Wenn heute Montag (1) ist, 0 Tage zurück.
const diffToMonday = (dayOfWeek + 6) % 7; 
const lastMonday = new Date(today);
lastMonday.setDate(today.getDate() - diffToMonday);
lastMonday.setHours(0, 0, 0, 0);

// Container für die Zeiten
let projectTimesTotal = {}; 
let projectTimesWeekly = {};
let totalTimeGlobal = 0;
let totalTimeWeekly = 0;

// 2. Alle Seiten aus dem Ordner holen (außer der aktuellen)
const pages = dv.pages(folder).where(p => p.file.name != dv.current().file.name);

// 3. Durch alle Dateien loopen
await Promise.all(pages.map(async (page) => {
    const content = await dv.io.load(page.file.path);
    const regex = /```timekeep\s*([\s\S]*?)\s*```/g;
    let match;
    
    while ((match = regex.exec(content)) !== null) {
        const jsonString = match[1];
        try {
            const data = JSON.parse(jsonString);
            if (data.entries) {
                data.entries.forEach(entry => {
                    
                    // Hilfsfunktion zum Buchen der Zeit auf ein Projekt
                    const addTime = (projName, durationMs, startTimeIso) => {
                        if (durationMs <= 0) return;

                        // 1. Gesamtzeit buchen
                        if (!projectTimesTotal[projName]) projectTimesTotal[projName] = 0;
                        projectTimesTotal[projName] += durationMs;
                        totalTimeGlobal += durationMs;

                        // 2. Wochenzeit buchen (nur wenn Startzeit >= letzter Montag)
                        if (startTimeIso) {
                            const entryDate = new Date(startTimeIso);
                            if (entryDate >= lastMonday) {
                                if (!projectTimesWeekly[projName]) projectTimesWeekly[projName] = 0;
                                projectTimesWeekly[projName] += durationMs;
                                totalTimeWeekly += durationMs;
                            }
                        }
                    };

                    // A) Prüfen, ob es Untereinträge (subEntries) gibt
                    if (entry.subEntries && Array.isArray(entry.subEntries) && entry.subEntries.length > 0) {
                        entry.subEntries.forEach(sub => {
                            if (sub.startTime && sub.endTime) {
                                let dur = (new Date(sub.endTime) - new Date(sub.startTime));
                                addTime(entry.name, dur, sub.startTime);
                            }
                        });
                    } 
                    // B) Falls keine Untereinträge, nimm die Hauptzeit
                    else if (entry.startTime && entry.endTime) {
                        let dur = new Date(entry.endTime) - new Date(entry.startTime);
                        addTime(entry.name, dur, entry.startTime);
                    }
                });
            }
        } catch (e) {
            console.error("Fehler beim Parsen in: " + page.file.name, e);
        }
    }
}));

// 4. Formatierung (ms -> Stunden:Minuten)
function formatDuration(ms) {
    if (!ms) return "0h 00m";
    const totalMinutes = Math.floor(ms / 60000);
    const hours = Math.floor(totalMinutes / 60);
    const minutes = totalMinutes % 60;
    const minutesStr = minutes < 10 ? "0" + minutes : minutes;
    return `${hours}h ${minutesStr}m`;
}

// 5. Tabelle bauen
// Wir holen alle Projektnamen, die entweder in Total oder Weekly vorkommen
const allProjects = new Set([
    ...Object.keys(projectTimesTotal), 
    ...Object.keys(projectTimesWeekly)
]);

let tableData = Array.from(allProjects).map(project => {
    const weekly = projectTimesWeekly[project] || 0;
    const total = projectTimesTotal[project] || 0;
    return [project, formatDuration(weekly), formatDuration(total), total]; // total als 4. Wert zum Sortieren
});

// Sortieren (meiste Gesamtzeit oben)
tableData.sort((a, b) => {
    return b[3] - a[3]; // Sortieren nach dem rohen Millisekunden-Wert (Index 3)
});

// Bereinigte Daten für die Anzeige (Index 3 entfernen)
const displayData = tableData.map(row => [row[0], row[1], row[2]]);

// 6. Ausgabe
dv.header(2, "Arbeitszeit-Übersicht");

// Zusammenfassung oben
dv.paragraph(`
**Seit Montag:** ${formatDuration(totalTimeWeekly)}  
**Gesamt:** ${formatDuration(totalTimeGlobal)}
`);

dv.table(["Projekt / Fach", "Seit Montag", "Gesamt"], displayData);
```


### ⚒️ Arbeitszeit (7 Tage)

```tracker
searchType: frontmatter
searchTarget: Arbeitszeit
folder: _DailyNotes
startDate: -7d
endDate: 0d
line:
    title: "Stunden pro Tag"
    yAxisLabel: "h"
    lineColor: "#7f5af0"
    showPoint: true
    xAxisTickLabelFormat: "dd"

```

### Rückentraining (7 Tage)
```tracker
searchType: frontmatter
searchTarget: Rückentraining
folder: _DailyNotes
startDate: -7d
endDate: 0d
bar:
    title: "Erledigt (Boolean)"
    yAxisLabel: "Status"
    barColor: "#2cb67d"
    yMin: 0
    yMax: 1
    xAxisTickLabelFormat: "dd"
```

### Schlafzeit (7 Tage)

```tracker
searchType: frontmatter
searchTarget: Schlafzeit
folder: _DailyNotes
startDate: -7d
endDate: 0d
line:
    title: "Stunden pro Tag"
    yAxisLabel: "h"
    lineColor: "#7f5af0"
    showPoint: true
    xAxisTickLabelFormat: "dd"

```

### Handy Screenon Time (7 Tage)
```tracker
searchType: frontmatter
searchTarget: HandyScreenOn
folder: _DailyNotes
startDate: -7d
endDate: 0d
line:
    title: "Stunden pro Tag"
    yAxisLabel: "h"
    lineColor: "#7f5af0"
    showPoint: true
    xAxisTickLabelFormat: "dd"
```
