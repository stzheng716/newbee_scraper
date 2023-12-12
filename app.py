import os
from dotenv import load_dotenv
import psycopg2

DEV = True
load_dotenv()


def db_connect(DEV):
    if DEV:
        return psycopg2.connect(dbname=os.environ["DATABASE_NAME"])
    else:
        return psycopg2.connect(
            dbname=os.environ["DATABASE_URL"],
            user=os.environ["RDS_USERNAME"],
            password=os.environ["RDS_PW"],
            host=os.environ["AWS_DATABASE_URL_EP"],
        )


conn = db_connect(DEV)
conn.autocommit = True
cursor = conn.cursor()
