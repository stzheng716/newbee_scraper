import psycopg2
from app import conn

cursor = conn.cursor()
"""This script contains functions that are used during the web scrapes and with
GPT to handle inserting, deleting, or updating rows in our tables"""


def bulk_insert_job_boards(data):
    insert_query = """
            INSERT INTO job_boards (company_name, careers_url, ats_url)
            VALUES (%s, %s, %s)
            ON CONFLICT (company_name) DO NOTHING;
            """
    try:
        cursor.executemany(insert_query, data)
        conn.commit()
        print("success! t1 insert")
    except psycopg2.DatabaseError as e:
        conn.rollback()
        print(f"Database error in t1 insert: {e}")
    except Exception as e:
        print(f"A non-psycopg2 error occurred in t1 insert: {e}")
        raise e


def bulk_insert_job_postings(jobs):
    """take list of dictionaries and insert into the main postgres database"""
    insert_query = """
        INSERT INTO job_postings (job_title, company_name, job_id, job_url, json_response)
        VALUES (%s, %s, %s, %s, %s::jsonb)
        ON CONFLICT (job_id) DO NOTHING;
        """
    try:
        cursor.executemany(insert_query, jobs)
        conn.commit()
        print("success! t2")
    except psycopg2.DatabaseError as e:
        conn.rollback()
        print(f"Database error t2 insert: {e}")
    except Exception as e:
        print(f"A non-psycopg2 error occurred in t2 insert: {e}")
        raise e


def bulk_insert_jds(job_desc):
    update_query = f"""
        UPDATE job_postings
        SET job_description = %s
        WHERE job_id = %s;
        """  # noqa
    try:
        conn.commit()
        cursor.executemany(update_query, (job_desc))
        cursor.connection.commit()
        print("success! t3 jds")

    except psycopg2.Error as e:
        cursor.connection.rollback()
        print(f"An error occurred in t3 JD insert: {e}")
        raise e

    except Exception as e:
        # Handle other exceptions
        print(f"A non-psycopg2 error occurred in t3 JD insert: {e}")
        raise e


def bulk_insert_GPT_response(GPT_resp):
    """Performs lookup of id in job_posting - inserts GPT object into JSON_response field
    Maintains data already saved into the json_response field"""

    insert_query = """
        UPDATE job_postings
        SET json_response = (
            json_response::jsonb ||
            %s::jsonb
        )::json
        WHERE job_id = %s;
    """

    try:
        conn.commit()
        # Execute the update query
        cursor.executemany(insert_query, (GPT_resp))
        # If the update is successful, commit the transaction
        cursor.connection.commit()
        print("success! GPT responses")

    except psycopg2.Error as e:
        # Rollback the transaction on error
        cursor.connection.rollback()
        print(f"An error occurred on GPT insert: {e}")
        # Optionally, re-raise the exception if you want it to bubble up
        raise e

    except Exception as e:
        # Handle other exceptions
        print(f"A non-psycopg2 error occurred on GPT insert: {e}")
        raise e


def remove_jobs_by_ids(inactive_jobs):
    """takes in a list of job ids and then bulk removes jobs from the database
    from job_postings table
    """
    # print("INACTIVE JOB>>>", inactive_jobs)

    delete_query = """
        DELETE FROM job_postings
        WHERE job_id = %s; """

    if inactive_jobs:
        try:
            conn.commit()
            # Execute the update query

            cursor.executemany(delete_query, [[job_id] for job_id in inactive_jobs])

            # If the update is successful, commit the transaction
            cursor.connection.commit()
            print("success! remove old")

        except psycopg2.Error as e:
            # Rollback the transaction on error
            cursor.connection.rollback()
            print(f"An error occurred removing jobs: {e}")
            # Optionally, re-raise the exception if you want it to bubble up
            raise e

        except Exception as e:
            # Handle other exceptions
            print(f"A non-psycopg2 error occurred removing jobs: {e}")
            raise e
