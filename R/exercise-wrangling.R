#Load packages
source(here::here("R/package-loading.R"))



# basics of wrangling -----------------------------------------------------


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



# exercise with selecting -------------------------------------------------


nhanes_small %>%
    select(tot_chol, bp_sys_ave, poverty)

nhanes_small %>%
    rename(diabetes_diagnosis_age = diabetes_age)

nhanes_small %>%
    select(bmi, contains("age"))

nhanes_small %>%
    select(phys_active_days, phys_active) %>%
    rename(days_phys_active = phys_active_days)

#filtering vs selecting. Select works on columns whereas filter works on rows

nhanes_small %>%
    filter(sex == "female")

nhanes_small %>%
    filter(sex != "female")

nhanes_small %>%
    filter(bmi >= 25)

#be careful with & and | (OR) operators. & is that both conditions are true. Whereas | is when one is true

nhanes_small %>%
    filter(bmi == 25 & sex == "female")
#gave females with bmi of 25

nhanes_small %>%
    filter(bmi == 25 | sex == "female")
#gives all the females with a BMI NOT 25 and males with bmi of 25.


#arranging ascending or alphabetically or descending with (desc)
nhanes_small %>%
    arrange(age)

nhanes_small %>%
    arrange(sex)

nhanes_small %>%
    arrange(desc(age))

nhanes_small %>%
    arrange(sex, age)


# Transform and add columns
#e.g. put height in metres
nhanes_small %>%
    mutate(height = height / 100)

#create a new column with the log height
nhanes_small %>%
    mutate(logged_height = log(height))

nhanes_small %>%
    mutate(height = height / 100,
           logged_height = log(height))

#we can also make a column of if_else. SO if the thing is true say "" else say ""

nhanes_small %>%
    mutate(highly_active = if_else(phys_active_days <= 5, "yes", "no")) %>%
    select(highly_active, phys_active_days)

#nothing happens if you don't assign!

nhanes_update <- nhanes_small %>%
    mutate(height = height / 100,
           logged_height = log(height),
           highly_active = if_else(phys_active_days >= 5, "Yes", "No"))

nhanes_update


# Exercie with filtering --------------------------------------------------

nhanes_small %>%
    filter(bmi >=20 & bmi <=40 & diabetes == "Yes")

nhanes_modified <- nhanes_small %>%
    mutate(mean_arterial_pressure = (((2*bp_dia_ave) + bp_sys_ave)/3),
           young_child = if_else(age < 6, "yes", "no"))

nhanes_modified



# Summarizing -------------------------------------------------------------

#try getting the max of the bmi
nhanes_small %>%
    summarise(max_bmi = max(bmi))

#oops output is NA. Why? you need to get rid of NAs
nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE))

# and you can do multiple stats at once
nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE),
              min_bmi = min(bmi, na.rm = TRUE))

nhanes_small %>%
    summarise(mean_weight = mean(weight, na.rm = TRUE), mean_age = mean(age))

nhanes_small %>%
    summarise(max_height = max(height, na.rm = TRUE),
              min_height = min(height, na.rm = TRUE),
              sum(is.na(height)))
#is.na gives you true or false is NA

nhanes_small %>%
    summarize(med_age = median(age), med_phys_active_days = median(phys_active_days, na.rm = TRUE))


#add using groupby

nhanes_small %>%
    group_by(!is.na(diabetes)) %>%
    summarise(mean_age = mean(age, na.rm = TRUE), mean_bmi = mean(bmi, na.rm = TRUE))

nhanes_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes, sex) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE)) %>%
    ungroup()
