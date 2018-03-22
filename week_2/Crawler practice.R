rm(list = ls())
library(rvest)
url <- "http://news.ltn.com.tw/list/newspaper/politics/20180322"
res <- read_html(url)
title =html_nodes(res,".tit p")   
title =html_text(title)
title =iconv(title,"UTF-8")
title
url=read_html("http://news.ltn.com.tw/list/newspaper/politics/20180322")
url=html_nodes(url,".tit p")
url=html_attr(url,"href")
url   ## unsucceful



library(magrittr)
title=read_html("http://news.ltn.com.tw/list/newspaper/politics/20180322") %>% 
html_nodes(".tit p") %>% 
html_text() %>% iconv("UTF-8")
title
