# Deckungsbeitragsrechnung

> **Zweck:** Teilkostenrechnung — Trennung fixe / variable Kosten. Basis für Break-Even, Engpass, Make-or-Buy.

---

## 1. Kostenauflösung (Zwei-Punkte-Methode / High-Low)

| Position | Betrag | Formel |
|----------|:------:|--------|
| Gesamtkosten Periode 1 (bei Menge x₁) | K₁ | |
| Gesamtkosten Periode 2 (bei Menge x₂) | K₂ | |
| **Variable Stückkosten** | **kv** | **(K₂ − K₁) / (x₂ − x₁)** |
| **Fixkosten** | **Kf** | **K₁ − kv × x₁** |
| **Kostenfunktion** | | **K(x) = Kf + kv × x** |

```
kv = ΔK / Δx           Kf = K − kv × x           K(x) = Kf + kv × x
```

---

## 2. Einstufige DB-Rechnung (Direct Costing)

### Pro Stück

| Position | Betrag | Formel |
|----------|:------:|--------|
| Nettoverkaufspreis / Stk | p | |
| − Variable Kosten / Stk | −kv | |
| = **Stück-Deckungsbeitrag (db)** | **db** | **db = p − kv** |

### Gesamtergebnis

| Position | Betrag | Formel |
|----------|:------:|--------|
| Nettoerlöse (Umsatz) | E | p × x |
| − Variable Gesamtkosten | −Kv | kv × x |
| = **Deckungsbeitrag (DB)** | **DB** | **DB = db × x = E − Kv** |
| − Fixkosten | −Kf | |
| = **Betriebsergebnis** | **BE** | **BE = DB − Kf** |

### Mehrprodukt-Tabelle

| Produkt | Stück | Erlös/Stk | var. Kosten/Stk | db/Stk | DB gesamt | DB-Rang |
|:-------:|:-----:|:---------:|:---------------:|:------:|:---------:|:-------:|
| A | x_A | p_A | kv_A | db_A | db_A × x_A | |
| B | x_B | p_B | kv_B | db_B | db_B × x_B | |
| … | … | … | … | … | … | |
| **∑** | **Σx** | | | | **ΣDB** | |

---

## 3. Break-Even-Analyse (Gewinnschwellenanalyse)

| Position | Betrag | Formel |
|----------|:------:|--------|
| Fixkosten | Kf | |
| Stück-DB | db | p − kv |
| **Break-Even-Menge (x_BEP)** | **x_BEP** | **Kf / db** |
| × Preis | × p | |
| **= Deckungsumsatz (Umsatz am BEP)** | **U_BEP** | **x_BEP × p** |

### Break-Even-Umsatz (Mehrproduktfall)

| Position | Betrag | Formel |
|----------|:------:|--------|
| Fixkosten | Kf | |
| DB-Umsatzquote (DB / E) | DBQ | DB / E |
| **Break-Even-Umsatz** | **U_BEP** | **Kf / DBQ** |

### Sicherheitsabstand

| Position | Formel |
|----------|--------|
| **Sicherheitsabstand (€)** | Ist-Umsatz − BE-Umsatz |
| **Sicherheitsabstand (%)** | (Ist-Umsatz − BE-Umsatz) / Ist-Umsatz × 100 |

### Zielgewinn

| Gesucht | Formel |
|---------|--------|
| **Menge bei Zielgewinn G** | **(Kf + G) / db** |
| **Preis bei Zielgewinn G** | **kv + (Kf + G) / x** |

### Kapazitätsauslastung bei Kostendeckung

| Position | Formel |
|----------|--------|
| BE-Menge × Fertigungszeit / Stk | BE-Minuten |
| / Jahreskapazität (Minuten) | / Kapazität |
| = **Kapazitätsauslastung bei Kostendeckung** | **BE-Zeit / Kapazität × 100 %** |

---

## 4. Mehrstufige DB-Rechnung (Fixkostendeckungsrechnung)

