# CHAPTER 6(루프)

- 루프는 특정상 반복되는 일에 적합하다. 일련의 코드 집합을 반복적으로 실행하는데, 여기서 '반복'은 지정된 횟수 또는 정의된 조건이 충족될 때까지 진행된다.
- for-loop의 인스턴스들의 특정 요소들을 반복적으로 처리해야 할 때 반복 횟수를 알고 있거나 어렵지 않게 알 수 있을 때 사용할 수 있다.
- while-loop 어떤 조건이 충족될 때까지 반복 처리하는 일에 좋다.

~~~swift
var myFirstInt: Int = 0

for i in 1...5 {
  myFirstInt += 1 
  print(myFirstInt)
}
~~~

- 루프를 작성하겠다고 알리는 키워드가 for이다 그 뒤에 이터레이터 i가 선언되었는데, 루프의 현재 반복 횟수를 나타내는 **이터레이터(iterator)** 는 루프 안에서는 일정한 값을 보이며, 루프 안에서만 존재한다.



~~~swift
// where가 적용된 for-in loop
for i in 1...100 where i % 3 == 0 {
  print(i)
}
~~~



- while-loop는 조건이 참인 동안만 루프 안에 있는 코드를 실행한다. 

~~~swift
var i = 1
while i < 6 {
  myFirstInt += 1 
  print(myFirstInt)
  i += 1
}
~~~

- while 루프의 조건은 루프가 반복되는 어떤 시점에 바뀔 상태를 판단하게 된다. 만일 조건이 판단할 상태가 바뀌지 않거나 항상 참이라면 while 루프는 **무한 루프(infinite loop)** 가 될 것이다.



- repeat-while 루프

~~~swift
repeat {
  myFirstInt += 1
  print(myFirstInt)
  i += 1
} while i < 6
~~~

- while과 repeat-while의 차이점은 조건을 판단하는 위치이다. while 루프는 루프로 들어가기 전에 조건을 판단한다. 따라서 루프가 한 번도 실행이 되지 않을 수 있다. 반면 repeat-while 루프는 적어도 루프를 한 번을 실행하고 조건을 판단한다.



# CHAPTER 7(문자열)

- 스위프트의 문자열을 구성하는 문자들도 타입이 있다. 바로 Character 타입이다.
- 주로 유니코드 문자를 나타날 때 Character 타입을 사용하며, Character 타입을 조합하면 String 타입이 된다.



- 유니코드
  - 유니코드는 플랫폼과 상관없이 문자들을 같은 방식으로 처리하고 표현할 수 있도록 약속한 국제 표준이다.
  - 유니코드의 모든 문자에는 교유 번호가 지정되어 있다.
  - Swift의 String과 Character 타입은 이 유니코드를 바탕으로 만들어졌다.
- 유니코드 스칼라
  - Swift의 문자열은 속을 들여다보면  *유니코드 스칼라(scalar)* 로 구성되어 있다.
  - 유니코드 스칼라는 유니코드 표준의 특정 문자를 나타내는 21비트짜리 수이다.
- 스위프트의 모든 문자는 **확장형 문자소 집합체(extended grapheme cluster)** 이다. 확장형 문자소 집합체는 하나 또는 여럿의 유니코드 스칼라가 연속된 형태를 말한다. 하나또는 여럿의 유니코드 스칼라가 서로 결합하여 읽을 수 있는 문자를 만들어 내는 것이다.



- 인덱스와 구간

  - 문자열은 문자들의 순서 컬렉션으로 생각할 수 있으며 문자열의 특정 문자에 접근이 가능하다.

  ~~~swift
  var playground = "playground"
  let index = playground[3]
  ~~~

  - playground[3] 코드에는 서브스크립트 문법이 적용되었다. 일반적으로 대괄호([]) 는 스위프트에서 서브스크립트를 나타내며, *컬렉션에 있는 특정 값을 가리킬 때 사용된다.*
  - 다만 이 코드처럼 서브스크립트를 사용하면 오류가 발생한다. ('subscript(_:)' is unavailable: cannot subscript String with an Int)
  - 스위프트 컴파일러는 서브스크립트 인덱스를 통해 문자열의 특정 문자에 액세스할 수 없도록 막아 놓았다. 이런 제한은 문자열이나 문자가 스위프트에 저장되는 방식과 관련이 있다.
  - 왜 정수를 문자열의 인덱스로 사용하지 못할까? -> 스위프트는 앞에서부터 모든 문자를 일일이 확인하지 않으면 지정된 인덱스와 유니코드 스칼라를 일대일로 대응시키지 못하기 때문이다.

  ~~~swift
  // 5번째 문자 찾기
  let start = playground.startIndex
  let end = playground.index(start, offsetBy: 4)
  let fifthCharacter = playground[end]
  ~~~

  



# CHAPTER 8(옵셔널)

- Swift의 특별한 기능 가운데 하나인 옵셔널은 어떤 인스턴스에 값이 없을 수도 있다는 일종의 안내다.
- 옵셔널이 적용된 인스턴스는 두 가지 중 하나이다.
  1. 인스턴스에 값이 지정되어 있고 언제든 사용될 수 있다.
  2. 인스턴스에 저장된 값이 없다. 지정된 값이 없는 인스턴스를 가리켜 *nil* 이라고 한다.
- Objective-C 에서는 객체만 nil로 지정할 수 있다.



## 옵셔널 타입

