# K-Digital BigData Learning
## Project4: Oil Price
- 공공 데이터 강의 때 배운 내용을 바탕으로 oil price 에 관해 EDA 진행

### 맡은 역할
- 맡은 부분 : main.ipynb
- Dataset: 
    1. 국가물류통합정보센터 http://nlic.go.kr/nlic/KosGudeHtm.action
    2. e-나라지표 http://index.go.kr/potal/stts/idxMain/selectPoSttsIdxMainPrint.do?idx_cd=1265&board_cd=INDX_001
    3. kosis https://kosis.kr/statHtml/statHtml.do?orgId=116&tblId=DT_MLTM_662&conn_path=I2
- Used Package :
    - pandas, numpy, matplotlib
### EDA 작업
- 전처리 과정
    - 결측치 제거
    - 컬럼병 자료형 설정
    - 데이터 표준화
- 그래프 그리기
#### 유가 변동에 따른 물류, 유통 분야의 변화
1. 유가와 컨테이너 화물수송 실적과의 관계
2. 유가와 물동량 간의 관계
