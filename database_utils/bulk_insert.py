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

# iterate across all of the rows in crawler data, inserting them as we go
def bulk_insert_job_boards(data):
    conn = db_connect(DEV)
    conn.autocommit = True
    cursor = conn.cursor()
    with conn.cursor() as cursor:
        insert_query = """
                INSERT INTO job_boards (company_name, careers_url, ats_url)
                VALUES (%s, %s, %s)
                ON CONFLICT (company_name) DO NOTHING;
                """
        try:
            cursor.executemany(insert_query, data)
            conn.commit()
            conn.close()
        except psycopg2.DatabaseError as e:
            conn.rollback()
            print(f"Database error: {e}")

def bulk_insert_job_postings(jobs):
    """take list of dictionaries and insert into the main postgres database"""
    flat_jobs = [job for sublist in jobs for job in sublist]
    insert_query = """
        INSERT INTO job_postings (job_title, company_name, job_id, job_url, json_response)
        VALUES (%s, %s, %s, %s, %s::jsonb)
        ON CONFLICT (job_id) DO NOTHING;
        """
    try:
        conn = db_connect(DEV)
        conn.autocommit = True
        cursor = conn.cursor()
        cursor.executemany(insert_query, flat_jobs)
        conn.commit()
    except psycopg2.DatabaseError as e:
        conn.rollback()
        print(f"Database error: {e}")
    finally:
        conn.close()
