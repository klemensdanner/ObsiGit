# Zuschlagskalkulation

> **Zweck:** Ermittlung der Selbstkosten je Produkt/Auftrag mittels Zuschlagssätzen aus dem [[03_Betriebsabrechnungsbogen_BAB\|BAB]].

---

## Grundschema

| Pos. | | Betrag | E/G | % |
|:----:|----------------------------|:------:|:---:|:---:|
| 1 | **Fertigungsmaterial (FM)** | FM | E | — |
| 2 | + Materialgemeinkosten | + MGK % × FM | G | [[03_Betriebsabrechnungsbogen_BAB#Zuschlagssätze\|MGK %]] |
| 3 | **= Materialkosten** | **FM + MGK** | | |
| 4 | **Fertigungslöhne (FL)** | FL | E | — |
| 5 | + Fertigungsgemeinkosten | + FGK % × FL | G | [[03_Betriebsabrechnungsbogen_BAB#Zuschlagssätze\|FGK %]] |
| 6 | + Sondereinzelkosten der Fertigung (SEKF) | + SEKF | E | — |
| 7 | **= Fertigungskosten** | **FL + FGK + SEKF** | | |
| 8 | **= Herstellkosten (HK)** | **3 + 7** | | |
| 9 | + Verwaltungsgemeinkosten | + VwGK % × HK | G | [[03_Betriebsabrechnungsbogen_BAB#Zuschlagssätze\|VwGK %]] |
| 10 | + Vertriebsgemeinkosten | + VtGK % × HK | G | [[03_Betriebsabrechnungsbogen_BAB#Zuschlagssätze\|VtGK %]] |
| 11 | + Sondereinzelkosten des Vertriebs (SEKV) | + SEKV | E | — |
| 12 | **= Selbstkosten (SK)** | **HK + VwGK + VtGK + SEKV** | | |
| 13 | + Kalk. Gewinnzuschlag | + G % × SK | | |
| 14 | **= Nettoverkaufspreis** | **SK + Gewinn** | | |
| 15 | + Umsatzsteuer (USt) | + USt % × 14 | | |
| 16 | **= Bruttoverkaufspreis** | **14 + USt** | | |

```
E = Einzelkosten (direkt zurechenbar)    G = Gemeinkosten (über Zuschlagssatz)
```

---

## Schema mit 2 Fertigungsstellen

| Pos. | | Betrag | % |
|:----:|----------------------------|:------:|:---:|
| 1 | **Fertigungsmaterial (FM)** | FM | |
| 2 | + Materialgemeinkosten | + MGK % × FM | [[03_Betriebsabrechnungsbogen_BAB#Variante 2 Fertigungsstellen\|MGK %]] |
| 3 | = Materialkosten | FM + MGK | |
| 4 | **Fertigungslöhne 1 (FL₁)** | FL₁ | |
| 5 | + Fertigungsgemeinkosten 1 | + FGK₁ % × FL₁ | [[03_Betriebsabrechnungsbogen_BAB#Variante 2 Fertigungsstellen\|FGK₁ %]] |
| 6 | **Fertigungslöhne 2 (FL₂)** | FL₂ | |
| 7 | + Fertigungsgemeinkosten 2 | + FGK₂ % × FL₂ | [[03_Betriebsabrechnungsbogen_BAB#Variante 2 Fertigungsstellen\|FGK₂ %]] |
| 8 | + Sondereinzelkosten der Fertigung | + SEKF | |
| 9 | **= Herstellkosten (HK)** | **3 + 5 + 6 + 7 + 8** | |
| 10 | + Verwaltungs- u. Vertriebsgemeinkosten | + Vw-VtGK % × HK | |
| 11 | + Sondereinzelkosten des Vertriebs | + SEKV | |
| 12 | **= Selbstkosten (SK)** | **9 + 10 + 11** | |
| 13 | + Kalk. Gewinnzuschlag | + G % × SK | |
| 14 | **= Nettoverkaufspreis** | **12 + 13** | |

---

## Kalkulationszeitpunkte

| Zeitpunkt | Bezeichnung | Verwendete Sätze |
|-----------|-------------|------------------|
| Vor Produktion | **Vorkalkulation** | Normal-Zuschlagssätze (Plansätze) |
| Nach Produktion | **Nachkalkulation** | Ist-Zuschlagssätze |
| Nachkalkulation − Vorkalkulation | **Abweichungsanalyse** | Δ = Ist − Normal |

---

## Abkürzungen

| Abk. | Begriff | Abk. | Begriff |
|:----:|---------|:----:|---------|
| **FM** | Fertigungsmaterial | **MEK** | Materialeinzelkosten (= FM) |
| **FL** | Fertigungslöhne | **FEK** | Fertigungseinzelkosten (= FL) |
| **MGK** | Materialgemeinkosten | **SEKF** | Sondereinzelkosten der Fertigung |
| **FGK** | Fertigungsgemeinkosten | **SEKV** | Sondereinzelkosten des Vertriebs |
| **HK** | Herstellkosten | **SK** | Selbstkosten |
| **VwGK** | Verwaltungsgemeinkosten | **VtGK** | Vertriebsgemeinkosten |

> **Sondereinzelkosten der Fertigung:** z. B. Fremdbearbeitung, Spezialwerkzeuge, Modelle, Lizenzen für einen Auftrag.
> **Sondereinzelkosten des Vertriebs:** z. B. Provision, Ausgangsfrachten, Sonderverpackung, Rabatt.
