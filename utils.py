from bs4 import BeautifulSoup
from app import app
from models import JobBoards, JobPostings
import json

import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

# connect to the local database directly for the insert
# conn = psycopg2.connect(database=os.environ["DATABASE_NAME"])

# connect to the AWS database directly for the insert
conn = psycopg2.connect(
    dbname=os.environ["DATABASE_NAME"],
    user=os.environ["RDS_USERNAME"],
    password=os.environ["RDS_PW"],
    host=os.environ["AWS_DATABASE_URL_EP"]
)

conn.autocommit = True
cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

""" Utility functions for extracting data from the Tier 1 MEGASCRAPE """

KEYWORDS = ["developer", "software engineer",
            "engineer", "software", "engineering"]
ATS_KEYWORDS = ["ashby", "greenhouse", "lever"]

# FOR TESTING
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
    - the filled set, to be processed by the calling parent
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
            VALUES (%s, %s, %s, %s, %s::jsonb))
            ON CONFLICT (job_id) DO NOTHING;
            """
        cursor.execute(insert_query, (job_title, company_name,
                       job_id, job_url, json.dumps(json_response)))


def insert_GPT_response(response_json, id):
    """Performs lookup of id in job_posting - inserts GPT object into JSON_response field
    Maintains data already saved into the json_response field"""

    insert_query = """
        UPDATE job_postings
        SET json_response = (
            json_response::jsonb || 
            %s::jsonb
        )::json
        WHERE job_id = %s;
    """
    cursor.execute(insert_query, (json.dumps(response_json), id))


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


def select_US_roles_entry():
    """take list of dictionaries and insert into the main postgres database"""

    select_query = f"""
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
        '%Virginia%', '%VA%', '%Washington%', '%WA%', '%West Virginia%', '%WV%', '%Wisconsin%', '%WI%', '%Wyoming%', '%WY%',
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
        ])
        AND (json_response ->> 'location') NOT ILIKE '%India%' AND (json_response ->> 'location') NOT ILIKE '%latin%' AND (json_response ->> 'location') NOT ILIKE '%europe%' AND (json_response ->> 'location') NOT ILIKE '%UK%' AND (json_response ->> 'location') NOT ILIKE '%mexico%' AND (json_response ->> 'location') NOT ILIKE '%paris%'
        AND (job_title NOT ILIKE '%senior%' AND job_title NOT ILIKE '%staff%' AND job_title NOT ILIKE '%director%' AND job_title NOT ILIKE '%manager%' AND job_title NOT ILIKE '%sr.%' AND job_title NOT ILIKE '%data%' AND job_title NOT ILIKE '%head%' AND job_title NOT ILIKE '%sr %' AND job_title NOT ILIKE '%Mechanical%' AND job_title NOT ILIKE '%lead%' AND job_title NOT ILIKE '%net%' AND job_title NOT ILIKE '%Electrical%' AND job_title NOT ILIKE '%Principal%' AND job_title NOT ILIKE '%VP%' AND job_title NOT ILIKE '%Chassis%' AND job_title NOT ILIKE '%Legal%' AND job_title NOT ILIKE '%Avionics%' AND job_title NOT ILIKE '%President%')
        AND NOT (json_response ? 'entry_level')
        AND NOT job_url ILIKE 'https://jobs.lever.co/passportshipping%'
        AND NOT job_url ILIKE 'https://jobs.lever.co/palantir%';
    """
    cursor.execute(select_query)
    return cursor.fetchall()


sample_job_description = "Here is an example of job that should return 'True': Who We AreVerkada is the largest cloud-based B2B physical security platform company in the world. Only Verkada offers six product lines — video security cameras, access control, environmental sensors, alarms, workplace and intercoms — integrated with a single cloud-based software platform. Designed with simplicity and scalability in mind, Verkada gives organizations the real-time insight to know what could impact the safety and comfort of people throughout their physical environment, while empowering them to take immediate action to minimize security risks, workplace frustrations and costly inefficiencies. Founded in 2016 with more than $360M in funding raised to date, Verkada has expanded rapidly with 15 offices across three continents, 1,600+ full-time employees and 17,000+ customers across 70+ countries, including 45 companies in the Fortune 500.About the Alarms Team: As a member of the Alarms engineering team, you will be responsible for building compelling user experiences for one of Verkada’s major new product categories. This is an opportunity to take ownership over software products which keep our customers protected in times of critical need. You’ll be working alongside a small, dynamic team of frontend, backend and firmware engineers to develop these experiences. Our team operates as a startup within a startup, so you can expect a lot of autonomy and impact on the direction of the Alarms product category. If you are an experienced, Backend Engineer who is excited about building new ways to keep people safe and secure, then we want to hear from you. Who You Are:Excited about creating best-in-class products which protect people and propertyYou can take an ambitious product or technical idea and drive it to completionYou are excited about the idea of working on large scale backend services, computer vision pipelines and / or embedded systems.Experience:3+ years of industry software engineering experience.Mastery of at least one common server programming language (e.g. Python or Go)Mastery of scalable backend design — Including databases, queues and blob storageExperience working in a fast-paced software development environment.Recommended Skills:Software architecture and API design experienceGood understanding of at least one relational database technology, including performance and load characteristics, transactions and lockingExperience with some of the following technologies: Postgres or MySQL, Distributed high concurrency key-value storage (Redis, DynamoDB), Docker, AWS, Kubernetes, Kafka, Embedded systems (Raspbian, Embedded Linux, FreeRTOS)Culture and Values:Self-motivated problem solver: At Verkada, you will tackle large, complex problems with no clear answers. Teach and learn: You will learn new technologies while being entrusted with the technical ownership of major systems, and we hope to learn something from you in turn. Growth mindset: As a small, fast-growing startup, every day brings new challenges and opportunities for growth, and we want you to grow with us!Perks and Benefits:Generous company paid medical, dental & vision insurance coverage Unlimited paid time off & 11 companywide paid holidays Wellness allowance Commuter benefits Healthy lunches and dinners provided daily Generous paid parental leave policy & fertility benefits  $120,000 - $280,000 a yearVerkada is an equal opportunity employer. We strive to be a welcoming place for everyone, and we do our best to make sure all people feel supported and connected at work. A big part of that effort is support for members and allies of our internal communities like Women at Verkada, Pride at Verkada, Multicultural at Verkada, and Parents at Verkada."
