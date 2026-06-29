# Stundensatzkalkulation

> **Zweck:** Berechnung des Kosten-Stundensatzes (Selbstkosten je Stunde) für Verrechnung an Kunden.

---

## Block 1 — Jahreskosten / Mitarbeiter

| Position | pro Monat | pro Jahr | % / Formel |
|----------|:---------:|:--------:|------------|
| **Bruttogehalt** (Monatsbrutto) | BG | BG × 12 | |
| + Urlaubs- und Weihnachtsremuneration (UG + WR) | + BG / 6 | + BG × 2 | ⅙ = 13./14. Gehalt aliquot |
| = **Monatsentgelt (durchschnittlich)** | BG × 7/6 | BG × 14 | |
| + Gehaltsnebenkosten (SV-DGA, DB, DZ, KommSt, …) | + ≈30 % × ME | + ≈30 % × ME × 12 | ≈ 30 % des Monatsentgelts |
| = **Kosten Einkommen pro Monat (Brutto-Brutto)** [0] | **ME + NK** | **[0] × 12** | |

| | | | |
|----------|:---------:|:--------:|------------|
| + Fortbildungskosten | | + FB | p. a., anteilig |
| + Reise- u. Fahrspesen (nicht verrechenbar) | | + RF | p. a., anteilig |
| = **Direkte mitarbeiterbezogene Kosten pro Monat** **[1]** | **[1]** | **[1] × 12** | |

| | | | |
|----------|:---------:|:--------:|------------|
| + Kalk. Abschreibung | | + kA | p. a., anteilig, [[02_Kalkulatorische_Kostenarten#Kalk. Abschreibung\|Kalk. Abschreibung]] |
| + Kalk. Zinsen | | + kZ | p. a., anteilig, [[02_Kalkulatorische_Kostenarten#Kalk. Zinsen\|Kalk. Zinsen]] |
| + Kalk. Miete | | + kM | p. a., anteilig (Arbeitsplatz) |
| + Sonstige Kosten (Verwaltung, Vertrieb) | | + SoKo | p. a., anteilig |
| = **Summe sonstige Kosten pro Monat** **[2]** | **[2]** | **[2] × 12** | |

| | |
|----------|:--------:|
| **Monatskosten gesamt = [1] + [2]** | **[3]** |
| + Kalk. Wagnis (% von [3]) | + w % × [3] |
| = **Kalk. monatliche Kosten eines Mitarbeiters** | **[3] + Wagnis** |
| × 12 | × 12 |
| = **Kalk. Jahreskosten [A]** | **[A]** |

---

## Block 2 — Verrechenbare Stunden

| Position | Std / Tag | Tage | Wochen | Stunden | Formel |
|----------|:---------:|:----:|:-----:|:-------:|--------|
| Durchschnittliche Arbeitsstunden | 8 | | 52 | **2.080** | 40 × 52 |
| − Urlaub | 8 | 25 | | −200 | |
| − Krankheitstage | 8 | 8 | | −64 | Ø-Wert |
| − Sonstige Dienstverhinderung | 8 | 10 | | −80 | Schulungen, etc. |
| = **Verfügbare Stunden** | | | | **1.736** | |
| − Zusätzlicher nicht verrechenbarer Zeitaufwand | | | | −100 | Rüsten, Admin, interne Tätigkeiten |
| = **Verrechenbare Stunden bei Vollauslastung [B]** | | | | **[B]** | |
| *Anteil in %* | | | | *[B] / 2.080* | |
| *Anteil in Tagen* | | | | *[B] / 8* | |

---

## Block 3 — Stundensatz / Tagessatz

| Position | Formel |
|----------|--------|
| **Kalk. Jahreskosten [A]** | [A] |
| / Verrechenbare Stunden [B] | / [B] |
| = **Selbstkosten je Stunde (zu Vollkosten)** | **[A] / [B]** |
| × 8 | × 8 |
| = **Selbstkosten je Tag (zu Vollkosten)** | **8 × [A] / [B]** |

| | |
|----------|--------|
| **Direkte mitarbeiterbezogene Kosten p. a.** | [1] × 12 |
| / Verrechenbare Stunden [B] | / [B] |
| = **Selbstkosten je Stunde (zu Teilkosten)** | **[1] × 12 / [B]** |
| × 8 | × 8 |
| = **Selbstkosten je Tag (zu Teilkosten)** | **8 × [1] × 12 / [B]** |

---

## Abkürzungen

| Abk. | Bedeutung |
|:----:|-----------|
| **BG** | Bruttogehalt (Monatsbrutto) |
| **UG** | Urlaubsgeld (13. Gehalt) |
| **WR** | Weihnachtsremuneration (14. Gehalt) |
| **ME** | Monatsentgelt (durchschnittlich, inkl. UG+WR) |
| **SV-DGA** | Sozialversicherung — Dienstgeberanteil |
| **DB** | Dienstgeberbeitrag zum Familienlastenausgleichsfonds |
| **DZ** | Dienstgeberzuschlag |
| **KommSt** | Kommunalsteuer |
| **NK** | (Gehalts-)Nebenkosten |
