library(stringr)

complete <- function(directory,id=1:332) {
  nobs <- numeric()
  for(currentid in id){
    filename <- paste(directory,str_pad(currentid,3,pad="0"),".csv",sep="")
    print(currentid)
    moni <- read.csv(filename)
    nobs <- c(nobs,nrow(moni[complete.cases(moni),]))
  }
  data.frame(id=id,nobs=nobs)
}