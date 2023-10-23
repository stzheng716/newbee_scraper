"""script to bulk insert the result of a query into the main database"""
import psycopg2
import os
import csv
from dotenv import load_dotenv

load_dotenv()

#connect to the database directly for the insert
conn = psycopg2.connect(database=os.environ["DATABASE_NAME"])
conn.autocommit = True
cursor = conn.cursor()

#table structures to update
table_name = 'job_boards'
columns = ('company_name', 'careers_url')


#insert csv from scrape into database, checking for duplicates
with open('hrefs.csv', 'r') as f:
    csv_reader = csv.reader(f, delimiter=',', quotechar='"')
    # cursor.copy_expert(f"COPY job_boards (company_name, careers_url) FROM stdin CSV", f)
    for row in csv_reader:
        company_name = row[0]
        careers_url = row[1]

        insert_query = f"""
                INSERT INTO {table_name} (company_name, careers_url)
                VALUES (%s, %s)
                ON CONFLICT (company_name) DO NOTHING;
                """
        cursor.execute(insert_query, (company_name, careers_url))

conn.commit
conn.close()
