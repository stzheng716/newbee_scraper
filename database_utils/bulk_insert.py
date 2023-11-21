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


def bulk_insert_job_boards(data):
  """Takes in list of tuples, executemany bulk insert"""
    with conn.cursor() as cursor:
        insert_query = """
                INSERT INTO job_boards (company_name, careers_url, ats_url)
                VALUES (%s, %s, %s)
                ON CONFLICT (company_name) DO NOTHING;
                """
        try:
            conn = db_connect(DEV)
            conn.autocommit = True
            cursor = conn.cursor()
            cursor.executemany(insert_query, data)
            conn.commit()
        except psycopg2.DatabaseError as e:
            conn.rollback()
            print(f"Database error: {e}")
        finally:
            conn.close()

            
def bulk_insert_job_postings(jobs):
  """Takes in list of tuples, executemany bulk insert"""
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


def bulk_insert_jds(job_desc):
  """Takes in list of tuples, executemany bulk insert"""
    update_query = f"""
        UPDATE job_postings
        SET job_description = %s
        WHERE job_id = %s;
        """
    try:
        conn = db_connect(DEV)
        conn.autocommit = True
        cursor = conn.cursor()
        conn.commit()
        # Execute the update query
        cursor.executemany(update_query, (job_desc))
        # If the update is successful, commit the transaction
        cursor.connection.commit()
    except psycopg2.Error as e:
        # Rollback the transaction on error
        cursor.connection.rollback()
        print(f"An error occurred: {e}")
        # Optionally, re-raise the exception if you want it to bubble up
        raise e
    except Exception as e:
        # Handle other exceptions
        print(f"A non-psycopg2 error occurred: {e}")
        raise e
    finally:
        conn.close()


def bulk_insert_GPT_response(GPT_resp):
  """Takes in list of tuples, executemany bulk insert"""
    insert_query = """
        UPDATE job_postings
        SET json_response = (
            json_response::jsonb || 
            %s::jsonb
        )::json
        WHERE job_id = %s;
    """

    try:
        conn = db_connect(DEV)
        conn.autocommit = True
        cursor = conn.cursor()
        conn.commit()
        # Execute the update query
        cursor.executemany(insert_query, (GPT_resp))
        # If the update is successful, commit the transaction
        cursor.connection.commit()
    except psycopg2.Error as e:
        # Rollback the transaction on error
        cursor.connection.rollback()
        print(f"An error occurred: {e}")
        # Optionally, re-raise the exception if you want it to bubble up
        raise e
    except Exception as e:
        # Handle other exceptions
        print(f"A non-psycopg2 error occurred: {e}")
        raise e
    finally:
        conn.close()
