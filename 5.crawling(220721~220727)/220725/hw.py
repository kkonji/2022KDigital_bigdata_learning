PATH = '../home/chromedriver'
import time
import requests
from bs4 import BeautifulSoup

url = 'https://finance.naver.com/sise/sise_market_sum.naver'

html = requests.get(url)
soup = BeautifulSoup(html.text, 'html.parser')

import pandas as pd

link_list = []

# 링크 받아오기
for num in range(10):
    row = soup.select_one('div.box_type_l > table > tbody').find_all('tr', onmouseout ="mouseOut(this)")[num].find_all('td')
    link = pd.Series(row)[1].find('a')['href']    # 상대경로
    link_list.append('https://finance.naver.com' + link)
    # row_list.append(row)

# 데이터 프레임 만들기
row_list = []
for link in link_list:
    url = link
    html = requests.get(url)
    soup = BeautifulSoup(html.text, 'html.parser')

    jongmok = soup.select_one('h2 a').text   # 종목명
    code = url[-6:]                          # 종목코드

    yesterday = soup.select('div.rate_info table td')[0].select_one('span.blind').text # 전일가
    high = soup.select('div.rate_info table td')[1].select_one('span.blind').text # 고가
    si = soup.select('div.rate_info table td')[3].select_one('span.blind').text # 시가
    low = soup.select('div.rate_info table td')[4].select_one('span.blind').text # 저가
    today = soup.select_one('p.no_today span.blind').text  # 현재가
    row_list.append([jongmok, code, today, yesterday, si, high, low, url])

column = ['종목명', '종목코드', '현재가', '전일가', '시가', '고가', '저가', '링크']

df = pd.DataFrame(row_list, columns= column)
print(df)


def main():
    while True:
        print('-'*40)
        print('[네이버 코스피 상위 10대 기업 목록]')
        for idx, name in enumerate(df['종목명']):
            print(f'{[idx+1]}', name)
        print('-'*40)
        
        try: 
            select = int(input('주가를 검색할 기업의 번호를 입력하세요(-1: 종료): '))
            if select == -1 :
                print('프로그램 종료')
                quit()

            elif select in range(1,11):
                print(df['링크'][select])
                print('종목명: ',df['종목명'][select])
                print('종목코드: ',df['종목코드'][select])
                print('현재가: ',df['현재가'][select])
                print('전일가: ',df['전일가'][select])
                print('시가: ',df['시가'][select])
                print('고가: ',df['고가'][select])
                print('저가: ',df['저가'][select])

        except Exception as e: continue

main()
