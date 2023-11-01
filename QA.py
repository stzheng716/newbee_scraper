from utils import sql_url_query
from ashby_scraper import scrape_ashby_job_board
from greenhouse_scraper import scrape_greenhouse_job_board
from lever_scraper import scrape_lever_job_board

""" Passing the variable "test" isn't necessary when calling these functions, but 
running it with test=True prints the jobs to the terminal instead of adding it
to the DataBase. 
"""

def test_ashby():
    ats_dict = sql_url_query()
    for url in ats_dict["ashby"]:
        print("JOBURL---->", url.careers_url)
        print("CoName---->", url.company_name)
        scrape_ashby_job_board(url.careers_url, url.company_name, test=True)
        breakpoint()

def test_greenhouse():
    ats_dict = sql_url_query()
    for url in ats_dict["greenhouse"]:
        scrape_greenhouse_job_board(url.careers_url, url.company_name, test=True)
        print("JOBURL---->", url.careers_url)
        print("CoName---->", url.company_name)
        breakpoint()

def test_lever():
    ats_dict = sql_url_query()
    for url in ats_dict["lever"]:
        print("JOBURL---->", url.careers_url)
        print("CoName---->", url.company_name)
        scrape_lever_job_board(url.careers_url, url.company_name, test=True)
        breakpoint()

def test_all_boards():
    ats_dict = sql_url_query()
    for key in ["lever", "ashby", "greenhouse"]:
        for url in ats_dict[key]:
            if key == "lever":
                print("JOBURL---->", url.careers_url)
                print("CoName---->", url.company_name)
                scrape_ashby_job_board(url.careers_url, url.company_name, test=True)
            elif key == "ashby":
                print("JOBURL---->", url.careers_url)
                print("CoName---->", url.company_name)
                scrape_ashby_job_board(url.careers_url, url.company_name, test=True)
            elif key == "greenhouse":
                print("JOBURL---->", url.careers_url)
                print("CoName---->", url.company_name)
                scrape_greenhouse_job_board(url.careers_url, url.company_name, test=True)
            breakpoint()

