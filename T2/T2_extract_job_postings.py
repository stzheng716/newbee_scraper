from database_utils.db_bulk_data_utils import bulk_insert_job_postings, remove_jobs_by_ids
from utilities.utils import sql_job_board_query_ats, flatten_tuple_list, get_all_job_ids, identify_inactive_jobs
from t2.ashby_scraper import scrape_ashby_job_board
from t2.greenhouse_scraper import scrape_greenhouse_job_board
from t2.lever_scraper import scrape_lever_job_board

def scrape_all_boards():
    potential_jobs = []
    jobs = sql_job_board_query_ats()
    for job in jobs:
        if job[3] == "jobs.lever.co":
            # print("CoName>>", job[1], "URL>>>", job[2] )
            lever_jobs = scrape_lever_job_board(job[2], job[1])
            if lever_jobs:
                potential_jobs.append(lever_jobs)
                print("t2 scrape jobs count lever", len(potential_jobs))
            else:
                pass
        elif job[3] == "jobs.ashbyhq.com":
            # print("CoName>>", job[1], "URL>>>", job[2] )
            ashby_jobs = scrape_ashby_job_board(job[2], job[1])
            if ashby_jobs:
                potential_jobs.append(ashby_jobs)
                print("t2 scrape jobs count ashby", len(potential_jobs))
            else:
                pass
            
        elif job[3] == "boards.greenhouse.io":
            # print("CoName>>", job[1], "URL>>>", job[2] )
            greenhouse_jobs = scrape_greenhouse_job_board(job[2], job[1])
            if greenhouse_jobs:
                potential_jobs.append(greenhouse_jobs)
                print("t2 scrape jobs count greenhouse", len(potential_jobs))
            else:
                pass
                
    print("potential_jobs ", potential_jobs)
    print("TOTAL t2 scrape jobs count", len(potential_jobs))

    # combines all list to a single list of jobs scraped
    flat_jobs = flatten_tuple_list(potential_jobs)

    # get all jobs id from the database
    db_job_ids = get_all_job_ids()
    flat_all_jobs_id = flatten_tuple_list(db_job_ids)

    #returns a list of jobs that is in database but not in recently scraped jobs
    inactive_jobs = identify_inactive_jobs(flat_jobs, flat_all_jobs_id)
    
    #bulk removes a list of jobs from the data
    remove_jobs_by_ids(inactive_jobs)

    bulk_insert_job_postings(flat_jobs)

# scrape_all_boards()
            
