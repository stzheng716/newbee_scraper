"""script to bulk insert the result of a query into the main database"""
import psycopg2
import os
from urllib.parse import urlparse
from dotenv import load_dotenv

import sqlite3
sq3_con = sqlite3.connect("crawler.db")
sq3_cur = sq3_con.cursor()

load_dotenv()

#connect to the local database directly for the insert
# conn = psycopg2.connect(database=os.environ["DATABASE_NAME"])

#connect to the AWS database directly for the insert
#TODO: dry up this code by combining with utils.py

conn = psycopg2.connect(
    dbname=os.environ["DATABASE_NAME"],
    user=os.environ["RDS_USERNAME"],
    password=os.environ["RDS_PW"],
    host=os.environ["AWS_DATABASE_URL_EP"]
)


conn.autocommit = True
cursor = conn.cursor()

#table structures to update
table_name = 'job_boards'
columns = ('company_name', 'careers_url')

def extract_domain(url):
    """extracts the domain from an url

    params:
    - a url string

    returns:
    - the domain portion of a url

    ex:
    "https://www.example.com/path/to/page" -> "example.com"

    """
    # Parse the URL
    parsed_url = urlparse(url)

    # Get the hostname (domain) portion from the parsed URL
    domain = parsed_url.hostname

    # Check if the domain starts with "www." and remove it if present
    if domain and domain.startswith("www."):
        domain = domain[4:]  # Remove "www."

    return domain


#pull all of the data from the crawler temporary database
crawler_data = sq3_cur.execute("SELECT * FROM crawler")

#interate across all of the rows in crawler data, inserting them as we go
for row in crawler_data.fetchall():
    company_name = row[0]
    careers_url = row[1]
    ats_url = extract_domain(careers_url)

    insert_query = f"""
            INSERT INTO {table_name} (company_name, careers_url, ats_url)
            VALUES (%s, %s, %s)
            ON CONFLICT (company_name) DO NOTHING;
            """
    cursor.execute(insert_query, (company_name, careers_url, ats_url))

conn.commit
conn.close()
