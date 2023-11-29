import requests
import time
from bs4 import BeautifulSoup
from utilities.db_utils import query_all_job_posting
from utilities.db_bulk_data_utils import bulk_insert_jds


def scrape_job_description(url):
    """
    input a job_url from the job_postings table

    output: the job description as text
    """
    response = None
    try:
        response = requests.get(url)
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
    except Exception as e:
        print("t3: Error processing HTML content: ", e)
        return "scrape error"



def aggregate_job_descriptions():
    '''
    This function sends the URL off to scrape_j_d() that returns a JD, 
    then it appends it to a tuple with its associated job_id. 
    That is then added to a large list. 
    The list of tuples is used to bulk insert the data into the DB
    
    returns job_descriptions = 
        [( 'job description string', 'job_id'), ()...]
        '''
    job_descriptions = []
    for job in query_all_job_posting():
        jd_text = scrape_job_description(job[0]).strip()
        job_descriptions.append((jd_text, job[1]))
        print("t3 job description length >>> ", len(job_descriptions))
        time.sleep(0.25)
    return job_descriptions


def scrape_n_save():
    jobs = aggregate_job_descriptions()
    bulk_insert_jds(jobs)

# scrape_n_save()
