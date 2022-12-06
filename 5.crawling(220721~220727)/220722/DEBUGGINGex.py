from urllib.request import urlopen
from bs4 import BeautifulSoup



def parse_use_find(soup):
    
    seven_day = soup.find('div', id = 'seven-day-forecast')
    # 디버깅 키(파이참 기준): f8: 한 라인씩 실행 f7: 함수 내부로 이동
    # vscode는 f5 사용
    forecast_items = seven_day.find_all('div', class_ = 'tombstone-container')
    for day in forecast_items:
        if day.find(class_ = 'temp') is not None:
            period = day.find('p', class_ = 'period-name').text
            print(period)
            short_desc = day.find('p', class_ = 'short-desc').text
            print(short_desc)
            temp = day.find('p', class_ = 'temp').text
            img_desc = day.find('img')['title']

            print('-'* 80)
            print(f'[period]: {period}')
            print(f'[short-desc]: {short_desc}')
            print(f'[temp]: {temp}')
            print(f'[img_desc]: {img_desc}')



    print(len(forecast_items))



def parse_use_select(soup):
    print('parse_use_select')


# 기능 구현
page = urlopen('https://forecast.weather.gov/MapClick.php?lat=37.7772&lon=-122.4168#.YtnpU3ZBxPY')
soup = BeautifulSoup(page.read(), 'html.parser')
print(soup)

parse_use_find(soup)
parse_use_select(soup)