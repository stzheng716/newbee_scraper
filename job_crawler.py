import time
from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains

# Set up Selenium
URL = "https://airtable.com/embed/appPGrJqA2zH65k5I/shrI8dno1rMGKZM8y/tblKU0jQiyIX182uU?backgroundColor=cyan&viewControls=on"
options = webdriver.ChromeOptions()
options.headless = True  # Use this option if you don't want to open a browser window
driver = webdriver.Chrome(options=options)
COUNT=0

def getURL():
    driver.set_window_size(1024, 1024)
    driver.get(URL)
    global COUNT
    processed_urls = set()
    try:
        element =  WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.ID, "viewContainer")))
        print(element)
    except TimeoutException:
        print("Page title couldn't be found")

    def extract_and_save(response):
        soup = BeautifulSoup(response, 'html.parser')
        all_spans = soup.find_all('span', class_='truncate noevents')
        if all_spans:
            for span in all_spans:
                a_tag = span.find_parent('a')
                # print(a_tag['href'])
                processed_urls.add(a_tag['href'])


    initial_response = driver.page_source
    extract_and_save(initial_response)
    scrollable_div = driver.find_element(By.CSS_SELECTOR, ".scrollOverlay.antiscroll-wrap")
    record_number = extract_number(initial_response)

    previous_set_size = 0
    no_change_counter = 0
    max_no_change = 3  # Adjust based on your preference

    while  len(processed_urls) < record_number:
        # Scroll down by 850px
        actions = ActionChains(driver)
        actions.move_to_element(scrollable_div).click().send_keys(Keys.PAGE_DOWN).perform()

        # Wait for the page to load or for more content to appear
        time.sleep(.5)

        # Get the updated page source after scroll
        response = driver.page_source
        extract_and_save(response)

        # Check if we're at the bottom of the page
        if len(processed_urls) == previous_set_size:
            no_change_counter += 1
        else:
            no_change_counter = 0

        # Update the previous set size
        previous_set_size = len(processed_urls)

        # Break if we've tried to get new data multiple times without success
        if no_change_counter >= max_no_change:
            break

    response = driver.page_source

    with open('hrefs.txt','a') as file:
        for url in processed_urls:
            file.write(url + '\n')

    driver.quit()

def extract_number(html_content: str) -> int:
    """
    Extracts the number from a specific div element in the provided HTML content.

    Parameters:
    - html_content: A string containing the HTML content.

    Returns:
    - An integer representing the extracted number (e.g., 1349).
    """
    soup = BeautifulSoup(html_content, 'html.parser')
    div_element = soup.find('div', class_='selectionCount summaryCell flex-auto')

    if div_element:  # Check if the div_element was found
        text_content = div_element.text
        number_str = text_content.split()[0]
        # Remove commas and convert to integer
        number = int(number_str.replace(',', ''))
        return number

    return None  # Return None if the div element was not found

getURL()