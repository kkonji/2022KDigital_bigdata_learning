from urllib.request import urlopen
from bs4 import BeautifulSoup

page = urlopen('https://forecast.weather.gov/MapClick.php?lat=37.7772&lon=-122.4168#.YtnpU3ZBxPY')
soup = BeautifulSoup(page.read(), 'html.parser')
print(soup)