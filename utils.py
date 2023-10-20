from bs4 import BeautifulSoup

''' Utility functions for extracting data from the Tier 1 MEGASCRAPE '''
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

def extract_and_save(response, url_set):
    '''Extracts and saves URLs from a selenium scrape

    Parameters:
    - selenium page source

    Returns:
    - Adds href to the "PROCESSED_URLS" set.
    '''
    soup = BeautifulSoup(response, 'html.parser')
    all_spans = soup.find_all('span', class_='truncate noevents')
    if all_spans:
        for span in all_spans:
            a_tag = span.find_parent('a')
            # print(a_tag['href'])
            url_set.add(a_tag['href'])
        return url_set

