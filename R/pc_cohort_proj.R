#This is work in progress. The processes will later be automated by compiling the steps in a function

#Fertility
#Mortality
#Migration

#Life table....




# This may need some extra work. One just need to input only nMx or just ndx 
# and specify whether to produce it at single year or 5-year intervals. To 
# motivate you further, let's redo using a function below

#First clear the memory of everything
#Highlight the function from line 64 to 90 and run it.
#


life_table <- function(x,n,nMx)
{
  nkx <- c(0.33,1.56,rep(2.5,length(nMx)-2))
  
  nqx <- round((n*nMx)/(1 + (n - nkx)*nMx),4)
  
  lx <- c(100000)
  for (i in 2:length(nqx))
  {
    lx[i] <- round(lx[i-1] - lx[i-1]*nqx[i-1]) 
    #Lx[i] <- (lx[i-1] + lx[i])*2.5
  }
  
  ndx <- round(nqx*lx)
  nLx <- n * lx - ndx*(n - nkx)
  
  Tx <- NA
  
  for (i in 1:length(nqx))
  {
    Tx[i] <- sum(nLx[i:length(nqx)])
    #Lx[i] <- (lx[i-1] + lx[i])*2.5
  }
  
  ex <- Tx/lx
  as.data.frame(cbind(x,n,nMx,nkx, nqx,lx,ndx,nLx,Tx,ex))
}

#We can now use the function to produce any life table of our choice. 



#The function needs inputs x=age groups, n= intervals  and nMx. For now, let's 
#use what we had before

x   <- c(0,1,seq(5,75,5))
n   <- c(1,4,rep(5,(length(x)-2)))
nMx <- c(0.1072,0.0034,0.0010,0.0007,0.0017,0.0030,0.0036,0.0054,0.0054,0.0146,0.0128,0.0269,0.0170,0.0433,0.0371,0.0785,0.0931)

life_table(x,n,nMx)

#POPULATION SMOOTHING

#The Carrier-Farrag Formula
#The Karup-King-Newton Formula
#Arriaga's Light Smoothing Formula
#The United Nations Formula
#Arriaga's Strong Smoothing Formula



