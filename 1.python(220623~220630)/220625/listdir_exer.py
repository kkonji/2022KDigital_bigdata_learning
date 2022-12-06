# File & Dir 관련 모듈
import os.path as op
import os
import time
# 특정 폴더 존재 여부 체크 -> 폴더 없으면 폴더 생성하기
DIR_PATH = './image/jpg'
if not op.exists(DIR_PATH):  # 특정 폴더 존재 여부 체크
    os.makedirs(DIR_PATH)   # os.mkdirs 은 한개 만드는 애(폴더 생성)
                            # os.makedirs은 여러개 만드는 애 (하위 폴더까지 모두 생성)
# 특정 파일 존재 여부 체크
DATA_FILE = DIR_PATH+'/flow.txt'
if not op.exists(DATA_FILE):  # 특정 폴더 존재 여부 체크
    print('파일없음')

# 특정 경로 안에 존재하는 내용 리스트 화

dataList = os.listdir('./AddressBook')
print(dataList)
# os.scandir('')

print(time.ctime())
curTime = time.localtime(time.time())
print(curTime.tm_year, curTime.tm_mon, curTime.tm_mday)
print(time.strftime('%Y %m %d', curTime))

for i in range(10):
    print('▶', end='')
    time.sleep(0.2)

print(os.listdir('./image'))