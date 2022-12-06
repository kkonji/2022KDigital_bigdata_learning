import pandas as pd
DIR_PATH = '../DATA/'
FILE_NAME = DIR_PATH + 'iris.csv'

irisDF = pd.read_csv(FILE_NAME)
irisDF.info()
# 과제 2-1번
print(irisDF[['SepalLength', 'PetalLength']])
# 과제 2-2번
print(irisDF[irisDF['SepalLength'] >= 5.0][['SepalLength', 'Name']]  )
# 과제 2-3번
print(irisDF[irisDF['Name']=='Iris-setosa'].min(), irisDF[irisDF['Name']=='Iris-setosa'].max(), sep='\n')
print(irisDF[irisDF['Name']=='Iris-versicolor'].min(), irisDF[irisDF['Name']=='Iris-versicolor'].max(), sep='\n')
print(irisDF[irisDF['Name']=='Iris-virginica'].min(), irisDF[irisDF['Name']=='Iris-virginica'].max(), sep='\n')


# 엑셀 파일 읽기
northsouth = '남북한발전전력량.xlsx'
FILE_NAME2 = DIR_PATH + northsouth
northDF = pd.read_excel(FILE_NAME2)
print(northDF)
