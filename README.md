# test_job_scraper

### Running the project locally
1.) clone the repo
2.) navigate to the project root<br>
3.) activate your venv<br>
4.) create your .env file
```
SK=abc123<br>
DATABASE_URL="postgresql:///job_crawler"
DATABASE_NAME="job_crawler"
```
5.) run the following commands in the terminal to create your local copy of the database
```
psql
CREATE DATABASE job_crawler
ctrl+d to qui
```
6.) in the terminal, run the `python3 migrate.py` this will drop all of the tables, create the latest version of the tables, and add the contents of the hrefs.csv file to your local database


### Project Overview:
- Who's it for?
	- Bootcamp grads
- What are we looking for?
	- Job descriptions that fit our needs (bootcamp grads, no degree)
- Where are we looking for it?
	- Fortune 1000 company websites (for now) https://stillhiring.today/


### There will be three scrapers:
1. Scrape for the URLs
	- Get company "career" URLs
2. Scrape those job URLs (company websites) for jobs in our field
	-  top 5 job boards
		1. jobs.lever.co: 191
		2. boards.greenhouse.io: 113
		3. jobs.ashbyhq.com: 37
		4. jobs.jobvite.com: 8
		5. careers.smartrecruiters.com: 7
3. Scrape the job descriptions
	- run them through OpenAI


### Create a env file:



### REMINDER:

Please git pull and pip install when before you start working on the codebsae to ensure you have the most up-to-date packages and code.
