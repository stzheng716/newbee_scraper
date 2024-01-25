from app import cursor

"""Database query functions"""

KEYWORDS = ["developer", "software engineer", "engineer", "software", "engineering"]
ATS_KEYWORDS = "%(ashby|greenhouse|lever)%"


def query_all_job_ids():
    """queries job_postings for all job_ids
    used in comparison for removing job_postings that are no longer open"""

    select_query = """SELECT job_id FROM job_postings"""

    cursor.execute(select_query)
    return cursor.fetchall()


def query_job_board_ats():
    """
    Called for t2 scrape (to get job application urls)

    returns list of ATS sites we've written scrapers for as tuples
    Output: [(1319, 'iCapital', 'https://boards.greenhouse.io/icapitalnetwork',
            'boards.greenhouse.io', datetime.datetime(2023, 11, 18, 0, 44, 15, 569994)),
            (1320, 'Covariant', 'https://jobs.lever.co/covariant/',
            'jobs.lever.co', datetime.datetime(2023, 11, 18, 0, 44, 15, 570120)),
            ()...]
    """

    insert_query = """
                SELECT * FROM job_boards
                WHERE careers_url SIMILAR TO %s;
            """

    cursor.execute(insert_query, [ATS_KEYWORDS])
    return cursor.fetchall()


def query_all_job_posting():
    """
    returns list of job_postings as Tuples: (job_url, job_id)
    Only returns job posting rows that do_not contain a job_description
    called in t3 scrape

    Output: [('https://jobs.lever.co/voltus/552ab97b-414d-4b54-83ce-b353f8196a5c',
            '552ab97b-414d-4b54-83ce-b353f8196a5c'),
            ('https://jobs.lever.co/voltus/d858d25b-47f2-4ecc-8b9a-3b44549c6087',
            'd858d25b-47f2-4ecc-8b9a-3b44549c6087'),
            ...]
    """

    insert_query = """
            SELECT job_url, job_id FROM job_postings
            WHERE job_description is null;;
        """

    cursor.execute(insert_query)
    return cursor.fetchall()


