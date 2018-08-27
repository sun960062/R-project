install.packages("Rfacebook")
library(Rfacebook)

kmt10 <-data.frame() # 命名data frame的名稱

i<-1
tryCatch( {
  p<- getPage("Bikhim", token =fb_oauth, n=10000, feed = TRUE, reactions = TRUE) # getpage 這個指令後面必須貼上粉絲頁的id
}, error=function(e) {
  print(e)
  return(NULL)
})
if(!is.null(p)) {
  ddp46<-rbind(ddp46,p) # 這邊的data frame名稱必須跟上面開頭的一致
}
i<-i+1
print(i)