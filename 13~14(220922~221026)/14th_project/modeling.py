import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from keras.layers import LSTM, GRU, Dense, Dropout, Flatten, Embedding
from keras import Sequential
from keras.callbacks import EarlyStopping, ModelCheckpoint
from keras.metrics import Recall, Precision
from keras.utils import set_random_seed, to_categorical, plot_model
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split

set_random_seed(42)

# 데이터 프레임 불러오기
input_data = pd.read_csv("./data/input_data.csv", index_col=0)
target_data = pd.read_csv("./data/target_data.csv", index_col=0)

# 불필요한 컬럼 제거 및 컬럼명 변경
input_data1 = input_data.iloc[:,0:8]
input_data2 = input_data.iloc[:,8:]
target_data1 = target_data.iloc[:,0:2]
target_data2 = target_data.iloc[:,2:]

input_data1.drop(columns=["지점", "평균 상대습도(%)", "일시"], inplace=True)
input_data2.drop(columns=["지점.2", "평균 상대습도(%).1"], inplace=True)

input_data2.rename(columns={"평균 풍속(m/s).1":"평균 풍속(m/s)", "평균 기온(°C).1":"평균 기온(°C)", "평균 수온(°C).1": \
 "평균 수온(°C)", "일강수량(mm).1": "일강수량(mm)", "합계 일조시간(hr).1" : "합계 일조시간(hr)"}, inplace=True)

target_data1.drop(columns=["지점_x"], inplace=True)
target_data2.drop(columns=["지점_y"], inplace=True)
target_data1.rename(columns={"target_x": "target"}, inplace=True)
target_data2.rename(columns={"target_y": "target"}, inplace=True)

print(input_data1.shape, target_data1.shape)

input_data1.drop(input_data1.iloc[0:365,:].index, inplace=True)
input_data2.drop(input_data2.iloc[0:365,:].index, inplace=True)
target_data1.drop(target_data1.iloc[0:365,:].index, inplace=True)
target_data2.drop(target_data2.iloc[0:365,:].index, inplace=True)

input_data1.reset_index(inplace=True)
input_data1.drop(columns=["index"], inplace=True)
input_data2.reset_index(inplace=True)
input_data2.drop(columns=["index"], inplace=True)

target_data1.reset_index(inplace=True)
target_data1.drop(columns=["일시"], inplace=True)
target_data2.reset_index(inplace=True)
target_data2.drop(columns=["일시"], inplace=True)

# 밀도 상한 1000으로 두기
def get_dens(v):
    if v >= 1000:
        density = 1000
    else:
        density = v
    return density

# get_dens(v) 함수 적용
target_data1["target"] = target_data1["target"].apply(lambda v : get_dens(v))
target_data2["target"] = target_data2["target"].apply(lambda v : get_dens(v))


# 0값이 많아서 거제 데이터 19~22년도 1000개 제거 
target_data1.drop(target_data1.iloc[700:,:].index, inplace=True)
input_data1.drop(input_data1.iloc[700:,:].index, inplace=True)

# 오버샘플링 함수 생성

# # Oversampling 1. 앞 쪽 데이터 증식
def oversample(df, TRAIN_SPLIT):
    df['target_oversample'] = df['target']
    for i in range(2,TRAIN_SPLIT):
        if df['target_oversample'].iloc[i-2] == 0 and df['target_oversample'].iloc[i-1] == 0 and df['target_oversample'].iloc[i] != 0:
            df['target_oversample'].iloc[i-2] = (df['target_oversample'].iloc[i])*1/3
            df['target_oversample'].iloc[i-1] = (df['target_oversample'].iloc[i])*2/3
            
        elif df['target_oversample'].iloc[i-1] == 0 and df['target_oversample'].iloc[i] != 0:
            df['target_oversample'].iloc[i-1] = (df['target_oversample'].iloc[i])*1/2
    # # Oversampling 2. 뒤 쪽 데이터 증식
    for i in range(0,TRAIN_SPLIT):
        if df['target_oversample'].iloc[i+2] == 0 and df['target_oversample'].iloc[i+1] == 0 and df['target_oversample'].iloc[i] != 0:
            df['target_oversample'].iloc[i+2] = (df['target_oversample'].iloc[i])*1/3
            df['target_oversample'].iloc[i+1] = (df['target_oversample'].iloc[i])*2/3
            i = i+2
    return df


# 오버샘플링 적용
TRAIN_SPLIT = 1300
target_data2 = oversample(target_data2, TRAIN_SPLIT)
target_data1 = oversample(target_data1, len(target_data1)-2)

# 표준화
st = StandardScaler()
st.fit(input_data1)
input_data1 = st.transform(input_data1)
input_data2 = st.transform(input_data2)

# 반올림
target_data1 = target_data1.round(2)
target_data2 = target_data2.round(2)


# step 은 보통 1, start_index, end_index 기준으로 데이터를 쪼갠다. -> train, validation
# history_size로 30, target_size로 7로 우선 생각
def multivariate_data(input, target, start_index, end_index, history_size=30, target_size=7, step=1):
    """ dataset 기간별로 쪼개는 함수"""
    data = []
    labels = []

    start_index = start_index + history_size
    if end_index is None:
        end_index = len(input) - target_size

    for i in range(start_index, end_index):
        indices = range(i - history_size, i, step)
        data.append(input[indices])  # 사용할 데이터 수 (날짜 이전 값)
        labels.append(target[i:i+target_size]) # 예측할 데이터 수 (날짜 이후 값)
    return np.array(data), np.array(labels)


