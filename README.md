# test_job_scraper

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
		1. jobs.lever.co: 191->164 on 10/23
		2. boards.greenhouse.io: 113->97 on 10/23
		3. jobs.ashbyhq.com: 37->33 on 10/23
		4. jobs.jobvite.com: 8->8 on 10/23
		5. careers.smartrecruiters.com: 7->5 on 10/23
3. Scrape the job descriptions
	- run them through OpenAI


### Create a env file:
SK=abc123<br>
DATABASE_URL="postgresql:///job_crawler"<br>
DATABASE_NAME="job_crawler"<br>

### REMINDER:

Please git pull and pip install when before you start working on the codebsae to ensure you have the most up-to-date packages and code.
