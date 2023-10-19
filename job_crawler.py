from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support import expected_conditions as EC

# Set up Selenium
URL = "https://airtable.com/embed/appPGrJqA2zH65k5I/shrI8dno1rMGKZM8y/tblKU0jQiyIX182uU?backgroundColor=cyan&viewControls=on"
options = webdriver.ChromeOptions()
options.headless = True  # Use this option if you don't want to open a browser window
driver = webdriver.Chrome(options=options)

def getURL():

    driver.get(URL)

    try:
       element =  WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.ID, "viewContainer")))
       print(element)
    except TimeoutException:
        print("Page title couldn't be found")
    response = driver.page_source

    driver.quit()

    soup = BeautifulSoup(response, 'html.parser')

    all_spans = soup.find('span', id='truncate noevents')

    if all_spans and all_spans.find_parent('a'):
        a_tag = all_spans.find_parent('a')
        print(a_tag['href'])

getURL()