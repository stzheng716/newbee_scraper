"""script to bulk insert the result of a query into the main database"""
import psycopg2
import os
import csv
from urllib.parse import urlparse
from dotenv import load_dotenv

load_dotenv()

#connect to the database directly for the insert
conn = psycopg2.connect(database=os.environ["DATABASE_NAME"])
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

#insert csv from scrape into database, checking for duplicates
with open('hrefs.csv', 'r') as f:
    csv_reader = csv.reader(f, delimiter=',', quotechar='"')
    # cursor.copy_expert(f"COPY job_boards (company_name, careers_url) FROM stdin CSV", f)
    for row in csv_reader:
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
