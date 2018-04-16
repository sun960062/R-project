# RMatrix Exercise
# Ex1
A <- c(1,2,3)
B <- c(4,5,6)
cbind(A,B)
rbind(A,B)
#Ex2
mat <- matrix(data=c(1:9),nrow = 3,ncol = 3)
mat
#Ex3
is.matrix(mat)
#Ex4
mat2 <- matrix(data=c(1:25), nrow=5,ncol =5,byrow = T)
mat2
#Ex5
mat2[2,2:3]
mat2[3,2:3]
mat2[2:3,2:3]
#EX6
mat2[4:5,4:5]
#Ex7
sum(mat2)
#Ex8
runif(20,min = 0, max = 100)
