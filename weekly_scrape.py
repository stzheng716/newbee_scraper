from t1.get_job_boards import scrape_airtable
from app import conn

def weekly_scrape():
    scrape_airtable()  # t1
    conn.close()

weekly_scrape()
