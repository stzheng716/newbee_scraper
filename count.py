from urllib.parse import urlparse
from collections import Counter

def count():
    def extract_base_domain(url):
        return urlparse(url).netloc.split("www.")[-1]

    # Read URLs from the file
    with open('hrefs.txt', 'r') as file:
        urls = [line.strip() for line in file]

    base_domains = [extract_base_domain(url) for url in urls]

    frequency_counter = Counter(base_domains)

    # Sort by frequency in descending order
    sorted_domains = sorted(frequency_counter.items(), key=lambda x: x[1], reverse=True)

    # Print the sorted frequencies
    for domain, count in sorted_domains:
        print(f"{domain}: {count}")

count()