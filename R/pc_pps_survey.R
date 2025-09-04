#library(tidyverse)
#library(writexl)


#' Sample units with proportional to size of the primary unit
#'
#' @param data A data frame object
#' @param nsize Number of units to be sampled
#'
#' @returns Returns the the data frame object with additional rows that mark selected units, probability of select, etc
#' @export
#'
#' @examples
#' set.seed(1000)
#' stratum = rep(c(1,2),c(30,50))
#' cluster <- c(1:30,1:50)
#' cluster_pop <- sample(365:1309,80,replace=TRUE)
#' sample_frame <- data.frame(stratum,cluster, cluster_pop)
#' pc_pps_survey(sample_frame,10)
#' sample <- pc_pps_survey(sample_frame,nsize = c(10,7))
#'
#'
#'

pc_pps_survey = function (data, nsize = 20){

  stratum <- cluster_pop <- cluster <- NULL

  data <- data[rowSums(is.na(data)) != ncol(data),]                       #Remove empty rows
  sampled_pps_data  <- data.frame()                                       #Container to hold sampled hhs
  strata_data    <- sort(unique(data$stratum))                            #Extract unique stratum values/codes
  tracker = 1


  # If a single nsize is passed, sample the samen number of cases in each stratum
  # Replicate the values to the number of strata

  if(length(nsize) == 1)
  {
    nsize = rep(nsize,length(strata_data))
  }

  for (i in strata_data){                                                 #Loop through the unique values of strata

    #stratum_data <- data %>% filter(stratum == i)                         #Data for a selected stratum
    stratum_data <- dplyr::filter(data, stratum == i)                            #Data for a selected stratum
    sample_points <- c()                                                  #Clear up the container for selected hhs
    sampleSel <- c()
    prob_cluster_sel <- c()
    interval_k   <- sum(stratum_data$cluster_pop)/nsize[tracker]          # Sampling interval

    randStart    <- stats::runif(1)*interval_k                                   # Random start


    #Systematically select (rows of) clusters (Adopted from MICS)
    cat("Stratum: ",i,"\n")
    cat("Nsize: ",nsize[tracker],"\n")
    cat("Interval: ",interval_k,"\n")
    cat("Random start: ",randStart,"\n")
    cat("Number of clusters: ",nrow(stratum_data),"\n")

    for(ctr in 1:nsize[tracker])
    {
      ifelse (ctr > 1,
              sample_points <- c(sample_points,ceiling(randStart+(ctr-1)*interval_k)),
              sample_points <- c(sample_points,ceiling(randStart)))
    }



    clusters_sampled <- c()

    ctr = 1

    stratum_data <- stratum_data |>
      dplyr::mutate(pop_cum_sum = cumsum(cluster_pop)) # Calculate cumulative population totals

    # stratum_data$pop_cum_sum <- cumsum(stratum_data$cluster_pop)   # Calculate cumulative population totals

    #For each sampled point, check if it falls within some cluster by checking if the point is less than the cummulative sum
    for (selected_sum in sample_points) {

      start_repeat = 0 # To increase number of iterations based on repeated number checking after matches with sampled point

      while(ctr <= (nrow(stratum_data) + start_repeat)){
        if (selected_sum <= stratum_data$pop_cum_sum[ctr]){
          #cat("Iteration :", ctr, "Point: ",selected_sum," versus pop",stratum_data$pop_cum_sum[ctr],"\n")
          clusters_sampled <- c(clusters_sampled,selected_sum)
          sampleSel <- c(sampleSel,ctr)

          #Calculate and store the probability of selecting a cluster
          prob_cluster_sel <- c(prob_cluster_sel,stratum_data$cluster_pop[ctr]*nsize[tracker]/sum(stratum_data$cluster_pop))

          #ctr = ctr + 1
          #if(sample_points[ctr = ctr + 1] > stratum_data$pop_cum_sum[ctr]){ctr = ctr + 1}
          start_repeat = start_repeat + 1
          break
        }
        else
        {
          #cat("Iteration :", ctr, "Point: ",selected_sum," versus pop",stratum_data$pop_cum_sum[ctr],"\n")
          #clusters_sampled <- c(clusters_sampled,NA)
          ctr = ctr + 1
        }

        #ctr = ctr + 1
      }


    }


    selected_clusters <- data.frame(sampleSel,clusters_sampled,prob_cluster_sel)

    stratum_data <- stratum_data |>
      dplyr::mutate(sampleSel = cluster) |>
      dplyr::full_join(selected_clusters, by = "sampleSel") |>
      dplyr::arrange(cluster)

    writexl::write_xlsx(stratum_data,paste0("sampled_pps_stratum_",i,".xlsx"))

    #View(stratum_data)

    #readline(prompt = "View data : ")

    sampled_pps_data <- dplyr::bind_rows(sampled_pps_data,stratum_data)



    #print(sel_data)
    #cat(i,"(",nrow(ea_data),",",interval_k,",",round(randStart,2),") : ",nrow(sel_data),"->,",sampleSel,"\n")
    tracker = tracker + 1

  }


  selected_eas <- sampled_pps_data |>
    dplyr::filter(!is.na(clusters_sampled))



  writexl::write_xlsx(selected_eas,"selected_eas.xlsx")
  writexl::write_xlsx(sampled_pps_data,"sampled_pps_data.xlsx")

  return(list(sampled_pps_data = sampled_pps_data))


}


# set.seed(1000)                                 # For reproducibility
#
# stratum = rep(c(1,2),c(30,50))
# cluster <- c(1:30,1:50)
# cluster_pop <- sample(365:1309,80,replace=T)
#
# sample_frame <- data.frame(stratum,cluster, cluster_pop)
#
# #pc_pps_survey(sample_frame,10)
# sample <- pc_pps_survey(sample_frame,nsize = c(10,7))

