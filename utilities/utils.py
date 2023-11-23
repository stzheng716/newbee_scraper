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


def extract_ats_domain(url):
    """extracts the domain from an url

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
    - the filled set, to be processed by the calling parent
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


def sql_job_board_query_ats():
    """
    returns list of ATS sites we've written scrapers for as tuples
    Output: [(1319, 'iCapital', 'https://boards.greenhouse.io/icapitalnetwork',
            'boards.greenhouse.io', datetime.datetime(2023, 11, 18, 0, 44, 15, 569994)),
            (1320, 'Covariant', 'https://jobs.lever.co/covariant/',
            'jobs.lever.co', datetime.datetime(2023, 11, 18, 0, 44, 15, 570120)),
            ...]
    """

    insert_query = """
                SELECT * FROM job_boards 
                WHERE careers_url SIMILAR TO %s;
            """

    cursor.execute(insert_query, [ATS_KEYWORDS])
    return cursor.fetchall()


def sql_job_posting_query_ats():
    """
    returns list of job_postings that match ATS_KEYWORDS as Tuples
    Output: [('https://jobs.lever.co/voltus/552ab97b-414d-4b54-83ce-b353f8196a5c',
            '552ab97b-414d-4b54-83ce-b353f8196a5c'),
            ('https://jobs.lever.co/voltus/d858d25b-47f2-4ecc-8b9a-3b44549c6087',
            'd858d25b-47f2-4ecc-8b9a-3b44549c6087'),
            ...]
    """

    insert_query = """
            SELECT job_url, job_id FROM job_postings 
            WHERE job_url SIMILAR TO %s;
        """

    cursor.execute(insert_query, [ATS_KEYWORDS])
    return cursor.fetchall()


def select_all_unblessed_US_roles_entry():
    """returns db query of all jobs matching the below filters:
        - location
        - title
        - NOT passed through gpt
        
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

def select_unblessed_US_roles_matching_ats():
    """returns list of job_postings that match ATS_KEYWORDS as Tuples, in US, 
    Match title exclusions, and match location exclusions

    We designed this query to limit the job descriptions we're scraping to improve efficiency

    Output: [('https://jobs.lever.co/voltus/552ab97b-414d-4b54-83ce-b353f8196a5c',
    '552ab97b-414d-4b54-83ce-b353f8196a5c'),
    ('https://jobs.lever.co/voltus/d858d25b-47f2-4ecc-8b9a-3b44549c6087',
    'd858d25b-47f2-4ecc-8b9a-3b44549c6087'),
    ...]"""

    select_query = f"""
        SELECT job_url, job_id
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
        AND NOT (json_response::jsonb) ? 'apply'
        AND job_url SIMILAR TO '{ATS_KEYWORDS}';
    """
    cursor.execute(select_query)
    return cursor.fetchall()

def select_applicable_jobs():
    '''Query's job_postings and returns jobs given GPT's blessing '''

    select_query = ''' SELECT * FROM job_postings WHERE (json_response::jsonb) ? 'apply' 
    AND json_response ->> 'apply' ILIKE 'True';'''

    cursor.execute(select_query)
    return cursor.fetchall()


def flatten_tuple_list(jobs):
    flat_jobs = [job for sublist in jobs for job in sublist]
    return flat_jobs


def get_all_job_ids():

    select_query = '''SELECT job_id FROM job_postings'''

    cursor.execute(select_query)
    return cursor.fetchall()


def identify_inactive_jobs(scraped_jobs, db_job_id):
    '''compare two list and returns list that appears on second 
    list and not on first list
    scraped job_id = scraped_jobs[2]
    '''

    scraped_jobs_id = [job[2] for job in scraped_jobs]
    delete_set = set(db_job_id) - set(scraped_jobs_id)

    delete_list = [*delete_set]

    return delete_list


def get_tech_stack():
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
            AND (json_response ->> 'tech_stack') NOT ILIKE 'None'
            AND (json_response::jsonb) ? 'apply';'''

    cursor.execute(select_query)
    return cursor.fetchall()


def count():
    stack_list = get_tech_stack()
    tech_requirements = []
    for item in stack_list:
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
