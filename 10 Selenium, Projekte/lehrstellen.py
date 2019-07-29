from bs4 import BeautifulSoup
import requests
import time
import datetime
import pandas as pd
from selenium import webdriver
from selenium.webdriver.common.keys import Keys

#Funktion, um nur die Informationen herauszuziehen, die uns interessieren
def lehrstellen(html):

    soup = BeautifulSoup(html, 'lxml')
    try:
        ortsliste = soup.find('div', {'class':'resultpart result-body'})\
                    .find_all('div', {'class':'display-table-cell table-col-3'})

        firmenliste = soup.find('div', {'class':'resultpart result-body'})\
                    .find_all('div', {'class':'display-table-cell bold company data-id table-col-1'})

        jahresliste = soup.find('div', {'class':'resultpart result-body'})\
                    .find_all('div', {'class':'display-table-cell float-left-for-sd table-col-4'})

        anzahlliste = soup.find('div', {'class':'resultpart result-body'})\
                    .find_all('div', {'class':'display-table-cell text-align-center float-left-for-sd table-col-5'})

        lehrstelle = soup.find('ul',{'class':'ui-autocomplete full-list '})\
                    .find_all('a')
        lst = []

        for ort, firma, jahr, anzahl,lehr in zip(ortsliste,firmenliste,jahresliste, anzahlliste,lehrstelle):

            mini_dict = {'Ort':ort.text,
                     'Firma':firma.text,
                     'Jahr':jahr.text,
                     'Anzahl':int(anzahl.text.replace(' Lehrstelle(n)\n','').replace('\n','')),
                     'Lehrstelle':lehr['data-value']}
            lst.append(mini_dict)

        return pd.DataFrame(lst).to_csv("d/"+str(datetime.datetime.now())+".csv")

    except:
        return pd.DataFrame([{'Ort':'Keine Treffer',
                'Firma':'Keine Treffer',
                'Jahr':'Keine Treffer',
                'Anzahl':'Keine Treffer'}])

#Bauen wir Listen aller Job-IDs
r = requests.get('https://www.berufsberatung.ch/dyn/show/2930')
soup = BeautifulSoup(r.text, 'lxml')
ids = []
for elem in soup.find('ul',{'class':'ui-autocomplete full-list '}).find_all('a'):
    elem = "sw_" + elem['data-id']
    ids.append(elem)

#Teilen wir diese Listen mit Länge von je 5 Teilen.
#Das habe ich nicht selber geschrieben, sondern hier geholt:
#https://stackoverflow.com/questions/312443/how-do-you-split-a-list-into-evenly-sized-chunks
idslst = [ids[i:i + 5] for i in range(0, len(ids), 5)]

count = 13
for ids in idslst[13:]:

    #Starten wir den Chrome-Browser und besuchen die Site
    driver = webdriver.Chrome('/usr/local/bin/chromedriver')
    driver.get("https://www.berufsberatung.ch/dyn/show/2930")

    try:
        #Bereiten wir die Suche vor
        for elem in ids:
            time.sleep(1) #damit es nicht zu schnell geht
            print(elem)
            driver.find_element_by_class_name("fs-autocomplete-trigger").click()
            time.sleep(1)
            driver.find_element_by_id(elem).click()

            #Suchen wir
            time.sleep(3)
            driver.find_element_by_id("uxfs-action").click()

        #Nun nun sorgen wir dafür, dass alle Ergebnisse anzeigt werden.
        exists = 1
        while(exists==1):
            loadmore = driver.find_element_by_id("aSearchPaging")
            if loadmore.text == "MEHR ERGEBNISSE ANZEIGEN":
                driver.find_element_by_id("aSearchPaging").click()
                time.sleep(1)
            else:
                exists = 0

                print(count)
                count += 1

                lehrstellen(driver.page_source)
                driver.close()
    except:
        driver.close()
