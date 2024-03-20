## Overview

This repo contains the data, code, and analysis of the 2020 U.S. presidential election forecast, designed by Jiwon Choi and Jeongwoo Kim.  

## File Structure

The repo is structured as:

-   `data/analysis_data` contains the cleaned datasets that were constructed for the survey data from Democracy Fund + UCLA Nationscape of the Voter Study Group and post-stratification data of the U.S. Census data from IPUMS. 
-   `model` contains the fitted logistic regression models for our analysis. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document (paper.qmd) and reference bibliography file (references.bib), as well as the PDF of the paper (peper.pdf). 
-   `scripts` contains the R scripts used to simulate, download, and clean data. This is categorized into two folders 'post_strat' and 'survey' as we have used two different datasets for this research. 'post-strat' contains the R scripts to simulate the post-stratification data (00-simulation-poststratification.R), clean the data (01-data-cleaning-poststratification.R), test the data (02-test-data-poststratification.R), and prediction modeling (03-model-poststratification.R). Similarly, 'survey' contains the R scripts to simulate the survey data (00-simulation-survey.R), clean the data (01-data-cleaning-survey.R), test the data (02-test-data-survey.R), and survey data modeling (03-model-survey.R). 

## Raw Data details

The survey data from the Voter Study Group and the U.S. Census data from IPUMS cannot be shared so we are going to document the steps to get the original, unedited data here. 

- Survey data from the Voter Study Group: To obtain this data, you can click https://www.voterstudygroup.org/data/nationscape, scroll down the page, and type in your First Name, Last Name, and e-mail address to submit a request to download the full data set. This could take a day or two. They will send you a link to download the data. Once you have access and click the link, you will have 5 files that include weekly crosstabs, a codebook, variables, and instructions in addition to the data file. We suggest you to download .dta files. The week data that we have decided to use for this analysis is 'ns20191003'. 

- U.S. Census data from IPUMS: To obtain this data, you can visit the link: https://usa.ipums.org/usa/index.shtml. To obtain the ACS data, visit https://usa.ipums.org/usa/index.shtml. You will need to create an account by filling in your name, organization, e-mail address, and the purpose of the usage. Once you have completed this step, click 'Get Data' in the middle of the page. First, you must select a sample (year), we used the 2019 1-year ACS to avoid the effect of COVID-19. After completing this step, you can choose a variety of variables including Age, Gender, Race, etc. For our project, we selected "age", "sex", "educd", "races", and "stateicp" among other variables. After selecting your variables, click on "View Data Cart", then click "Create Data Extract". You will then see a page with information about your data, for your "Data Format" (3rd row), select STATA or .dta. After this, you will receive an email when the data is processed. You can download and put the data into the data/raw_data folder to continue this project.

## Statement on LLM usage

No LLMs were used. 
