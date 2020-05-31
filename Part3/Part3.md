# CHAPTER 9(배열)

- 논리적으로 서로 연관된 값들을 한 데 묶는 것은 프로그래밍에서 중요하며 이럴 때 필요한 것이 **컬렉션(collection)** 이다.



- 배열은 *순서 있는 값* 들의 컬렉션이다. 배열 내 위치는 *인덱스* 로 정해지며, 어떤 값도 몇 번이든 배열에 저장될 수 있다. 
- 배열은 일반적으로 어떤 값들의 *순서를 구분하는 것이 중요한 경우* 에 사용된다.
- Swift의 배열은 Objective-C와 달리 어떤 종류의 값도 담을 수 있다. **객체든 비객체든 가리지 않는다.**

~~~swift
var bucketList: Array<String>
var bucketList: [String]
var bucketList = ["Climb Mt.Everest"] // 타입 추론
bucketList.append("Fly hot air balloon to Fiji")

print(bucketList[0..1]) // 서브스크립트

var newItems = [
  "Find a triple rainbow",
  "Watch the Lord of the Rigns trilogy in one day"
]

// 1
for item in newItems {
  bucketList.append(item)
}

// 2
bucketList += newItems
~~~

- <String>은 bucketList에 담길 인스턴스의 종류를 나타낸다. String 타입의 인스턴스를 담게 된다.
- append(_:) 메서드는 어떤 타입이든 배열이 받는 타입을 인수로 받아 새 요소로 추가한다.
- 배열은 **count** 프로퍼티를 통해 항목의 개수를 파악하는 것이 가는하다.
- 배열에서 특정 인덱스 값에 접근하고 싶을 때는 *서브스크립트* 기능을 사용하면 간편하다.



- 변경할 수 없는 배열(immutable array)
  - let 키워드를 사용하면 배열을 수정하려고 하면 컴파일러는 변경할 수 없는 배열이라 변경할 수 없다며 오류 메세지를 출력할 것이다.





# CHAPTER 10(딕셔너리)

- 순서가 중요하지 않을 때 일련의 정보만 담아 두고 필요할 때마다 꺼내오기만 할 수 있는 것이 딕셔너리(dictionary)다.
- Dictionary는 데이터를 **키(key)와 값(value)** 의 쌍으로 담아 두는 컬렉션 타입이다. 키와 값은 서로 짝을 맞춰 딕셔너리에 저장된다.
- 딕셔너리 인스턴스의 키는 중복되지 않아야 한다. 값에 매핑되는 키는 반드시 하나여야 한다.
- 딕셔너리 타입의 키는 반드시 **해쉬 가능(hashable)** 해야 한다. 다시 말해 key는 저마다 하나밖에 없어야 한다.
- Swift의 기본 타입인 String, Int, Float, Double, Bool 등은 모두 해시 가능하다.

~~~swift
// Dictionary 인스턴스 생성 방법
var dict1: Dictionary<String, Double> = [:]
var dict2 = Dictionary<String, Double>()
var dict3 = [String:Double] = [:]
var dict4 = [String:Double]()
~~~

- [:]와 ()는 무엇이 다를까?
  - 핵심은 둘 다 Dictionary 타입의 인스턴스를 만들어 준비한다..
  -  **[:]** 코드는 리터럴 문법 구조를 사용하여 딕셔너리 타입의 빈 인스턴스를 만든다. 이 인스턴스에 적용될 키와 값의 타입은 선언 부분에 포함된다.
  -  **()** 문법 구조는 딕셔너리 타입의 기본 초기화 방식을 사용한다.



~~~swift
var movieRatings = ["Donnie Darko": 4, "Chungking Express": 5, "Dark City": 4]
print("I have rated \(movieRatings.count) movies")

let darkoRating = movieRatings["Donnie Darko"]

et oldRating: Int? = movieRatings.updateValue(5, forKey: "Donnie Darko")
if let lastRating = oldRating, let currentRating = movieRatings["Donnie Darko"] {
    print("Old rating: \(lastRating); current rating: \(currentRating)")
}

movieRatings.removeValue(forKey: "Donnie Darko")
movieRatings["Donnie Darko"] = nil // 이렇게도 제거 가능하다

// for-in loop 적용
for (key, value) in movieRatings {
  print("The movie \(key) was rated \(value)")
}

for movie in movieRatings.keys {
  print("User has rated \(movie)")
}
~~~

