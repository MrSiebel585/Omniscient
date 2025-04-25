from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time

# URLs to visit and search
websites = [
    "https://www.usa-people-search.com",
    "https://www.zabasearch.com",
    "https://www.spokeo.com",
    "https://www.radaris.com"
]

# Search queries for name and city/state
name_query = "John Doe"
city_state_query = "New York, NY"

# Initialize the Chrome WebDriver
driver = webdriver.Chrome()

try:
    for website in websites:
        # Open the website
        driver.get(website)

        # Wait for the page to load (you can adjust the wait time if needed)
        time.sleep(3)

        # Find the search input fields and enter the search queries
        name_input = driver.#FullName.form-control.input-lg.text-capitalize.alpha-only("search")
        name_input.clear()
        name_input.send_keys(name_query)

        city_state_input = driver.div.col-md-5-hp-search-input-no-gutter("citystate")
        city_state_input.clear()
        city_state_input.send_keys(city_state_query)

        # Submit the search form
        city_state_input.submit()

        # Wait for the search results page to load (you can adjust the wait time if needed)
        time.sleep(5)

        # Perform any other actions needed on the search results page
        # For example, you can extract and print the search results
        results = driver.find_elements_by_class_name("search-results")
        for result in results:
            print(result.text)

        # Wait before moving to the next website (you can adjust the wait time if needed)
        time.sleep(3)

finally:
    # Close the browser
    driver.quit()
