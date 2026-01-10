```bash
ls -l | wc -l
```

Die Ausgabe von ls -l wird von wc -l als Eingabe verwendet


```bash
klemens@Klemens:~$ ls -l | cut -c2-10
```



```bash
// Uhrzeit angeben
klemens@Klemens:~$ date | tr -s ' ' | cut -d ' ' -f 4
```

```
echo 'lives good' > A.txt
```
mit einem > wird der Inhalt von A.txt überschrieben
mit zwei >> wird es drangehängt.

![[Pasted image 20251014110212.png]]

1)
```
wc -l abfahrt.txt
```

2)
```
//gibt alle Namen aus. -d ist nicht notwendig, weil das Standardtrennzeichen der Tabulator ist
cut -f3 abfahrt.txt
```

```
//listet Abfahrer nach Nachname
cut -f3 abfahrt.txt | sort -t ' ' -k 2
```

3)
```
head -n3 abfahrt.txt | cut -f1,3 > podium.txt
```


![[Pasted image 20251014111029.png]]

4)
```bash
cut -f2 abfahrt.txt | sort | uniq -c | sort -n -r
//oder
cut -f2 abfahrt.txt | sort | uniq -c | sort -nr

//-n: sort numerisch, -r: reverse
```

8)

``

```
head -n3 abfahrt.txt | tail -n1 | cut -f3
```

	

- [x] z_WSE nochmal durchgehen 🔼 📅 2025-10-21 ✅ 2025-11-07