- 딕셔너리의 값에 접근하려면 가져올 값에 연결된(매핑된) *키* 가 있어야 한다.
- **이때 darkoRating의 타입이 Int?인 이유는 요청받은 값이 존재 하지 않는지 알려 줄 방법이 필요하다. (즉 키가 존재하지 않을때)**

- removeValue(forKey:) 메서드는 키를 인수로 받아 해당 키-값 쌍을 제거한다. 이 메서드는 해당 키가 발견되어 제거된다면 그 키에 연결된 값을 리턴한다. 하지만 이 리턴 값을 꼭 지정하지 않아도 된다. 지정하지 않아도 해당 키-값 쌍이 제거된다.



### 딕셔너리를 배열로 변환

- 딕셔너리에서 정보를 꺼내 배열로 간직해야 할 상황이 있기도 하다

- 이럴때는 딕셔너리의 키들로 Array 타입의 인스턴스를 만드는 것이 논리적이다.

- ~~~swift
  let watchedMovies = Array(movieRatings.keys)
  ~~~

- Array() 문법 구조를 적용하여 [String] 타입의 새 인스턴스를 만들게 된다.





# CHAPTER 11(집합)

- Set은 우리말로 집합이라고도 표현하며, 서로 연관성이 없는 인스턴스들의 컬렉션을 가리킨다.
- Array는 순서만 있으면 반복되는 값도 허용하지만 집합은 그렇지 않다.
- 집합의 값은 딕셔너리처럼 컬렉션 안에서 순서가 없다. 딕셔너리의 키가 고유해야 한다는 조건을 갖춰야 하는 것처럼 집합 또한 반복되는 값을 허용하지 않는다. 집합의 요소는 딕셔너리의 키처럼 Hashable 프로토콜을 준수해야 한다. 하지만 해당 키로 접근하는 딕셔너리의 값들과 달리 집합은 요소만을 개별적으로 담는다.

| 컬렉션 타입 | 순서 여부 | 고유 여부 | 저장 대상 |
| :---------: | :-------: | :-------: | :-------: |
|    배열     |   있음    |   없음    |   요소    |
|  딕셔너리   |   없음    |    키     | 키-값 쌍  |
|    집합     |   없음    |   요소    |   요소    |



~~~swift
// 1번
var groceryBag = Set<String>()
groceryBag.insert("Apples")
groceryBag.insert("Oranges")
groceryBag.insert("Pineapple")

// 2번
var groceryBag = Set(["Apples","Oranges","Pineapple"])

// 3번
var groceryBag: Set = ["Apples","Oranges","Pineapple"]

let hasBanana: Bool = groceryBag.contains("Banans") // false
~~~



### 합집합

~~~swift
var groceryBag = Set<String>()
groceryBag.insert("Apples")
groceryBag.insert("Oranges")
groceryBag.insert("Pineapple")

let friendsGrceryBag = Set(["Bananas","Cereal","Milk","Oranges"])
let commonGroceryBag = groceryBag.union(friendsGrceryBag)
~~~

- union(_:) 메서드를 사용하여 두 집합을 합쳤다.
- union(_:)은 Set 타입의 메서드로서 Sequence에 해당하는 인수를 받아 두 컬렉션의 고유 요소를 포함하는 새 Set 인스턴스를 리턴한다.
  - 배열이나 집합을 union(_:)에 전달하면 요소들이 중복되지 않게 합쳐진 새 집합을 리턴받는다.



### 교집합

~~~swift
let roomateGroceryBag = Set(["Apples","Bananas","Cereal","Toothpaste"])
let itemsToReturn = commonGroceryBag.intersection(roomateGroceryBag) // ["Cereal", "Bananas", "Apples"]
~~~

- 중복 요소를 추려 새 Set 인스턴스를 리턴하게 된다.



### 서로소

- 두 집합에 공통되는 요소가 없다는 것은 어떻게 알까?

~~~swift
let mySecondBag = Set(["Berries","Yogurt"])
let roomatesSecondBag = Set(["Grapes", "Honey"])
let disjoint = mySecondBag.isDisjoint(with: roomatesSecondBag) // true
~~~

- Set의 **isDisjoint(with)** 메서드는 한 집합의 원소가 인수로 받은 집합에 있는지 없는지에 따라 true(없다), false(있다)를 리턴하게 된다.





# CHAPTER 12(함수)

- 함수를 한마디로 하자면 구체적인 어떤 테스크를 수행하는 코드 집합에 이름을 붙인 것이다. **함수는 코드를 실행한다.**
- 일부 함수는 자신이 맡은 일을 위해 데이터를 전달하는 데 사용할 *인수(argument)* 를 정의한다. 또 일부 함수는 일을 끝내고 무언가를 *제공한다(return)* .



