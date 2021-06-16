#Load packages
source(here::here("R/package-loading.R"))

#check column names
colnames(NHANES)

#Look at contents
str(NHANES)
glimpse(NHANES)

#See summary
summary(NHANES)

#look over dataset documentation
?NHANES


#select a specific column or many columns
select(NHANES, Age)
select(NHANES, Age, Weight, BMI)

#exclude a column
select(NHANES, -HeadCirc)

#see what sort of helpers you can use, then example using starting with letters BP
?select_helpers
select(NHANES, starts_with("BP"))
select(NHANES, ends_with("Day"))
select(NHANES, contains("Age"))

# but so far we haven't saved anything, just viewed. To save you need to assign using <-

nhanes_small <- select(NHANES, Age, Gender, Height,
                       Weight, BMI, Diabetes, DiabetesAge,
                       PhysActiveDays, PhysActive, TotChol,
                       BPSysAve, BPDiaAve, SmokeNow, Poverty)
#view new dataframe
nhanes_small
