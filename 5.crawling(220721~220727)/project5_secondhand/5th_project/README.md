# K-Digital BigData Learning
## Project5: Second hand dealings
- 크롤링 Crawling 강의 때 배운 내용을 바탕으로 중고거래 second hand dealings 에 관해 미니 프로젝트 수행

### 맡은 역할
- 맡은 부분 : main.ipynb
- Dataset: 
    1. 중고나라 티켓 https://cafe.naver.com/joonggonara?iframe_url=/ArticleList.nhn%3Fsearch.clubid=10050146%26search.menuid=1285%26userDisplay=50%26search.boardtype=L%26search.specialmenutype=%26search.totalCount=501%26search.cafeId=10050146%26search.page=1
    2. 연도별 박스오피스 http://www.kobis.or.kr
    3. 네이버 데이터랩
- Used Package :
    - pandas, time, matplotlib, BeautifulSoup, Selenium, konlpy, wordcloud
### Summary
1. 중고나라 티켓 항목 크롤링
2. wordcloud 사용해서 형태소 분석 작업
3. 중고나라 빈도수 상위 키워드에 관해 네이버 포털 사이트(네이버 데이터랩 참고)에서의 관심도와 비교
4. wordcloud 사용해서 월별로 중고나라 티켓 부문 키워드 알아보기
5. 중고나라의 빈도수가 실제 판매량으로 이어지는지 체크하기 위해서 연도별 박스오피스 관객수와 매출액과 비교


