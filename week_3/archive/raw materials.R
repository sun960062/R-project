require(lattice)
histogram(x= ~ building size | school name,  # 根據月份(Month)的條件，繪製臭氧(Ozone)的直方圖
          data=Ground,     
          xlab="學校名稱")

Ground$`school name`<- as.integer(Ground$`school name`)
Ground$`building size`<- as.numeric(Ground$`building size`)
xyplot(x= Ground$`building size`~ Ground$`school name`,  # Wind放在Y軸，Temp放在X軸，並根據Month條件分別繪圖
       data=Ground)

hist(x=Ground$`building size`, 
     main="School size",         # 圖片的名稱
     xlab="name",                      # X軸的名稱
     ylab="m^2")  

histogram(x= ~ Ozone | Month,  # 根據月份(Month)的條件，繪製臭氧(Ozone)的直方圖
          data=airquality,     
          xlab="Ozone(ppb)",  
          layout=c(5,1))       # 以5x1的方式呈現圖表

ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()
xyplot(x=mtcars$disp ~ mtcars$mpg,  # Wind放在Y軸，Temp放在X軸，並根據Month條件分別繪圖
       data=mtcars)





require(datasets)
head(airquality)

hist(x=airquality$Month, 
     main="Histogram of Month",         # 圖片的名稱
     xlab="Month",                      # X軸的名稱
     ylab="Frequency")                  # Y軸的名稱

boxplot(formula = Ozone ~ Month, # Y ~ X (代表X和Y軸要放的數值) 
        data = airquality,       # 資料
        xlab = "Month",          # X軸名稱
        ylab = "Ozone (ppb)",    # Y軸名稱
        col ="gray")             # 顏色

plot(x=airquality$Month,            # X軸的值
     y=airquality$Temp,             # Y軸的值
     main="Month to Temperature",   # 圖片名稱
     xlab="Month(1~12)",            # X軸名稱
     ylab="Temperature(degrees F)") # Y軸名稱       

plot(x=airquality$Ozone,      # X軸的值
     y=airquality$Wind,       # Y軸的值
     main="Ozone to Wind",    # 圖片名稱
     xlab="Ozone(ppb)",       # X軸的名稱
     ylab="Wind(mph)"         # Y軸的名稱
)
