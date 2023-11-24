# newbee_scraper
**Taking the Sting Out of the Job Hunt**

---
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
OPEN_AI_API_KEY=[ROBOT API KEY]
```
6. run the following commands in the terminal to create your local copy of the database
```
createdb job_crawler
```
7. Update Local DB >>> You have two options: 
   
   1. Use the provided backup data (it's old, links might not work)
      1. If you already have a database on your machine, you'll need to drop it and recreate it:
      	2. ```dropdb job_crawler```
        3. ```createdb job_crawler```
      1. ```psql -d job_crawler -f database_utils/backup_database.sql```
   
   
   3. create the tables and run the scraper to get the data in realtime
      1. ```psql -d job_crawler -f database_utils/migrate.sql``` 
      2. run full_scrape.py: ```python full_scrape.py```

---
### Project Overview:
**Who's it for?**	- Bootcamp grads & junior devs
**What are we looking for?**	- Job descriptions that fit our needs (bootcamp grads, no degree)
**Where are we looking for it?**	- (for now) https://stillhiring.today/


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
3. Scrape and save the job descriptions

4. Run the job descriptions through GPT
---
### REMINDER:
Please make sure to run the following commands before you start working on the codebase to ensure you have the most up-to-date packages and code:
```
git pull
``` 
```
pip install -r requirements.txt
``` 

