library(tidyverse)
data1 <- tibble(Month = 1:4, MonthName = c('Jan','Feb','Mar','Apr'),
                Sales = c(6,8,1,2), RD = c(4,1,2,4))
data2 <- tibble(Department = 'Sales', Director = 'Lavy')

joined_data <- data1 %>%
  pivot_longer(cols = c('Sales','RD'),
               names_to = 'Department',
               values_to = 'Budget') %>%
  full_join(data2, by = 'Department')


joined_data %>%
  filter(!(MonthName %in% c('Jan','Feb')))
joined_data %>%
  filter((MonthName %in% c('Jan','Feb')) & Department == 'Sales')
joined_data %>%
  filter((MonthName %in% c('Jan','Feb')) | Department == 'Sales')

data("construction")
construction %>%
  select(Year, Month, West) %>%
  filter(Month %in% c('July','August','September')) %>%
  arrange(-West) %>%
  slice(1:2)

joined_data
joined_data %>%
  group_by(MonthName) %>%
  mutate(MonthAverage = sum(Budget)/n())

joined_data %>%
  group_by(MonthName) %>%
  summarize(MonthAverage = mean(Budget))

joined_data %>%
  group_by(MonthName) %>%
  summarize(proportion_above_6 = mean(Budget > 5))


data(construction)
new_cons <- construction %>%
  mutate(avg = (Northeast + Midwest + South + West)/4) %>%
  rename(`Price Average` = avg) %>%
  mutate(firsthalf = case_when(
    row_number() <= 6 ~ 'First half',
    TRUE ~ 'Second half'
  )) %>%
  group_by(firsthalf) %>%
  summarize(`Price Average` = mean(`Price Average`))
new_cons %>%
  pull(firsthalf) %>%
  is.character()
str(new_cons)
class(construction$Year)
sapply(construction, class)

joined_data %>%
  mutate(Department = factor(Department)) %>%
  group_by(Department) %>%
  summarize(Budget =mean(Budget)) %>%
  mutate(Department = reorder(Department, -Budget)) %>%
  arrange(Department)
summarized$Department


library(lubridate)
ymd('2020-01-01')
ym('202001')
my('012020')
mdy('01-01-2020')
construction %>%
  mutate(year_as_date = ym(paste(Year, '01'))) %>%
  pull(year_as_date)

tibble(year = 2015:2018, month = c(1,6,2,4), day = c(5,6,1,2)) %>%
  mutate(date = dmy(paste(day, month, year))) %>%
  mutate(quarter = quarter(date),
         year_new = year(date)) %>%
  mutate(month_label = month.name[month])
ymd('2020-01-01') + years(1)
ymd('2020-01-01') + months(3)
ymd('2020-03-31') - months(1)


tibble(year = c(2015,2015,2016,2016), month = c(1,6,2,4), day = c(5,6,1,2)) %>%
  mutate(date = dmy(paste(day, month, year))) %>%
  mutate(quarter = quarter(date),
         year_new = year(date)) %>%
  mutate(month_label = month.name[month]) %>%
  mutate(year_date = floor_date(date, 'month'))

c('my string', 'my second string')
paste('a','b','c','d', sep = ' and ')
paste0('a','b','c',' d')

construction
construction %>%
  mutate(Month = case_when(
    Month == 'January' ~ 'Janubary',
    TRUE ~ Month
  ))
cat('Look at the \n result in my graph')
str_sub('hello', 2, 4)

construction %>%
  mutate(Month = str_replace(Month, 'Ju', 'Jub'))

fips_to_names %>%
  mutate(Just_name = word(countyname, 1))
fips_to_names %>%
  mutate(Just_name = str_replace(countyname, 'County|Parish', ''))


data(gss_cat)
changed_gss_cat <- gss_cat %>%
  mutate(birthyear = ym(paste0(year, '-06')) - years(age)) %>%
  mutate(birthyear = floor_date(birthyear, 'year')) %>%
  mutate(race = factor(race, levels = c('Black','White','Other'))) %>%
  mutate(income_num = word(rincome,1)) %>%
  mutate(income_num = str_replace(income_num, '\\$','')) %>%
  mutate(income_num = as.numeric(income_num)) 

table(gss_cat$rincome)

stockgrowth <- tibble(ticker = c('AMZN','AMZN', 'AMZN', 'WMT', 'WMT','WMT'),
                      date = as.Date(rep(c('2020-03-04','2020-03-05','2020-03-06'), 2)),
                      stock_price = c(103,103.4,107,85.2, 86.3, 85.6)) %>%
  arrange(ticker, date) %>% group_by(ticker) %>%
  mutate(price_growth_since_march_4 = stock_price/first(stock_price) - 1,
         price_growth_daily = stock_price/lag(stock_price, 1) - 1) 
stockgrowth

do_bps <- function(p) {
  bps <- p*10000
  return(bps)
}
do_bps(.00006)
library(purrr)
c(.00006, .05, 1) %>% map_dbl(do_bps)

list.files(pattern = 'trends_') %>%
  map_df(read_csv)


my_function <- function(i) {
  print(i+1)
}
# Print the numbers 1:10
1:10 %>% map(my_function)

xplusa <- function(x, a) {
  return(x+a)
}

my_plus_a_p <- function(a) {
  data(mtcars)
  mtcars %>%
    mutate(across(ends_with('p'), xplusa, a = a)) %>%
    return()
}

1:5 %>% map_df(my_plus_a_p) %>%
  write_csv('my_filename.csv')

save(my_data, construction, file = 'my_data_and_construction.Rdata')
load('my_data_and_construction.Rdata')
saveRDS(my_data, 'mydata.Rdata')
my_data <- readRDS('mydata.Rdata')
write_csv(my_data, 'mydata.csv')