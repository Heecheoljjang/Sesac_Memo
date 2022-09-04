# 계획


## 8/31

- Realm Model 설계와 Repositary 클래스 생성 등 기본 세팅
- BaseViewController와 BaseView 생성

## 9/1

- 최초 팝업 화면 완성(UserDefaults 적용)
- 메모 리스트, 검색 화면 UI
- 작성/수정 화면
  - UI
  - 완료 버튼 누르면 내용, 날짜 
- 메모 리스트 화면
  - 메모 개수 표시
  - 최신 순 정렬
  - 제목, 내용, 날짜 표시

## 9/2

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

## 9/3 

- 메모 리스트 화면
  - 날짜 포맷 형태
- 검색 화면
  - 검색한 키워드 단어 색 변경
  - 스와이프 액션(고정, 삭제)
- 작성/수정 화면
  - 키보드 자동으로 띄우기(편집 상태 자동으로 시작)
  - 키보드 안내려감(완료하면 내려감)
  - 텍스트뷰를 클릭하면 편집 상태 시작
  - UIActivityViewController를 통해 공유 버튼 구현
  
## 9/4 

- 작성/수정 화면 
  - 완료 버튼, 편집 상태 끝, 백버튼 액션, 제스쳐(스와이프?)를 통해 이전 화면으로 가고 작성한게 있다면 메모 저장
  - 텍스트 없는 경우엔 저장안함
  - 텍스트가 있는 경우에 뒤로 가면 한 번 더 물어보기
  - 작성된 텍스트에서 리턴키 입력 전까지를 제목으로, 나머진 내용으로 저장
    -> 두 개의 컬럼에 나눠 저장
  - 편집했을 때의 시간으로 다시 저장
- 전체적으로 색 구현

## 9/5

없다고 생각


# 진행

## 8/31

- [x] Realm Model 설계와 Repositary 클래스 생성 등 기본 세팅
- [x] BaseViewController와 BaseView 생성

### 추가 구현

- 최초 팝업 화면 UI

### 이슈

없음

### 새롭게 안 것

- realm 필터링할때 bool값은 ‘’없이 그냥 “isFixed == false”
- BaseView에서 @available(*, unavailable)을 이용하면 required init 매번 설정 안해도됨.


 
## 9/1

- [x] 최초 팝업 화면 완성(UserDefaults 적용)
- [x] 메모 리스트(색 제외), 검색 화면 UI
- [ ] 작성/수정 화면
  - [x] UI(색 제외)
  - [ ] 완료 버튼 누르면 내용, 날짜 
- [ ] 메모 리스트 화면
  - [x] 메모 개수 표시
  - [x] 최신 순 정렬
  - [ ] 제목, 내용, 날짜 표시

### 구현 못한 것

- 완료 버튼 누르면 내용, 날짜 
- 메모 리스트에 제목, 내용, 날짜 표시

PK를 아직 지정안해줘서 데이터 저장이 하나만됨.
PK를 날짜 문자열로 지정해주는 것 구현해야됨.

### 추가 구현

- 서치 컨트롤러 적용

### 이슈

색 똑같이 하려다가 너무 시간을 많이 날렸음.
우선순위를 생각해서 나중으로 미루기로함.

계획을 조금 수정함.

### 새롭게 안 것

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


## 9/2

- [x] 메모 리스트 화면
  - [x] 제목, 내용, 날짜 셀에 표시
  - [x] 스와이프 액션(고정, 삭제)
  - [x] 고정 메모 섹션
- [ ] 검색 화면
  - [ ] 실시간 검색
  - [ ] 키보드 내리기
  - [ ] 검색 결과 개수 섹션에 보여주기
  - [ ] 셀 탭하면 수정 화면으로 전환(push로 해야 백버튼 가능) -> 검색 기능 화면에 네비게이션 컨트롤러 붙이기
- [x] 작성/수정 화면
  - [x] pop될 때 내용, 날짜 저장

### 구현 못한 것

