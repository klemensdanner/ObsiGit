# OSI Referenzmodell

![[CNW-2026S-Kapitel2.pdf#page=3&rect=52,127,783,499|CNW-2026S-Kapitel2, p.3]]

Schichten sind sozusagen Abstraktionen. Sie verwenden über eine Schnittstelle die Schicht darunter und kann Daten an die Schicht darüber weitergeben. Sie hält sich an den Standard eines Protokolls und kann damit mit der selben Schicht auf einem anderen Gerät kommunizieren.

![[CNW-2026S-Kapitel2.pdf#page=5&rect=54,125,698,497|CNW-2026S-Kapitel2, p.5]]

**data link**: Bits werden das erste Mal interpretiert. (z.B. Bitfehlererkennung, 1. Bit - letztes Bit in der Nachricht)
**physical**: analoges Signal, Bits werden übertragen - Zeit zwischen Bits - dann Spannung messen - eher 0 oder 1


![[CNW-2026S-Kapitel2.pdf#page=6&rect=62,123,756,496|CNW-2026S-Kapitel2, p.6]]

**Schicht n Gerät**: Gerät, welches alle Schichten bis Schicht n unterstützt
**Endsystem**: Sender oder Empfänger, muss alle Schichten beherrschen
**Layer 8**: oberhalb des Stacks, werden von Anwendungen selber implementiert, aber eigentlich keine eigene Netzwerkschicht



![[CNW-2026S-Kapitel2.pdf#page=8&rect=63,168,776,435|CNW-2026S-Kapitel2, p.8]]

7: 
**5 Sitzung / Session**: Beispiel Telefonanruf: Metadaten, Verbindungsaufbau, -abbau, Dauer etc.
**4 Transport**: Niedrigstes End-To-End Level - Bitstrom
**3 Vermittlung**: Wie werden die Pakete übertragen
**2 Data Link:** 


### Protokolle und Dienste, S.8

![[CNW-2026S-Kapitel2.pdf#page=11&rect=63,147,712,435&color=yellow]]

grauer Knödel: Service Access Point von Schicht n

**N-ICI**: Steuerinformationen für die konkrete Schicht. möglicherweise sind diese Informationen in einer unteren Schicht relevant - dann können diese Daten auch im Header weiter übertragen werden

**NPCI**: Zusatzdaten, meistens Headerdaten der vor die eigentlichen Daten.
Kann aber auch ein Tailer sein; z.B. in Schicht 2 - Übertragung von Paketen. Es kann zum Beispiel eine Checksum nachgestellt werden, um die korrekte Übertragung sicherzustellen
**N-SDU**: ursprünglich relevanten Daten
Beides zusammen sind die **N-PDU**
Diese wird wieder als SDU an die untere Schicht weitergegeben.

S. 11

![[CNW-2026S-Kapitel2.pdf#page=13&rect=58,135,760,436&color=yellow]]
Ob Response und Confirm angewendet werden hängt vom Anwendungsfall ab. 
z.B. File Transfer ist nicht fehlertolerant, dadurch mit confirm
Vidoestreaming soll schnell sein, aber wenn ein Frame verloren geht wird es nicht nachgeschickt



**Verbindungsabbau**: möglich ist es, ohne confirmation, ein time-out würde die Verbindung sowieso schließen. Allerdings nicht so gut, weil halboffene Verbindungen 
