## iOS 커리어 스타터 캠프

### 은행 매니저 프로젝트 저장소

https://hackmd.io/bgqdom-NSJG5Tg80WMQ80w

# 은행창구 매니저 후기

## Generics 개념이해 및 적용
 제네릭을 사용하여 하나의 메서드에 다양한 타입을 적용시킬수 있었다.
 또한 프로토콜의 경우 associatedtype을 활용하여 유사하게 사용할 수 있다.
 
 
## 타입 추상화 및 일반화
프로토콜을 사용하여 타입을 추상화 시킬수 있다(자바의 인터이스랑 비슷). 차이점은 POP 프로토콜에 extension으로 구현하여 기본기능을 만들수 있다.
 
 
## 동기(Synchronous)와 비동기(Asynchronous)의 이해
동기 - 실행이 끝날때까지 기다림
 
 
##  동시성 프로그래밍 개념의 이해
 
  쓰레드와 관련된 내용 DispatchQueue를 사용하여 concurrent, serial 큐를 만들수 있다. defualt는 serial 큐를 사용하며 serial은 단일 스레드로만 처리함으로 순서가 보장되어 있다.(fifo - 큐에 들어간거에 한해서) 반면 concurrent는 다중 스레드를 사용함으로 스레드가 여러개가 만들어지고 순서 또한 보장받을수 없다. 순서를 보장 할수 없다 = 언재 실행될지 모른다 임으로 보통 escaping 클로져를 사용하여 실행이 끝난뒤 실행하도록 설계하는 경우가 많다.
 
 
## 동시성 프로그래밍을 위한 기반기술(GCD, Operation) 등의 이해
자세한건 다른 문서에 정리한 내용 참조
[GCD 심화 내용](https://hackmd.io/BdaOlvbvQ56c-Q1Q7BrDNw)
Operation은... 안써봤다.


## 스레드(Thread) 개념에 대한 이해
 
 스레드는 메인 스레드와 다른 스레드가 있다는것만 이해하면된다. main에서 주로 UI에 대한 처리를하며 이 main.async만 쓴다. sync를 쓸때 락이 걸리면 앱이 멈추기때문에 절대절대 안쓴다. 왠만하면. 우리가 정보를 불러오고 다운로드를 받고 하는건 다 다른 스레드에서 한다고 생각하면된다.
 
 
## GCD를 활용한 동시성 프로그래밍 구현
이것도 GCD 심화 내용에서 확인하는게 좋을듯! 


## 동기(Synchronous)와 비동기(Asynchronous) 동작의 구현 및 적용

동기 - 다른스레드에서 실행이 끝날때까지 기다린다.
비동기 - 다른스레드에 넘겨주고 진행한다.


## 동시성 프로그래밍 중 UI 요소 업데이트의 주의점 이해

main에서 sync가 안걸리도록 안쓰도록 주의해서 사용한다. 

## 커스텀 뷰 구현

코드로 View를 구성할땐 view를 주고 constraint를 주도록 설계해야된다.

## 스택뷰 활용

스택뷰에 alignment, distribution 값을 올바르게 줘야한다.

## Xcode 프로젝트 관리 구조의 이해와 응용

pod을 이용하여 외부 라이브러리를 설치 및 관리한다. 외부 파일을 사용할경우 Pod 파일안에 적어놓고 git에 커밋한다. 이때 Pod으로 다운받은 파일들을 커밋하지않도록 주의한다.(git ignore로 관리하는 경우도 있다.)

---

# PR 피드백 내용

단순히 값을 리턴하는 경우는 연산 프로퍼티를 사용하는것도 괜찮다.

가독성을 높이기위해서 함수를 따로 만들어서 사용하는 경우가 더 독이 될수도 있다.(재사용이 없는경우))

리턴값이 있지만 안쓰일수도 있는경우 `@discardableResult` 를 사용한다.

테스트의 커버리지로 테스트가 더 필요한지 알 수 있다. 그러므로 테스트 코드를 작성했을때는 커버리지또한 체크할것

IDEWorkspaceChecks.plist
필요한 작업 공간 검사의 상태를 저장합니다. 이 파일을 소스 제어에 커밋하면 작업 공간을 여는 각 사용자에 대해 해당 검사를 불필요하게 다시 실행하는 것을 방지할 수 있습니다.
[참고링크](https://developer.apple.com/library/archive/releasenotes/DeveloperTools/RN-Xcode/Chapters/Introduction.html#//apple_ref/doc/uid/TP40001051-CH1-DontLinkElementID_7)

xcworkspace란 내 프로젝트와 외부 라이브러리를 연결해주는 역할을 합니다.

while 문을 무한 루프로 사용하고 return으로 종료하는 방식은 굉장히 위험하니 사용을 자제하자.

상수는 굳이 외부에서 전달 보기보다는 내부에서 `private enum constant` 식으로 선언해서 사용한다.

네이밍에서 관사(a/an/the) 를 생략하고 사용하자.

escaping 클로저 사용시 순환 참조 문제가 생길수 있기때문에 weak를 써줘야한다. [참고링크](https://eastjohntech.blogspot.com/2019/12/closure-self.html)

파라미터로 받은 값을 변경해야될때? -> inout을 고려한다.
Swift에서 함수의 파라미터는 상수(Constant)이므로 함수 내부에서 파라미터의 값을 변경할 수 없다. 이는 우리가 파라미터를 실수로라도 변경할 수 없다는 뜻이기도 하다. 만약 함수에서 파라미터의 값을 변경하고, 변경된 값이 함수 호출이 종료된 후에도 지속되길 원한다면 inout 파라미터를 사용하면 된다.

# 미완성인 부분

stack view에 추가되는 Label의 레이아웃이 균일하지 못함. -> stackview로 할당했기에 그런듯하다. 그리고 scrollview가 지정되어있지않아서 그런듯? 추후 수정필요하다.