| Stufe | | Produkt A | Produkt B | Produkt C | Produkt D |
|:-----:|-|:---------:|:---------:|:---------:|:---------:|
| | Nettoerlöse | E_A | E_B | E_C | E_D |
| | − Variable Kosten | −Kv_A | −Kv_B | −Kv_C | −Kv_D |
| **I** | **= DB I** | **DB I_A** | **DB I_B** | **DB I_C** | **DB I_D** |
| | − Produktfixkosten | −Kf_A | −Kf_B | −Kf_C | −Kf_D |
| **II** | **= DB II** | **DB II_A** | **DB II_B** | **DB II_C** | **DB II_D** |

| | | **Bereich 1** | **Bereich 2** |
|:-----:|-|:-------------:|:-------------:|
| | Summe DB II | ΣDB II (A+B) | ΣDB II (C+D) |
| | − Bereichsfixkosten | −Kf_Ber1 | −Kf_Ber2 |
| **III** | **= DB III (Bereichs-DB)** | **DB III₁** | **DB III₂** |

| | | **Gesamtunternehmen** |
|:-----:|-|:---------------------:|
| | Summe DB III | ΣDB III |
| | − Unternehmensfixkosten | −Kf_UN |
| **IV** | **= Betriebsergebnis** | **BE** |

### Fixkosten-Hierarchie

| Stufe | Fixkostenart | Beispiele |
|:-----:|--------------|-----------|
| **1** | **Produktfixkosten** | Maschinenleasing, Produktentwicklung, produktspezifische Werbung |
| **2** | **Bereichsfixkosten** | Bereichsleitung, Fertigungshallen-Miete, Spartenverwaltung |
| **3** | **Unternehmensfixkosten** | Geschäftsführung, Zentrale IT, Rechtsabteilung, Konzernzentrale |

---

## 5. Entscheidungsregeln

| Frage | Entscheidungsregel |
|-------|-------------------|
| Kurzfristige Preisuntergrenze | **p ≥ kv** (DB ≥ 0) |
| Langfristige Preisuntergrenze | **p ≥ Selbstkosten (Vollkosten)** |
| Produkt kurzfristig behalten? | **DB I > 0** → behalten |
| Produkt langfristig behalten? | **DB II > 0** → behalten |
| Bereich fortsetzen? | **DB III > 0** → fortsetzen |
| Zusatzauftrag annehmen? (Unterbeschäftigung) | **p ≥ kv** → annehmen (positiver DB) |
| Make-or-Buy | **Fremdbezugspreis < interne var. Kosten?** → Fremdbezug |
| Werbeaktion / Preissenkung | **ΔDB > ΔFixkosten?** → durchführen |

### Engpass — Produktionsprogrammoptimierung

| Rang | Produkt | db/Stk | Zeit/Stk | db/Zeiteinheit | Rangfolge |
|:----:|:-------:|:------:|:--------:|:--------------:|:---------:|
| | A | db_A | t_A | **db_A / t_A** | |
| | B | db_B | t_B | **db_B / t_B** | |
| | C | db_C | t_C | **db_C / t_C** | |

```
Relativer Deckungsbeitrag = db / Engpasseinheit (z.B. db/Minute)
→ Produziere zuerst das Produkt mit dem höchsten relativen DB.
```

---

## Abkürzungen

| Symbol | Bedeutung | Symbol | Bedeutung |
|:------:|-----------|:------:|-----------|
| **p** | Nettoverkaufspreis / Stück | **Kf** | Fixkosten (gesamt) |
| **kv** | Variable Kosten / Stück | **DB** | Deckungsbeitrag (gesamt) |
| **x** | Menge (Stück) | **db** | Stück-Deckungsbeitrag |
| **E** | Erlöse / Umsatz (E = p × x) | **BE** | Betriebsergebnis |
| **Kv** | Variable Gesamtkosten (Kv = kv × x) | **DBQ** | DB-Umsatzquote (DB/E) |
