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

# Rename all columns to snake case
nhanes_small <- rename_with(nhanes_small, snakecase::to_snake_case)


#rename a column
rename(nhanes_small, sex = gender)

nhanes_small

#notice that did not rename anything. Because you didn't ASSIGN
nhanes_small <- rename(nhanes_small, sex = gender)
nhanes_small


##Pipe operators. you can say:
colnames(nhanes_small)
#OR:
nhanes_small %>%
    colnames()

#Let's try selecting and renaming
nhanes_small %>%
    select(phys_active) %>%
    rename(physically_active = phys_active)

nhanes_small

