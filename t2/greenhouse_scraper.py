import json
import requests
from bs4 import BeautifulSoup
import re
from utilities.db_utils import KEYWORDS
from data.headers import headers

"""
Scraper for jobs on boards.greenhouse.io

In:
    URL
    Keywords [developer, engineer, software]

Out:
    Job Title(?)
    Job ID
    Job URL

BS4 will do the main scrape and we can put all of the divs containing the pertinent job data into a list.
All jobs on jobs.greenhouse.io are in a div w/ class="posting"

Roadblocks:
    # noqa
    - job and department titles are inconsistent. We run the risk of missing jobs outside of our keywords ie: "site reliability"
    -
"""

BASE_URL = "https://boards.greenhouse.io"


def scrape_greenhouse_job_board(url, company_name, test=False):
    try:
        response = requests.get(url, headers=headers)

        response.raise_for_status()  # Check if the request was successful

        soup = BeautifulSoup(response.content, "html.parser")
        potential_jobs = []

        # greenhouse usually has job listings within <div> elements with a class of "posting"
        for job_div in soup.find_all("div", class_="opening"):
            job_title = job_div.find("a").get_text()
            location = job_div.find("span", class_="location").get_text()
            job_url = BASE_URL + job_div.find("a")["href"]
            job_id = job_url.split("/")[-1]

            # Check if the title indicates a software engineering or related role
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
    except (requests.HTTPError, requests.ConnectionError):
        print("Page title couldn't be found")
        pass
