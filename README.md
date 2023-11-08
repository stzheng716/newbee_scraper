# test_job_scraper

### Running the project locally
1. clone the repo<br>
2. navigate to the project root<br>
3. activate and enter your venv<br>
4. pip install -r requirements.txt
5. create your .env file
```
SECRET_KEY=[YOUR SECRET KEY HERE] or ask someone on the team for the secret key
DATABASE_URL=postgresql:///job_crawler
TEST_DATABASE_URL=postgresql:///job_crawler
DATABASE_NAME=job_crawler
```
6. run the following commands in the terminal to create your local copy of the database
```
psql
CREATE DATABASE job_crawler
ctrl+d to quit
```
TODO: make the damn tables
7. from the root project dir, populate your local database:
```
pg_dump -O database_utils/backup_database.sql | psql postgresql://job_crawler
```


### Project Overview:
Who's it for?
	- Bootcamp grads
What are we looking for?
	- Job descriptions that fit our needs (bootcamp grads, no degree)
Where are we looking for it?
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
4. Run the job descriptions through GPT

### REMINDER:
Please `git pull` and `pip install -r requirements.txt` before you start working on the codebase to ensure you have the most up-to-date packages and code.
