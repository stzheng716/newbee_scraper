from utils import sql_url_query
from ashby_scraper import scrape_ashby_job_board
from greenhouse_scraper import scrape_greenhouse_job_board
from lever_scraper import scrape_lever_job_board

def test_ashby():
    ats_dict = sql_url_query()
    for url in ats_dict["ashby"]:
        print("JOBURL---->", url.careers_url)
        scrape_ashby_job_board(url.careers_url)
        breakpoint()

def test_greenhouse():
    ats_dict = sql_url_query()
    for url in ats_dict["greenhouse"]:
        scrape_greenhouse_job_board(url.careers_url)
        print("JOBURL---->", url.careers_url)
        breakpoint()

def test_lever():
    ats_dict = sql_url_query()
    for url in ats_dict["lever"]:
        print("JOBURL---->", url.careers_url)
        scrape_lever_job_board(url.careers_url)
        breakpoint()

def test_all_boards():
    ats_dict = sql_url_query()
    for key in ["lever", "ashby", "greenhouse"]:
        for url in ats_dict[key]:
            if key == "lever":
                print("JOBURL---->", url.careers_url)
                scrape_ashby_job_board(url.careers_url)
            elif key == "ashby":
                print("JOBURL---->", url.careers_url)
                scrape_ashby_job_board(url.careers_url)
            elif key == "greenhouse":
                print("JOBURL---->", url.careers_url)
                scrape_greenhouse_job_board(url.careers_url)
            breakpoint()

