[[21-10-25T3_Benutzer_Rechte_T1.pdf]]

Es gibt jeweils
 - Lese
 - Schreibe
 - Ausführrechte

für Dateien und Verzeichnisse

Verzeichnis vorstellen wie eine Textdatei mit einer Auflistung aller enthaltenen Daten

Wann ist bei einem Verzeichnis ein execute Recht erforderlich?
- bei einer Verzeichnisüberspringung bsp. mkdir /home/klemens - hier braucht man execute rechte für home und Klemens
- bei ls -l in einem Verzeichnis. ls alleine reicht read


Bei Seite 6:
numerisch rechnen:


```
4 2 1

r w x
```

Da die Reihenfolge rwx vorgegeben ist und man gerne Dinge in Binär darstellt, werden Gesamtrechte als Oktalzahl angegeben. 7 wär also 111, also 4+2+1


001 ist also das execute Recht
010 ist das write Recht
100 ist das read recht

//nicht weil read wertvoller als write ist, sondern nur weil die Schreibweise r w x vorgegeben ist.




sudo = substitute user do


S. 9
Man kann nur sudo verwenden, wenn man auch in der Gruppe sudo ist
Rechte dazu können in der Datei festgelegt. - Kann man so einstellen, dass die Rechte sich unterscheiden.

Diese Datei /etc/sudoers nur mit visudo --> syntaxprüfung wegen heikel




```bash
/etc/passwd


klemens:x: 1000:        1000         :,,,:    /home/klemens:/bin/bash

usern.  .   u-id       prim group                 bash login pfad





www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
- niedrige userids < 1000 sind systemusers - für bestimmte Aufgaben mit weniger Rechte z.B. für Webserver


```


Passwörter aber in -Exkurs

```bash
/etc/shadow

klemens:$y$j9T$SFwSs3jJ8XLtwna5A7ydO/$VxEdTsif9W5P/A.m2POxYVWZUvNMEKpjYjgGJ8sDrD5:19956:0:99999:7:::

Das ist ein hash.

Einwegfunktion h(passwort)=abgespacedesTeil

ursprüngliches Passwort nicht umbedingt berechenbar
```


Berechnet wird der Hash von Passwort+Saltwert
Das ist wichtig
- im Fall von gleichen Passwortbenutzungen, damit der hash verschieden ist
- bei dicinary attacs, damit der hash nicht mit dem hash des 'erratenen' Passworts übereinstimmt

/-Exkurs Ende


Bei Gruppe erstellen:
Es wird standardmäßig zu jedem neuen Benutzer eine Primärgruppe mit dem selben Namen erstellt

S.14
userinformation wird auch in passwd gespeichert, bei ',,,'


![[Pasted image 20251021093843.png]]
Warum passwd wenn passwort in shadow gespeichert



Bei S.16
Nicht verschlüsselt sondern gehasht. verschlüsseln kann man entschlüsseln - rückhashen geht nicht

#funfact unix timestamp: Millisekunden seit 1.1.1970

S. 17



[[21-10-25_T3_Benutzer_Rechte_T2.pdf]]

S4: umask ist eine Voreinstellung

```bash
‐rwsr‐xr‐x 1 root root 29104 2007‐05‐18 11:59 /usr/bin/passwd


Was macht das 's'?
's' gibt kurzfristig die jeweiligen Rechte des users bzw der Gruppe (je nachdem wo das s steht), um Änderungen vorzunehmen

Es ist aber vom Programm kontrolliert, welche Änderungen genau vorgenommen werden können
```

S. 6 anschauen bei SUID


### S. 7 Sticky Bit


### Ändern der Zugriffsrechte

S.10
```bash
chmod 777 file.txt


sticky bit kommt vor 000, also bsp 1712
```