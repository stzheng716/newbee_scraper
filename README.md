# test_job_scraper

### Database Migration procedure
1.) navigate to the project root<br>
2.) activate your venv<br>
3.) in the terminal, run the `flask shell` command to open the flask shell<br>
4.) drop the current tables `db.drop_all()`<br>
5.) create the new version of the database `db.create_all()`<br>
6.) exit the flask shell with ctrl+d (mac)<br>
7.) in the regular terminal, run the following `python3 bulk_insert.py`<br>


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
SK=abc123<br>
DATABASE_URL="postgresql:///job_crawler"<br>
DATABASE_NAME="job_crawler"<br>


### REMINDER:

Please git pull and pip install when before you start working on the codebsae to ensure you have the most up-to-date packages and code.
