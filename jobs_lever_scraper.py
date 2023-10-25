import requests
from bs4 import BeautifulSoup
import re
from utils import KEYWORDS

"""Scraper for jobs on jobs.lever.io

In:
    URL

Out:
    returns a list of objects:
        [{job_data}, ...]
        
        job_data = {"job_title": job_title,
                    "id": job_id,
                    "job_url": job_url,
                    "JSON_response": {
                        "location": location,
                        "department": department
                        }
                    }

Pulls out pertinent jobs that meet KEYWORD criteria"""

def scrape_lever_job_board(url):
    response = requests.get(url)
    response.raise_for_status()  # Check if the request was successful
    soup = BeautifulSoup(response.content, 'html.parser')
    potential_jobs = []

    # Loop over div containing job data
    for job_div in soup.find_all('div', class_='posting'):
        job_title = job_div.find('h5').get_text()
        location = job_div.find('span', class_='sort-by-location').get_text()
        department = job_div.find('span', class_='sort-by-team').get_text()
        job_id = soup.find('div', class_='posting')['data-qa-posting-id']
        job_url = soup.find('a', class_='posting-btn-submit')['href']


        # Check if the title meets KEYWORD criteria
        for keyword in KEYWORDS:
            if re.search(r'\b%s\b' % (keyword), job_title, re.I):
                job_data = {"job_title": job_title,
                            "id": job_id,
                            "job_url": job_url,
                            "JSON_response": {
                                "location": location,
                                "department": department
                                }
                            }
                potential_jobs.append(job_data)

    return potential_jobs
