## 계획


### 8/31

- Realm Model 설계와 Repositary 클래스 생성 등 기본 세팅
- BaseViewController와 BaseView 생성

### 9/1

- 최초 팝업 화면 완성(UserDefaults 적용)
- 메모 리스트, 검색 화면 UI
- 작성/수정 화면
  - UI
  - 완료 버튼 누르면 내용, 날짜 
- 메모 리스트 화면
  - 메모 개수 표시
  - 최신 순 정렬
  - 제목, 내용, 날짜 표시

### 9/2

- 메모 리스트 화면
  - 제목, 내용, 날짜 셀에 표시
  - 스와이프 액션(고정, 삭제)
  - 고정 메모 섹션
- 검색 화면
  - 실시간 검색
  - 키보드 내리기
  - 검색 결과 개수 섹션에 보여주기
  - 셀 탭하면 수정 화면으로 전환(push로 해야 백버튼 가능) -> 검색 기능 화면에 네비게이션 컨트롤러 붙이기
- 작성/수정 화면
  - 완료 버튼 누르면 내용, 날짜

### 9/3 

- 검색 화면
  - 검색한 키워드 단어 색 변경
  - 스와이프 액션(고정, 삭제)
- 작성/수정 화면
  - 키보드 자동으로 띄우기(편집 상태 자동으로 시작)
  - 키보드 안내려감(완료하면 내려감)
  - 텍스트뷰를 클릭하면 편집 상태 시작
  - UIActivityViewController를 통해 공유 버튼 구현
  
### 9/4 

- 작성/수정 화면 
  - 완료 버튼, 편집 상태 끝, 백버튼 액션, 제스쳐(스와이프?)를 통해 이전 화면으로 가고 작성한게 있다면 메모 저장
  - 텍스트 없는 경우엔 저장안함
  - 텍스트가 있는 경우에 뒤로 가면 한 번 더 물어보기
  - 작성된 텍스트에서 리턴키 입력 전까지를 제목으로, 나머진 내용으로 저장
    -> 두 개의 컬럼에 나눠 저장
  - 편집했을 때의 시간으로 다시 저장
- 전체적으로 색 구현
### 9/5

없다고 생각


## 진행

### 8/31

- [x] Realm Model 설계와 Repositary 클래스 생성 등 기본 세팅
- [x] BaseViewController와 BaseView 생성

#### 추가 구현

- 최초 팝업 화면 UI

#### 이슈

없음

#### 새롭게 안 것

- realm 필터링할때 bool값은 ‘’없이 그냥 “isFixed == false”
- BaseView에서 @available(*, unavailable)을 이용하면 required init 매번 설정 안해도됨.


 
### 9/1

- [x] 최초 팝업 화면 완성(UserDefaults 적용)
- [x] 메모 리스트(색 제외), 검색 화면 UI
- [ ] 작성/수정 화면
  - [x] UI(색 제외)
  - [ ] 완료 버튼 누르면 내용, 날짜 
- [ ] 메모 리스트 화면
  - [x] 메모 개수 표시
  - [x] 최신 순 정렬
  - [ ] 제목, 내용, 날짜 표시

#### 구현 못한 것

- 완료 버튼 누르면 내용, 날짜 
- 메모 리스트에 제목, 내용, 날짜 표시

PK를 아직 지정안해줘서 데이터 저장이 하나만됨.
PK를 날짜 문자열로 지정해주는 것 구현해야됨.

#### 추가 구현

- 서치 컨트롤러 적용

#### 이슈

색 똑같이 하려다가 너무 시간을 많이 날렸음.
우선순위를 생각해서 나중으로 미루기로함.

계획을 조금 수정함.

#### 새롭게 안 것

- 테이블뷰 헤더 설정
- 코드베이스로 구현할 때 스토리보드 삭제
- 테이블뷰 스타일은 처음에 이니셜라이즈 할 때 설정하는 것.
    ~~~
    let view = UITableView(frame: CGRect.zero, style: .insetGrouped)
    ~~~
- 네비게이션바 LargeTitle
    ~~~
    navigationController?.navigationBar.prefersLargeTitles = true
    ~~~
- 서치 컨트롤러 취소 버튼 변경
    ~~~
    searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
    ~~~
- 툴바 설정할 때 오른쪽에 버튼을 하나만 두더라도 flexible Space 필요



