from gpt.filter_GPT import request_GPT
from utilities.db_utils import query_unblessed_US_jobs
from app import conn

def daily_scrape():
    jobs = query_unblessed_US_jobs()
    request_GPT(jobs)  # gpt / t4
    conn.close()
    print("HUZZAH! GPT es mui bien")

daily_scrape()
