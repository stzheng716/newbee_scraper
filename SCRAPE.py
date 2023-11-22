from GPT.filter_GPT import request_GPT
from t1.get_job_boards import getURL
from t2.T2_extract_job_postings import scrape_all_boards
from t3.job_description_scraper import scrape_n_save
from utilities.utils import select_US_roles_entry
def run_scrapers():
    getURL()
    scrape_all_boards()
    scrape_n_save()
    
    jobs = select_US_roles_entry()
    request_GPT(jobs)

run_scrapers()