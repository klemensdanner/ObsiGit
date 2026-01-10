img ist so ähnlich wie eine zip datei

"Linux runtime", darin kann man Befehle ausführen
je nachdem, welche files im Container liegen, die programme kann man ausführen

-Container kann nicht nach außen schauen
aber: Host-Betriebssystem kann Prozesse der Container sehen, weil eigentlich die Prozesse aufm Host laufen. Die Docker engine managed das

Bei Änderungen des filesystems innerhalb eines laufenden Containers werden die Änderungen nicht im image sondern in einem zum Container gehörenden Speicherbereich abgelegt. Wenn man den Container löscht ist der Speicherbereich weg

man kann auch Ordner vom Hauptsystem in den container mounten

image: Inhalte
container: ausführbare version vom image
network: 
data volumes: gemounteter ordner vom hauptsystem


//image vom Server ziehen
```bash
$ docker pull alpine:latest

docker images

docker run --rm alpine:latest
```

docker run: image in container verwandeln
1. Ordnerstruktur aus img extrahiert und erstellt (in container verwandeln) //unveränderbar, nur lesend
2. speicherbereich erstellt //read / writeable layer, standardmäßig leer
3. Prozess mit PID 1 wird ausgeführt -- sichtbar in docker inspect alpine:latest //macht container engine -- sobald der Prozess PID 1 beendet ist, ist der container beendet

![[Pasted image 20251118094320.png]]
// hier: /bin/sh hat keinen input bekommen. von selber wartet er nicht. somit ist der command beendet und der container wird beendet


Container löschen
![[Pasted image 20251118094633.png]]

```bash
docker run --interactive --tty dockerimage

--interactive //lässt die shell des containers auf Eingaben warten
--tty //macht eine Schnittstelle zum kommunizieren (so ca., genauer im 5. semester)

//run attached automatisch auf diese Schnittstelle
```
// das wird dann von der --interactive und --tty, also die Optionen werden in einer config file gespeichert und sind dann immer gültig. Das sind also die gesetteten Einstellungen für den container. //tty macht eine Schnittstelle
bei start muss man manuell attachen


```bash
docker create //erstellt einen container
docker start //startet container
docker run // createt einen neuen container und startet ihn
```


![[Pasted image 20251118095207.png]]
--das ist das Filesystem, welches im Image gespeichert wurde
exi
wenn man in dem speicherbereich was ändert, wird die zu verändernde Datei in den read-writable layer kopiert und dann die datei von dem layer genommen

mit exit wird der Prozess mit der PID 1, also bin/sh beendet, somit wird der container beendet


```bash
docker run --rm -it --name heisenberg alpine:latest

//--rm: sobald der container gestoppt wird, wird er gelöscht
```

![[Pasted image 20251118103938.png]]
//hier: neues image erstellt, deshalb ist nano not found

### Docker Volume

```bash
klemens@Klemens:~$ docker volume create wse-volume
wse-volume
klemens@Klemens:~$ docker volume ls
DRIVER    VOLUME NAME
local     wse-volume
klemens@Klemens:~$ docker run -ti --rm -v wse-volume:/data alpine:latest
/ #

//-v: für volume. das vorher erstellte Volume wse-volume wird in das Verzeichnis /data vom container gemountet. -- wenn das Verzeichnis nicht vorhanden ist, wird es erstellt
```
// wenn der container gelöscht wird, bleibt das volume und kann z.B. in einen neuen Container gemountet werden

![[Pasted image 20251118104731.png]]

"Ein leeres Docker Volume übernimmt den Inhalt des Mountpoints. 
Ein befülltes Volume überschreibt den Inhalt des Mountpoints."

also: -v wse-bin:/data xxx

wenn wse-bin leer:
- alles in /data wird ins volume wse-bin geschrieben
wenn wse-bin gefüllt
- alle Inhalte von wse-bin wird in /data geschrieben und alles in data wird überschrieben


### Bind Mounts
Es können auch Ordner vom Hostsystem in einen container gemappt werden


## Docker images builden

```bash
  GNU nano 6.2                              Dockerfile *
FROM freepascal/fpc:3.2.2-alpine-3.19-full
WORKDIR /app
COPY ./HelloWorld.pas .
RUN fpc -Mtp -Criot -gl -gh HelloWorld.pas

```