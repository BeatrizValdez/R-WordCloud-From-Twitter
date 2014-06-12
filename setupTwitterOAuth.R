# install.packages("twitteR")
# install.packages("ROAuth")

library("twitteR")
library("ROAuth")


# Download "cacert.pem" file
download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")

#create an object "cred" that will save the authenticated object that we can use for later sessions
cred <- OAuthFactory$new(consumerKey='4FqJ1OcYADoBg7fiTLc9nsUTN',
                         consumerSecret='4y0Jj4KSVnmUucARm8tXFz06wtbCPBON32pPzSdvw9i2HEx7MR',
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')

# Executing the next step generates an output --> To enable the connection, please direct your web browser to: <hyperlink> . Note:  You only need to do this part once
cred$handshake(cainfo="cacert.pem")

#save for later use for Windows
save(cred, file="twitter authentication.Rdata")
