from bs4 import BeautifulSoup

""" Utility functions for extracting data from the Tier 1 MEGASCRAPE """


def extract_number(html_content: str) -> int:
    """
    Extracts the number from a specific div element in the provided HTML content.

    Parameters:
    - html_content: A string containing the HTML content.

    Returns:
    - An integer representing the extracted number (e.g., 1349).
    """
    soup = BeautifulSoup(html_content, "html.parser")
    div_element = soup.find("div", class_="selectionCount summaryCell flex-auto")

    if div_element:  # Check if the div_element was found
        text_content = div_element.text
        number_str = text_content.split()[0]
        # Remove commas and convert to intege(
        number = int(number_str.replace(",", ""))
        return number

    return None  # Return None if the div element was not found


def extract_and_save(response, url_set):
    """Extracts and saves URLs from a selenium scrape

    Parameters:
    - selenium page source
    - set to hold processed company names and job link urls
        -set will be set of tuples (company_name: str, job_url: str)

    Returns:
    - the filled set, to be procssed by the calling parent
    """
    soup = BeautifulSoup(response, "html.parser")

    # access all of the dataRows from "dataLeftPaneInnerContent paneInnerContent"
    all_rows = soup.find_all(attrs={"data-testid": "data-row"})

    if all_rows:
        for row in all_rows:
            company_name = row.find(attrs={"data-columnindex": "0"}).get_text()
            #this is n^2?
            company_name_no_commas = "".join(
                char if char != "," else " " for char in company_name
            )
            jobs_link = row.find(attrs={"data-columnindex": "2"}).a.get("href")

            company_info = (company_name_no_commas, jobs_link)

            url_set.add(company_info)
        return url_set
