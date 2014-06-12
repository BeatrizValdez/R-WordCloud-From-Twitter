# install.packages("twitteR")
# install.packages("ROAuth")
# install.packages("tm")
# install.packages("wordcloud")

library("twitteR")
library("ROAuth")
library("tm")
library("wordcloud")

load("twitter authentication.Rdata")
registerTwitterOAuth(cred)

tweets <- searchTwitter("#bigdata", n=499, cainfo="cacert.pem", lang="en")
tweets.text <- sapply(tweets, function(x) x$getText())

#convert all text to lower case
tweets.text <- tolower(tweets.text)

# Replace blank space ("rt")
tweets.text <- gsub("rt", "", tweets.text)

# Replace @UserName
tweets.text <- gsub("@\\w+", "", tweets.text)

# Remove punctuation
tweets.text <- gsub("[[:punct:]]", "", tweets.text)

# Remove links
tweets.text <- gsub("http\\w+", "", tweets.text)

# Remove tabs
tweets.text <- gsub("[ |\t]{2,}", "", tweets.text)

# Remove blank spaces at the beginning
tweets.text <- gsub("^ ", "", tweets.text)

# Remove blank spaces at the end
tweets.text <- gsub(" $", "", tweets.text)

#create corpus
tweets.text.corpus <- Corpus(VectorSource(tweets.text))

#clean up by removing stop words
tweets.text.corpus <- tm_map(tweets.text.corpus, function(x)removeWords(x,stopwords()))

#generate wordcloud
wordcloud(tweets.text.corpus, 
          min.freq = 3, 
          scale=c(7,0.5), 
          colors=brewer.pal(8, "Dark2"), 
          random.color= TRUE, 
          random.order = FALSE, 
          max.words = 150)
