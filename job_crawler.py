import time
from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.remote.webdriver import WebDriver



# Set up Selenium
URL = "https://airtable.com/embed/appPGrJqA2zH65k5I/shrI8dno1rMGKZM8y/tblKU0jQiyIX182uU?backgroundColor=cyan&viewControls=on"
options = webdriver.ChromeOptions()
options.headless = True  # Use this option if you don't want to open a browser window
driver = webdriver.Chrome(options=options)

def getURL():
    driver.set_window_size(1024, 1024)
    driver.get(URL)

    try:
       element =  WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.ID, "viewContainer")))
       print(element)
    except TimeoutException:
        print("Page title couldn't be found")

    def extract_and_save(response):
        soup = BeautifulSoup(response, 'html.parser')
        all_spans = soup.find_all('span', class_='truncate noevents')
        if all_spans:
            with open("hrefs.txt", "a") as file:
                for span in all_spans:
                    a_tag = span.find_parent('a')
                    # print(a_tag['href'])
                    file.write(a_tag['href']+'\n')

    initial_response = driver.page_source
    extract_and_save(initial_response)    
    scrollable_div = driver.find_element(By.CSS_SELECTOR, ".scrollOverlay.antiscroll-wrap")
    total_height = driver.execute_script("return document.body.scrollHeight;")

    while True:
        # Scroll down by 850px
        actions = ActionChains(driver)
        actions.move_to_element(scrollable_div).click().send_keys(Keys.PAGE_DOWN).perform()
        
        # Wait for the page to load or for more content to appear
        time.sleep(.5)  

        # Get the updated page source after scroll
        response = driver.page_source
        extract_and_save(response)

        # Check if we're at the bottom of the page
        scroll_position = driver.execute_script("return arguments[0].scrollHeight", scrollable_div)

        print("ScrollPosition ===", scroll_position, '\n', 'total Height ==', total_height)
        if scroll_position == total_height:
            break

    response = driver.page_source

    driver.quit()

getURL()