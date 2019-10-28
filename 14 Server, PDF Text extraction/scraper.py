
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
import time
import pandas as pd
from bs4 import BeautifulSoup

#Wir starten den Browser auf
driver = webdriver.Chrome(executable_path='/usr/local/bin/chromedriver')
#Und nun sagen wir dem Browser, welche Seite er besuchen sollte.
driver.get('https://www.zefix.ch')
#Geben wir ihm etwas ZEit
time.sleep(10)
#Und nun geben wir unseren Begriff ein. ZUerst suchen wir das richtige Feld. Wir benutzen dafür den Webinspector.
#https://selenium-python.readthedocs.io/locating-elements.html
search = driver.find_element_by_id('firm-name-fomfield')
#Jetzt schicken wir das, was wir suchen wollen
search.send_keys('bäckerei')
#Und jetzt suchen wir nach dem Button
click = driver.find_element_by_id('submit-search-btn')
#Und wir klicken
click.click()
#Das kann dauern, bauen wir zur Not genügend Zeit ein.
time.sleep(5)
#Und jetzt speichern wir diese ganze Seite ab. Den Inhalt rausziehen wollen wir später.
page = driver.page_source.encode('utf-8')
button = driver.find_elements_by_class_name('btn')[14]
with open("page.htm", "wb+") as file:
    file.write(page)
    file.close()
#its the 14th page
for elem in range(35):
    driver.find_elements_by_class_name('btn')[14].click()
    time.sleep(3)
    page = driver.page_source.encode('utf-8')
    with open("pages/page"+str(elem)+".htm", "wb+") as file:
        file.write(page)
        file.close()