def query_unblessed_US_jobs():
    """
    --- This is where we do our primary filtering outside of GPT ---
    Called to find jobs to pass into GPT.

    Filters:
        - Location: in the US
        - Title: excluding specific job titles, ie: 'senior', 'mechanical', 'staff', etc
        - No-GPT: (signified by existence of json_response key "apply")

    Output: [(id, job_title, job_url, job_id, scrape-date, company_name,
            job_description, json_response), (), ()...]
    """

    select_query = f"""
    
        SELECT *
        FROM job_postings
        WHERE
        (json_response ->> 'location') LIKE ANY (ARRAY[
        '%Alabama%', '%AL%', '%Alaska%', '%AK%', '%Arizona%', '%AZ%', '%Arkansas%', '%AR%', '%California%', '%CA%',
        '%Colorado%', '%CO%', '%Connecticut%', '%CT%', '%Delaware%', '%DE%', '%Florida%', '%FL%', '%Georgia%', '%GA%',
        '%Hawaii%', '%HI%', '%Idaho%', '%ID%', '%Illinois%', '%IL%', '%Indiana%', '%IN%', '%Iowa%', '%IA%', '%Kansas%',
        '%KS%', '%Kentucky%', '%KY%', '%Louisiana%', '%LA%', '%Maine%', '%ME%', '%Maryland%', '%MD%', '%Massachusetts%',
        '%MA%', '%Michigan%', '%MI%', '%Minnesota%', '%MN%', '%Mississippi%', '%MS%', '%Missouri%', '%MO%', '%Montana%',
        '%MT%', '%Nebraska%', '%NE%', '%Nevada%', '%NV%', '%New Hampshire%', '%NH%', '%New Jersey%', '%NJ%', '%New Mexico%',
        '%NM%', '%New York%', '%NY%', '%North Carolina%', '%NC%', '%North Dakota%', '%ND%', '%Ohio%', '%OH%', '%Oklahoma%',
        '%OK%', '%Oregon%', '%OR%', '%Pennsylvania%', '%PA%', '%Rhode Island%', '%RI%', '%South Carolina%', '%SC%',
        '%South Dakota%', '%SD%', '%Tennessee%', '%TN%', '%Texas%', '%TX%', '%Utah%', '%UT%', '%Vermont%', '%VT%',
        '%Virginia%', '%VA%', '%Washington%', '%WA%', '%West Virginia%', '%WV%', '%Wisconsin%', '%WI%', '%Wyoming%', '%WY%',
        ' Alabama', ' AL', ' Alaska', ' AK', ' Arizona', ' AZ', ' Arkansas', ' AR',
        ' California', ' CA', ' Colorado', ' CO', ' Connecticut', ' CT', ' Delaware', ' DE',
        ' Florida', ' FL', ' Georgia', ' GA', ' Hawaii', ' HI', ' Idaho', ' ID',
        ' Illinois', ' IL', ' Indiana', ' IN', ' Iowa', ' IA', ' Kansas', ' KS',
        ' Kentucky', ' KY', ' Louisiana', ' LA', ' Maine', ' ME', ' Maryland', ' MD',
        ' Massachusetts', ' MA', ' Michigan', ' MI', ' Minnesota', ' MN', ' Mississippi', ' MS',
        ' Missouri', ' MO', ' Montana', ' MT', ' Nebraska', ' NE', ' Nevada', ' NV',
        ' New Hampshire', ' NH', ' New Jersey', ' NJ', ' New Mexico', ' NM', ' New York', ' NY',
        ' North Carolina', ' NC', ' North Dakota', ' ND', ' Ohio', ' OH', ' Oklahoma', ' OK',
        ' Oregon', ' OR', ' Pennsylvania', ' PA', ' Rhode Island', ' RI', ' South Carolina', ' SC',
        ' South Dakota', ' SD', ' Tennessee', ' TN', ' Texas', ' TX', ' Utah', ' UT',
        ' Vermont', ' VT', ' Virginia', ' VA', ' Washington', ' WA', ' West Virginia', ' WV',
        ' Wisconsin', ' WI', ' Wyoming', ' WY','% US %', '% US - %', ' US', 'US ', 'US -', '%United States%', '%US%', ' United States', 
        'United States ', 'US',
        '%Boston%', '%San Francisco%', '%Mountain View%', 'Remote', '%Seattle%', '%Portland%', '%Denver%', '%New York%'
        'Remote', '%Portland%'
        ])
        AND (json_response ->> 'location') NOT ILIKE '%India%' AND (json_response ->> 'location') NOT ILIKE '%latin%' AND (json_response ->> 'location') NOT ILIKE '%europe%' AND (json_response ->> 'location') NOT ILIKE '%UK%' AND (json_response ->> 'location') NOT ILIKE '%mexico%' AND (json_response ->> 'location') NOT ILIKE '%paris%'
        AND (job_title NOT ILIKE '%senior%' AND job_title NOT ILIKE '%staff%' AND job_title NOT ILIKE '%director%' AND job_title NOT ILIKE '%manager%' AND job_title NOT ILIKE '%sr.%' AND job_title NOT ILIKE '%data%' AND job_title NOT ILIKE '%head%' AND job_title NOT ILIKE '%sr %' AND job_title NOT ILIKE '%Mechanical%' AND job_title NOT ILIKE '%lead%' AND job_title NOT ILIKE '%net%' AND job_title NOT ILIKE '%Electrical%' AND job_title NOT ILIKE '%Principal%' AND job_title NOT ILIKE '%VP%' AND job_title NOT ILIKE '%Chassis%' AND job_title NOT ILIKE '%Legal%' AND job_title NOT ILIKE '%Avionics%' AND job_title NOT ILIKE '%President%')
        AND NOT (json_response::jsonb) ? 'apply';
    """
    cursor.execute(select_query)
    return cursor.fetchall()


def query_blessed_jobs():
    """Query's job_postings and returns jobs given GPT's blessing"""

    select_query = """ SELECT * FROM job_postings WHERE (json_response::jsonb) ? 'apply'
    AND json_response ->> 'apply' ILIKE 'True';"""

    cursor.execute(select_query)
    return cursor.fetchall()


