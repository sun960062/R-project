# R Functions Exercises
#Ex1
go_away <- function(name){
  print(paste('Fuck off!!', name))
}
go_away('jerk')
#Ex2

#Ex1
prod <- function(a,b){
  print(a*b)
}
prod(3,4)

#Ex2
num_check <- function(num, v){
  for(item in v){
    if (item == num){
      return(TRUE)
    }
  }
  return(FALSE)
}
num_check(2,c(1,4,5))

#Ex3
num_count <-function(num1,v){
  count = 0
  for(item1 in v){
    if (item1 == num1){
      count = count+1
    }
  }
  return(count)
}
num_count(2,c(1,1,2,2,3,3))

#Ex4
bar_count <- function(totalkilo){
  for(kilo in totalkilo){
    fivekilobars <- kilo %/% 5
    onekilobars <- kilo %% 5
  }
  return (print(fivekilobars + onekilobars))
    
}
bar_count(5)
bar_count(80)
bar_count(81)

#Ex5
summer <- function(a, b, c){
  out <- c(0)
  if (a %% 3 != 0){
    out <- append(a,out)
  }
  if (b %% 3 != 0){
    out <- append(b,out)
  }
  if (c %% 3 != 0){
    out <- append(c,out)
  }
  return(sum(out))       
}

summer(5,7,9)

#Ex6
prime_check <- function(num) {
if (num == 2) {
  return(TRUE)
} else if (any(num %% 2:(num-1) == 0)) {
  return(FALSE)
} else { 
  return(TRUE)
}
}
prime_check(9777)
