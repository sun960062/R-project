install.packages('rjson')
install.packages('data.table')
install.packages('text2vec')
install.packages('lda')
library('data.table')
library('text2vec')
library('lda')

data <- fread("Ma_artWord.csv",encoding = "UTF-8")
column <- names(data)[1:ncol(data)]

temp <- data[1]$artTitle
mystr = "" # Set default String
text = c()
id = c()
id <- append(id, temp) # Set start title_id

str_vec = c() # word segmentation in one document
str_vec_name = c() # names for str_vec
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
    str_vec_name = c(str_vec_name, temp)
    temp <- data[i]$artTitle
    str_vec = c()
  }
}
text <- append(text, mystr) 
tokens[[temp]] = str_vec # append the last document
str_vec_name = c(str_vec_name, temp)

names(tokens) <- str_vec_name
post_text <- data.frame(id, text)

# Preprocessing
ids = post_text$id[1:nrow(post_text)]
txt = tolower(post_text$text[1:nrow(post_text)])
names(txt) = ids
it = itoken(tokens, progressbar = FALSE, ids = ids)
vocab = create_vocabulary(it)
# Remove setting
vocab = prune_vocabulary(vocab, term_count_min = 1, doc_proportion_min = 0.01)
dtm = create_dtm(it, vectorizer = vocab_vectorizer(vocab))

# Parameters for LDA
# topics = c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
topic <- seq(from = 5 , to = 100 ,by = 5) 
perplexity = c()
for(n_topic in topic){
  n_iter = 10
  model = LDA$new(n_topic, doc_topic_prior = 0.1, topic_word_prior = 0.01)
  doc_topic_distr  =
    model$fit_transform(dtm, n_iter = n_iter, n_check_convergence = 1,
                        convergence_tol = -1, progressbar = FALSE)
  topic_word_distr_10 = model$topic_word_distribution
  perplexity <- c(perplexity, perplexity(dtm, topic_word_distr_10, doc_topic_distr))
}
plot(topic, perplexity, type = 'b', col = "blue", pch = 19)

