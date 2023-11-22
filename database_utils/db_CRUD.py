"""script to bulk insert the result of a query into the main database"""
import psycopg2
from app import conn
cursor = conn.cursor()


def bulk_insert_job_boards(data):
    with conn.cursor() as cursor:
        insert_query = """
                INSERT INTO job_boards (company_name, careers_url, ats_url)
                VALUES (%s, %s, %s)
                ON CONFLICT (company_name) DO NOTHING;
                """
        try:
            cursor.executemany(insert_query, data)
        except psycopg2.DatabaseError as e:
            conn.rollback()
            print(f"Database error: {e}")


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
    except psycopg2.DatabaseError as e:
        conn.rollback()
        print(f"Database error: {e}")
    finally:
        conn.close()


def bulk_insert_jds(job_desc):

    update_query = f"""
        UPDATE job_postings
        SET job_description = %s
        WHERE job_id = %s;
        """
    try:
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

def remove_jobs_by_ids(inactive_jobs):
    '''takes in a list of job ids and then bulk removes jobs from the database 
    from job_postings table 
    '''

    delete_query = """
        DELETE FROM job_postings
        WHERE job_id = %s; """
    
    try:
        conn.commit()
        # Execute the update query
        cursor.executemany(delete_query, (inactive_jobs))
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