def query_tech_stack():
    select_query = """SELECT (json_response ->> 'tech_stack')
            FROM job_postings
            WHERE
            (json_response ->> 'location') LIKE ANY (ARRAY[
            '%Alabama%', '%AL%', '%Alaska%', '%AK%', '%Arizona%', '%AZ%', '%Arkansas%', '%AR%', '%California%', '%CA%',
            '%Colorado%', '%CO%', '%Connecticut%', '%CT%', '%Delaware%', '%DE%', '%Florida%', '%FL%', '%Georgia%', '%GA%',
            '%Hawaii%', '%HI%', '%Idaho%', '%ID%', '%Illinois%', '%IL%', '%Indiana%', '%IN%', '%Iowa%', '%IA%', '%Kansas%',
            '%KS%', '%Kentucky%', '%KY%', '%Louisiana%', '%LA%', '%Maine%', '%ME%', '%Maryland%', '%MD%', '%Massachusetts%',
            '%MA%', '%Michigan%', '%MI%', '%Minnesota%', '%MN%', '%Mississippi%', '%MS%', '%Missouri%', '%MO%', '%Montana%',
            '%MT%', '%Nebraska%', '%NE%', '%Nevada%', '%NV%', '%New Hampshire%', '%NH%', '%New Jersey%', '%NJ%', '%New Mexico%',
            '%NM%', '%New York%', '%NY%', '%North Carolina%', '%NC%', '%North Dakota%', '%ND%', '%Ohio%', '%OH%', '%Oklahoma%',
            '%OK%', '%Oregon%', '%OR%', '%Pennsylvania%', '%PA%', '%Rhode Island%', '%RI%', '%South Carolina%', '%SC%',
            '%South Dakota%', '%SD%', '%Tennessee%', '%TN%', '%Texas%', '%TX%', '%Utah%', '%UT%', '%Vermont%', '%VT%',
            '%Virginia%', '%VA%', '%Washington%', '%WA%', '%West Virginia%', '%WV%', '%Wisconsin%', '%WI%', '%Wyoming%', '%WY%',
            ' Alabama', ' AL', ' Alaska', ' AK', ' Arizona', ' AZ', ' Arkansas', ' AR',
            ' California', ' CA', ' Colorado', ' CO', ' Connecticut', ' CT', ' Delaware', ' DE',
            ' Florida', ' FL', ' Georgia', ' GA', ' Hawaii', ' HI', ' Idaho', ' ID',
            ' Illinois', ' IL', ' Indiana', ' IN', ' Iowa', ' IA', ' Kansas', ' KS',
            ' Kentucky', ' KY', ' Louisiana', ' LA', ' Maine', ' ME', ' Maryland', ' MD',
            ' Massachusetts', ' MA', ' Michigan', ' MI', ' Minnesota', ' MN', ' Mississippi', ' MS',
            ' Missouri', ' MO', ' Montana', ' MT', ' Nebraska', ' NE', ' Nevada', ' NV',
            ' New Hampshire', ' NH', ' New Jersey', ' NJ', ' New Mexico', ' NM', ' New York', ' NY',
            ' North Carolina', ' NC', ' North Dakota', ' ND', ' Ohio', ' OH', ' Oklahoma', ' OK',
            ' Oregon', ' OR', ' Pennsylvania', ' PA', ' Rhode Island', ' RI', ' South Carolina', ' SC',
            ' South Dakota', ' SD', ' Tennessee', ' TN', ' Texas', ' TX', ' Utah', ' UT',
            ' Vermont', ' VT', ' Virginia', ' VA', ' Washington', ' WA', ' West Virginia', ' WV',
            ' Wisconsin', ' WI', ' Wyoming', ' WY','% US %', '% US - %', ' US', 'US ', 'US -', '%United States%', '%US%', ' United States', 'United States ', 'US',
            'Boston', 'San Francisco', 'Mountain View', 'Remote', 'Seattle', 'Portland', 'Denver'
            ])
            AND (json_response ->> 'location') NOT ILIKE '%India%' AND (json_response ->> 'location') NOT ILIKE '%latin%' AND (json_response ->> 'location') NOT ILIKE '%europe%' AND (json_response ->> 'location') NOT ILIKE '%UK%' AND (json_response ->> 'location') NOT ILIKE '%mexico%' AND (json_response ->> 'location') NOT ILIKE '%paris%'
            AND (job_title NOT ILIKE '%senior%' AND job_title NOT ILIKE '%staff%' AND job_title NOT ILIKE '%director%' AND job_title NOT ILIKE '%manager%' AND job_title NOT ILIKE '%sr.%' AND job_title NOT ILIKE '%data%' AND job_title NOT ILIKE '%head%' AND job_title NOT ILIKE '%sr %' AND job_title NOT ILIKE '%Mechanical%' AND job_title NOT ILIKE '%lead%' AND job_title NOT ILIKE '%net%' AND job_title NOT ILIKE '%Electrical%' AND job_title NOT ILIKE '%Principal%' AND job_title NOT ILIKE '%VP%' AND job_title NOT ILIKE '%Chassis%' AND job_title NOT ILIKE '%Legal%' AND job_title NOT ILIKE '%Avionics%' AND job_title NOT ILIKE '%President%')
            AND (json_response ->> 'tech_stack') NOT LIKE '[]'
            AND (json_response::jsonb) ? 'apply';"""

    cursor.execute(select_query)
    return cursor.fetchall()


def query_weird_jobs():
    """For Testing Purposes
    Really just saving these here so we have a reference for odd-ball queries
    """
    query_blessed_null_tech_stack = """SELECT *
        FROM job_postings
        where json_response ->> 'apply' ILIKE 'true'
        and json_response ->> 'tech_stack' is null ;"""
    query_blessed_no_tech_stack = """SELECT * FROM job_postings
        WHERE (json_response::jsonb) ? 'apply'
        AND (json_response::jsonb) ->> 'tech_stack' LIKE '[]';"""

    cursor.execute(query_blessed_no_tech_stack)
    return cursor.fetchall()
