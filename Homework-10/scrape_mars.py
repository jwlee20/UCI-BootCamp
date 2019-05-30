from splinter import Browser
from bs4 import BeautifulSoup


def init_browser():
    # @NOTE: Replace the path with your actual path to the chromedriver
    executable_path = {"executable_path": "/usr/local/bin/chromedriver"}
    return Browser("chrome", **executable_path, headless=False)


def scrape():
    browser = init_browser()

	url = 'https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars'
    browser.visit(url)

    html = browser.html
    soup = BeautifulSoup(html, "html.parser")

    url_list=[]
	links = browser.find_by_css("h3")

	for i in range(len(links)):
	    hemisphere = {}
	    browser.find_by_css("h3")[i].click()
	    sample = browser.find_link_by_text('Sample').first
	    hemisphere['img_url'] = sample['href']
	    hemisphere['title'] = browser.find_by_css("h2").text
	    url_list.append(hemisphere)
	    browser.back()

    return hemisphere