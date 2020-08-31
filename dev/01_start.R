# Building a Prod-Ready, Robust Shiny Application.
# 
# README: each step of the dev files is optional, and you don't have to 
# fill every dev scripts before getting started. 
# 01_start.R should be filled at start. 
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
# 
# 
########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################

## Fill the DESCRIPTION ----
## Add meta data about your application
golem::fill_desc(
  pkg_name = "shiny.proxy.golem", # The Name of the package containing the App 
  pkg_title = "Shiny Proxy Golem", # The Title of the package containing the App 
  pkg_description = "A minimal application for testing shiny proxy and golem.", # The Description of the package containing the App 
  author_first_name = "Zac", # Your First Name
  author_last_name = "Garland", # Your Last Name
  author_email = "zachary.garland@outlook.com", # Your Email
  repo_url = NULL # The URL of the GitHub Repo (optional) 
)     

## Set {golem} options ----
golem::set_golem_options()

## Create Common Files ----
## See ?usethis for more information
usethis::use_mit_license( name = "Golem User" )  # You can set another license here
usethis::use_readme_rmd( open = FALSE )
usethis::use_code_of_conduct()
usethis::use_lifecycle_badge( "Experimental" )
usethis::use_news_md( open = FALSE )
usethis::use_git()



# zg edits
zgtools::zg_core_libs()

get_project_name <- function(){
  list.files(pattern = "proj") %>% 
    str_replace("\\.Rproj","")
  
}


read_lines("README.Rmd") %>% 
  tibble(line = .) %>% 
  print(n = nrow(.)) %>% 
  slice(1:24) %>% 
  filter(!str_detect(line,"The goal")) %>% 
  add_row(line = "  eval = FALSE,",.before = 11) %>% 
  pull(line) %>% 
  c("```{r}",
    paste0("devtools::install_github('zac-garland/",get_project_name(),"')","\n","```")) %>% 
  write_lines("README.Rmd")

rmarkdown::render("README.Rmd")



## Init Testing Infrastructure ----
## Create a template for tests
golem::use_recommended_tests()

## Use Recommended Packages ----
# golem::use_recommended_deps()

## Favicon ----
# If you want to change the favicon (default is golem's one)
golem::remove_favicon()
golem::use_favicon("https://raw.githubusercontent.com/zac-garland/zac-garland/master/static/favicon.ico") # path = "path/to/ico". Can be an online file. 

## Add helper functions ----
golem::use_utils_ui()
golem::use_utils_server()

# You're now set! ----

# go to dev/02_dev.R
rstudioapi::navigateToFile( "dev/02_dev.R" )

