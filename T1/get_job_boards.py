import random
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains
from database_utils.db_CRUD import bulk_insert_job_boards
from utilities.utils import extract_number, extract_and_save

# Set up Selenium
URL = "https://airtable.com/embed/appPGrJqA2zH65k5I/shrI8dno1rMGKZM8y/tblKU0jQiyIX182uU?backgroundColor=cyan&viewControls=on"
options = webdriver.ChromeOptions()
options.add_argument("--headless=new")
driver = webdriver.Chrome(options=options)
PROCESSED_URLS = set()

def getURL():
    '''Tier 1: The First Scrape
    Extracts URLs from the defined global URL variable.

    Parameters:
    - N/A

    Returns:
    - Inserts each URL into a local SQLite DB for bulk insert later on. 
        This saves database queries and is more efficient (and it saves us a little money)
    '''
    driver.set_window_size(1024, 1024)
    driver.execute_script("document.body.style.zoom='25%'")
    driver.get(URL)
    try:
        element =  WebDriverWait(driver, random.randint(2, 8)).until(EC.presence_of_element_located((By.ID, "viewContainer")))
        print(element)
    except TimeoutException:
        print("Page title couldn't be found")
        pass

    initial_response = driver.page_source
    print("INITIAL RESPONSE", type(initial_response))
    global PROCESSED_URLS
    extract_and_save(initial_response, PROCESSED_URLS)
    scrollable_div = driver.find_element(By.CSS_SELECTOR, ".scrollOverlay.antiscroll-wrap")

    # Variables used for breaking out of the while loop
    record_number = extract_number(initial_response)
    previous_set_size = 0
    no_change_counter = 0
    max_no_change = 2

    # Logic to break out of the scrape when it reaches the end of the table
    while len(PROCESSED_URLS) < record_number:
        # Scroll down by 850px
        actions = ActionChains(driver)
        actions.move_to_element(scrollable_div).click().send_keys(Keys.PAGE_DOWN).perform()

        # Wait for the page to load or for more content to appear
        time.sleep(random.randint(0, 10))

        # Get the updated page source after scroll
        response = driver.page_source
        PROCESSED_URLS = extract_and_save(response, PROCESSED_URLS)
        print ("PROCESSED_URLS >>>>>",PROCESSED_URLS)

        # Check if we're at the bottom of the page
        if len(PROCESSED_URLS) == previous_set_size:
            no_change_counter += 1
        else:
            no_change_counter = 0

        # Update the previous set size
        previous_set_size = len(PROCESSED_URLS)

        # Break if we've tried to get new data multiple times without success
        if no_change_counter >= max_no_change:
            break

    response = driver.page_source

    bulk_insert_job_boards(PROCESSED_URLS)

    driver.quit()

# getURL()