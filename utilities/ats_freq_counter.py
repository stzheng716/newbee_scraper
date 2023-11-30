from urllib.parse import urlparse
from collections import Counter


def count():
    """A frequency counter from early stages. We used it to count the frequency
    of ATS sites from the job_boards table

    Takes in a file of URLs, each on new lines
    Extracts the base URL, creates dict with base: count

    Prints the domain and count in descending order
    """

    def extract_base_domain(url):
        return urlparse(url).netloc.split("www.")[-1]

    # Read URLs from the file
    with open("hrefs.txt", "r") as file:
        urls = [line.strip() for line in file]

    print(urls[0])

    base_domains = [extract_base_domain(url.split("~")[1]) for url in urls]

    frequency_counter = Counter(base_domains)

    # Sort by frequency in descending order
    sorted_domains = sorted(frequency_counter.items(), key=lambda x: x[1], reverse=True)

    # Print the sorted frequencies
    for domain, count in sorted_domains:
        print(f"{domain}: {count}")


count()
