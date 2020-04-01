#### February 12 2020 ####
# These are class notes for Feb 12 2020
library(tidyverse)
library(nycflights13) #This is a dataset we are using, we installed it using install.packages("nycflights13")
library(tidylog) #Modifies dplyr behavior to only show readable data, ALWAYS load after the tidyverse package.

"notes_data/" -> path_to_data

filter(flights, month == 6.549) #The average of the months is 6.549 so here we are using dplyr to check which rows are contained in this average. This does not exist, there is no average month

flights %>% filter(month == 6) #This uses dplyr to show only rows pertaining to flights in June (6th month).

flights %>%
  filter(month > 8) #This uses dplyr to show only rows pertaining to months with a numerical value higher than 8.

select(flights, carrier, month) #Shows only specified variable(s) in columns.

ggplot(flights, aes(x = factor(month))) + 
  geom_bar() +
  labs(x = "Months", y = "Count")

#### February 19 2020 ####
library(tidyverse)
girl <- read_csv("girl_scouts1.csv")

girl %>%
  arrange(deliciousness) #Arranges by the defined variable.

girl %>%
  arrange(desc(deliciousness)) #Arranges by variable but in decesending order.

girl %>%
  mutate(yumminess = if_else(deliciousness < 5, "not yummy", "yummy")) #Creates a statement which defines eat cookie by the scale set.

girl %>%
  mutate(new_scale = case_when(deliciousness <= 3 ~ "gross",
                               deliciousness > 3 & deliciousness < 7 ~ "fine",
                               deliciousness >= 7 ~ "great")) #We created a more specific scale that can have more than just two definitions, here there are 3.

#After this we added another cookie with no recorded deliciousness value.

girl %>%
  drop_na(deliciousness) #Removes the variable that has no recorded value.
girl %>%
  drop_na(name)
girl %>%
  drop_na() #Removes ANYTHING with an 'NA'.

girl %>%
  replace_na(list(deliciousness = -7)) #Redefines the 'NA' as the specified value.

#After this we created the new .csv with the stickiness factor.

girl1 <- read_csv("girl_scouts1.csv")
girl2 <- read_csv("girl_scouts2.csv")

bind_cols(girl1, girl2) #Combines the columns of the two variables, however this creates a new unwanted column.

girl1 %>%
  select(-name) %>%
  bind_cols(girl2) %>% #Brings them together.
  select(name, everything()) #Rearranges the columns in the specified order.

left_join(girl1, girl2) #Binds what is on the LEFT of the second specified dataset.
right_join(girl1, girl2) #Binds what is on the RIGHT of the second specified dataset.

#Now we erased ThinMints from girl_scouts2 and added Samoa to girl_scouts1.

inner_join(girl1, girl2) #Only will combine the rows that are common between the two datasets.

anti_join(girl1, girl2) #Only will combine rows that they don't have in common.

full_join(girl1, girl2) #Will combine all of the rows even if they don't have common.

#### February 26 2020 ####

iris %>%
  select(Sepal.Length, Sepal.Width) %>%
  head(2)

iris %>%
  select(starts_with("S")) %>% #This function isolates data for the variables that start with the letter specified, not results.
  head(2)

my_string <- "hello"
str_starts(my_string, "h") #Letter that it starts with
str_ends(my_string, "o") #Letter that it ends with
str_starts(my_string, "\\w") #Specifies letters


head(fish_encounters) #This is the dataset we are using today.

fish_encounters %>%
  select(fish) %>%
  distinct() #Tells us the number of unique results from this column; 19 fish.

fish_encounters %>%
  select(fish) %>%
  distinct() %>%
  tally() %>%
  pull(n) #The last two commands tell us how many unique fish there are as a single value rather than the array.

fish_encounters %>%
  pivot_wider(names_from = "station",
              values_from = seen,
              values_fill = list(seen = 0)) -> wide_fish
#Separates stations into their own columns and replaces NA values with 0.

head(wide_fish)

wide_fish %>%
  pivot_longer(Release:MAW,
               names_to = "station",
               values_to = "seen") %>%
  drop(0)
#Condenses the manipulated dataset back into the original tidy one,

iris %>%
  select(Species, Sepal.Length) %>%
  pivot_wider(names_from = "Species",
              values_from = "Sepal.Length")
#Will not work because Sepal Length is not unique because these are not separated by flower only by species, this WOULD work if we were comparing the average Sepal Length for each species.

iris %>%
  group_by(Species) %>%
  summarize(mean_sl = mean(Sepal.Length)) %>%
  pivot_wider(names_from = "Species",
              values_from = "mean_sl")

#Shows how the pivot wider could be applied as explained below.

cars <- read_csv(paste0(path_to_data, "cars.csv")) #Created the new dataset.
head(cars)

cars %>%
  pivot_longer(acura:ferrari,
               names_to = "brand",
               values_to = "country") #Rearranges the data into a tidy set.

#### February 27 2020 ####
head(iris)
iris %>%
  mutate(Genus = "Iris") -> iris2

head(iris2)
iris2 %>%
  unite(gecies, Genus, Species, sep = " ", remove = FALSE) %>%
  head()
#Unite combines two columns, sep identifies what separates the values.

iris2 %>%
  unite(gecies, Genus, Species, sep = " ") -> iris3
head(iris3) 

iris3 %>%
  separate(gecies, into = c("Genus", "Species"), sep = " ") %>%
  head()
#Breaks a single column with numerous values into separate columns.

head(iris2)
iris2 %>%
  separate(Sepal.Length, into = c("befordec", "afterdec"), sep = ".") %>%
  head()
#Does not work because the period isn't a pattern, its a regular expression.

head(iris2)
iris2 %>%
  separate(Sepal.Length, into = c("befordec", "afterdec"), sep = "\\.") %>%
  replace_na(list(afterdec = 0)) %>%
  head()
#Fixes the error above, using the two backslashes escapes the use of a period to make it what we want, replace_na will fill in 0s for the NA values generated.

#### April 1, 2020 ####
#Linear Regression Notes

crabs <- read_csv("https://raw.githubusercontent.com/sjspielman/datascience_for_biologists/master/rmd_lessons/lm_files/crabs.csv")

head(crabs)
#This is the dataset we are using.

model_fit <- lm(formula = body_depth ~ carapace_length, data = crabs)
#This is our simple linear model.

summary(model_fit)
#Gives the information from the model.
#Residual is unexplained by the model.
#R-Squared is the predictive power.

library(broom)
broom::tidy(model_fit)
broom::glance(model_fit)
#Give us the same data as summary but in a simpler form.

broom::augment(model_fit)
#Gives an in-depth look at the data from our linear model.
#Shows where the y-values fall on the line of best fit, the deviation from the actual value to this predicted value is the RESIDUAL.

broom::augment(model_fit) -> augmented_fit

qqnorm(augmented_fit$.resid)
#Using base-R to create a Q-Q plot which visualizes how normal our residual values are.






















