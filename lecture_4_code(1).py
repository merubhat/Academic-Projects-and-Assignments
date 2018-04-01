import json
import pip
pip.main(['install','twitter'])
pip.main(['install','textblob'])

from textblob import TextBlob
!python -m textblob.download_corpora

from twitter import Twitter
from twitter import OAuth
from twitter import TwitterHTTPError
from twitter import TwitterStream

#import numpy and pandas
import numpy as np
import pandas as pd
#import json normalize
from pandas.io.json import json_normalize

#twitter keys
ck = "gwEdUQjvo9JDSLMpii205Q06O"
cs = "OlA4PIlLfpZ5HcEAGPOIJx4DwduhmACShoGQ66mJYt4ocxShwX"
at = "823996990329589760-1wW34frljiy7HrWp777qGFzOhEZksMW"
ats = "nzbKJCBUqlCsP6MNe5CFrOzZHo4wcvbubt1nJTqRkvFiB"
oauth = OAuth(at,ats,ck,cs)

#OAuth


#Twitter search
api = Twitter(auth=oauth)

t_loc = api.trends.available()
loc_df = json_normalize(t_loc)
loc_df[(loc_df['countryCode']=='US') & (loc_df['name'].str.contains('New'))]
ny_trend = api.trends.place(_id = 2459115)
nydf = json_normalize(ny_trend,'trends')
nydf.head()
nydf.sort_values('tweet_volume',ascending=False).head(5)



q='StudentsStandUp'
df = pd.DataFrame()
mid = 0
for i in range(10):
    if i==0:
        search_result = api.search.tweets(q=q, count = 100)
    else:
        search_result = api.search.tweets(q=q, count=100, max_id=mid)
        
    dftemp = json_normalize(search_result,'statuses')
    mid = dftemp['id'].min()
    mid = mid - 1
    df = df.append(dftemp, ignore_index = True)

df.shape

tweettext = df['text']
blob = TextBlob(tweettext[0])
list(blob.noun_phrases)
blob.tags


wordlist = pd.DataFrame()
for t in tweettext:
    tx = TextBlob(t)
    l = list(tx.noun_phrases)
    if len(l)!=0:
        wordlist = wordlist.append(l,ignore_index=True)

allword = wordlist.groupby(0).size()
allword

top20allword = allword.sort_values(0,ascending=False).head(20)
top20allword.plot(kind='bar',title='Top 20 words')

wordlist = pd.DataFrame()
for t in tweettext:
    tx = TextBlob(t)
    l = list(tx.words.lemmatize())
    if len(l)!=0:
        wordlist = wordlist.append(l,ignore_index=True)

allword = wordlist.groupby(0).size()
allword

top20allword = allword.sort_values(0,ascending=False).head(20)
top20allword.plot(kind='bar',title='Top 20 words')

wordlist = pd.DataFrame()
for t in tweettext:
    tx = TextBlob(t)
    ww = []
    for word, tag in tx.tags:
        if tag in ('NN', 'NNS', 'NNP', 'NNPS'):
           ww.append(word.lemmatize())
    if len(ww) !=0:
        wordlist = wordlist.append(ww, ignore_index=True)

allword = wordlist.groupby(0).size()



allword

top20allword = allword.sort_values(0,ascending=False).head(20)
top20allword.plot(kind='bar',title='Top 20 words')

#Lab part 3b
pip.main(['install','newspaper3k'])
import newspaper

url = 'https://www.bloomberg.com/news/articles/2018-02-22/if-you-believe-quants-nothing-happened-in-markets-this-month'
article = newspaper.Article(url)
article.download()
article.parse()
article.title
article.nlp()
article.keywords
article.summary
blob2 = TextBlob(article.text)

blob2.sentences[1]

wordlist = pd.DataFrame()
ssList=[]
for t in blob2.sentences:
    ww = []
    for word, tag in t.tags:
        if tag in ('NN', 'NNS', 'NNP', 'NNPS', 'VB', 'VBD', 'VBG', 'VBN', 'VBP', 'VBZ'):
            ww.append(word.lemmatize())
    ss = ' '.join(ww)
    ssList.append(ss.lower())
wordlist = wordlist.append(ssList, ignore_index=True)    

wordlist
len(blob2.sentences)
wordlist.to_csv('summary.csv')
