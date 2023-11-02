from bs4 import BeautifulSoup
from app import app
from models import JobBoards, JobPostings
import json

import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

#connect to the database directly for the insert
conn = psycopg2.connect(database=os.environ["DATABASE_NAME"])
conn.autocommit = True
cursor = conn.cursor()

""" Utility functions for extracting data from the Tier 1 MEGASCRAPE """

KEYWORDS = ["developer", "software engineer",
            "engineer", "software", "engineering"]
ATS_KEYWORDS = ["ashby", "greenhouse", "lever"]

## FOR TESTING
# ATS_KEYWORDS = ["lever"]


def extract_number(html_content: str) -> int:
    """
    Extracts the number from a specific div element in the provided HTML content.

    Parameters:
    - html_content: A string containing the HTML content.

    Returns:
    - An integer representing the extracted number (e.g., 1349).
    """
    soup = BeautifulSoup(html_content, "html.parser")
    div_element = soup.find(
        "div", class_="selectionCount summaryCell flex-auto")

    if div_element:  # Check if the div_element was found
        text_content = div_element.text
        number_str = text_content.split()[0]
        # Remove commas and convert to integer
        number = int(number_str.replace(",", ""))
        return number

    return 2000  # Return 2000 if the div element was not found


def extract_and_save(response, url_set):
    """Extracts and saves URLs from a selenium scrape

    Parameters:
    - selenium page source
    - set to hold processed company names and job link urls
        -set will be set of tuples (company_name: str, job_url: str)

    Returns:
    - the filled set, to be procssed by the calling parent
    """
    soup = BeautifulSoup(response, "html.parser")

    # access all of the dataRows from "dataLeftPaneInnerContent paneInnerContent"
    all_rows = soup.find_all(attrs={"data-testid": "data-row"})

    if all_rows:
        for row in all_rows:
            company_name = row.find(attrs={"data-columnindex": "0"}).get_text()
            # this is n^2?
            company_name_no_commas = (
                "requires research"
                if not company_name
                else "".join(char if char != "," else " " for char in company_name)
            )

            jobs_link = row.find(attrs={"data-columnindex": "2"}).a.get("href")

            company_info = (company_name_no_commas, jobs_link)

            url_set.add(company_info)
        return url_set


def sql_url_query():
    """
    functions that returns a dictionary with list of all of the specific ats platforms

    return {"lever": [{id, company_name, careers_url, ats_url, career_date_scraped} ,{}]
        ,"greenhouse": [{}{}],
        "ashby":[{},{}]}
    """

    ats_dict = {}

    with app.app_context():
        for ats in ATS_KEYWORDS:
            company_boards = JobBoards.query.filter(
                JobBoards.careers_url.like(f"%{ats}%")).all()
            ats_dict[ats] = company_boards

    return ats_dict

def insert_jobs(jobs):
    """take list of dictionaries and insert into the main postgres database"""

    for row in jobs:
        job_title = row["job_title"]
        company_name = row["company_name"]
        job_id = row["job_id"]
        job_url = row["job_url"]
        json_response = row["json_response"]
        # breakpoint()
        insert_query = f"""
            INSERT INTO job_postings (job_title, company_name, job_id, job_url, json_response)
            VALUES (%s, %s, %s, %s, %s)
            ON CONFLICT (job_id) DO NOTHING;
            """
        cursor.execute(insert_query, (job_title, company_name, job_id, job_url, json.dumps(json_response)))

def sql_job_posting_query():
    """
    functions that returns a dictionary with list of all of the specific ats platforms with a list of job postings

    return {"lever": [{id, job_title, job_url, job_id, job_scraped_date, company_name, json_response} ,{}]
        ,"greenhouse": [{}{}],
        "ashby":[{},{}]}
    """

    job_posting_dict = {}

    with app.app_context():
        for ats in ATS_KEYWORDS:
            company_boards = JobPostings.query.filter(
                JobPostings.job_url.like(f"%{ats}%")).all()
            job_posting_dict[ats] = company_boards

    return job_posting_dict