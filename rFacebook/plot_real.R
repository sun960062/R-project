---
陳學聖 <- c(kmt22$message, kmt22$message, kmt22$created_time, kmt22$link) # iris 是 R 內建的資料。
write.table(陳學聖, file = "陳學聖.CSV", sep = ",")
---

kmt07_mes<- data.frame(kmt07$story, kmt07$message, kmt07$created_time, kmt07$link)
colnames(kmt07_mes)<-c("artTitle", "artContent", "artDate", "artUrl")
write.csv(kmt07_mes, file = "luyuling.csv")

# data cleaning 

library(dplyr)
library(ggplot2)
library(reshape2)
library(plyr)

dpp24 <- ddp24
dpp24 <- filter(dpp24, dpp24$from_name == "柯建銘") #根據名稱做篩選
dpp24$date <- as.Date(dpp24$created_time) #將資料中的日期先做整理
dpp24$count <- 1 # 統計每天發文數量

kmt10_analysis <- kmt10[kmt10$date <= "2016-09-01",] #根據日期做分群，並且存成新檔案

######################################################
# 以此類推可以將其他資料進行清理，以及針對時間做分群 #
######################################################
library(plyr)

dpp24_plot <- ddply(dpp24, .(date), summarize, posts=sum(count)) # 根據天數統計貼文

ggplot(dpp19_plot, aes(x=date, y=posts))+geom_smooth()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_x_date(date_labels = "%b %Y")+ylab("Posts")+xlab("Date")+
  ggtitle("林淑芬發文頻率")  # 較簡單的畫圖方法：根據單一資料畫圖

## 目前製圖部份中文似乎還是亂碼，無法顯示

