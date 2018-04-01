
# extract the nouns from the tweets and create a bar graph:



import numpy as np
import pandas as pd
from pandas.io.json import json_normalize
import pip
#pip.main(['install', 'requests'])
#pip.main(["install","Twitter"])
import  twitter
from twitter import Twitter
from twitter import OAuth
import matplotlib.pyplot as plt

get_ipython().system('python -m textblob.download_corpora')
from  textblob import TextBlob





ck="OwENz4tXuarnZIi0PKtmfhlh7"
cs="L3IOhPkMhKyFH6zAHcQEKLqRWBwDIwPdRiexcBs0j11rtkVdPO"
at="451334829-k8h4sCMhPTqd9JhhlqzoJcvMAZSdk6v3mlJc91cY"
ats="d6JdyHLrP1VkxXccadjlxvTN2YWi6f0IxeqtHl0jrM3lV"

oauth=  OAuth(at,ats,ck,cs)
api= Twitter(auth=oauth)


# In[36]:


query = api.search.tweets(q='H1B', count=1000)
mid=0;
df=pd.DataFrame()    
for i in range(10):
    if i==0:
        search_result= api.search.tweets(q="H1B", count=100)
    else:
        search_result= api.search.tweets(q="H1B", count=100, max_id=mid)
    
        dftemp= json_normalize(search_result,'statuses')
        mid= dftemp['id'].min()
        mid=mid-1
        df=df.append(dftemp,ignore_index=True)
    


# In[38]:


tweettext=df['text']

wordlist=pd.DataFrame();


for t in tweettext:
    tx= TextBlob(t)
    tx.tags
    for word, tag in tx.tags:
        if tag=='NN':
            l= list(tx.noun_phrases)
            if len(l)!=0:
                wordlist= wordlist.append(l, ignore_index=True)




allword=wordlist.groupby(0).size()
top20allwords=allword.sort_values(0,ascending=False).head(20)
top20allwords.plot(kind='bar',title='top20') 
plt.show()


