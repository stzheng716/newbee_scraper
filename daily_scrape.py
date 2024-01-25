from gpt.filter_GPT import request_GPT
from t2.T2_extract_job_postings import scrape_all_boards
from t3.job_description_scraper import scrape_n_save
from utilities.db_utils import query_unblessed_US_jobs
from app import conn


def daily_scrape():
    scrape_all_boards()  # t2
    scrape_n_save()  # t3
    jobs = query_unblessed_US_jobs()
    request_GPT(jobs)  # gpt / t4
    conn.close()
    print("HUZZAH!")

daily_scrape()
