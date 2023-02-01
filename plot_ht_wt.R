#Data Extraction: read data from the txt file, skip the first row with ht, wt values (NaN)
data <- read.table("raw_data/student_height_weight.txt", skip = 1)

#split data into ht data for y-axis plot
ht_data <- data$V1

#split data into wt data for x-axis plot
wt_data <-data$V2

#scatter plot works with the order x-axis, y-axis
plot(wt_data,ht_data)
#identify(wt_data,ht_data, labels = paste0(wt_data, ht_data))

#abline's lm function the formula should be in order of y ~ x. It matters!
abline(lm(ht_data ~ wt_data))