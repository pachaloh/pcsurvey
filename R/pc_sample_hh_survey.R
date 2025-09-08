# pc_sample_hhs_survey!
#
# The function 'pc_sample_hh_survey' selects cases from a frame using systematic sampling.
#
#
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'


#' Sample units using systematic random sampling
#'
#' @param data A data frame object. Make sure one column name is refereed to as
#' @param nsize Number of units to be sampled in each cluster
#'
#' @returns Returns the the data frame object with additional rows that mark selected units, probability of select, etc
#' @export
#'
#'


pc_sample_hh_survey = function (data, nsize = 20){


  data <- data[rowSums(is.na(data)) != ncol(data),]                     #Remove empty rows
  sampled.hhs  <- data.frame()                                                    #Container to hold sampled hhs
  ea_codes     <- sort(unique(data$ea_code))                            #Extract unique EA values/codes

  for (i in ea_codes){                                                	#Loop through the unique values of EAs

    ea_data <- data[which(data$ea_code==i),]                            #Data for a selected EA
    sampleSel <- c()                                                    #Clear up the container for selected hhs
    interval_k   <- nrow(ea_data)/nsize
    #set.seed(777)
    randStart    <- stats::runif(1)*interval_k


    #Systematically select (rows of) HHs (Adopted from MICS)
    for(ctr in 1:nsize)
    {
      ifelse (ctr>1,
        sampleSel <- c(sampleSel,ceiling(randStart+(ctr-1)*interval_k)),
        sampleSel <- c(sampleSel,ceiling(randStart)))
    }


    sel_data <- ea_data[sampleSel,]                                     #Selected sample (Attaching corresponding info to the EAS)
    sel_data$sel_serno <- sampleSel                                     #Total number of households in an EA
    sel_data$total_hhs <- nrow(ea_data)                                 #Total number of households in an EA
    sel_data$prob_sel  <- nsize/nrow(ea_data)                           #Probability of selecting a household in an EA

    sel_data$hh_number <- 1:nsize

    sampled.hhs <- rbind(sampled.hhs,sel_data)

    #print(sel_data)
    #cat(i,"(",nrow(ea_data),",",interval_k,",",round(randStart,2),") : ",nrow(sel_data),"->,",sampleSel,"\n")


  }

  sampled.hhs <- sampled.hhs[rowSums(is.na(sampled.hhs)) != ncol(sampled.hhs),]       #Remove empty rows
  #writexl::write_xlsx(sampled.hhs,"sample.xlsx")

  #View(sampled.hhs)

  return(sampled.hhs)

  #print(sampled.eas)
  #return (lfs_sample)

}