- 검색 화면 구현

### 추가 구현

- 텍스트뷰 키보드 세팅
- 액티비티뷰컨트롤러 구현

### 이슈

- 서치 컨트롤러의 테이블뷰가 리로드가 안돼서 해결하느라 시간을 너무 많이 날림..
-> 해결 못함..내일 꼭 해결해야함
-> resultViewController를 사용했는데 didSet구문은 실행되는데 리로드만 안됨.
-> resultViewController를 사용하지않고 해결하는 방법도 생각해봐야겠음

- 고정된 메모가 없으면 섹션은 하나만 띄워야함. 
-> 못보고 지나쳤음. 내일 구현

- 스와이프 액션을 구현할 때, 섹션을 나누지 않고 indexPath.row만 사용해서 시간 좀 잡아먹음.

- 리스트 화면에서 작성 화면 넘어갈 때 네비게이션 타이틀이 보이는 버그가 있음.
-> 나중에 수정하기


### 새롭게 안 것

- becomeFirstResponder를 이용해 작성화면에서 바로 키보드를 띄웠음.


## 9/3 

- [x] 메모 리스트 화면
  - [x] 날짜 포맷 형태
  - [x] 고정된 메모 없을 때 섹션 숨기기
- [ ] 검색 화면
  - [ ] 검색한 키워드 단어 색 변경
  - [x] 스와이프 액션(고정, 삭제)
  - [x] 실시간 검색
  - [x] 키보드 내리기
  - [x] 검색 결과 개수 섹션에 보여주기
  - [x] 셀 탭하면 수정 화면으로 전환(push로 해야 백버튼 가능) -> 검색 기능 화면에 네비게이션 컨트롤러 붙이기

### 구현 못한 것

- 검색한 키워드 색 변경

### 추가 구현

- UIScreenEdgePanGestureRecognizer로 작성화면 pop
- 메모 리스트 타이틀 numberFormatter적용
- 제목, 내용 분리 구현


### 이슈

- 서치 컨트롤러에서 resultViewController를 사용했는데 테이블뷰가 리로드 안되는 이슈가 있었음. 

메모 리스트 뷰컨트롤러를 대리자로 설정해야했는데 나는 resultVC에 대리자를 줬었다.

그래서 다시 대리자를 메모 리스트 뷰컨으로 바꿔준 뒤, 테이블뷰가 resultVC에 있는지 메모리스트 뷰컨에 있는지로 확인하며 값을 설정했다.

해결하는데 너무너무너무 오래걸려서 큰일..



- 검색 키워드 색 변경 감이 잘 안옴...


- 메모 리스트 화면에서 작성화면으로 넘어갈때 네비게이션바 타이틀 잔상이 남는 버그가 있음. 해결법을 잘 모르겠음ㅠ 내일 다시 생각해보기.


### 새롭게 안 것

- 날짜 포맷 확인할 때 캘린더에 대해서 좀 더 알게됨.
- 서치 컨트롤러에서 resultViewController를 사용할 땐, 서치 컨트롤러를 사용하고 있는 뷰컨트롤러를 대리자로 지정해야함.
- 스크롤뷰에는 keyboardDismissMode라는 키워드가 있음. onDrag로 설정하면 드래그 시 키보드내려감.
- UIScreenEdgePanGesture
- [String]을 String으로 바꾸기 위해서는 join사용


## 9/4 

- [x] 작성/수정 화면 
  - [x] 완료 버튼, 편집 상태 끝, 백버튼 액션, 제스쳐(스와이프?)를 통해 이전 화면으로 가고 작성한게 있다면 메모 저장
  - [x] 텍스트 없는 경우엔 저장안함
  - [x] 작성된 텍스트에서 리턴키 입력 전까지를 제목으로, 나머진 내용으로 저장
    -> 두 개의 컬럼에 나눠 저장
  - [x] 편집했을 때의 시간으로 다시 저장
  - [x] 텍스트앞에 공백이 포함되었을때 그대로 저장하지만, 셀에서는 문자를 우선으로 보여주기
  - [x] 키보드에 텍스트 가려지는 현상 해결
  - [ ] 테이블뷰 섹션 타이틀 크게 해야함