~~~swift
func printGreeting() {
  print("Hello, Swift!")
}
printGreeting()
~~~

- func 키워드로 함수를 정의한다. 바로 다음에는 함수의 이름이 온다. 
- 빈 괄호를 사용하는 이유는 이 함수가 인수를 받지 않기 때문이다. 중괄호는 함수 구현의 시작을 알린다.
- **함수를 호출(call)**하면 함수의 코드가 실행된다. 함수를 호출하려면 함수의 이름을 입력해야 한다.



### 함수의 파라미터(parameter)

- 함수는 파라미터를 가질 때 생명력이 배가 된다.
- 파라미터는 함수에 무언가를 입력하기 위해 사용하는데, 우리는 함수를 호출한 caller가 그 함수로 전달한 데이터에 따라 값이 변경될 수 있다는 것을 나타내기 위해 함수의 이 부분을 '파라미터' 라고 부른다.
- 함수는 자신의 파라미터에 전달된 데이터를 받아 어떤 태스크를 수행하거나 결과를 만들어낸다.

~~~swift
func printPersonalGreeting(name: String) {
    print("Hello \(name)!")
}
printPersonalGreeting(name: "Minho")
~~~

- 하나의 인수를 받는 함수를 만들었다. 함수의 괄호 안을 보면 알 수 있다. *인수(argument)* 는 함수를 호출하는 콜러가 그 함수의 파라미터에 전달하는 값이다.

- 여기서는 *name* 이라는 파라미터가 사용되어 String 타입의 인스턴스를 받게 된다.

- name은 파라미터의 이름이며, name의 타입은 : 다음에 지정한다.

- 함수의 파라미터에는 이름이 있다.

- 경우에 따라서는 함수 외부에서 파라미터의 이름이 다르게 보여야 유용할 때가 있다. 이는 함수를 호출할 때 사용하는 파라미터의 이름과 실제 함수 안에 구현된 파라미터의 이름이 다르다는 것인데 이런 파라미터를 가리켜 **외부(external) 파라미터** 라고 부른다. 

- 외부 파라미터는 가독성 때문에 사용한다.

  ~~~swift
  func printPersonGreeting(to name: String) {
  	print("Hello \(name)!")
  }
  printPersonGreeting(to: "Minho")
  ~~~

- *구어체처럼 코드를 작성하면 다른 사람이 읽기 쉬워진다.*

  

### 가변 파라미터

- **가변(variadic)** 파라미터는 인수에 해당하는 값을 하나도 전달받지 않을 수도 있고 여러 개를 받을 수도 있다.
- 다만 함수는 하나의 가변 파라미터만을 자미녀, 대개 순서상 마지막 파라미터 자리에만 온다. 인수로 전달받은 값들은 함수 안에서 배열의 형태로 사용된다.
- 가변 파라미터는 파라미터의 타입 다음에 점 세 개를 붙여서 만든다.

~~~swift
func printPersonalGreetings(to names: String...) {
    for name in names{
        print("Hello! \(name)")
    }
}
printPersonalGreetings(to: "Minho", "Jack", "Jason")
~~~



### 파라미터의 기본값

- Swift의 파라미터에는 기본값을 정해 둘 수 있다.
- 기본값은 함수의 파라미터 리스트 끝에 두어야 한다. 파라미터에 기본값이 있으면 함수를 호출할 때 인수를 생략해도 된다.

~~~swift
func divisionDescriptionFor(numerator: Double, denominator: Double, withPunctuation punctuation: String = ".") {
    print("\(numerator) divided by \(denominator) equals \(numerator/denominator)\(punctuation)")
}
divisionDescriptionFor(numerator: 9.0, denominator: 3.0) // 9.0 divided by 3.0 equals 3.0.
divisionDescriptionFor(numerator: 9.0, denominator: 3.0, withPunctuation: "!") // 9.0 divided by 3.0 equals 3.0!
~~~



### 인아웃 파라미터

- 함수에서 인수의 값을 수정해야 할 때도 있다. 함수 밖에서도 변수의 통제권을 발휘하기 위해 **인아웃(in-out) 파라미터** 라는 방법을 사용한다.
- 두 가지 유의할점
  1. 인아웃 파라미터는 기본값을 가질 수 없다.
  2. 가변 파라미터에는 inout을 적용할 수 없다.

~~~swift
var error = "The request failed:"
func appendErrorCode(_ code: Int, toErrorString errorString: inout String) {
    if code == 400 {
        errorString += " bad request."
    }
}
~~~

