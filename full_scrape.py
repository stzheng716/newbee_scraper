from gpt.filter_GPT import request_GPT
from t1.get_job_boards import getURL
from t2.T2_extract_job_postings import scrape_all_boards
from t3.job_description_scraper import scrape_n_save
<<<<<<< HEAD
from utilities.db_utils import query_unblessed_US_jobs
=======
from utilities.utils import query_unblessed_US_jobs
>>>>>>> edea51dd59573c1537d4adc50d6153bea2180624
from app import conn

def jds_gpts():
    scrape_n_save() #t3
    jobs = query_unblessed_US_jobs() 
    request_GPT(jobs) #gpt / t4
    conn.close()
    print("HUZZAH!")


def run_scrapers():
    getURL() #t1
    scrape_all_boards() #t2
    jds_gpts()

run_scrapers()