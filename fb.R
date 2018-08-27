library(httr)

name = "sujiachyuan"
token = "EAACEdEose0cBAPSpBUaGIz3CSnDYtjH49vhl8XUzoEGCLqZBZAAQZALSU9FVwLJ9jL69Nu74ixm3vnOaPhLlg0ZAeTddcW0OUrVCjf8MM14RamA6ZAlYmKHqAv3pdJds0JZCzv9Ka6JA9d94y72ucpjpOkaZCWiyoEjZBK3G31ZAlZCrmb2Naggz9O72UCYZAJRKvZCIxEgl3wt7SUcCZAZBZBaX7Jhc6iTylHp8Q0ZD"

url = paste0("https://graph.facebook.com/v2.12/",
             name,
             "/feed?access_token=",
             token)

res = httr::GET(url)
post = content(res)

while( !is.null(url) )
{
  if( is.null(post$posts$data) )
  {
    data = post$data
  }
  else
  {
    data = post$posts$data
  }
  pageNo = length(data)
  from = 1
  date = data[[from]]$created_time
  currentY = strsplit(date, '-')[[1]][1]
  currentM = strsplit(date, '-')[[1]][2]
  currentM = paste0(currentY,'_',currentM)
  saveData = list(data[[from]])
  saveData2 = list(data[[from]]$message)
  print(saveData2)
  
  for( id in c(2:pageNo) )
  {
    date = data[[id]]$created_time
    year = strsplit(date, '-')[[1]][1]
    month = strsplit(date, '-')[[1]][2]
    month = paste0(year,'_',month)    
    if( currentM == month )
    {
      to = id
      saveData2 = append(saveData2, data[[to]])
    }
    else
    {
      filename = paste0("./",name,"/",currentM,".txt")
      currentM = month
      write(unlist(saveData2), filename, append = TRUE)
      write("\nCounter:", filename, append = TRUE)
      write(length(saveData2), filename, append = TRUE)
      from = to
      saveData2 = list(data[[from]])
    }
  }
  
  url = paste0(post$paging$`next`,
               post$posts$paging$`next`)
  res = httr::GET(url)
  post = content(res)
}

rm(list=ls())
