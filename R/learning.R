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
