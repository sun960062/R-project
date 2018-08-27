install.packages('later')
install.packages('LDAvis')
library('data.table')
library('text2vec')
library('later')

data <- fread("all_artWord.csv",encoding = "UTF-8")
column <- names(data)[1:ncol(data)]

temp <- data[1]$artTitle
mystr = "" # Set default String
text = c()
id = c()
id <- append(id, temp) # Set start title_id
str_vec = c() # word segmentation in one document
tokens = list() # word segmentation for each documents
for(i in 1:nrow(data)){
  # the same document
  if(data[i]$artTitle == temp){
    mystr <- paste0(mystr, data[i,5], " ")
    str_vec <- c(str_vec, unname(unlist(data[i,5])))
  }else{
    id <- append(id, data[i]$artTitle)
    text <- append(text, mystr)
    mystr = ""
    tokens[[temp]] <- str_vec
    temp <- data[i]$artTitle
    str_vec = c()
  }
}
text <- append(text, mystr) 
tokens[[temp]] = str_vec # append the last document
post <- data.frame(id, text)

doc.list <- tokens
term.table <- table(unlist(doc.list))
term.table <- sort(term.table, decreasing = TRUE) # sorted by term frequency

del <- term.table < 5| nchar(names(term.table)) < 2 # term frequency < 5 or len(term) <2
term.table <- term.table[!del]
vocab <- names(term.table)

get.terms <- function(x) {
  index <- match(x, vocab)
  index <- index[!is.na(index)]
  rbind(as.integer(index - 1), as.integer(rep(1, length(index))))
}
documents <- lapply(doc.list, get.terms)

K <- 25 # Topics
G <- 5000 # iteration times
alpha <- 0.10   
eta <- 0.02

# LDA
library(lda)
set.seed(357)
fit <- lda.collapsed.gibbs.sampler(documents = documents, K = K, vocab = vocab, num.iterations = G, alpha = alpha, eta = eta, initial = NULL, burnin = 0, compute.log.likelihood = TRUE)

theta <- t(apply(fit$document_sums + alpha, 2, function(x) x/sum(x)))  # Doc—Topic distribution matrix
phi <- t(apply(t(fit$topics) + eta, 2, function(x) x/sum(x)))  # Topic-Word distribution matrix
term.frequency <- as.integer(term.table)   # Term-Frequency
doc.length <- sapply(documents, function(x) sum(x[2, ])) # length of each Doc

# LDAvis
library(LDAvis)
json <- createJSON(phi = phi, theta = theta,
                   doc.length = doc.length, vocab = vocab,
                   term.frequency = term.frequency)
serVis(json, out.dir = './vis', open.browser = FALSE)


install.packages('rjson')
install.packages('data.table')
install.packages('text2vec')
install.packages('lda')
install.packages('later')
install.packages('LDAvis')
