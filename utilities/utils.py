from app import cursor
from collections import Counter
from urllib.parse import urlparse
from bs4 import BeautifulSoup
import json

""" Utility functions"""

KEYWORDS = ["developer", "software engineer",
            "engineer", "software", "engineering"]
ATS_KEYWORDS = '%(ashby|greenhouse|lever)%'

# FOR TESTING
# ATS_KEYWORDS = ["lever"]


def extract_number(html_content: str) -> int:
    """
    Extracts the number of rows in the air table in t1 scrape.
    Used in job_board scrape to create a guard.

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


def extract_ats_domain(url):
    """extracts the domain from an url
    Primarily used to identify the ATS input to job_board table

    params:
    - a url string

    returns:
    - the domain portion of a url

    ex:
    "https://www.example.com/path/to/page" -> "example.com"

    """
    # Parse the URL
    parsed_url = urlparse(url)

    # Get the hostname (domain) portion from the parsed URL
    domain = parsed_url.hostname

    # Check if the domain starts with "www." and remove it if present
    if domain and domain.startswith("www."):
        domain = domain[4:]  # Remove "www."

    return domain


def extract_and_save(response, url_set):
    """Extracts and saves URLs from a selenium scrape
    - Creates a three piece tuple and appends it to the url_set

    Parameters:
    - selenium page source
    - set to hold processed company names and job link urls
        -set will be set of tuples (company_name: str, job_url: str)

    Returns:
    - the filled set, to be processed by the calling parent:
        [(company_name, jobs_link, ats_url), ()...]
    """
    soup = BeautifulSoup(response, "html.parser")

    # access all of the dataRows from "dataLeftPaneInnerContent paneInnerContent"
    all_rows = soup.find_all(attrs={"data-testid": "data-row"})

    if all_rows:
        for row in all_rows:
            try:
                company_name = row.find(attrs={"data-columnindex": "0"}).get_text()
                # this is n^2?
                company_name_no_commas = (
                    "requires research"
                    if not company_name
                    else "".join(char if char != "," else " " for char in company_name)
                )
                jobs_link_guard = row.find(attrs={"data-columnindex": "2"})
                jobs_link = row.find(
                attrs={"data-columnindex": "2"}).a.get("href") if jobs_link_guard else ""
            except AttributeError as e:
                print(e, company_name)
                pass
            ats_url = extract_ats_domain(jobs_link)
            company_info = (company_name_no_commas, jobs_link, ats_url)

            url_set.add(company_info)
        return url_set

def flatten_tuple_list(jobs):
    '''flattens complex lists of nested tuples
    used in bulk insert functions
    '''
    flat_jobs = [job for sublist in jobs for job in sublist]
    return flat_jobs

def identify_inactive_jobs(scraped_jobs, db_job_id):
    '''compare two list and returns list that appears on second 
    list and not on first list
    scraped job_id = scraped_jobs[2]
    '''

    scraped_jobs_id = [job[2] for job in scraped_jobs]
    delete_set = set(db_job_id) - set(scraped_jobs_id)

    delete_list = [*delete_set]

    return delete_list


def freq_count(data):
    '''written to return frequency each technology is mentioned in tech_stack
    of json_response'''
    
    tech_requirements = []
    for item in data:
        for x in item:
            for tech in json.loads(x):
                tech_requirements.append(tech.upper())

    frequency_counter = Counter(tech_requirements)

    # Sort by frequency in descending order
    sorted_domains = sorted(frequency_counter.items(),
                            key=lambda x: x[1], reverse=True)

    # Print the sorted frequencies
    for tech, count in sorted_domains:
        if count >= 10:
            print(f"{tech}: {count}")


############################# DATABASE QUERIES #############################

def query_all_job_ids():
    '''queries job_postings for all job_ids
    used in comparison for removing job_postings that are no longer open'''

    select_query = '''SELECT job_id FROM job_postings'''

    cursor.execute(select_query)
    return cursor.fetchall()


def query_job_board_ats():
    """
    Called for t2 scrape (to get job application urls)

    returns list of ATS sites we've written scrapers for as tuples
    Output: [(1319, 'iCapital', 'https://boards.greenhouse.io/icapitalnetwork',
            'boards.greenhouse.io', datetime.datetime(2023, 11, 18, 0, 44, 15, 569994)),
            (1320, 'Covariant', 'https://jobs.lever.co/covariant/',
            'jobs.lever.co', datetime.datetime(2023, 11, 18, 0, 44, 15, 570120)),
            ()...]
    """

    insert_query = """
                SELECT * FROM job_boards 
                WHERE careers_url SIMILAR TO %s;
            """

    cursor.execute(insert_query, [ATS_KEYWORDS])
    return cursor.fetchall()


def query_all_job_posting():
    """
    returns list of job_postings that match ATS_KEYWORDS as Tuples
    Output: [('https://jobs.lever.co/voltus/552ab97b-414d-4b54-83ce-b353f8196a5c',
            '552ab97b-414d-4b54-83ce-b353f8196a5c'),
            ('https://jobs.lever.co/voltus/d858d25b-47f2-4ecc-8b9a-3b44549c6087',
            'd858d25b-47f2-4ecc-8b9a-3b44549c6087'),
            ...]
    """

    insert_query = """
            SELECT job_url, job_id FROM job_postings;
        """

    cursor.execute(insert_query)
    return cursor.fetchall()


def query_unblessed_US_jobs():
    """
    --- This is where we do our primary filtering outside of GPT ---
    Called to find jobs to pass into GPT.

    Filters:
        - Location: in the US
        - Title: excluding specific job titles, ie: 'senior', 'mechanical', 'staff', etc
        - No-GPT: (signified by existence of json_response key "apply")

    Output: [(id, job_title, job_url, job_id, scrape-date, company_name,
            job_description, json_response), (), ()...]
    """

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
        AND NOT (json_response::jsonb) ? 'apply';
    """
    cursor.execute(select_query)
    return cursor.fetchall()


def query_blessed_jobs():
    '''Query's job_postings and returns jobs given GPT's blessing '''

    select_query = ''' SELECT * FROM job_postings WHERE (json_response::jsonb) ? 'apply' 
    AND json_response ->> 'apply' ILIKE 'True';'''

    cursor.execute(select_query)
    return cursor.fetchall()


def query_tech_stack():
    select_query = '''SELECT (json_response ->> 'tech_stack')
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
            AND (json_response ->> 'tech_stack') NOT LIKE '[]'
            AND (json_response::jsonb) ? 'apply';'''

    cursor.execute(select_query)
    return cursor.fetchall()


def query_weird_jobs():
    ''' For Testing Purposes 
    Really just saving these here so we have a reference for odd-ball queries
    '''
    query_blessed_null_tech_stack = '''SELECT *
        FROM job_postings
        where json_response ->> 'apply' ILIKE 'true' 
        and json_response ->> 'tech_stack' is null ;'''
    query_blessed_no_tech_stack = '''SELECT * FROM job_postings 
        WHERE (json_response::jsonb) ? 'apply' 
        AND (json_response::jsonb) ->> 'tech_stack' LIKE '[]';'''
    
    cursor.execute(query_blessed_no_tech_stack)
    return cursor.fetchall()