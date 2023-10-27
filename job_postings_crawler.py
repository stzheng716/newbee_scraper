from utils import sql_url_query
from ashby_scraper import scrape_ashby_job_board
from greenhouse_scraper import scrape_greenhouse_job_board
from lever_scraper import scrape_lever_job_board

def scrape_all_boards():
    ats_dict = sql_url_query()
    for key in ["lever", "ashby", "greenhouse"]:
        for url in ats_dict[key]:
            if key == "lever":
                scrape_lever_job_board(url.careers_url)
            elif key == "ashby":
                scrape_ashby_job_board(url.careers_url)
            elif key == "greenhouse":
                scrape_greenhouse_job_board(url.careers_url)
            breakpoint()