# 사용자 정의 클래스 -> 학생을 표현하는 데이터 타입

# 특징, 성질, 외형: 변수 -- 필드/속성(Field, Attribute)
#                 교복, 급식, 학교, 담임, 성적, 학년, 반...
# 역할, 기능     : 함수 -- 메서드
#                공부한다, 학교에 간다, 시험친다...

class student:
    # 클래스 변수: 모든 인스턴스가 함께 사용함
    uniform = "검정"
    # 인스턴스(객체) 생성 시 초기화 메서드
    def __init__(self, name, grade=1, ban=1, school="중학교"):
        self.name = name
        self.grade = grade
        self.ban = ban
        self.school = school
    def study(self, subject="국어"):
        print(f"{self.name}는 {subject}과목을 공부하고 있다.")
    def test(self, subject="국어"):
        print(f"{self.name}는 {subject}과목 시험을 친다")
    def gotoschool(self, notgo=True):
        if not notgo:
            print(f"{self.name}는 학교를 안 갔다.")
        else: print(f"{self.name}는 학교가고 있다.")
    # 학생 정보 출력 기능
    def displayInfo(self):
        print(f'교복: {student.uniform}')
        print(f'학년: {self.grade}')
        print(f'학교: {self.school}')

# 객체,즉 student 인스턴스 생성
stu1 = student("파랑새", 2, 2, "고등학교")

stu1.study()
print(stu1.school)
print(stu1.ban)
stu1.gotoschool(True)
stu1.displayInfo()
stu1.school
