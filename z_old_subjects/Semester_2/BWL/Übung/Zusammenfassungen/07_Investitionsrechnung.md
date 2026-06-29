# Investitionsrechnung

> **Zweck:** Beurteilung der Vorteilhaftigkeit von Investitionen.

---

## Symbolverzeichnis

| Symbol | Bedeutung | Symbol | Bedeutung |
|:------:|-----------|:------:|-----------|
| **I₀** | Anschaffungswert / Anfangsinvestition | **i** | Kalkulationszinssatz |
| **RW** | Restwert / Liquidationserlös | **n / ND** | Nutzungsdauer |
| **CFₜ** | Cashflow in Periode t (Rückfluss) | **C₀** | Kapitalwert (NPV) |
| **R** | Ø Rückfluss pro Periode | **G** | Gewinn |

---

## A. Statische Verfahren

### A1. Kostenvergleichsrechnung

| Position | Betrag | Formel |
|----------|:------:|--------|
| Kalk. Abschreibung | kA | (I₀ − RW) / ND [[02_Kalkulatorische_Kostenarten#Kalk. Abschreibung\|Kalk. Abschreibung]] |
| + Kalk. Zinsen | + kZ | (I₀ + RW) / 2 × i [[02_Kalkulatorische_Kostenarten#Kalk. Zinsen\|Kalk. Zinsen]] |
| + Sonstige fixe Kosten | + Kf_sonst | Versicherung, Wartung, etc. |
| + Variable Kosten | + Kv | kv × Menge (Energie, Betriebsstoffe, …) |
| = **Gesamtkosten p. a.** | **K_ges** | **kA + kZ + Kf_sonst + Kv** |
| / Menge (bei untersch. Kapazität) | / x | |
| = **Stückkosten** | **k_Stk** | **K_ges / x** |

> **Entscheidung:** Alternative mit **niedrigsten Gesamtkosten** (gleiche Kapazität) oder **niedrigsten Stückkosten** (unterschiedliche Kapazität).

---

### A2. Gewinnvergleichsrechnung

| Position | Betrag | Formel |
|----------|:------:|--------|
| Erlöse p. a. | E | p × x |
| − Gesamtkosten p. a. | −K_ges | siehe [[#A1. Kostenvergleichsrechnung\|→ A1]] |
| = **Gewinn p. a.** | **G** | **E − K_ges** |

> **Entscheidung:** Alternative mit **höchstem Ø-Gewinn p. a.** Investition vorteilhaft wenn G > 0.

---

### A3. Rentabilitätsvergleichsrechnung

| Position | Betrag | Formel |
|----------|:------:|--------|
| Gewinn p. a. (exkl. kalk. Zinsen) | G' | E − K_ges + kZ |
| + Kalk. Zinsen | + kZ | (I₀ + RW) / 2 × i |
| / Ø gebundenes Kapital | / ØKap | (I₀ + RW) / 2 |
| = **Rentabilität** | **R %** | **(G' + kZ) / ØKap × 100** |

```
Rentabilität = (Gewinn + kalk. Zinsen) / ((I₀ + RW) / 2) × 100
```

> **Entscheidung:** Höchste Rentabilität. Mindestanforderung: **R ≥ i** (Kalkulationszinssatz).

---

### A4. Amortisationsrechnung (Pay-back-Methode)

#### Durchschnittsmethode

| Position | Betrag | Formel |
|----------|:------:|--------|
| Kapitaleinsatz | I₀ | Anschaffungswert |
| / Ø Rückfluss p. a. (Gewinn + AfA) | / R | R = G + kA |
| = **Amortisationsdauer (statisch)** | **t_A** | **I₀ / R** |

#### Kumulationsmethode

| Jahr | Rückfluss (CF) | Kumulierter Rückfluss |
|:----:|:--------------:|:---------------------:|
| 1 | CF₁ | CF₁ |
| 2 | CF₂ | CF₁ + CF₂ |
| … | … | … |
| n | CFₙ | ΣCF ≥ I₀ → **t_A = n** |

```
Cashflow (Rückfluss) = Einzahlungen − Auszahlungen = Gewinn + Abschreibungen
```

> **Entscheidung:** Kürzeste Amortisationsdauer. Voraussetzung: **t_A ≤ t_max** (maximal erlaubte Amortisationsdauer).

---

## B. Dynamische Verfahren

### B1. Kapitalwertmethode (NPV / Net Present Value)

#### Einzelne Cashflows

| Jahr | Cashflow | Abzinsungsfaktor (1 + i)^(−t) | Barwert |
|:----:|:--------:|:-----------------------------:|:-------:|
| 0 | −I₀ | 1 | −I₀ |
| 1 | CF₁ | (1 + i)^(−1) | CF₁ / (1 + i)¹ |
| 2 | CF₂ | (1 + i)^(−2) | CF₂ / (1 + i)² |
| … | … | … | … |
| n | CFₙ | (1 + i)^(−n) | CFₙ / (1 + i)ⁿ |
| | | **Kapitalwert C₀** | **Σ Barwerte − I₀** |

```
        n
C₀ =   Σ   [ CFₜ / (1 + i)ᵗ ]  −  I₀
       t=1
```

#### Gleichbleibende Rückflüsse — Rentenbarwertfaktor (RBF)

```
                     (1 + i)ⁿ − 1
RBF(i, n)  =   ——————————————————————
                    i × (1 + i)ⁿ

C₀  =  CF × RBF(i, n) − I₀
```

| Entscheidungsregel |
|-------------------|
| **C₀ > 0** → Investition vorteilhaft (Rendite > i) |
| **C₀ = 0** → indifferent (Rendite = i) |
| **C₀ < 0** → nicht vorteilhaft (Rendite < i) |

---

### B2. Interne Zinsfußmethode (IRR / Internal Rate of Return)

| Position | Formel |
|----------|--------|
| Ansatz | **C₀ = 0** → I₀ = Σ [CFₜ / (1 + r)ᵗ] |
| Gesucht | **r** (Interner Zinsfuß) |
| Excel | `=IKV(Bereich; Schätzwert)` |

#### Interpolation (händische Näherung)

| Position | Formel |
|----------|--------|
| Versuchszinssatz r₁ (→ C₀₁ > 0) | r₁ % → C₀₁ |
| Versuchszinssatz r₂ (→ C₀₂ < 0) | r₂ % → C₀₂ |
| **Interner Zinsfuß** | **r ≈ r₁ + (r₂ − r₁) × C₀₁ / (C₀₁ − C₀₂)** |

| Entscheidungsregel |
|-------------------|
| **r > i** → Investition vorteilhaft |
| **r = i** → indifferent |
| **r < i** → nicht vorteilhaft |

---

## Verfahrensvergleich

| Verfahren | Kriterium | Anwendung bei |
|-----------|-----------|---------------|
| **Kostenvergleich** | Niedrigste Kosten | Gleiche Erlöse, Ersatzinvestition |
| **Gewinnvergleich** | Höchster Gewinn | Unterschiedliche Erlöse |
| **Rentabilitätsvergleich** | Höchste %-Rendite | Unterschiedlicher Kapitaleinsatz |
| **Amortisationsrechnung** | Kürzeste Rückflussdauer | Risikobewertung, Liquiditätsschwerpunkt |
| **Kapitalwert (NPV)** | C₀ > 0 | Langfristige Investitionen, genaue Barwertbetrachtung |
| **Interner Zinsfuß (IRR)** | r > i | Renditevergleich, unabhängig von i |

| Kriterium | Statisch | Dynamisch |
|-----------|:--------:|:---------:|
| Zeitwert des Geldes | nein | **ja** (Abzinsung) |
| Rechenaufwand | gering | höher (Excel) |
| Ø-Betrachtung | ja | nein (periodengenau) |
| Geeignet für | kurze ND, Überschlag | langfristige Investitionen |

> **Statisch ≠ falsch.** Statische Verfahren reichen für einfache Vergleiche mit kurzer Nutzungsdauer. Dynamische Verfahren sind genauer, aber aufwändiger.