- 함수를 사용하게 되면 inout 파라미터에 전달되는 변수는 그 앞에 **앰퍼샌드(&)** 가 붙어야 한다. *변수가 함수에 따라 수정된다는 뜻이다.*



### 함수의 중첩과 영역

- Swift에서는 함수를 중첩해서 정의할 수도 있다.
- 함수는 다른 함수의 정의 안에서 선언되고 구현된다. 따라서 선언되고 구현된 곳 밖에서는 사용할 수 없다. 이 기능은 함수가 다른 함수 안에서만 어떤 일을 해야 할 때 유용하다.

~~~swift
func areaOfTriangleWith(base: Double, height: Double) -> Double {
    let numerator = base * height
    
    func divide() -> Double {
        return numerator / 2
    }
    return divide()
}
~~~

- divide()하는 제 2의 함수를 선언하고 구현했다. divide() 함수는 인수를 받지 않으며 Double 타입의 인스턴스를 리턴한다.
- areaOfTriangleWith(base:height:) 함수는 divide() 함수를 호출하고 그 결과를 리턴한다.
- divide() 함수는 areaOfTriangleWith(base:height:) 에서 정의된 numerator이라는 상수를 사용한다. 어떻게 이게 가능할까?
  - 이 상수는 divide() 함수의 **포함 영역(enclosing scope)** 에서 정의되었다.
  - *어떤 함수의 중괄호안에 든 것은 모두 그 함수의 영역에 포함되었다고 말한다.*
- **함수의 영역** 이란, 인스턴스나 함수가 가지는 *시야(visibility)* 다. 어떤 함수의 영역 안에서 정의된 것은 모두 그 함수가 볼 수 있다. 



### 복수 리턴값

- 함수는 하나보다 많은 값을 리턴할 수도 있다.
- 이를 위해 이미 튜플이라는 데이터 타입을 사용한다.

~~~swift
func sortedEvenOddNumbers(_ numbers: [Int]) -> (evens: [Int], odds: [Int]) {
    var evens: [Int] = []
    var odds: [Int] = []
    for number in numbers {
        if number % 2 == 0 {
            evens.append(number)
        } else {
            odds.append(number)
        }
    }
    return (evens,odds)
}

print(sortedEvenOddNumbers([1,2,3,4,5,6])) // (evens: [2, 4, 6], odds: [1, 3, 5])
~~~

- 이 함수는 정수 배열을 유일한 인수로 받고 *이름 있는 튜플(named tuple)* 을 리턴한다. 튜플에 이름이 있다는 것은 튜플 자체가 아니라 튜플의 요소에 이름이 붙었다는 뜻이다.



### 옵셔널 리턴 타입

- 상황에 따라서 nil을 리턴하거나 어떤 값을 리턴하기 위해 Swift는 옵셔널 리턴을 제공한다.

~~~swift
func greetMiddleName(fromFullName name: (String, String?, String)) -> String?  {
    return name.1
}

let middleName = greetMiddleName(fromFullName: ("Matt", nil, "Mathias"))
if let theName = middleName {
    print(theName) // nil이라 실행 안됨
}
~~~



### 함수에서 중도에 빠져나오기

- **guard** 는 어떤 조건이 만족되지 않을 때  함수 실행 도중에 빠져나오기 위해 사용한다.

- *guard라는 이름처럼 부적절한 조건일 때 코드가 실행되지 않도록 보호하는 임무를 맡는다.*

- ~~~swift
  func greetMiddleName(fromFullName name: (first: String, middle: String?, last: String)) {
      guard let middleName = name.middle else {
          print("Hey there")
          return
      }
      print("Hey \(middleName)")
  }
  
  greetMiddleName(fromFullName: ("Matt","Danger","Mathias")) // Hey Danger
  ~~~

- guard let middleName = name.middle 은 middle의 값을 middleName이라는 상수와 바인딩 했다.

- 따라서 옵셔널에 값이 없다면 guard 구문의 코드가 실행된다.



### 함수의 타입

- *함수의 타입* 은 함수의 파라미터와 리턴값의 타입으로 결정된다.

- 함수의 타입은 변수를 지정받을 수 있다는 점에서 쓸모가 많다. 특히 이 기능은 함수를 인수로 사용하거나 다른 함수를 리턴할 때 매우 편리하게 적용될 수 있다.

- 함수 타입을 상수에 지정하는 방법

- ~~~swift
  let evenOddFunction: ([Int]) -> ([Int], [Int]) = sortedEvenOddNumbers
  ~~~