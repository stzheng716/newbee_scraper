"""a ductape version of a database migration.
Given our experience with SIS migrations, I decided that this should do for
the time being"""
from app import db
import subprocess

db.drop_all()
db.create_all()

subprocess.run(["python", "bulk_insert.py"])