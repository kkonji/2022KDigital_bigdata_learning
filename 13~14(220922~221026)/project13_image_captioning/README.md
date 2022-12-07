# K-Digital BigData Learning
## Project13: Image Captioning
- NLP 강의 때 배운 내용을 바탕으로 Image Captioning에 관해 미니 프로젝트 수행

### 맡은 역할
- 맡은 부분 : project_NLP.ipynb
    - NLP와 CNN을 이용하여 Image Captioning (이미지를 설명하는 텍스트를 반환)
### 데이터셋 소개
- Dataset:
    -  kaggle https://www.kaggle.com/code/shadabhussain/automated-image-captioning-flickr8/data
- Used programming languages : Python(colab)
- Used package : pandas, matplotlib, nltk, scikit-learn, keras, librosa, tqdm
### Summary
- Image Captioning 작업은 Encoding 부분과 Decoding 부분으로 나뉜다. 먼저 전처리로, nltk와 keras의 Tokenizer를 사용해서 형태소로 쪼갠 후, Encoding 부분은 ResNet50을 사용하고, Decoding 부분은 LSTM을 연이어 붙여서 사용했다. 




