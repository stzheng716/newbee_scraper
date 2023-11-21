# newbee_scraper

### Running the project locally
1. clone the repo<br>
2. navigate to the project root<br>
3. create your venv<br>
```
python -m venv venv
```
5. activate and enter your venv<br>
```
source venv/bin/activate
```
6. install dependencies
```
pip install -r requirements.txt
```
7. create your .env file
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
7. from the root project dir, populate your local database:
```
psql -d job_crawler -f database_utils/backup_database.sql
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
Please make sure to run the following commands before you start working on the codebase to ensure you have the most up-to-date packages and code:
```
git pull
``` 
```
pip install -r requirements.txt
``` 

