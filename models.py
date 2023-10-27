"""SQLAlchemy models for Web Scraper."""

from datetime import datetime

from flask_sqlalchemy import SQLAlchemy
from sqlalchemy_utils import URLType
from sqlalchemy import text


db = SQLAlchemy()

class JobBoards(db.Model):
    """Job Boards Pages."""

    __tablename__='job_boards'

    id = db.Column(
        db.Integer,
        primary_key=True
    )

    company_name = db.Column(
        db.String(250),
        nullable=False,
        unique=True,
        server_default=text("'requires research'")
    )

    careers_url = db.Column(
        URLType,
        nullable=False
    )

    ats_url = db.Column(
        db.String(50),
        nullable=False,
    )

    career_date_scraped = db.Column(
        db.DateTime,
        nullable=False,
        server_default=db.func.now()
    )



class JobPostings(db.Model):
    """Job postings from job boards"""

    __tablename__='job_postings'

    id = db.Column(
        db.Integer,
        primary_key=True,
    )

    job_title = db.Column(
        db.String()
    )

    job_url = db.Column(
        URLType,
        nullable=False
    )

    job_id = db.Column(
        db.String(),
        index=True,
        nullable=False,
        unique=True,    )

    job_scraped_date = db.Column(
        db.DateTime,
        nullable=False,
        server_default=db.func.now()
    )

    company_name = db.Column(
        db.String(),
        db.ForeignKey('job_boards.company_name', ondelete='CASCADE'),
        nullable=False
    )

    json_response = db.Column(
        db.JSON
    )

def connect_db(app):
    """Connect this database to provided Flask app.
    You should call this in your Flask app.
    """

    app.app_context().push()
    db.app = app
    db.init_app(app)
