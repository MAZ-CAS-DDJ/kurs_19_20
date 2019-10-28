# Servers

-> [Anleitung für Windows](https://tutorials.ubuntu.com/tutorial/tutorial-ssh-keygen-on-windows#0)

1. Zuerst machen wir einen Krypto-Schlüssel: ```ssh-keygen -t rsa -C "your_email@example.com".```  RETURN, RETURN, RETURN.
2. Jetzt sehen wir den public Key an: ```cat ~/.ssh/id_rsa.pub```
   Diesen Schlüssel kopieren wir.
3. Öffne digital ocean
4. Kreiere ein Droplet
   Ubuntu 14.04.4 x64
   $5/mo
   Am besten einen europäischen Standort wählen
   New SSH Key
5. Also: ```ssh -i ~/.ssh/id_rsa root@YOUR_IP```
   Mit ```exit```kommen wir wieder raus.
6. Nun sollten wir mit dem Server verbunden sein.
   Testen wir: ```pwd```, ``ls```
   - ```curl http://www.watson.ch > watson.txt```
   - ``ls``
   - ```cat watson.txt```
   - ```python --version```
   - ```python3 --version```
   - ```apt-get update```
   - ```apt-get upgrade```
   - Keep the current version
   - ```apt-get install mailutils```
   - Wenn ein pinker Screen angezeigt wird, Taste "->", wähle "Internet" aus.
   - ```curl 'https://bootstrap.pypa.io/get-pip.py' > get-pip.py && sudo python get-pip.py```
   - ```apt-get install build-essential```
   - ```apt-get install python3-dev```
   - ```apt-get install python3-numpy```
   - ```apt-get install python3-scipy```
   - ```apt-get install libatlas-dev```
   - ```apt-get install ipython3```
   - ```apt-get install python3-pandas```
   - ```apt-get install libxml2-dev libxslt1-dev```
   - ```apt-get install python3-matplotlib```
   - ```apt-get install python3-pip```
   - ```pip3 install requests```
   - ```pip3 install bs4```

6. Grundbefehle
   - Verbindung mit dem Server. In der Command line folgende Zeile eingeben:
   - ```ssh -i ~/.ssh/id_rsa root@DEINEIP```
   - Etwas auf Deinen Server spielen: ```scp -i ~/.ssh/id_rsa deinfile root@DEINEIP:~/```
   - File vom Server nehmen, in diesem Fall all csvs: ```scp -i ~/.ssh/id_rsa root@DEINEIP:~/*.csv .```
   - Den Script ausführen starten: ```python3 deinscript.py```
   - Crontab editor definieren: ```export EDITOR=nano```
   - Crontab editor starten: ```crontab -e```

7. Server schliessen und dennoch laufen lassen
   - ```tmux```
   - Code eingeben
   - ```tmux attach```um sich wieder zu verbinden. Sonst bricht man die andere Verbindung ab.

____________________________________________________

Und jetzt bauen wir einen [Headless Scraper](https://docs.google.com/document/d/1LIO5-VXDW2piwR8gAHPT8rJS2N6CLCIsY6deJsjU9LE/edit) mit Selenium auf unserem Server.
