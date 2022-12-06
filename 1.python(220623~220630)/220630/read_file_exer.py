#!/usr/bin/env python
# coding: utf-8

# # 다양한 종류의 파일을 DataFrame으로 읽기
# 
# ## 메서드: pandas.read_xxx('파일경로', 옵션 파라미터...)


import pandas as pd


# In[38]:


DIR_PATH = '../DATA/'
FILE_NAME = DIR_PATH + 'iris.csv'


# In[39]:


# csv 파일 읽기 --> DataFrame으로 저장
irisDF = pd.read_csv(FILE_NAME)

# 데이터 확인하기
irisDF.info()



# iris-setosa 데이터를 추출해주세요
# irisDF[irisDF['Name'] == 'Iris-setosa' ]



# In[45]:


# 과제 2-1번
print(irisDF[['SepalLength', 'PetalLength']])


# In[46]:


# 과제 2-2번
print(irisDF[irisDF['SepalLength'] >= 5.0][['SepalLength', 'Name']]  )


# In[47]:


# 과제 2-3번
print(irisDF[irisDF['Name']=='Iris-setosa'].min(), irisDF[irisDF['Name']=='Iris-setosa'].max(), sep='\n')


# In[48]:


print(irisDF[irisDF['Name']=='Iris-versicolor'].min(), irisDF[irisDF['Name']=='Iris-versicolor'].max(), sep='\n')


# In[49]:


print(irisDF[irisDF['Name']=='Iris-virginica'].min(), irisDF[irisDF['Name']=='Iris-virginica'].max(), sep='\n')


# In[50]:


print(irisDF.shape)
print(irisDF.columns)
print(irisDF.index)


# In[52]:


# 엑셀 파일 읽기 , 과제 1-1
northsouth = '남북한발전전력량.xlsx' 
FILE_NAME2 = DIR_PATH + northsouth
northDF = pd.read_excel(FILE_NAME2)
northDF = northDF.fillna(" ")
northDF = northDF.replace('-',  None)

print(northDF)


# In[53]:


# 과제 1-2
northDF.info()


# In[54]:


# 문제 1-3
for i in northDF.columns[2:]:
    print(f'{i}년도 최솟값: {northDF[i].min()}')
    print(f'{i}년도 최댓값: {northDF[i].max()}')


# In[55]:


# 문제 1-4
year = northDF.columns[2:]
someLIst = ['전력량 (억㎾h)', '발전 전력별']; count = 0
for i in year:
    if count %2 == 0:
        someLIst.append(i)
    count += 1

print(northDF.loc[:, someLIst])


# In[59]:


# 문제1-5
nor1 = northDF['전력량 (억㎾h)']  # series1
nor2 = northDF['발전 전력별'] # series2
someList = []
row, column =northDF.shape
for i in range(row):
    someList.append(f'{nor1[i]}' + " " + f'{nor2[i]}')

print(someList)
mergeName = '전력량 (억㎾h)' + " " + '발전 전력별'
northDF[mergeName] = someList
print(northDF)


# In[60]:


# 문제1-6
northDF2 = northDF.set_index(mergeName)
print(northDF2)



