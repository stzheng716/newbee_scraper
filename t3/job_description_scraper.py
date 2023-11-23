import requests
import time
from bs4 import BeautifulSoup
from utilities.utils import select_unblessed_US_roles_matching_ats
from database_utils.db_bulk_data_utils import bulk_insert_jds


def scrape_job_description(url):
    """
    input a job_posting url from lever, greenhouse, or ashby

    output: the job description as text
    """
    response = None
    try:
        response = requests.get(url)
        response.raise_for_status()  # Check if the request was successful
    except Exception as e:
        print("t3: Error processing HTML content: ", e)
        return "null"

    soup = BeautifulSoup(response.content, 'html.parser')
    job_description = ""

    if "greenhouse" in url:
        content_divs = soup.find_all('div', id='content')
        if content_divs:  # Check if the list is not empty
            job_description = content_divs[0].text.replace(
                "\n", " ").strip()
        else:
            print("T3 >>> No div with id='content' found.")
    elif "ashby" in url:
        job_description = soup.find('meta', attrs={'name': 'description'}).get(
            'content').replace("\n", "").strip()
    elif "lever" in url:
        job_line = soup.find_all('div', class_="section page-centered")
        texts = [div.text for div in job_line]
        job_description = '\n'.join(texts).replace('\n', "")

    # print(job_description)
    return job_description



def aggregate_job_descriptions():
    job_descriptions = []
    print(select_unblessed_US_roles_matching_ats())
    for job in select_unblessed_US_roles_matching_ats():
        jd_text = scrape_job_description(job[0]).strip()
        job_descriptions.append((jd_text, job[1]))
        print("t3 job description length >>> ", len(job_descriptions))
        time.sleep(0.25)
    return job_descriptions


def scrape_n_save():
    jobs = aggregate_job_descriptions()
    bulk_insert_jds(jobs)

# scrape_n_save()
