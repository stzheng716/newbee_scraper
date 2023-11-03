import os 
from dotenv import load_dotenv
load_dotenv()


# Find the absolute file path to the top level project directory
basedir = os.path.abspath(os.path.dirname(__file__))

class Config:
    """
    Base configuration class. Contains default configuration settings + configuration settings applicable to all environments.
    """
    # Default settings
    FLASK_ENV = 'development'
    DEBUG = False
    TESTING = False

    # Settings applicable to all environments
    SECRET_KEY = os.getenv('SECRET_KEY')

    SQLALCHEMY_TRACK_MODIFICATIONS = False

    LOCAL_DB_URL = os.getenv('DATABASE_URL_LOCAL')
    AWS_DB_URL = os.getenv('DATABASE_URL_AWS')
    

class DevelopmentConfig(Config):
    DEBUG = True
    DATABASE_URI = os.getenv('DATABASE_URL_LOCAL')


class ProductionConfig(Config):
    FLASK_ENV = 'production'
    DATABASE_URI = os.getenv('DATABASE_URL_AWS')
    DB_USERNAME = os.getenv('RDS_USERNAME')
    RDS_PW = os.getenv('RDS_PW')
    HOST_URL = os.getenv('AWS_DATABASE_URL_EP')

# class TestingConfig(Config):
#     TESTING = True
#     SQLALCHEMY_DATABASE_URI = "sqlite:///" + os.path.join(basedir, 'test.db')
