# 주소록 찾는 python 파일입니다.
# 전역변수와 상수
DIC_NAME = './AddressBook/'
All_NAME = 'All.txt'
def bt2(name_input):
    with open(All_NAME, mode='r', encoding='utf-8') as alltxts:
        lists = alltxts.readlines()
    # 이름 조건을 탐색하고 있다면 파일을 엽니다.
    for i in lists:
        vala, valb = lists[i].split('_')
        valb = valb[:-1]
        if name_input in lists:
            with open(f"{vala}_{valb}.txt", mode='r', encoding='utf-8') as new_address:
                print(f"파일명: {vala}_{valb}")
                print(f"{new_address.read()}")
        else:
            print("찾는 결과가 없습니다. ")
# button 4->3->1->2 순으로 만들었습니다.
def bt3(name, phone, region, email):
    new_address_list.append([name, phone, region, email])
    print(f'[{name}, {phone}, {region}, {email}] 가 주소록에 새로 저장됩니다.')
    # 이름과 전화번호가 들어간 txt파일을 생성합니다
    with open(f"{name}_{phone}.txt", mode='a', encoding='utf-8') as new_address:
        new_address.write(f"이름: {name} \n전화번호: {phone} \n지역: {region}\n이메일: {email}")
    # 모든 주소록들을 포함한 전화번호부를 생성합니다 -> 파일명: All
    with open(All_NAME, mode='a', encoding='utf-8') as alltxt:
        alltxt.write(f"{name}_{phone}\n")


# 입력할 때, 이름, 전화번호, 지역, 이메일 순서로 입력하면 됩니다.
new_address_list = []
DIC_LIST = './AddressBook/'
while True:
    button = int(input("메뉴 선택: "))
    print(new_address_list)
    if button == 1:
        with open(All_NAME, mode='r', encoding='utf-8') as alltxts:
            print(alltxts.read())
    elif button == 2:
        name_input = input("검색 단어(이름): ")
        # All 전화번호부에서 모든 리스트를 들고옵니다.
        bt2(name_input)
    elif button == 3:
        name, phone, region, email = input("이름, 전화번호, 지역, 이메일: ").split(", ")
        bt3(name, phone, region, email)

    elif button == 4:
        break
    else:
        print("잘못된 선택입니다.")

