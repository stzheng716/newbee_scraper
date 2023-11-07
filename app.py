import os
from dotenv import load_dotenv
from models import db, connect_db

from flask import Flask
DEV = True
load_dotenv()

app = Flask(__name__)

database_url = os.environ['TEST_DATABASE_URL'] if DEV else os.environ["DATABASE_URL"]
database_url = database_url.replace('postgresql://', 'postgres://') if DEV else database_url.replace('postgres://', 'postgresql://')
app.config['SQLALCHEMY_ECHO'] = False
app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False
app.config['SECRET_KEY'] = os.environ['SECRET_KEY']
app.config['SQLALCHEMY_DATABASE_URI'] = database_url

connect_db(app)

with app.app_context():
    db.create_all()