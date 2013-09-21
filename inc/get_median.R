get_median <- function(X, meanOfMedianPerInstitute=TRUE, asList=FALSE) {
  if (meanOfMedianPerInstitute) {
    # complex approach:
    # first, compute the median for each quarter and each institute
    # and then take the mean per quarters
    medianByInst <- tapply(1:nrow(X), X$inst, function(i) { 
      tapply(X$value[i], as.yearqtr(X$date[i]), median, na.rm=T)
    })
    qtr <- vector(mode='character')
    med <- vector(mode='numeric')
    for (inst in rownames(medianByInst)) {
      qtr <- append(qtr, rownames(medianByInst[[inst]]))
      med <- append(med, as.numeric(medianByInst[[inst]]))
    }    
    val <- tapply(med, qtr, mean)
  } else {
    # simple approach:
    # compute median of all institutes polls per quarter
    val <- tapply(X$value, as.yearqtr(X$date), median, na.rm=T)
  }
  if (asList) {
    val
  } else {
    data.frame(value=as.numeric(val), date=quarts(1994,4,length(val)))    
  }
}

