from utils import sql_url_query
from ashby_scraper import scrape_ashby_job_board
from greenhouse_scraper import scrape_greenhouse_job_board
from lever_scraper import scrape_lever_job_board

def scrape_all_boards():
    ats_dict = sql_url_query()
    for key in ["lever", "ashby", "greenhouse"]:
        for url in ats_dict[key]:
            if key == "lever":
                print("CoName>>", url.company_name, "URL>>>", url.careers_url )
                scrape_lever_job_board(url.careers_url, url.company_name)
            elif key == "ashby":
                print("CoName>>", url.company_name, "URL>>>", url.careers_url )
                scrape_ashby_job_board(url.careers_url, url.company_name)
            elif key == "greenhouse":
                print("CoName>>", url.company_name, "URL>>>", url.careers_url )
                scrape_greenhouse_job_board(url.careers_url, url.company_name)

scrape_all_boards()
            
