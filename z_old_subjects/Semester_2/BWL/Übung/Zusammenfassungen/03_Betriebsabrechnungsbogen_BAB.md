# Betriebsabrechnungsbogen (BAB)

> **Zweck:** Verteilung Gemeinkosten → Kostenstellen → Zuschlagssätze für [[04_Zuschlagskalkulation\|Zuschlagskalkulation]].

---

## Grundschema (4 Kostenstellen)

| Kostenart | Summe (€) | Material | Fertigung | Verwaltung | Vertrieb | EK / GK |
|-----------|:---------:|:--------:|:---------:|:----------:|:--------:|:-------:|
| Fertigungsmaterial | | | | | | EK |
| Fertigungslöhne | | | | | | EK |
| Hilfsmaterial / Hilfsstoffe | | | | | | GK |
| Hilfslöhne | | | | | | GK |
| Gehälter | | | | | | GK |
| Lohnnebenkosten FL | | | | | | GK |
| Lohnnebenkosten HL | | | | | | GK |
| Gehaltsnebenkosten | | | | | | GK |
| Kalk. Abschreibung | | | | | | GK |
| Kalk. Zinsen | | | | | | GK |
| Kalk. Miete | | | | | | GK |
| Strom / Energie | | | | | | GK |
| Sonstige Kosten | | | | | | GK |
| **Summe Gemeinkosten** | **ΣGK** | **ΣGK_M** | **ΣGK_F** | **ΣGK_Vw** | **ΣGK_Vt** | |

---

## Zuschlagssätze

| Zuschlagssatz | Symbol | Formel | Zuschlagsgrundlage |
|---------------|:------:|--------|--------------------|
| **Materialgemeinkostenzuschlag** | **MGK %** | ΣGK_M × 100 / FM | Fertigungsmaterial (FM) |
| **Fertigungsgemeinkostenzuschlag** | **FGK %** | ΣGK_F × 100 / FL | Fertigungslöhne (FL) |
| **Verwaltungsgemeinkostenzuschlag** | **VwGK %** | ΣGK_Vw × 100 / HK | Herstellkosten (HK) |
| **Vertriebsgemeinkostenzuschlag** | **VtGK %** | ΣGK_Vt × 100 / HK | Herstellkosten (HK) |

```
MGK % = ΣGK_Material / Fertigungsmaterial × 100
FGK % = ΣGK_Fertigung / Fertigungslöhne × 100
VwGK % = ΣGK_Verwaltung / Herstellkosten × 100
VtGK % = ΣGK_Vertrieb / Herstellkosten × 100
```

---

## Variante: 2 Fertigungsstellen

| Kostenart | Summe (€) | Material | Fertigung 1 | Fertigung 2 | Verw. u. Vertr. |
|-----------|:---------:|:--------:|:-----------:|:-----------:|:---------------:|
| … | | | | | |
| **Summe Gemeinkosten** | **ΣGK** | **ΣGK_M** | **ΣGK_F1** | **ΣGK_F2** | **ΣGK_VwVt** |

| Zuschlagssatz | Formel | Zuschlagsgrundlage |
|---------------|--------|--------------------|
| **MGK %** | ΣGK_M × 100 / FM | Fertigungsmaterial |
| **FGK₁ %** | ΣGK_F1 × 100 / FL₁ | Fertigungslöhne 1 |
| **FGK₂ %** | ΣGK_F2 × 100 / FL₂ | Fertigungslöhne 2 |
| **Vw-VtGK %** | ΣGK_VwVt × 100 / HK | Herstellkosten |

---

## Verteilungsschlüssel (Kostenschlüssel) — Auswahl

| Schlüsselart | Basis | Typische Anwendung |
|-------------|-------|-------------------|
| **Mengenschlüssel** | m², m³, kg, kWh, Stk | Miete (m²), Strom (kWh) |
| **Wertschlüssel** | € Werte (FM, FL, HK) | Gehälter, Abschreibungen |
| **Zeitschlüssel** | Fertigungsstunden, Maschinenstunden | Instandhaltung |
| **Personalschlüssel** | Mitarbeiteranzahl | Sozialkosten, Kantine |

---

## BAB → Grenzkosten-BAB (Teilkosten)

| Spalte | Vollkosten-BAB | Grenzkosten-BAB |
|--------|:--------------:|:---------------:|
| Gemeinkosten | gesamt (fix + variabel) | **nur variable Gemeinkosten** |
| Zuschlagssätze | Vollkostensätze | **variable Zuschlagssätze** |
| Verwendung | [[04_Zuschlagskalkulation\|Zuschlagskalkulation (Vollkosten)]] | [[06_Deckungsbeitragsrechnung\|Deckungsbeitragsrechnung (Teilkosten)]] |

```
Variabler MGK % = var. Material-GK / FM × 100
Variabler FGK % = var. Fertigungs-GK / FL × 100
```

> **Herstellkosten (HK)** = Materialkosten + Fertigungskosten = (FM + MGK) + (FL + FGK + SEKF). Die HK sind die Zuschlagsgrundlage für VwGK und VtGK.
