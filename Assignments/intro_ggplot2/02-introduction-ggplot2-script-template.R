##########################################################################################
########################## INTRODUCTION TO ggplot2 #######################################
##########################################################################################

### Your name: Nicholas Paterna


# Load ggplot2 library
library(ggplot2)

# If you will be loading other optional libraries, do so on the next line(s). No other libraries are required for this lab/assignment.



############################################
############## Exercise Set 1 ##############
############################################


################
# Question 1.1 #
################
Plot1 <- ggplot(iris, aes(x = Petal.Length)) +
  geom_histogram(fill = "coral3", ## Fills in the histogram
                 color = "black" , ## Outlines the histogram
                 bins = 20) + ##Adjusts the width of the bins
  theme_bw() +
  labs(x = "Petal Length" , y = "Count", title = "Petal Length Histogram") ## Labeling the graph itself
print(Plot1)
ggsave("my_first_histogram.png", Plot1, height = 4, width = 6)

############################################
############## Exercise Set 2 ##############
############################################


################
# Question 2.1 #
################
ggplot(iris, aes(x = Sepal.Length)) + 
  geom_density(aes(fill = Species), alpha = 0.6) ##Needed to add aes() around fill = Species

################
# Question 2.2 #
################
ggplot(iris, aes(x = Sepal.Length)) + 
  geom_density(aes(fill = Species), alpha = 0.6) ##Alpha does not belong in () because it isn't data for aesthetic

################
# Question 2.3 #
################
ggplot(iris, aes(x = Petal.Length)) + 
  geom_density(aes(fill = Species), alpha = 0.6) +
  scale_fill_manual(values = c("purple", "pink", "orange")) +
  labs(x = "Petal Length", y = "Length", title = "Petal Length by Species") +
  theme_bw()

################
# Question 2.4 #
################

ggplot(iris, aes(x = Petal.Length)) + 
  geom_density(aes(fill = Species), alpha = 0.6) +
  scale_fill_manual(values = c("purple", "pink", "orange")) +
  labs(x = "Petal Length", y = "Length", title = "Petal Length by Species") +
  theme_bw() +
  theme(legend.position = "bottom") ##Labels on the bottom

ggplot(iris, aes(x = Petal.Length)) + 
  geom_density(aes(fill = Species), alpha = 0.6) +
  scale_fill_manual(values = c("purple", "pink", "orange")) +
  labs(x = "Petal Length", y = "Length", title = "Petal Length by Species") +
  theme_bw() +
  theme(legend.position = "top") ##Labels on the top

################
# Question 2.5 #
################

ggplot(iris, aes(x = Petal.Length)) + 
  geom_density(aes(fill = Species), alpha = 0.6) +
  scale_fill_manual(values = c("purple", "pink", "orange")) +
  labs(x = "Petal Length", y = "Length", title = "Petal Length by Species", fill = "Iris Species") +
  theme_bw() +
  theme(legend.position = "top")


################
# Question 2.6 #
################

ggplot(iris, aes(x = Sepal.Length)) + 
  geom_density(aes(fill = Species), alpha = 0.6) + ##Should use "fil" not "color"
  scale_fill_manual(values = c("blue", "pink", "yellow"))



############################################
############## Exercise Set 3 ##############
############################################


################
# Question 3.1 #
################

ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_boxplot(color = "lightblue3", aes(fill = Species), alpha = 1) +
  scale_fill_manual(values = c("red", "pink", "orange")) +
  theme_bw() +
  labs(x = "Iris Species", y = "Iris Pretal Length (cm)", title = "Boxplot of Iris Species Petal Lengths")


################
# Question 3.2 #
################

ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_violin(color = "black", aes(fill = Species), alpha = 1) +
  scale_fill_manual(values = c("orange", "pink", "red")) +
  theme_classic() +
  theme(legend.position = "none") +
  labs(x = "Iris Species", y = "Iris Pretal Length (cm)", title = "Boxplot of Iris Species Petal Lengths")


############################################
############## Exercise Set 4 ##############
############################################


################
# Question 4.1 #
################

ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_jitter(color = "purple") +
  theme_bw() +
  labs(y = "Petal Length", x = "Species")


################
# Question 4.2 #
################

ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_jitter(size = 2) +
  theme_bw() +
  labs(y = "Petal Length", x = "Species")

ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_jitter(size = 0.1) +
  theme_bw() +
  labs(y = "Petal Length", x = "Species")

##Size 0.1 is better at conveying the data because the points do not overlap

################
# Question 4.3 #
################

ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_jitter(aes(color = Species)) + #Use this code to auto assign colors based on the specific variable used
  theme_bw() +
  labs(y = "Petal Length", x = "Species")


################
# Question 4.4 #
################

ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_jitter(aes(color = Species)) + 
  scale_color_manual(values = c("orange", "purple", "navyblue")) + ##Must use color manual in this case to adjust the color by species. Dont forget to input the values or you'll get an error.
  theme_bw() +
  labs(y = "Petal Length", x = "Species")


################
# Question 4.5 #
################

ggplot(iris, aes(x = Species, y = Petal.Length)) +
  geom_jitter(aes(shape = Species)) + 
  theme_bw() +
  labs(y = "Petal Length", x = "Species")



############################################
############## Exercise Set 5 ##############
############################################


################
# Question 5.1 #
################

ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length)) + 
  geom_point(aes(color = Species)) +
  scale_color_manual(values = c("green3", "orange2", "navyblue")) + ##This line of code and the one directly above determine the color by Species
  theme_bw() +
  labs(x = "Sepal Width", y = "Sepal Length")


################
# Question 5.2 #
################

ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length)) + 
  geom_point(aes(shape = Species, color = Species)) + ##Wow I did not think I could use BOTH color and shape with species but I can, let's try three aesthetic arguments in the next one?
  scale_color_manual(values = c("pink3", "coral2", "purple3")) +
  theme_bw() +
  labs(x = "Sepal Width", y = "Sepal Length")

################
# Question 5.3 #
################

ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length)) + 
  geom_point(aes(shape = Species, color = Species, size = Species)) + 
  scale_color_manual(values = c("brown3", "black", "gold3")) +
  scale_size_manual(values = c(1.5, 2.75, 3)) + ##Through trial and error I figured out that I can apply a manual input for sizing!! Also as you can see, three arguments was acceptable.
  theme_bw() +
  labs(x = "Sepal Width", y = "Sepal Length")


## As a COMMENT below, answer: Which of the three scatterplots did you find most informative for viewing differences among species?

##I found that the combination of color and size was the easiest to read but color is 100% the easiest to distinguish between species.












