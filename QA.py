from utils import sql_url_query
from ashby_scraper import scrape_ashby_job_board

def test_scrapers():
    ats_dict = sql_url_query()
    for url in ats_dict["ashby"]:
        scrape_ashby_job_board(url.careers_url)
        print("JOBURL---->", url.careers_url)
        breakpoint()