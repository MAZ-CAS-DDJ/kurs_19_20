import requests
from bs4 import BeautifulSoup
import pandas as pd

r = requests.get("https://www.ecb.europa.eu/home/html/index.en.html")
soup = BeautifulSoup(r.text, 'html.parser')
percentage = soup.find_all('td', {'class':'stats-table-percentage'})
title = soup.find_all('td', {'class':'stats-table-figure'})

percentagelist = []
#Hier beginnt der For Loop
for e, t in zip(percentage, title):

    #Hier lese ich aus beiden Listen die Elemente heraus
    #das e Element aus der Percentage-Liste berücksichigt nur den Text
    #und ersetzt die Zeichenfolge xa0 mit nichts
    #Das t Element zieht nur den Text aus dem HTML Tag.
    #Daraus wird eine Mini-Dictionary
    minidict = {'Title':t.text,
                'Percentage':e.text.replace('\xa0','')}
    #Hier wird die erstelle Mini-Dictionary der Percentagliste angehängt
    #Daraus entsteht eine Liste von Dictionaries
    percentagelist.append(minidict)

#Diese Dictionaryliste wird in ein csv umgewandelt und abgespeichert.
pd.DataFrame(percentagelist).to_csv('percentage.csv')
