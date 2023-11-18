from utilities.utils import insert_jobs, sql_url_query
from T2.ashby_scraper import scrape_ashby_job_board
from T2.greenhouse_scraper import scrape_greenhouse_job_board
from T2.lever_scraper import scrape_lever_job_board

def scrape_all_boards():
    potential_jobs = []
    ats_dict = sql_url_query()
    for key in ["lever", "ashby", "greenhouse"]:
        for url in ats_dict[key]:
            if key == "lever":
                print("CoName>>", url.company_name, "URL>>>", url.careers_url )
                potential_jobs.append(scrape_lever_job_board(url.careers_url, url.company_name))
            elif key == "ashby":
                print("CoName>>", url.company_name, "URL>>>", url.careers_url )
                potential_jobs.append(scrape_ashby_job_board(url.careers_url, url.company_name))
            elif key == "greenhouse":
                print("CoName>>", url.company_name, "URL>>>", url.careers_url )
                potential_jobs.append(scrape_greenhouse_job_board(url.careers_url, url.company_name))
    insert_jobs(potential_jobs)

scrape_all_boards()
            
