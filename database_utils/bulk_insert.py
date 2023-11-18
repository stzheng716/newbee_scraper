"""script to bulk insert the result of a query into the main database"""
import traceback
import psycopg2
import os
from urllib.parse import urlparse
from dotenv import load_dotenv
from app import DEV

load_dotenv()

# connect to the local database directly for the insert
# conn = psycopg2.connect(database=os.environ["DATABASE_NAME"])

# Double checks DEV environment var and connects to appropriate DB
def db_connect(DEV):
    if DEV:
        return psycopg2.connect(
            dbname=os.environ["DATABASE_NAME"]
        )
    else:
        return psycopg2.connect(
            dbname=os.environ["DATABASE_URL"],
            user=os.environ["RDS_USERNAME"],
            password=os.environ["RDS_PW"],
            host=os.environ["AWS_DATABASE_URL_EP"]
        )

conn = db_connect(DEV)
conn.autocommit = True
cursor = conn.cursor()

# iterate across all of the rows in crawler data, inserting them as we go
def bulk_insert_job_boards(data):
        insert_query = f"""
                INSERT INTO job_boards (company_name, careers_url, ats_url)
                VALUES (%s, %s, %s)
                ON CONFLICT (company_name) DO NOTHING;
                """
        try:
            cursor.executemany(insert_query, (data))
        except psycopg2.DatabaseError as e:
            # Rollback in case of any error
            conn.rollback()
        
            # Log the error details
            print(f"Database error: {e}")
            print("Traceback:", traceback.format_exc())

            # Optionally, re-raise the exception if you want it to propagate
            raise
        
conn.commit()
conn.close()
