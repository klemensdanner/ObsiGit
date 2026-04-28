### IP Adressen

- unterteilt in Netz und Hostteil

Niedrigste Adresse: ist die netzadresse
// Es sind immer Bytes zwischen den punkten
// nach dem / kommt die anzahl der bits die zum Neztteil dazugehören

z.b.
123.45.67.0/24 ist die netzadresse

123.45.67.255 ist die höchste adresse, broadcast adresse genannt

von 0 bis 255 ist die net-range



nach dem / kommt die anzahl der bits im netzteil bzw definiert die Netzmaske (in Binär)
z.B. bei / 24
kommen 24 Einser und der Rest (bis 32) sind 0er

wenn man die IP adresse in binär bitweise und verknüpft mit der netzmaske kommt man auf die netzadresse, d.h. die kleinste IP adresse im netz
--> wichtig wenn die Präfixlänge (also das hinter dem /) keine ganzen vielfachen von 8 sind

---

wenn gefragt ist, wo der Hostteil und Netzteil geteilt ist




inverse Netzmaske:
- überall 0, wo die normale Netzmaske 1 hat

---

![[UE04-Subnetting-2026-01-30-Student.pdf#page=4&rect=100,552,492,636|UE04-Subnetting-2026-01-30-Student, p.4]]
Anleitung:
