library(ggplot2)
getwd()
setwd("/Users/tawnytsang/Dropbox/Bilingual DevMo/data/spreadsheets")

require(xlsx)
data <- read_excel("figs_for_R.xlsx", sheet = "Sheet1")

data$language_BG <- factor(data$LanguageBG, levels = c(1,2), labels = c("Monolingual", "Bilingual"))

data$scatter_adjusted <-0
data$scatter_adjusted[data$language_BG == "Bilingual"] <- 1

ggplot(data, aes(scatter_adjusted,age)) +
  geom_dotplot(binaxis="y", stackdir="center", size=1, aes(color=language_BG), fill=NA) + 
  scale_fill_grey(breaks=c("Monolingual","Bilingual"),values=c(0,1) +
  geom_boxplot(fill=NA)+ ylab("Age, Months") + coord_cartesian(xlim=c(-0.5,5))+ 
  theme(panel.background=element_rect(fill='white',colour='black'))

stat_summary(fun.ymin=function(Value)(mean(Value)-1*sd(Value)), fun.ymax=function(Value)(mean(Value)+1*sd(Value)), geom="errorbar",width=0.1,color="black") +
  stat_summary(fun.y=mean, geom="point", shape=22,color="black", size=15) +
  xlab("Group") + 
  + 
  theme(panel.background=element_rect(fill='white',colour='black'))




ggplot(data, aes(scatter_adjusted,age)) +
  geom_dotplot(binaxis="y", stackdir="center", size=1, aes(color=language_BG), fill="language_BG") + 
  scale_fill_manual(values = c("black", "gray")) + theme(panel.background=element_rect(fill='white',colour='black'))
aes(color=language_BG)


ggplot(data, aes(scatter_adjusted,age)) +
  geom_dotplot(binaxis="y", stackdir="center", size=1, aes(color=language_BG), fill=c(0,1)) + 
  scale_fill_manual(values = c("black", "gray")) + theme(panel.background=element_rect(fill='white',colour='black'))
aes(color=language_BG)

    
stat_summary(fun.ymin=function(Value)(mean(Value)-1*sd(Value)), fun.ymax=function(Value)(mean(Value)+1*sd(Value)), geom="errorbar",width=1,color="black") +
  stat_summary(fun.y=mean, geom="point", shape=22,color="black", size=15) +
  xlab("Group") + 
 + 
  theme(panel.background=element_rect(fill='white',colour='black'))


