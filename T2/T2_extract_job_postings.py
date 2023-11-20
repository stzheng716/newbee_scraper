from database_utils.bulk_insert import bulk_insert_job_postings
from utilities.utils import sql_url_query
from ashby_scraper import scrape_ashby_job_board
from greenhouse_scraper import scrape_greenhouse_job_board
from lever_scraper import scrape_lever_job_board

def scrape_all_boards():
    potential_jobs = []
    ats_dict = sql_url_query()
    for key in ["lever", "ashby", "greenhouse"]:
            
        for url in ats_dict[key]:
            if key == "lever":
                # print("CoName>>", url.company_name, "URL>>>", url.careers_url )
                lever_jobs = scrape_lever_job_board(url.careers_url, url.company_name)
                if lever_jobs:
                    potential_jobs.append(lever_jobs)
                else:
                    pass
                print(len(potential_jobs))
            elif key == "ashby":
                # print("CoName>>", url.company_name, "URL>>>", url.careers_url )
                ashby_jobs = scrape_ashby_job_board(url.careers_url, url.company_name)
                if ashby_jobs:
                    potential_jobs.append(ashby_jobs)
                else:
                    pass
                print(len(potential_jobs))
                
            elif key == "greenhouse":
                # print("CoName>>", url.company_name, "URL>>>", url.careers_url )
                greenhouse_jobs = scrape_greenhouse_job_board(url.careers_url, url.company_name)
                if greenhouse_jobs:
                    potential_jobs.append(greenhouse_jobs)
                else:
                    pass
                print(len(potential_jobs))
                
    print("potential_jobs ", potential_jobs)
    print(len(potential_jobs))
    bulk_insert_job_postings(potential_jobs)

scrape_all_boards()
            
