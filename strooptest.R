# read in data
st <- read.csv('stroopdata.csv')

# mean of the time in two conditions
mean(st$Congruent)
mean(st$Incongruent)
# standard deviation respectively
sd(st$Congruent)
sd(st$Incongruent)

# histograms of time differences between condition 1 and 2
library(ggplot2)

ggplot(aes(x = Incongruent - Congruent), data = st) +
  geom_histogram(binwidth = 4, fill = I('#F7DC6F'), color = 'black') +
  labs(x = 'Time Differences Between Two Conditions',
       y = 'Number of Participants',
       title = 'The Distribution of Time Differences Between Two Conditions') +
  theme(plot.title = element_text(hjust = 0.5))

# bar chart of time spent for each participants in 2 conditions
library(reshape2)
st$id <- c(1:24)
st.long <- melt(st, id.vars = 'id')

ggplot(aes(x = factor(id), y = value, fill = variable), data = st.long) +
  geom_bar(stat="identity", position = 'dodge', width = 0.5) +
  scale_fill_manual(values = c('Congruent' = I('#85C1E9'), 
                               'Incongruent' = I('#F1948A')),
                    guide = guide_legend(title = NULL,
                                         keywidth = 1.5,
                                         keyheight = 0.5)) +
  labs(x = 'Individual Participants',
       y = 'Time',
       title = 'The Time Spent in 2 Conditions for Each Participants') +
  theme(legend.position = c(0.1, 0.9),
        plot.title = element_text(hjust = 0.5))

# t-test on the time in condition 1 and 2
t.test(st$Incongruent, st$Congruent, 
       alternative = 'greater', paired = T, conf.level = .99)
# the statistics computed by this function is slightly different from
# what's presented in the report, which has rounding errors from calculation
# by hand.