from models import JobPostings  # Import the JobPostings model
from sqlalchemy import Inspector, create_engine
from sqlalchemy.orm import sessionmaker
engine = create_engine("postgresql:///job_crawler")
Session = sessionmaker(bind=engine)
session = Session()

# This is a guard for populating tables into an empty db
if not Inspector.has_table("job_postings"):  
    JobPostings.__table__.create(engine)
else:
    # Drop and recreate the table if it exists
    JobPostings.__table__.drop(engine)
    JobPostings.__table__.create(engine)

session.commit()
session.close()
