# Trump-Hass auf Twitter

Analyse von 34771 von Donald Trump verfassten Twitter-Meldungen zwischen dem 4. Mai 2009 und dem 13. August 2019.

![Trump Hate](dt.png)
Source: [Gage Skidmore](https://www.flickr.com/photos/gageskidmore/32758233090)


## 0 Checkliste

- These formulieren: **Trumps Hass nimmt zu. Aber er erhält dafür weniger Applaus.**
- These checken: Relevanz? neu? Aufwand/Ertrag? **Es gab ähnliche Geschichten, aber nichts Umfassendendes zu allen Trump-Tweets. Aufwand und Ertrag ist überschaubar. Am Ende 2 Arbeitstage.**
- Knackpunkt bestimmen = Priorität für Recherchestart
- Briefing Person konsultieren **Fiel in diesem Fall weg.**
- Daten beschaffen/reinigen/analysieren/visualisieren -> These justieren
- Ergänzen durch klassische Recherche (Experten, Politiker etc.)
- Dokumentieren Code und statistische Annahmen
- Link auf Publikation



## 1 Daten-Quelle

Für die Untersuchung berücksichtigt, wurden alle 34'771 Kurzmeldungen, die der 45. US-Präsident Donald Trump zwischen dem 4. Mai 2009 und dem 13. August 2019 im sozialen Netzwerk publiziert hat. Abgelegt sind die Inhalte im [«Trump Twitter Archive»](http://www.trumptwitterarchive.com).
Enthalten sind auch die Tweets, die nachträglich gelöscht wurden. Ausgeschlossen wurden die rund 2000 Weiterleitung von Meldungen anderer Twitter-Nutzer, sogenannte Retweets. Die effektiv verwendeten Daten im .csv Format [sind hier](https://github.com/tamedia-ddj/trumphate/blob/master/trumptweets.csv).

## [2 Sentiment-Analyse](https://github.com/tamedia-ddj/trumphate/blob/master/1.%20Sentiment%20Analysis.ipynb)

Um die Meldungen in positiv, negativ oder neutral formulierte Meldungen zu kategorisieren, wurde der [«Vader Sentiment Analyzer»](https://github.com/cjhutto/vaderSentiment) verwendet. Dabei handelt es sich um einen Algorithmus, dessen Code von einer Gruppe Forschern offen im Internet publiziert ist. Er ist speziell darauf ausgelegt, die Tonlage von Englisch-sprachigen Social-Media-Inhalten zu kategorisieren.

Der Algorithmus nutzt dabei unter anderem ein Lexikon von Wörtern, die entweder als positiv, neutral oder negativ definiert sind. Berücksichtigt wird in der Analyse aber auch die Interpunktion oder die Information, ob gewisse Wörter in Grossbuchstaben verfasst werden. Die Kombination aller Parameter ergibt pro Meldung einen Wert, der zwischen 1 und -1 liegt. In der vorliegenden Analyse wurde alles, was einen Wertung von unter -0,5 hatte, als negativ klassifiziert; alles was zwischen -0,5 und 0,5 als neutral; alles über 0,5 als positiv. Mit diesem System wurden 16181 als neutral, 13720 als positiv und 4870 als negativ klassifiziert. Zur Qualitätskontrolle wurden nachträglich 100 klassifizierte Meldungen von Hand geprüft. In allen Fällen war die Klassifizierung sinnvoll. Mehr über die Methode kann [hier nachgelesen werden](http://comp.social.gatech.edu/papers/icwsm14.vader.hutto.pdf), und [hier ist der eigentliche Code abgelegt](https://github.com/cjhutto/vaderSentiment).

## [3 Namensextraktion](https://github.com/tamedia-ddj/trumphate/blob/master/2.%20Name%20Extraction.ipynb)

Zur Extrahierung der Namen wurde der auf die Programmiersprache Python basierte Werkzeugkasten [Natural Language Toolkit] (NTLK)](https://www.nltk.org) verwendet. Die in einem ersten Durchlauf ermittelten Namen wurden dann von Hand zusammengeführt. Zum Beispiel: «Crooked Hillary» und «Hillary Clinton» oder «Loser Obama» und «Barack Obama».

## 4 Artikel
[Publikation auf Tages-Anzeiger.ch](https://www.tagesanzeiger.ch/ausland/Trumps-Hasstiraden-in-den-sozialen-Medien-nehmen-unaufhoerlich-zu/story/11406769)
