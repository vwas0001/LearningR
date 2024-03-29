# Loading packages --------------------------------------------------------
library(tidyverse)
library(NHANES)

glimpse(NHANES)

# Select specific columns -------------------------------------------------
select(NHANES, ID, Age)
select(NHANES, -HeadCirc)

select(NHANES, starts_with("BP"))
select(NHANES, ends_with("day"))
select(NHANES, contains("age"))

# Renaming ----------------------------------------------------------------
NHANES_small <- rename_with(NHANES, snakecase::to_snake_case)

# Renaming specific column ------------------------------------------------
NHANES_small <- rename(NHANES_small, sex = gender)


# Changing the functions with pipe ----------------------------------------
colnames(NHANES_small)

NHANES_small %>%
  colnames()

NHANES_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)


# Excercise ---------------------------------------------------------------

NHANES_small %>%
  select(bp_sys_ave, education)

NHANES_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

NHANES_small %>%
  select(bmi, contains("age"))

NHANES_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys_ave)


# Filtering data by row ---------------------------------------------------

NHANES_small %>%
  filter(phys_active == "No")

NHANES_small %>%
  filter(phys_active != "No")

NHANES_small %>%
  filter(bmi == "25")

NHANES_small %>%
  filter(bmi >= "25")

TRUE & TRUE
TRUE & FALSE
FALSE & FALSE

TRUE | TRUE
TRUE | FALSE
FALSE | FALSE

NHANES_small %>%
  filter(bmi == 25 & phys_active == "No") %>%
  select(bmi, phys_active)

NHANES_small %>%
  filter(bmi == 25 | phys_active == "No") %>%
  select(bmi, phys_active)


# Arranging the rows ------------------------------------------------------

NHANES_small %>%
  arrange(age)

NHANES_small %>%
  arrange(education)

NHANES_small %>%
  arrange(desc(age))

NHANES_small %>%
  arrange(age, education)

# Transform or add columns ------------------------------------------------

NHANES_small %>%
  mutate(age = age * 12)

NHANES_small %>%
  mutate(
    age = age * 12,
    log_bmi = log(bmi)
  ) %>%
  select(age, log_bmi)

NHANES_small %>%
  mutate(old = if_else(age >= 30, "Yes", "No")) %>%
  select(old)


# Exercise ----------------------------------------------------------------

# 1. BMI between 20 and 40 with diabetes
NHANES_small %>%
  # Format should follow: variable >= number or character
  filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes") %>%
  select(bmi, diabetes)

# Pipe the data into mutate function and:
NHANES_modified <- NHANES_small %>% # Specifying dataset
  mutate(
    # 2. Calculate mean arterial pressure
    mean_arterial_pressure = ((2 * bp_dia_ave) + bp_sys_ave) / 3,
    # 3. Create young_child variable using a condition
    young_child = if_else(age < 6, "Yes", "No")
  )

NHANES_modified


# Calculating summary statistics ------------------------------------------

NHANES_small %>%
    summarise(max_bmi = max(bmi))

NHANES_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE))

NHANES_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE),
              min_bmi = min(bmi, na.rm = TRUE))


# Summary statistics by group ---------------------------------------------

NHANES_small %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE))

NHANES_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE))

NHANES_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes, phys_active) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE))

NHANES_small %>%
    filter(!is.na(diabetes) & !is.na(phys_active)) %>%
    group_by(diabetes, phys_active) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE)) %>%
    ungroup()


# Save dataset as file ----------------------------------------------------

readr::write_csv(
    NHANES_small,
    here::here("data/nhanes_small.csv")
)

