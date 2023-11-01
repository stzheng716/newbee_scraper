import requests
from bs4 import BeautifulSoup
import re
from headers import headers
from utils import KEYWORDS, insert_jobs


"""
Scraper for jobs on jobs.lever.io

In:
    URL
    Keywords [developer, engineer, software]

Out:
    Job Title(?)
    Job ID
    Job URL

BS4 will do the main scrape and we can put all of the divs containing the pertinent job data into a list.
All jobs on jobs.lever.io are in a div w/ class="posting"

Roadblocks:
    - job and department titles are inconsistent. We run the risk of missing jobs outside of our keywords ie: "site reliability"
    -
"""

def scrape_lever_job_board(url, company_name, test=False):
    response = requests.get(url, headers=headers)
    try:
        response.raise_for_status()  # Check if the request was successful
    except (requests.HTTPError, requests.ConnectionError): 
        print("Page title couldn't be found")
        pass
    soup = BeautifulSoup(response.content, 'html.parser')
    potential_jobs = []

    # Lever usually has job listings within <div> elements with a class of "posting"
    for job_div in soup.find_all('div', class_='posting'):
        job_title = job_div.find('h5').get_text()
        location_div = job_div.find('span', class_='sort-by-location')
        location = location_div.get_text() if location_div else None
        department_div = job_div.find('span', class_='sort-by-team')
        department = department_div.get_text() if department_div else None
        job_id = job_div['data-qa-posting-id']
        job_url = job_div.find('a', class_='posting-btn-submit')['href']


        # Check if the title indicates a software engineering or related role
        for keyword in KEYWORDS:
            if re.search(r'\b%s\b' % (keyword), job_title, re.I):
                job_data = {"job_title": job_title,
                            "company_name":company_name,
                            "job_id": job_id,
                            "job_url": job_url,
                            "json_response": {
                                "location": location,
                                "department": department
                                }
                            }
                potential_jobs.append(job_data)
                break

    if test:
        print(potential_jobs)
    else:
        insert_jobs(potential_jobs)
