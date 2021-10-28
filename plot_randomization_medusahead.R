library(tidyverse)

treats <- c("C", "MH", "S", "A", "MHL", "AL")
plotpos <- c(1:6)
  
dat <- data.frame(replicate(16, plotpos)) %>%
  pivot_longer(cols = 1:16, names_to = "block", values_to = "plot_position")

blocks <- c("X1", "X2", "X3", "X4", "X5", "X6", "X7", "X8", "X9", "X10",
            "X11", "X12", "X13", "X14", "X15", "X16")

randomized <- data.frame(block = NA, plot_position= NA, treat = NA)

for(i in 1:length(blocks)) {
  
  # select block
  temp <- dat %>%
    filter(block == blocks[i])
  
  ## randomly select the treatment from our trt list
  trt <- sample(treats, replace = FALSE)
  
  ## put it as a column
  temp$treat <- trt
  
  ## attach to empty dataframe
  randomized <- rbind(randomized, temp)
  
}

randomized <- randomized[-1,]

write.csv(randomized, "seed_treatments.csv")
