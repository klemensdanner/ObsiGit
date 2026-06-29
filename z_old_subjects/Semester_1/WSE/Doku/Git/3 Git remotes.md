regelmäßig mergen oder rebasen, sonst verwendet man in seiner branch alte Funktionen etc.

### Semantische Inkompatiblität
- Bei strukturellen Änderungen (bsp. an Funktionen, die im Hauptbranch definiert wurden, und im feature branch verwendet wird)
- deshalb oft änderungen aus dem Mainbranch in den Feature-Branch holen.
- vorm merge commit noch mal änderungen aus dem main branch holen, testen
	- so kann man solche semantischen Inkompabilitäten vermeiden


Ein git merge merged alles ausgehend von der gemeinsamen Basis

```bash
$ git branch -d old-gamma
$ git branch -D old-gamma //das selbe aber forced delete!
```

```bash
kleme@Klemens MINGW64 /c/public/wse-ws25/shopping-list (main)
$ git remote -v

kleme@Klemens MINGW64 /c/public/wse-ws25/shopping-list (main)
$ git config --global alias.remotes 'remote -v'

```


#git Add #gitremote
```bash
$ git remote add origin https://github.com/klemensdanner/wse-shopping-list-ws25.git


//alle commits, die von main aus erreichbar sind, werden ins remote-repo 'origin' gespeichert
$ git push origin main
```



#gitAlias
```bash
$ git config --global alias.branches 'branch -vva'
```


### verschiedene Branches

| tracking local branches  |                                                                                                               |
| ------------------------ | ------------------------------------------------------------------------------------------------------------- |
| remote tracking branches | branch: origin/main: wurde bei git push erstellt<br>- git fetch und git push aktualisieren diese branches<br> |
| local branches           | z.B. 'main' - Nach dem Aufruf von git push wird ein remote tracking branch erstellt                           |
| remote branches          | bei uns 'origin', --> github.com/blabla.git<br>                                                               |

```bash
$ git push origin main // git push {Änderungen im aktuellen Branch werden gepusht} origin {ins remote repo origin} main {in den branch main}
```
neue commits im aktuellen branch werden gepusht

dabei muss man immer ---origin main angeben

was man machen kann ist, dass man den branch main in einen Tracking Local Branch verwandelt, welcher dann mit dem remote tracking branch verknüpft ist
```bash
//geht mit:
git 
```

```bash
git fetch //lädt neue branch infos vom remote repo
```

![[Pasted image 20251114102025.png|400]]
// 'zulu' wurde im remote repo erstellt. wenn man auf ihn switched, wird für ihn ein tracking local branch erstellt. wenn man änderungen von dort pushed wird es automatisch auf origin/zulu gepusht

```bash
$ git push -d origin zulu
//das löscht zulu im remote repo
```
der tracking local branch zeigt aber noch auf zulu im remote tracking branch - im remote gibts den aber nicht mehr

![[Pasted image 20251114102745.png|400]]

zulu ist jetzt wieder ein ganz normaler local branch

Bei git fetch werden neue commits vom remote-repo ins remote tracking repo übernommen aber noch nicht mit dem tracking local branches (bei uns main) gemerged.
git pull versucht das zu mergen.
pull:
1. git fetch
2. git merge

## git clone

Es wird immer der branch gecloned, auf den der head im remote repo zeigt. By default ist das main.

### General
wenn man im remote repo eine änderung rückgängig macht, b


#prüfung 
graph gegeben, z.b. was reintegrieren