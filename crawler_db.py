import sqlite3
con = sqlite3.connect("crawler.db")
cur = con.cursor()

##should probably be a one of script
cur.execute("CREATE TABLE IF NOT EXISTS crawler(company_name, careers_url)")

def insert_company(data):
    """inserts a single company into the crawler sqlite database"""
    cur.execute("INSERT INTO crawler VALUES(?, ?)", data)
    con.commit() 


