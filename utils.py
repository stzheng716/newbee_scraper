from bs4 import BeautifulSoup
from app import app
from models import JobBoards, JobPostings
import json

import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

#connect to the local database directly for the insert
# conn = psycopg2.connect(database=os.environ["DATABASE_NAME"])

#connect to the AWS database directly for the insert
conn = psycopg2.connect(
    dbname=os.environ["DATABASE_NAME"],
    user=os.environ["RDS_USERNAME"],
    password=os.environ["RDS_PW"],
    host=os.environ["AWS_DATABASE_URL_EP"]
)

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

        insert_query = f"""
            INSERT INTO job_postings (job_title, company_name, job_id, job_url, json_response)
            VALUES (%s, %s, %s, %s, %s)
            ON CONFLICT (job_id) DO NOTHING;
            """
        cursor.execute(insert_query, (job_title, company_name, job_id, job_url, json.dumps(json_response)))

def sql_job_posting_query():
    """
    functions that returns a dictionary with list of all of the specific ats platforms with a list of job postings

    return [{job_postings}]
    """

    job_posting_list = []

    with app.app_context():
        for ats in ATS_KEYWORDS:
            job_posting_list += JobPostings.query.filter(
                JobPostings.job_url.like(f"%{ats}%")).all()
            
    return job_posting_list

def insert_jd_to_db(jd, job_id):

    update_query = f"""
        UPDATE job_postings
        SET job_description = %s
        WHERE job_id = %s;
        """
    
    try:
        # Execute the update query
        cursor.execute(update_query, (jd, job_id))
        # If the update is successful, commit the transaction
        cursor.connection.commit()
    except psycopg2.Error as e:
        # Rollback the transaction on error
        cursor.connection.rollback()
        print(f"An error occurred: {e}")
        # Optionally, re-raise the exception if you want it to bubble up
        raise e
    except Exception as e:
        # Handle other exceptions
        print(f"A non-psycopg2 error occurred: {e}")
        raise e

def select_US_roles():
    """take list of dictionaries and insert into the main postgres database"""

    insert_query = f"""
        SELECT *
        FROM job_postings
        WHERE 
        (json_response ->> 'location') LIKE ANY (ARRAY[
            '%Alabama%', '%AL%', '%Alaska%', '%AK%', '%Arizona%', '%AZ%', '%Arkansas%', '%AR%', '%California%', '%CA%', 
            '%Colorado%', '%CO%', '%Connecticut%', '%CT%', '%Delaware%', '%DE%', '%Florida%', '%FL%', '%Georgia%', '%GA%', 
            '%Hawaii%', '%HI%', '%Idaho%', '%ID%', '%Illinois%', '%IL%', '%Indiana%', '%IN%', '%Iowa%', '%IA%', '%Kansas%', 
            '%KS%', '%Kentucky%', '%KY%', '%Louisiana%', '%LA%', '%Maine%', '%ME%', '%Maryland%', '%MD%', '%Massachusetts%', 
            '%MA%', '%Michigan%', '%MI%', '%Minnesota%', '%MN%', '%Mississippi%', '%MS%', '%Missouri%', '%MO%', '%Montana%', 
            '%MT%', '%Nebraska%', '%NE%', '%Nevada%', '%NV%', '%New Hampshire%', '%NH%', '%New Jersey%', '%NJ%', '%New Mexico%', 
            '%NM%', '%New York%', '%NY%', '%North Carolina%', '%NC%', '%North Dakota%', '%ND%', '%Ohio%', '%OH%', '%Oklahoma%', 
            '%OK%', '%Oregon%', '%OR%', '%Pennsylvania%', '%PA%', '%Rhode Island%', '%RI%', '%South Carolina%', '%SC%', 
            '%South Dakota%', '%SD%', '%Tennessee%', '%TN%', '%Texas%', '%TX%', '%Utah%', '%UT%', '%Vermont%', '%VT%', 
            '%Virginia%', '%VA%', '%Washington%', '%WA%', '%West Virginia%', '%WV%', '%Wisconsin%', '%WI%', '%Wyoming%', '%WY%'
            ' Alabama', ' AL', ' Alaska', ' AK', ' Arizona', ' AZ', ' Arkansas', ' AR', 
            ' California', ' CA', ' Colorado', ' CO', ' Connecticut', ' CT', ' Delaware', ' DE', 
            ' Florida', ' FL', ' Georgia', ' GA', ' Hawaii', ' HI', ' Idaho', ' ID', 
            ' Illinois', ' IL', ' Indiana', ' IN', ' Iowa', ' IA', ' Kansas', ' KS', 
            ' Kentucky', ' KY', ' Louisiana', ' LA', ' Maine', ' ME', ' Maryland', ' MD', 
            ' Massachusetts', ' MA', ' Michigan', ' MI', ' Minnesota', ' MN', ' Mississippi', ' MS', 
            ' Missouri', ' MO', ' Montana', ' MT', ' Nebraska', ' NE', ' Nevada', ' NV', 
            ' New Hampshire', ' NH', ' New Jersey', ' NJ', ' New Mexico', ' NM', ' New York', ' NY', 
            ' North Carolina', ' NC', ' North Dakota', ' ND', ' Ohio', ' OH', ' Oklahoma', ' OK', 
            ' Oregon', ' OR', ' Pennsylvania', ' PA', ' Rhode Island', ' RI', ' South Carolina', ' SC', 
            ' South Dakota', ' SD', ' Tennessee', ' TN', ' Texas', ' TX', ' Utah', ' UT', 
            ' Vermont', ' VT', ' Virginia', ' VA', ' Washington', ' WA', ' West Virginia', ' WV', 
            ' Wisconsin', ' WI', ' Wyoming', ' WY','% US %', '% US - %', ' US', 'US ', 'US -', '%United States%', '%US%', ' United States', 'United States ', 'US',
            'Boston', 'San Francisco', 'Mountain View', 'Remote', 'Seattle', 'Portland', 'Denver'
        ]);
        """
    cursor.execute(insert_query)
    return cursor.fetchall()
