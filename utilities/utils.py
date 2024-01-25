from collections import Counter
from urllib.parse import urlparse
from bs4 import BeautifulSoup
import json

""" Utility functions"""


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
    div_element = soup.find("div", class_="selectionCount summaryCell flex-auto")

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

    return domain if domain else ""


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
                company_name_element = row.find(attrs={"data-columnindex": "0"})
                company_name = company_name_element.get_text() if company_name_element else ""
                jobs_link_element = row.find(attrs={"data-columnindex": "2"})
                jobs_link = jobs_link_element.a.get("href") if jobs_link_element and jobs_link_element.a else ""
            except AttributeError as e:
                print(e, company_name)
                pass

            ats_url = extract_ats_domain(jobs_link)
            company_info = (company_name, jobs_link, ats_url)
            url_set.add(company_info)

    return url_set

def flatten_tuple_list(jobs):
    """flattens complex lists of nested tuples
    used in bulk insert functions
    """
    flat_jobs = [job for sublist in jobs for job in sublist]
    return flat_jobs


def identify_inactive_jobs(scraped_jobs, db_job_id):
    """compare two list and returns list that appears on second
    list and not on first list
    scraped job_id = scraped_jobs[2]
    """

    scraped_jobs_id = [job[2] for job in scraped_jobs]
    delete_set = set(db_job_id) - set(scraped_jobs_id)

    delete_list = [*delete_set]

    return delete_list


def freq_count(data):
    """written to return frequency each technology is mentioned in tech_stack
    of json_response"""

    tech_requirements = []
    for item in data:
        for x in item:
            for tech in json.loads(x):
                tech_requirements.append(tech.upper())

    frequency_counter = Counter(tech_requirements)

    # Sort by frequency in descending order
    sorted_domains = sorted(frequency_counter.items(), key=lambda x: x[1], reverse=True)

    # Print the sorted frequencies
    for tech, count in sorted_domains:
        if count >= 10:
            print(f"{tech}: {count}")
