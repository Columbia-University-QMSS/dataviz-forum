install.packages("babynames")
install.packages("ggplots2")
install.packages("magrittr")
install.packages("dplyr")


library(babynames)
library(ggplot2) # the king of plotting
library(magrittr) # chain operators, e.g. to "pipe" a value forward
library(dplyr) # for data manipulation
str(babynames)
head(babynames)
tail(babynames)
length(unique(babynames$name))
sum(babynames$n)/10^6
b <- ggplot(data = babynames, aes(x = year, y = n))
b + geom_line(color = "purple",data = filter(babynames, name == "Erin")) 
head(filter(babynames, name == "Erin"))

b + geom_line(data = filter(babynames, name == "Erin"), aes(color = sex))
View(babynames)
top10 <- babynames %>%
  group_by(sex, name) %>%
  summarize(total = sum(n)) %>%
  arrange(desc(total)) %>%
  group_by(sex) %>%
  mutate(rank=row_number()) %>%
  filter(rank<=10) %>%
  arrange(sex, rank)
filter(babynames, n)
top10f <- top10 %>% filter(sex=="F")
top10m <- top10 %>% filter(sex=="M")
top10f  
top10m   

filter(sex=="F") %>%
  filter(name %in% top10f$name) %>%
  ggplot(., aes(year, n)) +
  geom_line(aes(color=name, group=name))  

filter(sex=="M") %>%
  filter(name %in% top10m$name) %>%
  ggplot(., aes(year, n)) +
  geom_line(aes(color=name, group=name))
b + geom_line(data = filter(babynames, name == "Neha", year > "2000"), aes(color = sex))