- [x] 검색 화면
  - [x] 검색 키워드 텍스트 색상 변경
- [x] 전체적인 UI
  - [x] Color
  - [x] 네비게이션 타이틀 잔상 오류 해결
  - [x] 커서 노란색으로 변경
  
### 구현 못한 것

- 테이블뷰 섹션 타이틀 크게하기

### 이슈

- 검색 키워드 텍스트 컬러 변경 시에 NSMutableAttributedString을 사용했는데, 문자열 자체를 사용하다보니 대소문자 구별이 안되어있어서 해결해야했음.

attributedString은 원래의 값을 갖고 있는 상태로 range로 판별해서 색을 적용하는 것 같음.

~~~
    private func changeKeywordColor(_ string: String) -> NSMutableAttributedString {
        let beforeString = (string.lowercased() as NSString).range(of: searchKeyword.lowercased())
        let attributedString = NSMutableAttributedString.init(string: string)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemOrange, range: beforeString)
        return attributedString
    }
~~~

beforeString에서 텍스트의 원래 값과 검색어를 lowercased를 적용해서 선언했다.

attributedString은 텍스트 원래의 값을 가진 채로 이니셜라이즈되었고, beforeString에서 lowercased한 string과 검색어를 비교하는 것.

검색어만큼의 range가 attributedString에도 적용되어 색이 바뀌어 보이는 것인듯.

- 실제 메모 앱에서는 맨 첫줄이 빈 칸일때 처음으로 나오는 문자열을 제목으로 설정하지만, 메모를 확인했을때 공백은 남아있음.

어떻게 해결해야할까..

지금 생각나는 방법은 일단 split으로 나누고 문자가 처음나올때까지 반복문을 사용해서 문자열을 만들어 저장.

이때 들어간 마지막 원소를 따로 변수에 저장하여 인덱스를 구한 뒤 그 이후부터 끝까지를 content에 넣어줌.

저장은 이렇게 하고 셀에 표시할 때는 split의 omittingEmptySubsequences를 true로 해서 각각 0번째 요소를 보여주면 될 것 같음.

타이틀 앞에 공백있는 경우도 생각하기

해결했는데 너무 지저분해서 맞는지모르겠음.

이제 앞에 공백이 있어도 그대로 저장되지만 셀에서는 문자부터 보이게 구현

- 잔상이 남는 이유는 색때문이었음..

화면이 전환될때 뷰 자체가 남아있어서 색이 다르면 잔상이 보임.

근데 다시 생각해보니 작성하는뷰의 백그라운드 색을 설정안해서 그런듯

- 키보드에 텍스트가 가려지는 현상 발생해서 IQKeyboardManager 라이브러리로 해결

### 새롭게 안 것

- NSMutableAttributedString을 이용해 해당 키워드에 대해서만 텍스트컬러를 바꿀 수 있음.
- split의 omittingEmptySubsequences를 이용할때 "\n"은 그냥 ""로 나옴.... 하
- trim으로 문자열의 앞뒤 공백을 지울 수 있음.
- 툴바의 색은 아무 설정 안해야 실제 메모앱과 동일

    스크롤될때 색 바뀌는 것도 자동으로 적용
- 기본적인 흑백 다크모드색은 UIColor에서 systemBackground로 설정하면됨.
- 직접적인 색으로 하려면 systemGray6인듯
- NavigationController로 연결되어있어서 한 쪽 뷰컨트롤러에서 바꾸면 모두 적용되기때문에 viewWillAppear에서 설정하는게 나을 것 같음.
- traitCollection.userInterfaceStyle로 다크모드/라이트모드 처리 가능.
- 앱이 켜져있는 상태에서 바꾼다면 처음엔 적용안됨

# 체크
