import sqlite3
con = sqlite3.connect("job_boards.db")
cur = con.cursor()

'''
Creates job_boards.db sqlite file. No database insertion takes place here.
'''
##should probably be a one of script
cur.execute("CREATE TABLE IF NOT EXISTS crawler(company_name, careers_url)")

def insert_company(data):
    """inserts a single company into the crawler sqlite database"""
    cur.execute("INSERT INTO crawler VALUES(?, ?)", data)
    con.commit() 

def insert_job(data):
    """inserts a single job into the crawler sqlite database"""
    cur.execute("INSERT INTO crawler VALUES(?, ?)", data)
    con.commit() 

