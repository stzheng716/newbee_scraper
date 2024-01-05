import random
import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains
from utilities.db_bulk_data_utils import bulk_insert_job_boards
from utilities.utils import extract_and_save

# Set up Selenium
URL = "https://airtable.com/embed/appPGrJqA2zH65k5I/shrI8dno1rMGKZM8y/tblKU0jQiyIX182uU?backgroundColor=cyan&viewControls=on"
options = webdriver.ChromeOptions()
options.add_argument("--headless=new")
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
options.add_argument("--disable-gpu")
driver = webdriver.Chrome(options=options)


def scrape_airtable():
    """Tier 1: The First Scrape
    Extracts URLs from the defined global URL variable.

    Parameters:
    - N/A

    Returns:
    - Inserts each URL into a local SQLite DB for bulk insert later on.
        This saves database queries and is more efficient (and it saves us a little money)
    """
    processed_urls = set()
    driver.get(URL)
    driver.execute_script("document.body.style.zoom='25%'")
    driver.execute_script("window.dispatchEvent(new Event('resize'));")
    time.sleep(5)

    try:
        element = WebDriverWait(driver, random.randint(10, 12)).until(
            EC.presence_of_element_located((By.ID, "viewContainer"))
        )
        print(element)
    except TimeoutException:
        print("Page title couldn't be found")
        pass

    initial_response = driver.page_source
    extract_and_save(initial_response, processed_urls)
    scrollable_div = driver.find_element(By.CSS_SELECTOR, ".scrollOverlay.antiscroll-wrap")

    # Variables used for breaking out of the while loop
    previous_set_size = 0
    no_change_counter = 0
    max_no_change = 2
    end_of_content = False

    while not end_of_content:
        # Scroll down
        actions = ActionChains(driver)
        actions.move_to_element(scrollable_div).click().send_keys(Keys.PAGE_DOWN).perform()

        # Wait for the page to load or for more content to appear
        time.sleep(random.randint(2, 10))

        # Get the updated page source after scroll
        response = driver.page_source
        processed_urls = extract_and_save(response, processed_urls)
    
        # update counter
        if len(processed_urls) == previous_set_size:
            no_change_counter += 1
        else:
            no_change_counter = 0

        # Update the previous set size
        previous_set_size = len(processed_urls)
        print("t1 get job boards urls processed: ", len(processed_urls))

        # Break if we've tried to get new data multiple times without success
        if no_change_counter >= max_no_change:
            break

    response = driver.page_source

    bulk_insert_job_boards(processed_urls)

    driver.quit()
