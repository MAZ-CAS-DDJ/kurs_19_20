# 02 Einstieg ins Programmieren: Hausaufgaben

Nun wollen wir mit unsere Commandline Skills mit einem richtig grossen Datensatz üben. Wir arbeitn mit den Google Copyright Infringement Meldungen. Das sind über 3 Milliarden Meldungen, die in den letzten Jahren bei Google eingegangen sind. Ihr findet sie [hier](https://transparencyreport.google.com/copyright/explore?hl=en). Ganze 3,2 GB. Und [hier](https://storage.googleapis.com/transparencyreport/google-websearch-copyright-removals.zip) könnt ihr die Daten runterladen.

1. Nachdem ihr die Daten herunter geladen habt, sucht den Befehl, um die Daten zu entzippen.
- ```unzip google-websearch-copyright-removals.zip -d google```

2. Lesen wir zuerst das README Kopfzeile
- ```cat README.txt```

3. Schauen wir uns die Kopfzeile der "Domains" Daten an, damit ihr wisst, was sich in den drei Datensammlungen überhaupt befindet.
- ```head domans.csv```

4. Suchen wir all ".ch" Domains in den Datensatz. (Das dauert nun eine Weile)
- ```grep "\.ch" domains.csv```

5. Speichern wir das ab als ch_domains.csv:
- ```grep "\.ch" domains.csv > ch_domains.csv```

6. Und nun zählen wir die Linien in diesem Kopfzeile
- ```wc -l ch_domains.csv```
- ```grep \.ch domains.csv | wc -l``` (das geht auch, ohne das Abspeichern)

7. Rufen wir csvstat auf, um die häufigsten Schweizer Domains zu zählen.
- ```csvstat ch_domains.csv```