- Swift의 옵셔널은 일종의 안정 장치다. 
- nil이 될 수도 있는 인스턴스는 반드시 옵셔널 타입으로 선언해야 한다. 다르게 말하면 옵셔널 타입으로 선언되지 않은 인스턴스는 nil이 될 수 없다. 컴파일러는 이러한 틀에 따라 인스턴스가 nil이 될 수 있는지 판단한다.
- 프로그래머의 입장에서는 인스턴스를 명시적으로 선언하여 코드의 독해력이나 안전성을 높일 수 있다.



~~~swift
var errorCodeString: String?
if errorCodeString != nil {
  let theError = errorCodeString!
  print(theError)
}
~~~

- errorCodeString이 nil이 아닌 경우에 실행하는 조건문이다.
- 뒤에 !를 덧붙였는데 이것은 **강제 언래핑(forced unwrapping)** 이다. 강제 언래핑을 적용하면 값에 액세스 할 수 있다. '강제' 라고 표현하는 이유는 실제로 값이 있든 없든 옵셔널에 엑세스하려고 하기 때문이다. !는 값이 있다고 단정 짓겠다는 의도이며 실제로 값이 없다면 *런타임 오류* 가 발생하게 된다.
- 강제 언래핑에는 위험 요소가 있다. 옵셔널에 값이 없다면 런타임에 무단 종료(crash)가 발생하게 된다.



## 옵셔널 바인딩(optional binding)

- 옵셔널 바인딩은 어떤 옵셔널에 값이 있는지 판단할 수 있는 유용한 패턴이다.

- 옵셔널에 값이 있다면 임시 상수나 변수에 그 값을 지정할 수 있다.

- ~~~swift
  // 기본 옵셔널 바인딩 문법 
  if let temporaryConstant = anOptional {
  	// temporaryConstant로 어떤 일을 한다
  } else {
    // temporarayConstant에는 값이 없다. 즉, nil이다.
  }
  ~~~

- 옵셔널 바인딩을 중첩하면 코드가 난해해질 수 있다. 언래핑해야 되는 옵셔널이 3개 4개로 늘어나면 옵셔널 바인딩의 중첩은 구현하기 복잡해진다. 이러한 상황을 가리켜 -> 파별의 피라미드라고 한다.

~~~swift
// 여러 optional 언래핑
var errorCodeString: String?
errorCodString = "404"
if let theError = errorCodeString, let errorCodeInteger = Int(theError) {
  print("\(theError): \(errorCodeString)")
}
~~~



## 암묵적으로 언래핑된 옵셔널(implictly unwrapped Optional)

- 암묵적이라는 표현이 붙었지만, 옵셔널을 일반적으로 언래핑할 때와 한가지만 다르다. *따로 언래핑할 필요가 없다는 점이다!*

- ~~~swift
  var errorCodeString: String!
  errorCodeString = "404"
  print(errorCodeString)
  ~~~

- 여기서 옵셔널은 암묵적 언래핑을 나타내는 **!** 가 붙어 선언되었다. 암묵적으로 언래핑된 옵셔널을 사용한다는 것은 옵셔널을 명시적으로 언래핑하여 사용하는 것보다 훨씬 더 강한 확신, 즉 값이 있다는 확신의 방증이므로 조건문을 없애도 된다.

- 암묵적 언래핑이 가진 힘과 유연성은 **따로 옵셔널을 언래핑하지 않고 그 값에 접근할 수 있다는 데에 있다!**

- 하지만 옵셔널의 값에 접근할 때 실제로는 값이 없다면 런타임 오류가 발생하게 된다. 이런 이유에서 어떤 인스턴스가 nil이 될 가능성이 조금이라도 있다면 사용하지 않는 것이 좋다.

- **클래스의 초기화** 가 암묵적 언래핑의 주된 사용처이다.



## 옵셔널 체이닝(Optional Chaining)

- 옵셔널 체이닝도 옵셔널 바인딩처럼 어떤 옵셔널에 값이 있는지 판단하는 방법을 제공한다.
- 옵셔널 바인딩과는 다르게 어떤 옵셔널의 값에 여러 번 사슬처럼 이어 조회할 수 있다는 점이 다르다.
- 체인에서 어떤 옵셔널에 값이 있다면 호출은 올바로 동작하게 되고, 조회 체인 자체는 예상 타입의 옵셔널을 리턴한다. 반면, 어떤 옵셔널이 nil이라면 체임 자체가 nil을 리턴한다.

~~~swift
var errorCodeString: String?
errorCodeString = "404"
var errorDescription: String?

if let theError = errorCodeString, let errorCodeInteger = Int(theError), errorCodeInteger == 404 {
    errorDescription = "\(errorCodeInteger + 200): resource was not found."
}
~~~

- errorDescription에 붙는 ?는 이 코드 행이 옵셔널 체이닝 과정의 시작임을 알린다.
- 보통은 **?** 를 사용하는 것이 최선이다. **!** 연산자는 옵셔널이 nil이 될 가능성이 없을 때만 사용해야 한다. 하지만 옵셔널이 nil이어서 크래시되는 것이 합리적인 유일한 해결책이라면 ! 연산자가 어울릴 것이다.



## nil 결합 연산자

~~~swift
var errorCodeString: String?

let description = errorCodeString ?? "No error"
~~~

- **??** 의 왼쪽에는 옵셔널이 와야한다. 옵셔널이 nil이면 ??는 오른쪽 값을 리턴하게 된다.



- 옵셔널은 어떤 인스턴스가 nil인지 아닌지를 추적하여 그에 따른 적절한 조치를 취하는 데 유용하게 사용할 수 있다. 