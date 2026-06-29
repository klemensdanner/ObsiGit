# Betriebsüberleitungsbogen (BÜB)

> **Zweck:** Überführung Aufwand lt. GuV → Kosten (KLR)

---

## Schema

| Konto | Aufwand lt. GuV | Abgrenzung (+) | Abgrenzung (−) | Kosten | Kostenart |
|-------|:---------------:|:--------------:|:--------------:|:------:|-----------|
| Fertigungsmaterial | | | | | Fertigungsmaterial |
| Personal | | | | | LGK |
| Abschreibungen Gebäude | | | | | kalk. Abschreibung |
| Abschreibungen Maschinen | | | | | kalk. Abschreibung |
| Werbung | | | | | Werbekosten |
| Forderungsausfälle | | | | | kalk. Wagnisse |
| Instandhaltung | | | | | Instandhaltungskosten |
| Rest sonstiger Aufwand | | | | | sonstige Kosten |
| Zinsen | | | | | kalk. Zinsen |
| Außerordentlicher Aufwand | | | | | — |
| **Summe Aufwand / Summe Kosten** | **Σ** | **Σ** | **Σ** | **Σ** | |

```
Kosten = Aufwand + Abgrenzung (+) − Abgrenzung (−)
```

---

## Korrekturschritte

| # | Schritt | Ebene | Wirkung |
|:-:|---------|-------|---------|
| **1** | **Betriebliche Abgrenzung** — neutralen Aufwand ausscheiden (betriebsfremd, außerordentlich) | Mengenebene | Abgrenzung (−) |
| **2** | **Zeitliche Abgrenzung** — periodenfremden Aufwand ausscheiden | Zeitebene | Abgrenzung (−) |
| **3** | **Normalisierung** — ungleichmäßiger Anfall → Durchschnittswerte | Mengenebene | Abgrenzung (−) / (+) |
| **4** | **Umwertung** — Anschaffungswerte → Wiederbeschaffungswerte | Wertebene | Abgrenzung (+)  |
| **5** | **Zusatzkosten** — in GuV nicht enthaltene Kosten ergänzen | Wertebene | Abgrenzung (+) |

---

## Arten der Kosten nach BÜB-Korrektur

| Art | Bedeutung | BÜB-Behandlung |
|-----|-----------|----------------|
| **Aufwandsgleiche Kosten** | Aufwand = Kosten (keine Korrektur) | Abgrenzung = 0 |
| **Anderskosten** | Aufwand ungleich Kosten (Umwertung / Normalisierung) | Abgrenzung (±) vorhanden |
| **Zusatzkosten** | Kein Aufwand in GuV, aber Kosten in KLR | Nur Abgrenzung (+), Aufwand = 0 |

---

## Zusatzkosten (Standard-Positionen)

| Zusatzkostenart | Beschreibung | Siehe |
|-----------------|--------------|-------|
| Kalk. Unternehmerlohn | Opportunitätskosten der Arbeitsleistung des Unternehmers | [[02_Kalkulatorische_Kostenarten#Kalk. Unternehmerlohn\|Kalk. Unternehmerlohn]] |
| Kalk. Zinsen (auf EK) | Opportunitätskosten des Eigenkapitals | [[02_Kalkulatorische_Kostenarten#Kalk. Zinsen\|Kalk. Zinsen]] |
| Kalk. Miete | Fiktive Miete für eigene Räumlichkeiten | — |
| Kalk. Wagnisse | Durchschnittliche Risikokosten | [[02_Kalkulatorische_Kostenarten#Kalk. Wagnisse\|Kalk. Wagnisse]] |

---

## Kalkulatorische Kostenarten — Überleitung FiBu → KLR

| Kalk. Kostenart | FiBu-Wert | Korrektur (Wert/Menge/Zeit) | KLR-Wert | Siehe |
|-----------------|-----------|-----------------------------|----------|-------|
| **Kalk. Abschreibung** | AfA lt. FiBu (AW / steuerl. ND) | Umwertung (WBW statt AW) + Normalisierung (tats. ND statt steuerl. ND) | (WBW − RW) / ND | [[02_Kalkulatorische_Kostenarten#Kalk. Abschreibung\|Kalk. Abschreibung]] |
| **Kalk. Zinsen** | FK-Zinsen lt. GuV | Vollständige Ausscheidung + kalk. Zinsen auf Gesamtkapital | betriebsnotw. Kapital × i | [[02_Kalkulatorische_Kostenarten#Kalk. Zinsen\|Kalk. Zinsen]] |
| **Kalk. Unternehmerlohn** | 0 (nicht in GuV) | Zusatzkosten | Vergleichsgehalt + Zuschlag | [[02_Kalkulatorische_Kostenarten#Kalk. Unternehmerlohn\|Kalk. Unternehmerlohn]] |
| **Kalk. Wagnisse** | Ist-Verluste lt. GuV | Normalisierung (Ø statt Ist) + Umfangskorrektur | Wagnissatz × Bezugsgröße | [[02_Kalkulatorische_Kostenarten#Kalk. Wagnisse\|Kalk. Wagnisse]] |
