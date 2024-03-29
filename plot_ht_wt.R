#Data Extraction: read data from the txt file, skip the first row with ht, wt values (NaN)
data <- read.table("raw_data/student_height_weight.txt", skip = 1)

#split data into ht data for y-axis plot
ht_data <- data$V1

#split data into wt data for x-axis plot
wt_data <-data$V2

#calculate percentiles(0%,25%,50%,75%100%), use the default quantile function: credit:https://livebook.datascienceheroes.com/appendix.html#appendix-percentiles
quantile(ht_data)
quantile(wt_data)

#calculate specific percentiles eg. 20%,40% 60% and 80% quantiles.
quantile(ht_data, probs=0.20)
quantile(wt_data, probs=0.40)

#use c() function for a vector of quantiles
quantile(ht_data, probs=c(0.60,0.80,0.90))

#if there is na values in the data, set argument na.rm=TRUE in the quantile function.
quantile(wt_data, c(0.25,0.45,0.65,0.85), na.rm=TRUE)

#visualize or plot the quantiles for ht(y-axis)
htplot_quant<- quantile(ht_data, c(0.25,0.50,0.75), na.rm=TRUE)

#add to data.frame
df_htplot<- data.frame(value=htplot_quant, quantile=c("25th", "50th","75th"))

#import the library
library(ggplot2)

#ggplot the histograms
ggplot(data, aes(ht_data))+geom_histogram()+geom_vline(data = df_htplot, aes(xintercept=value,colour=quantile),show.legend = TRUE, linetype="dashed")+theme_classic()

#visualize or plot the quantiles for the wt(x-axis)
wtplot_quant<- quantile(wt_data, c(0.25,0.50,0.75), na.rm=TRUE)

#add to data.frame
df_wtplot<- data.frame(value=wtplot_quant, quantile=c("25th", "50th","75th"))

#ggplot the histograms
ggplot(data, aes(wt_data))+geom_histogram()+geom_vline(data = df_wtplot, aes(xintercept=value,colour=quantile),show.legend = TRUE, linetype="dashed")+theme_classic()

#scatter plot works with the order x-axis, y-axis
plot(wt_data,ht_data)
#identify(wt_data,ht_data, labels = paste0(wt_data, ht_data))

#abline's lm function the formula should be in order of y ~ x. It matters!
abline(lm(ht_data ~ wt_data))