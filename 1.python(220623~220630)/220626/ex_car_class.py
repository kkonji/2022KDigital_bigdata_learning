# 현대 자동차를 표현하는 데이터 타입
# 클래스명: car
# 속성, 특징: 제조사-현대, 차번호, 차종류, 색상
# 역할, 기능: 이동한다-시작,끝, 정지한다, 차정보 출력한다.
# 이동한다: xxx 자동차가 oo에서 oo로 간다.
# 정지한다: xxx 자동차가 oo에 정지한다.
# 차정보 출력:
class car:
    manufacturer = "현대"
    def __init__(self, car_nbr='123가-4567', car_type="벨로스터 N", color="검정"):
        car.car_nbr = car_nbr
        car.car_type = car_type
        car.color = color
    def move(self, start="서울", end="부산"):
        print(f"{self.car_nbr} 자동차가 {start}에서 {end}로 간다.")
    def stop(self, end="부산"):
        print(f"{self.car_nbr} 자동차가 {end}에 정지한다.")
    def carInfo(self):
        print("===========차 정보=============")
        print(f"제조사 : {car.manufacturer}")
        print(f"차 번호: {self.car_nbr}")
        print(f"차 종류: {self.car_type}")
        print(f"차 색깔: {self.color}")
        print("=============================")


# 테스트 -> 자동차 데이터 저장 -> 자동차 인스턴스 생성 -> 클래스명() -- __init__()
car1 = car()
car1.carInfo()
car1.stop("울릉도")
car1.move("대구", "수원")
print(car1.manufacturer)

# 숫자 10개 저장
# nums = []
# for n in range(10):
#     nums.append(int(input("enter nbr: ")))
# car 데이터 10개 저장
cars = []
for n in range(3):
    num, type, color = input("차번호, 차종류, 차색상: ").split(',')
    cars.append(car(num, type, color))
    for i in cars:
        print(f'{i.car_nbr}')
        i.carInfo()


