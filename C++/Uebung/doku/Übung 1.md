## gcc

```
-E nur Präprozessor
-O optimieren, -O0 nicht optimieren
-Os - optimieren auf size etc
-pedantic-errors: gibt Fehler wenn standard missachtet wird
-fsanitize=address: kann manche index out of bounds erkennen
gcc -std=c23 -pedantic -Wall -Wextra -g -o calc main.c

```

Disassambler
```
objdump -dSr calc | less
```


## Namenskonventionen
- man verwendet häufig snake_case
- Name vom Variablen ist genauer wenn die Lebensauer länger ist (z.B. globale var sind gut zu beschreiben)
- Funktionen sind Verben, was macht sie, z.B. convert_to
- Präprozessoranweisungen sind uppercase
```
#define MAX_AGE
```
- selbst definierte Typen: node_t und vertex_t


Kommentare sollen weniger beschreiben, was der code macht, sonderne eher auch warum (was der code macht sieht man ja eh im code)



