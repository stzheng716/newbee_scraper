import requests
import time
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from utilities.db_utils import query_all_job_posting
from utilities.db_bulk_data_utils import bulk_insert_jds


def scrape_with_selenium(url):
    """
    Scrape the job description from a web page using Selenium for dynamic content.

    This function is used as a fallback when BeautifulSoup fails to find the job description
    due to the content being dynamically loaded via JavaScript.

    Args:
    url (str): The URL of the job posting.

    Returns:
    str: The text of the job description, or None if an error occurs.
    """
    options = webdriver.ChromeOptions()
    options.add_argument("--headless=new")
    driver = webdriver.Chrome(options=options)
    try:
        driver.get(url)
        element = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CLASS_NAME, "_description_z1j6s_201"))
        )
        return element.text
    except Exception as e:
        print(f"Selenium scraping error: {e}")
        return None
    finally:
        driver.quit()


def scrape_job_description(url):
    """
    input a job_url from the job_postings table

    output: the job description as text

    Scrape the job description from a given URL.

    This function first attempts to scrape the job description using BeautifulSoup.
    If it fails (typically in case of dynamic content), it falls back to using Selenium.

    Args:
    url (str): The URL of the job posting.

    Returns:
    str: The job description as text. If an error occurs, returns "scrape error".
    """
    response = None
    try:
        response = requests.get(url)
        soup = BeautifulSoup(response.content, "html.parser")
        job_description = ""

        if "greenhouse" in url:
            content_divs = soup.find_all("div", id="content")
            if content_divs:  # Check if the list is not empty
                job_description = content_divs[0].text.replace("\n", " ").strip()
            else:
                print("T3 >>> No div with id='content' found.")
        # elif "ashby" in url:
        #     job_description = soup.find('meta', attrs={'name': 'description'}).get(
        #         'content').replace("\n", "").strip()
        elif "ashby" in url:
            job_desc_div = soup.find("div", class_="_description_z1j6s_201")
            if job_desc_div:
                job_description = " ".join(job_desc_div.stripped_strings)
            else:
                print("BeautifulSoup failed to find the Ashby job description, attempting Selenium...")
                job_description = scrape_with_selenium(url)
                if not job_description:
                    print(f"Failed to scrape job description for {url}")

        elif "lever" in url:
            job_line = soup.find_all("div", class_="section page-centered")
            texts = [div.text for div in job_line]
            job_description = "\n".join(texts).replace("\n", "")

        # print(job_description)
        # breakpoint()
        return job_description
    except Exception as e:
        print("t3: Error processing HTML content: ", e)
        return "scrape error"


def aggregate_job_descriptions():
    """
    Aggregate job descriptions from a list of job postings.

    This function iterates over job postings obtained from the database, scrapes each job
    description, and compiles them into a list along with their associated job IDs.

    Returns:
    list of tuples: A list where each tuple contains a job description and its corresponding job ID.

    ex: job_descriptions =
        [( 'job description string', 'job_id'), ()...]
    """
    job_descriptions = []
    for job in query_all_job_posting():
        jd_text = scrape_job_description(job[0])
        if jd_text and jd_text != "scrape error":
            job_descriptions.append((jd_text, job[1]))
        print("t3 job description length >>> ", len(job_descriptions))
        time.sleep(0.25)
    return job_descriptions


def scrape_n_save():
    """
    Scrape job descriptions and save them to a database.

    This function aggregates job descriptions using `aggregate_job_descriptions` and then
    uses `bulk_insert_jds` to save them into a database.
    """
    jobs = aggregate_job_descriptions()
    bulk_insert_jds(jobs)


# scrape_n_save()
