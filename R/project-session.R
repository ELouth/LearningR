source(here::here("R/package-loading.R"))

# Basics of R -------------------------------------------------------------

#how to assign a number to a vector
weight_kilos <- 100
weight_kilos

#use c to combine things into vectors
c("a", "b", "c")
c(TRUE, FALSE)
factor(c("high", "medium", "low"))
c(1, 2, 4)

#see first 6 of a data set
head(CO2)

#see column names of a data set
colnames(CO2)

#see structure info. not always useful
str(CO2)

#see some descriptive stats
summary(CO2)



#Fixing code for style
# Object names
day_one
this_is_false <- FALSE
nine <- 9

# Spacing
x[, 1]
x[, 1]
mean(x, na.rm = TRUE)
mean(x, na.rm = TRUE)
height <- (feet * 12) + inches
df$z
x <- 1:10

# Indenting and brackets
if (y < 0 && debug) {
    message("Y is negative")
}

# Object names
DayOne
T <- FALSE
c <- 9

# Spacing
x[, 1]
x[, 1]
mean (x, na.rm = TRUE)
mean(x, na.rm = TRUE)
height <- feet * 12 + inches
df$z
x <- 1:10

# Indenting and brackets
if (y < 0 && debug) {
    message("Y is negative")
}
