#!/bin/bash

# Load environment variables
export $(cat /home/newbee/newbee_scraper/.env | xargs)

# Activate virtual environment
source /home/newbee/newbee_scraper/venv/bin/activate

# Run your Python script
time python /home/newbee/newbee_scraper/daily_scrape.py

