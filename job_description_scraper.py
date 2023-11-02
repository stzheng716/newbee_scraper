import requests
import time
from bs4 import BeautifulSoup
from utils import sql_job_posting_query

def scrape_job_description(url):
    """
    input a job_posting url from lever, greenhouse, or ashby

    output: the job description as text
    """
    response = requests.get(url)
    try:
        response.raise_for_status()  # Check if the request was successful
    except (requests.HTTPError, requests.ConnectionError): 
        print("Page title couldn't be found")
        pass

    soup = BeautifulSoup(response.content, 'html.parser')
    job_description = ""

    if "greenhouse" in url:
        content_divs = soup.find_all('div', id='content')
        if content_divs:  # Check if the list is not empty
            job_description = content_divs[0].text.replace("\n", " ").strip()
        else:
            print("No div with id='content' found.")
    elif "ashby" in url:
        job_description = soup.find('meta', attrs={'name': 'description'}).get('content').replace("\n","").strip()
    elif "lever" in url:
        job_line = soup.find_all('div', class_="section page-centered")
        texts = [div.text for div in job_line]
        job_description = '\n'.join(texts).replace('\n', "")

    print(job_description)
    return job_description


for job in sql_job_posting_query():
    jd_text = scrape_job_description(job.job_url)
    print(jd_text)
    time.sleep(0.5)