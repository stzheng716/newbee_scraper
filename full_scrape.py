from GPT.filter_GPT import request_GPT
from t1.get_job_boards import getURL
from t2.T2_extract_job_postings import scrape_all_boards
from t3.job_description_scraper import scrape_n_save
from utilities.utils import select_unblessed_US_roles_matching_ats
from app import conn

def jds_gpts():
    scrape_n_save() #t3
    jobs = select_unblessed_US_roles_matching_ats() 
    request_GPT(jobs) #gpt / t4
    conn.close()
    print("HUZZAH!")


def run_scrapers():
    getURL() #t1
    scrape_all_boards() #t2
    jds_gpts()

run_scrapers()