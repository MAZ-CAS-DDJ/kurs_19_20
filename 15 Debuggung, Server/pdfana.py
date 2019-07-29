
# coding: utf-8

# # Übersichtlichen .py Code zusammenbauen

# In[2]:


#Imports
import os
import progressbar
import textract
import pandas as pd


# In[ ]:


#Vorbereitung
pdfs = os.listdir('pdfs')
bar = progressbar.ProgressBar()
lst = []


# In[ ]:


#Rohe Analyse
for pdf,i in zip(pdfs, bar(range(len(pdfs)))):
    try:
        text = textract.process("pdfs/"+pdf, method='pdfminer', encoding='ISO-8859-1')
        text = text.decode("ISO-8859-1").replace("\n", " ")
        if len(text) < 40:
            text = textract.process("pdfs/"+pdf, method='tesseract', language='deu')
            text = text.decode("ISO-8859-1").replace("\n", " ")
            
        mini_dict = {'Text':text,
                     'File':pdf}
        lst.append(mini_dict)
    except:
        mini_dict = {'Text':'Fehlermeldung',
                     'File':pdf}
        lst.append(mini_dict)


# In[ ]:


#Erste Säuberung
df = pd.DataFrame(lst)
def date(elem):
    elem = elem[3:11]
    return elem
df['date'] = df['File'].apply(date)
df['date'] = pd.to_datetime(df['date'], format='%Y%m%d')
df.index = df['date']
#Suchen wir noch nach Implantaten
df['implant'] = df['Text'].str.contains('implant')
df.to_csv('datafile.csv')


# In[ ]:




