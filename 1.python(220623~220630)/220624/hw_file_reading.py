# (1) 사용자가 작성한 댓글을 파일로 저장하기
# (조건): 키보드로 댓글 입력 받기 ->  input
# 입력 받은 댓글 누적 하기
# 댓글 무한반복으로 받을 건대, 종료조건은 Q 또는 q

# with open('댓글.txt', mode='a', encoding='utf-8') as file:
#     with open('댓글.txt', mode='r', encoding='utf-8') as fo:
#         count = len(fo.readlines())
#     while True:
#         count += 1
#         value = input("댓글을 입력하세요: ")
#         if value in ['Q', 'q']: break
#         file.write(f'댓글{count}번째: {value}\n')  # txt +'\n'

# HOME.html파일을 복사해서 home.txt파일로 만들기 -> 이 함수는 html뿐만아니라 다른 파일확장자도 txt도 변환가능
# 함수명: fileCopy
# 매개변수: 파일명
# 반환값: 없음
name = '.\HTML\HOME.html'
def fileCopy(name):
    with open(name, mode='r', encoding='utf-8') as html:
        nm = name[:name.rindex(".")]
        with open(f'{nm}.txt', mode='w', encoding='utf-8') as txt:
            txt.write(html.read())

fileCopy(name)

# print(name.rindex("."))

