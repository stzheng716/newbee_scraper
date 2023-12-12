from curses.ascii import isdigit
import requests
from bs4 import BeautifulSoup
import re
from data.headers import headers
from utilities.db_utils import KEYWORDS
from utilities.utils import insert_jobs


BASE_URL = "https://jobs.jobvite.com"

"""
Scraper for jobs on jobs.jobvite.com

In:
    URL

Out:
    Job Title(?)
    Job ID
    Job URL
    location >>
    department

BS4 will do the main scrape and we can put all of the divs containing the pertinent job data into a list.
All jobs on jobs.jobvite.com are in a div w/ class="posting"

Roadblocks:
    - https://jobs.jobvite.com/upland-software >>> Redirects to upland's website
    - The html layout is significantly different across various jobvite sites.
        - Some are tables, some are lists, some are divs
        - https://uplandsoftware.com/careers/#career-openings
            - tables, anchors
        - https://jobs.jobvite.com/insurity/jobs/positions
            - divs, spans, anchors
        - https://jobs.jobvite.com/imprivata
            - redirects to imprivata.com
            - tables, divs, anchors

"""


def scrape_jobvite_job_board(url, company_name, test=False):
    response = requests.get(url, headers=headers)
    try:
        response.raise_for_status()  # Check if the request was successful
    except (requests.HTTPError, requests.ConnectionError):
        print("Page title couldn't be found")
        pass

    soup = BeautifulSoup(response.content, "html.parser")
    potential_jobs = []

    # Lever usually has job listings within <div> elements with a class of "posting"
    for job_element in soup.find_all("div", class_="jv-job-item"):
        job_title = job_element.find("a").get_text()
        department = job_element.parent.parent.find_previous_sibling("h3").get_text()
        job_id = job_element.find("a")["href"].split("/")[-1]

        location = job_element.find("div", class_="jv-job-list-location").get_text().strip().split(",")[0]
        if isdigit(location[0]):
            location = None

        job_url = BASE_URL + job_element.find("a")["href"]
        # Check if the title indicates a software engineering or related role
        for keyword in KEYWORDS:
            if re.search(r"\b%s\b" % (keyword), job_title, re.I):
                job_data = {
                    "job_title": job_title,
                    "company_name": company_name,
                    "job_id": job_id,
                    "job_url": job_url,
                    "json_response": {"location": location, "department": department},
                }
                potential_jobs.append(job_data)
                break

    if test:
        print(potential_jobs)
    else:
        insert_jobs(potential_jobs)
