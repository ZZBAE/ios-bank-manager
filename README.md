
# 🏦 은행 창구 매니저

## 💾 프로젝트 저장소
>**프로젝트 기간** : 2022-06-30 ~ 2022-07-08<br>
**소개** : 은행에 온 고객의 업무를 처리하는 은행 창구 매니저를 구현하였습니다.<br>
**리뷰어** : [**제이슨**](https://github.com/ehgud0670)

## 👥 팀원
    
| 재재 | 나이든별 |
|:---:|:---:|
|![](https://i.imgur.com/Xa9oBRA.png)|![](https://i.imgur.com/IajxRmr.png)|
|[Github](https://github.com/ZZBAE)|[Github](https://github.com/OldStarKR)|
    
---

## 💾 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.6-orange)]()
[![xcode](https://img.shields.io/badge/Xcode-13.4.1-blue)]()
---

## 🕖 타임라인: 시간 순으로 프로젝트의 주요 진행 척도를 표시

### Week 2
- **2022-07-04 (월)** 
  - STEP3 진행: 은행원과 고객 간의 동시성 프로그래밍 적용
 
- **2022-07-05 (화)**
  - STEP3 마무리 후 PR

- **2022-07-06 (수)**
  - STEP3에서 놓쳤던 개념 공부

- **2022-07-07 (목)**
  - STEP3 리뷰 반영 및 리팩토링 후 머지
  
- **2022-07-08 (금)**
  - Readme.md 작성


---

## ✏️ 프로젝트 내용

### 💻 핵심 기능 경험
- [X] Linked-list 자료구조의 이해 및 구현
- [x] Queue 자료구조의 이해 및 구현
- [x] Generics 개념이해 및 적용
- [x] Queue의 활용
- [x] 타입 추상화 및 일반화
- [x] 동기(Synchronous)와 비동기(Asynchronous)의 이해
- [x] 동시성 프로그래밍 개념의 이해
- [x] 동시성 프로그래밍을 위한 기반기술(GCD, Operation) 등의 이해
- [x] 스레드(Thread) 개념에 대한 이해
- [x] GCD를 활용한 동시성 프로그래밍 구현
- [x] 동기(Synchronous)와 비동기(Asynchronous) 동작의 구현 및 적용
- [x] 동시성 프로그래밍 중 UI 요소 업데이트의 주의점 이해
- [x] 커스텀 뷰 구현
- [x] 스택뷰 활용
- [x] Xcode 프로젝트 관리 구조의 이해와 응용


### ⚙️ 구현 기능
- **BankManagerConsoleApp**
    - Model
        - Service : 제공할 서비스(대출, 예금)를 나타냅니다.
        - Customer : 고객을 나타내며, 고객 번호와 제공받고자 하는 서비스를 프로퍼티로 가지고 있습니다.
        - NameSpaces
            - Clerk : 서비스 제공 static 메서드가 들어 있는 네임스페이스입니다.
            - NumberOfClerks : 각 업무를 담당하는 은행원의 수가 들어 있는 네임스페이스입니다.
            - NumberOfCustomers : 가능한 초기 고객의 최소 수와 최대 수가 들어 있는 네임스페이스입니다.
            - Selections : 처음 시작할 때 숫자 1과 2를 골라 프로그램의 시작과 끝을 선택할 수 있게끔 정해준 네임스페이스입니다.
    - Controllers
        - BankManager : 은행이 돌아가는 과정을 나타내는 클래스이며, `main`의 유일한 인스턴스로 동작합니다. 
    - Utilities
        - Node : 연결 리스트의 노드입니다. 각각의 값과 다음 노드를 참조하는 프로퍼티를 가지고 있습니다.
        - QueueWithLinkedList : 연결 리스트를 활용하여 만든 큐 구조체입니다.
        - Queue : 큐가 구현해야 할 기능을 명시한 프로토콜입니다.
        - LinkedList : 노드를 사용해 구현한 단방향 연결 리스트입니다. 큐에 사용하기 위해, 제한된 기능만이 구현되어 있습니다.

---
### 🏀 TroubleShooting
1. **semaphore의 잘못된 사용**
![](https://i.imgur.com/dzu7dEE.png)
![](https://i.imgur.com/OMJtW83.png)
    - 전체 고객의 업무가 끝나기도 전에 업무가 마감되어 버리고 설정해둔 78~79번째 라인의 `finishWork(customers: servedClients, time: timeSpent)`와`openBank()`가 먼저 나와버리는 상황이 발생하였습니다. (`timeSpent`는 추후에 네이밍 수정해주었습니다.)
    - switch구문 앞뒤로 감싼 `semaphore.wait()`와 `semaphore.signal()`사이의 구문이 끝나는걸 기다려주지 않고 밑으로 가버리는 것 같았습니다. 
    - 추후 학습해본 결과, 상기 코드처럼 코드를 작성하면 글로벌 큐에 비동기적으로 전달만 해주고, 밑에 있는 `finishWork(customers: servedClients, time: timeSpent)`와`openBank()`가 실행되는 것으로 이해했습니다.
    - 결과적으로 `group`과 `semaphore`를 어떻게 적용할지 각각의 경우에 대한 이해를 제대로 하지 못한 상태에서 적용해 본 실패 사례라고 생각되어, 같이 공부하고 더 생각해본 결과 밑의 이미지처럼 구현을 성공하였습니다.
![](https://i.imgur.com/PIZ2TNi.png)


2. **`Clerk` 인스턴스를 복수로 두는 것 여부**
    - 원래 은행원이 세 명이었기 때문에, `Clerk` 인스턴스도 세 개가 있어야 한다고 생각했습니다.
    - 그러나 `DispatchSepaphore`를 통해 예금 스레드를 최대 2개, 대출 스레드를 최대 1개로 제한하고 나니, 굳이 은행원 인스턴스를 3개씩이나 둘 필요가 없다고 생각했습니다.
        - `Clerk` 인스턴스에 있는 `provideService` 메서드가 대출과 예금 모든 케이스에서 작업을 수행할 수 있었기 때문입니다.
        - 인스턴스에서 메서드를 불러오는 것은, 가지고 있는 하나의 인스턴스에서 해도 좋다고 생각했습니다.
    - 따라서, `BankManager` 안의 `Clerk` 인스턴스를 하나로 줄여 주었습니다.
        - 이마저도 `Clerk`를 네임스페이스로 활용하고, `provideService`를 static 메서드로 저장하는 방법도 고민중입니다 -`Clerk` 구조체에 별다른 프로퍼티가 없기 때문입니다.
    - 최종적으로 이후 리팩토링하는 과정에서, `BankManager` 클래스에 있는 모든 프로퍼티를 삭제해 주었습니다.
        - 함수형 프로그래밍의 순수함수적인 접근법을 적용하고자 했습니다.
        - 이 과정에서 `provideService`가 `Clerk` 네임스페이스의 static 메서드가 되었습니다.
 

---

### 참고한 페이지

[Swift Language Guide - Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html)<br>
[Swift Language Guide - Closures](https://docs.swift.org/swift-book/LanguageGuide/Closures.html)<br>
[Swift Language Guide - Generics](https://docs.swift.org/swift-book/LanguageGuide/Generics.html)<br>
[Concurrent Programming With GCD in Swift 3](https://developer.apple.com/videos/play/wwdc2016/720/)<br>
[Swift Language Guide - Subscripts(선택사항)](https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html)<br>
[Concurrency Programming Guide(선택사항)](https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html)<br>
[Swift Language Guide - Concurrency(선택사항)](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)<br>
[오토레이아웃 정복하기 - Dynamic Stack View까지 (선택사항)](https://yagom.net/courses/autolayout/)
