"""script to bulk insert the result of a query into the main database"""
import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()
conn = psycopg2.connect(database=os.environ["DATABASE_NAME"])

conn.autocommit = True
cursor = conn.cursor()

table_name = 'job_boards'

#clear the current contents of the table
columns = ('company_name', 'careers_url')
truncate_query = f"TRUNCATE TABLE {table_name} CASCADE"

cursor.execute(truncate_query)

#open the csv and bulk insert it into the database
with open('hrefs.csv', 'r') as f:
    cursor.copy_expert(f"COPY job_boards (company_name, careers_url) FROM stdin CSV", f)

conn.commit
