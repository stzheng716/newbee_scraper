#!/bin/bash

# Load environment variables
export $(cat /home/newbee/newbee_scraper/.env | xargs)

# Activate virtual environment
source /home/newbee/newbee_scraper/venv/bin/activate

# Run Python scraper
time python /home/newbee/newbee_scraper/weekly_scrape.py