# 상수 고정
BUFFER_SIZE = 10000; TRAIN_SPLIT = 1300; BATCH_SIZE = 16

# TRAIN, TEST 쪼개기
train_data, train_target = multivariate_data(input_data2, target_data2["target_oversample"], 30, TRAIN_SPLIT)
train_data2, train_target2 = multivariate_data(input_data1, target_data1["target_oversample"], 30, 693)
test_data, test_target = multivariate_data(input_data2, target_data2["target_oversample"], TRAIN_SPLIT, None)

train_data = np.concatenate([train_data, train_data2])
train_target = np.concatenate([train_target, train_target2])

print(train_data.shape, train_target.shape)
print(test_data.shape, test_target.shape)

# 타겟 표준화 0~1000 -> 0~1
train_target = train_target/1000.0
test_target = test_target/1000.0

# 회귀 LSTM

import tensorflow as tf
train_data_multi = tf.data.Dataset.from_tensor_slices((train_data, train_target))
train_data_multi = train_data_multi.cache().shuffle(BUFFER_SIZE).batch(len(input_data2)-TRAIN_SPLIT).repeat()

val_data_multi = tf.data.Dataset.from_tensor_slices((test_data, test_target))
val_data_multi = val_data_multi.batch(len(input_data2)-TRAIN_SPLIT).repeat()

model = Sequential()
model.add(LSTM(16,activation = 'relu',input_shape = (30,5)))
model.add(Dense(7)) # <- 예측 갯수에 따라서 dense 값 수정 할 것(현재 7일 예측)

adam = tf.keras.optimizers.Adam(learning_rate=0.01)
model.compile(optimizer='adam', loss='mse')

for x, y in val_data_multi.take(1):
    print(model.predict(x).shape)
es = EarlyStopping(monitor='val_loss', mode='min', verbose=1, patience = 10)
mc = ModelCheckpoint('best_model.h5', monitor='val_loss', save_best_only=True)

##########모델생성###############
history = model.fit(train_data_multi, epochs = 100,
                                          batch_size = BATCH_SIZE,
                                          steps_per_epoch = len(input_data2)/BATCH_SIZE, 
                                          validation_data = val_data_multi, validation_steps = 14, callbacks = [es,mc])

# 예측, 실제 그래프 그리기
plt.plot(range(0,7), model.predict(test_data)[395])
plt.plot(range(0,7), test_target[395])
plt.legend(['predict','real'])
plt.show()


# 적조 예측

# y값 -> 실제 값 DataFrame에 저장
y_np_array = np.array(y)
real_value = pd.DataFrame(y_np_array)
real_value

# multi_step_model.predict 값 -> 예측 값 DataFrame에 저장
predict_value = pd.DataFrame(model.predict(x))
predict_value

result = pd.concat([real_value,predict_value], axis=1)
result.columns = ['real_1','real_2','real_3','real_4','real_5', 'real_6', 'real','predict_1','predict_2','predict_3', \
     'predict_4', 'predict_5', 'predict_6', 'predict']

for col in result.columns:    
    for i in range(0,len(result[col])):
        if int(result[col][i]) < 0:
            result[col][i] = 0
        if int(result[col][i]) > 1:
            result[col][i] = 1

# 적조발생 수치 계산

red_tied_rate = 0.1  #적조 발생 밀도 기준치
TP = result.real[(result['real_1'] >= red_tied_rate) & (result['predict_1'] >= red_tied_rate)].count()
TN = result.real[(result['real_1'] < red_tied_rate) & (result['predict_1'] < red_tied_rate)].count()
FN = result.real[(result['real_1'] >= red_tied_rate) & (result['predict_1'] < red_tied_rate)].count()
FP = result.real[(result['real_1'] < red_tied_rate) & (result['predict_1'] >= red_tied_rate)].count()
Pr = result.real[(result['real_1'] >= red_tied_rate)].count()
Nr = result.real[(result['real_1'] < red_tied_rate)].count()
Pp = result.real[(result['predict_1'] >= red_tied_rate)].count()
Np = result.real[(result['real_1'] < red_tied_rate)].count()
All = Pr + Nr



### 1일차 적조 예측
print("TP = {}".format(TP))
print("TN = {}".format(TN))
print("FN = {}".format(FN))
print("FP = {}".format(FP))
print("Pr = {}".format(Pr))
print("Nr = {}".format(Nr))
print("Pp = {}".format(Pp))
print("Np = {}".format(Np))
print("All = {}".format(All))


Precision = TP /(TP+FP)
Recall = TP /(TP+FN)
F1_Score = (2*Precision*Recall) / (Precision + Recall)
print("Precision = {}".format(Precision))
print("Recall = {}".format(Recall))
print("F1_Score = {}".format(F1_Score))

print("Accuracy = {}".format((TP+TN)/ All))
print("Error Rate = {}".format((FP+FN)/ All))
print("Sensitivity = {}".format(TP /Pr))
print("Specificity = {}".format(TN /Nr))
print("Precision = {}".format(Precision))
print("Recall = {}".format(Recall))
print("F1_Score = {}".format(F1_Score))

# 결과 그래프
result[['real_1','predict_1']].plot()