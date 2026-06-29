# Kalkulatorische Kostenarten

> **Zweck:** Ermittlung der Kostenansätze in der KLR. Anderskosten + Zusatzkosten gemäß [[01_Betriebsueberleitungsbogen_BUEB\|BÜB]].

---

## Kalk. Abschreibung

| Position | Betrag | Formel / Herleitung |
|----------|:------:|---------------------|
| Wiederbeschaffungswert (WBW) | WBW | Tageswert / Wiederbeschaffungspreis |
| − Restwert (RW) | −RW | Geschätzt am Ende der tats. ND |
| = Wertverlust gesamt | WBW − RW | |
| / Tatsächliche Nutzungsdauer (ND) | / ND | Betriebliche ND, nicht steuerliche |
| **= Kalk. Abschreibung p. a.** | **(WBW − RW) / ND** | |

### Index-Methode (bei bekannten Indexreihen)

| Position | Betrag |
|----------|:------:|
| AfA lt. FiBu | AfA_FiBu |
| × (Index_aktuell / Index_Basis) | × (I₁ / I₀) |
| **= Kalk. Abschreibung p. a.** | **AfA_FiBu × (I₁ / I₀)** |

### Anderskosten-Ermittlung

| Position | Betrag |
|----------|:------:|
| Kalk. Abschreibung p. a. | kA |
| − AfA lt. FiBu | −AfA_FiBu |
| **= Anderskosten (±)** | **±Δ** | → Abgrenzung im [[01_Betriebsueberleitungsbogen_BUEB\|BÜB]] |

---

## Kalk. Zinsen

| Position | Betrag | Formel |
|----------|:------:|--------|
| Betriebsnotwendiges Vermögen | BV | AV + UV zu WBW |
| − Abzugskapital | −AK | zinsfrei: Verbindlichkeiten L&L, Anzahlungen |
| = **Betriebsnotwendiges Kapital** | **BK** | BV − AK |
| × Kalkulatorischer Zinssatz | × i | marktüblicher Zinssatz |
| = **Kalk. Zinsen p. a.** | **BK × i** | |

### Ø-gebundenes-Kapital-Methode (Vereinfacht)

| Position | Betrag |
|----------|:------:|
| Anschaffungswert (AW) | AW |
| + Restwert (RW) | +RW |
| / 2 | / 2 |
| = **Ø gebundenes Kapital** | **(AW + RW) / 2** |
| × Kalk. Zinssatz | × i |
| = **Kalk. Zinsen p. a.** | **(AW + RW) / 2 × i** |

> Kalk. Zinsen sind **Zusatzkosten** (auf EK) bzw. **Anderskosten** (wenn FK-Zinsen in GuV durch kalk. Zinsen ersetzt werden). Im BÜB: FiBu-Zinsaufwand wird vollständig neutralisiert und durch kalk. Zinsen ersetzt.

---

## Kalk. Unternehmerlohn

| Position | Betrag |
|----------|:------:|
| Vergleichsgehalt (vergleichbarer Angestellter) | VG |
| + Unternehmerzuschlag (≈ 20 %) | +0,20 × VG |
| = **Kalk. Unternehmerlohn p. a.** | **1,20 × VG** |

> **Zusatzkosten** — in FiBu nicht enthalten. Im [[01_Betriebsueberleitungsbogen_BUEB\|BÜB]] dem Personalaufwand zugeschlagen.

---

## Kalk. Wagnisse

| Position | Betrag | Formel |
|----------|:------:|--------|
| Wagnisverluste (letzte n Jahre, Summe) | ΣW | tatsächliche Ist-Verluste |
| / Anzahl Jahre | / n | |
| = Ø Wagnisverlust p. a. | W_Ø | ΣW / n |
| / Bezugsgröße (Umsatz, Lagerbestand, Forderungen, …) | / BG | |
| = **Wagnissatz** | **w %** | W_Ø / BG |
| × Aktuelle Bezugsgröße | × BG_akt | |
| = **Kalk. Wagnis p. a.** | **w × BG_akt** | |

### Wagnisarten

| Wagnisart | Bezugsgröße | Beispiele |
|-----------|-------------|-----------|
| **Beständewagnis** | Ø Lagerbestand | Schwund, Diebstahl, Verderb |
| **Gewährleistungswagnis** | Umsatz | Garantie, Kulanz, Nachbesserung |
| **Fertigungswagnis** | Herstellkosten | Ausschuss, Fehlproduktion |
| **Anlagenwagnis** | Anlagenwert | Maschinenbruch, nicht versicherte Schäden |
| **Vertriebswagnis / Forderungswagnis** | Forderungsbestand / Umsatz | Zahlungsausfall, Preisverfall |

> Kalk. Wagnisse sind **Anderskosten** — in FiBu als Ist-Aufwand, in KLR als normalisierter Ø-Wert. Differenz → Abgrenzung im [[01_Betriebsueberleitungsbogen_BUEB\|BÜB]].
