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
