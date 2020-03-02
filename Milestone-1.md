---
title: "Milestone 1"
author: "Carleena Ortega and Saelin Bjornson"
date: "01/03/2020"
always_allow_html: true
output: 
  html_document:
    toc: true
    keep_md: yes
---



# Task 1: Choosing a dataset

We chose [the Adult Income](https://archive.ics.uci.edu/ml/datasets/adult) data set to analyze for the group project.


# Task 2. Project Proposal and EDA

## 2.1 Introduce and describe your dataset

Who: The data set was extracted by Barry Becker from the 1994 Census database and is donated by Silicon Graphics 
What: The data set contains the predicted income of individuals from the census based on attributes including age, marital status, work class, education, sex, and race.
When: The data is from a 1994 census.
Why: The data set is found in the University of California Irvine Machine Learning Repository so it is primarily used for learning.
How: The census data was collected by humans.

|Variable|Type|Description|
|--------|-------|------|
|age|||
|workclass|||
|education|||
|educationnum|||
|marital_status|||
|occupation|||
|relationship|||
|race|||
|sex|||
|capital_gain|||
|capital_loss|||
|hours_per_week|||
|country|||
|income|||


## Task 2.2: Load your dataset (from a file or URL).

```r
adult_income <- read_csv("adult_data.csv", col_names=FALSE)
```

## Task 2.3: Explore your dataset





Distribution of age for men and women:

```r
df <-select(data, sex, age) %>% mutate(sex = factor(sex, levels=c("Male", "Female"))) %>% group_by(sex)  %>% summarize(mean=mean(age))


data %>% mutate(sex = factor(sex, levels=c("Male", "Female"))) %>%
  ggplot(aes(x=age,fill=sex)) + 
  geom_histogram(alpha=0.8,position="identity") +
  #geom_vline(data=df,aes(xintercept=mean,color=sex,linetype="dashed"))+
  scale_fill_manual(values=c("skyblue2","deeppink4")) + 
  labs(title="Distribution of Age by Sex",x="Age",y="Count") +
  theme_bw() +
  theme(legend.title=element_blank())
```

![](Milestone-1_files/figure-html/unnamed-chunk-3-1.png)<!-- -->


Proportion of people making >50K a year for men and women, by race:

```r
df <- data %>% select(sex,education_num,income,race)
df$educ[df$education_num < 10] <- "PS"  #for Post-secondary
df$educ[df$education_num >= 10] <- "HS"  #for High School

df %>% filter(income =="over_50K") %>% select(race,educ,sex) %>% group_by(race,educ,sex) %>% tally() %>%
  ggplot(aes(sex, n, fill=educ)) +
  geom_bar(position="fill", stat="identity") +
 # scale_y_continuous(labels=percent()) +
  theme_bw() +
  scale_fill_manual(values=c("skyblue2","deeppink4"),labels=c("High School","Post-Secondary")) + 
  facet_wrap(~race) +
  labs(title="Education level of people making over 50K",fill="Education",y="Percent",x="Sex")
```

![](Milestone-1_files/figure-html/unnamed-chunk-4-1.png)<!-- -->


## Task 2.4: Research question & plan of action
1. With your data set and your EDA, identify at least one research question that you will attempt to answer with analyses and visualizations. Clearly state the research question and any natural sub-questions you need to address, and their type. The main research question should be either descriptive or exploratory.
Below are some descriptions of descriptive or exploratory research questions, adapted by Dr. Timbers from the Art of Data Science by Roger Pengand Elizabeth Matsui. 

*Exploratory Research Questions* 

2. Propose a plan of how you will analyze the data (what will you plot, which variables will you do a linear regression on?)