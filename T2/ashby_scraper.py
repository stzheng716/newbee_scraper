import json
import random
from bs4 import BeautifulSoup
import re
from utilities.db_utils import KEYWORDS
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support import expected_conditions as EC


"""
Scraper for jobs on boards.ashby.io

In:
    URL
    Keywords [developer, engineer, software]

Out:
    Job Title(?)
    Job ID
    Job URL

BS4 will do the main scrape and we can put all of the divs containing the pertinent job data into a list.
All jobs on jobs.ashby.io are in a div w/ class="posting"

Roadblocks:
    - job and department titles are inconsistent. We run the risk of missing jobs outside of our keywords ie: "site reliability"
    -
"""

BASE_URL = "https://jobs.ashbyhq.com"

options = webdriver.ChromeOptions()
options.add_argument("--headless=new")
driver = webdriver.Chrome(options=options)


def scrape_ashby_job_board(url, company_name, test=False):
    try:
        driver.get(url)
        WebDriverWait(driver, random.randint(2, 10)).until(
            EC.presence_of_element_located((By.CLASS_NAME, "ashby-job-posting-brief"))
        )

        response = driver.page_source
        soup = BeautifulSoup(response, "html.parser")
        potential_jobs = []

        # ashby usually has job listings within <div> elements with a class of "posting"
        for job_div in soup.find_all("div", class_="ashby-job-posting-brief"):
            job_title = job_div.find("h3").get_text()
            location = job_div.find("p").get_text().split("•")[1].strip()
            job_url = BASE_URL + job_div.parent["href"]
            job_id = job_url.split("/")[-1]

            # Check if the title indicates a software engineering or related role
            # This is purposely designed to scrape more jobs than we want
            for keyword in KEYWORDS:
                if re.search(r"\b%s\b" % (keyword), job_title, re.I):
                    job_data = (
                        job_title,
                        company_name,
                        job_id,
                        job_url,
                        json.dumps(
                            {
                                "location": location or "",
                                "department": "",
                                "salary": "",
                                "tech_stack": [],
                            }
                        ),
                    )
                    potential_jobs.append(job_data)
                    break
        if test:
            print(potential_jobs)
        else:
            return potential_jobs
    except TimeoutException:
        print("Page title couldn't be found")
        pass
    # TODO: handle this error better: track it, remove from db, etc.
