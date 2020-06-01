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



#CHATER 13(클로저)

- **클로저(Closure)** 는 애플리케이션에서 특정 태스크를 수행하기 위해 사용될 수 있는 각종 기능들의 개별 묶음을 말한다.
- 함수는 클로저의 종류이며, 다른 말로 하면 *이름 있는 클로저* 라고 할 수 있다.
- 클로저는 문법 구조가 간결하다는 점에서 함수와 다르다. 함수를 정의할 때처럼 이름을 지정한다거나 온전한 선언 구조를 따르지 않아도 함수와 비슷한 구조를 만들 수 있다는 것이 클로저의 장점이다. 
- 유연성 높은 클로저의 구조 덕분에 함수의 인수나 리턴값을 쉽게 전달할 수 있다.





### 클로저 수식 문법

~~~swift
{(parameters) -> return type in
	// 코드
}
~~~

- *in* 키워드는 클로저의 파라미터와 리턴 타입을 실행 코드와 구별하기 위해 사용된다.

~~~swift
let volounteerCounts = [1,3,40,32,2,53]

func sortAscending(_ i: Int, _ j: Int) -> Bool {
    return i < j
}
var volounteersSorted = volounteerCounts.sorted(by: sortAscending(_:_:))

// 클로저 형식으로 바꿔보기
let volounteersSorted = volounteerCounts.sorted { (i: Int, j: Int) -> Bool in
    return i < j
}

// 타입 추론 활용하기
let volounteersSorted = volounteerCounts.sorted { (i, j) in i < j }

// 축약형 인수명 문법 구조 적용하기
let volounteersSorted = volounteerCounts.sorted { $0 < $1 }
~~~

- 파라미터와 리턴값의 타입 정보를 제거했다. 리턴 타입을 제거할 수 있는 이유는 i <  j 라는 수식의 결과가 **Bool** 인스턴스임을 컴파일러가 알기 때문이다.
- 모든 클로저 수식에서 return 키워드를 생략할 수 있는 것은 아니다. 여기서는 수식이 하나뿐(i < j) 이라 생략이 가능하다. 수식이 여렷이라면 명시적으로 return 키워드가 필요하다.

- 축약형 인수명은 지금까지 사용한 명시적 인수 선언, 즉 타입과 값이 서로 짝이 맞다는 규칙과 비슷하다. *컴파일러의 타입 추론 기능을 적용하면 클로저가 받는 인수의 개수와 타입을 쉽게 알 수 있으므로 굳이 이름을 지정할 필요가 없어진다.*

- **후행 클로저 문법 구조** 를 채택하여 클로저가 함수의 마지막 인수에 전달될 때는 함수의 괄호 밖이나 다음에 인라인으로 작성할 수 있다. 





### 리턴 타입 역할을 하는 함수

- 함수는 리턴값으로 다른 함수를 리턴할 수 있다.

~~~swift
func makeTownGrand() -> (Int, Int) -> Int {
    func buildRoads(byAddingLights lights: Int, toExistingLights existingLights: Int) -> Int {
        return lights + existingLights
    }
    return buildRoads(byAddingLights:toExistingLights:)
}

var stopLights = 4
let townPlanByAddingLights = makeTownGrand()
stopLights = townPlanByAddingLights(4, stopLights)
print("Knowhere has \(stopLights) stoplights") // Knowhere has 8 stoplights
~~~

- makeTownGrand() 함수는 인자가 없다. 하지만 **리턴값은 함수** 이다. 이 함수는 정수인 두 개의 인수를 받아 정수를 리턴한다.

- townPlanByAddingLights 상수는 makeTownGrand() 함수가 만든 buildRoads 함수를 가리킨다.





### 인수 역할을 하는 함수

- 함수는 다른 함수의 인수가 될 수 있다. 예를들어 sorted(by:) 에 sortAscending(_:_:) 함수를 인수로 제공했다.

~~~swift
func makeTownGrand(withBudget budget: Int, condition: (Int) -> Bool) -> ((Int, Int) -> Int)? {
    if condition(budget) {
        func buildRoads(byAddingLights lights: Int, toExistingLights existingLights: Int) -> Int {
            return lights + existingLights
        }
        return buildRoads(byAddingLights:toExistingLights:)
    } else {
        return nil
    }
}

func evaluate(budget: Int) -> Bool {
    return budget > 10000
}

var stoplights = 4
if let townPlanByAddingLights = makeTownGrand(withBudget: 1000, condition: evaluate(budget:)) {
    stoplights = townPlanByAddingLights(4, stoplights)
}
print("Knowhere has \(stoplights) stoplights.") // Knowhere has 4 stoplights.
~~~





### 클로저, 값을 붙잡다

- 클로저와 함수는 자신의 영역에서 정의된 변수에 캡슐화된 내부 정보를 추적할 수 있다.

~~~swift
func makePopulationTracker(forInitialPopulation population: Int) -> (Int) -> Int {
    var totalPopulation = population
    func populationTracker(growth: Int) -> Int {
        totalPopulation += growth
        return totalPopulation
    }
    return populationTracker(growth:)
}

var currentPopulation = 5422
let growBy = makePopulationTracker(forInitialPopulation: currentPopulation)
growBy(500)
growBy(500)
growBy(500)
currentPopulation = growBy(500)
print(currentPopulation) // 7422
~~~

- growBy(_:) 를 4번 호출하여 2000명이 증가하게 된다.
- 인구를 업데이트 하기 위해서는 currentPopulation에 함수의 결과를 대입하면 된다.



### 클로저는 참조 타입이다 !

- 클로저는 *참조 타입(reference type)* 이다. 함수를 상수나 변수에 대입하면 실세로는 상수나 변수가 그 함수를 가리키도록 설정되는 것이다. 다만 함수의 복사본이 만들어진 것은 아니다.

  - 함수의 영역에서 붙잡힌 정보는 무엇이 됐든 새 상수나 변수를 통해 호출하면 변경된다.

    ~~~swift
    var currentPopulation = 5422
    let growBy = makePopulationTracker(forInitialPopulation: currentPopulation)
    growBy(500)
    growBy(500)
    growBy(500)
    currentPopulation = growBy(500)
    
    let anotherGrowBy = growBy 
    anotherGrowBy(500) // totalPopulation은 7922가 된다
    ~~~

  - 이렇게 하면 anotherGrowBy는 growBy와 같은 함수를 가리킨다.  따라서 anotherGrowBy(_:)를 호출하고 500을 인수로 전달하면 totalPopulation은 500 증가한다. 하지만 currentPopulation의 값은 변하지 않는다. -> 그 값을 anotherGrowBy(_:)의 리턴값으로 설정하지 않았기 때문이다.

  - anotherGrowBy는 populationTracker(growth:) 함수의 영역에 붙잡힌 totalPopulation 내부 변수의 값을 직접 늘릴 뿐이다.



### 함수형 프로그래밍

- Swift는 *함수형 프로그래밍(functional programming)* 이라는 패러다임의 패턴을 일부 도입했다.
  1. **일급 함수(first-class function)** : 다른 타입처럼 다른 함수에서 리턴되거나 인수로 전달될 수도 있고 변수에 저장될 수도 있는 함수다.
  2. **순수 함수(pure function)** : 부작용이 없는 함수. 함수는 입력이 같으면 리턴하는 출력도 언제나 같고, 프로그램 내 특정 위치에서 수정되지도 않는다. ex) 피보나치, 팩토리얼을 비록한 수학 함수 대부분은 순수 함수이다.
  3. **불변경성(immutability)** 
  4. **강력한 타입 지정(strong typing)** : 강력한 타입 시스템은 코드의 런타임 안정성을 높인다. 프로그래밍 언어의 타입 시스템이 컴파일 타임에 확인되기 때문이다.
- 함수형 프로그래밍을 적용하면 코드가 간결해지고 표현력이 높아진다. 불변경성과 강력한 컴파일 타임 타입 확인을 강조함으로써 코드는 더더욱 런타임 안정성을 확보하게 된다.
- 이러한 강점 덕분에 코드는 추론과 유지 보수가 한결 수월해진다.



### 고차 함수

- **고차 함수(higher-order function)** 은 입력으로 적어도 하나의 함수를 받는다. 



1. **map(_:)**

   - 배열의 내용물을 변형하는 데 사용하는 함수이다. 

   - 배열의 내용물을 한 값에서 다른 값으로 *매핑하고* , 이 새 값을 새 배열에 넣는 것이다. 고차 함수이므로 배열의 내용물을 어떻게 변형하는지 알려 주는 또 하나의 함수가 제공된다.

   - Swift의 표준 라이브러리는 Array 타입에 map을 구현해 놓았다.

   - ~~~swift
     let arr1 = [1244,2021,2157]
     let arr2 = arr1.map { (number: Int) -> Int in
         return number * 2
     }
     print(arr2) // [2488, 4042, 4314]
     ~~~

2. **filter(_:)**

   - map(_:) 처럼 Array타입의 인스턴스에 호출된다. 그리고 클로저 수식을 인수로 받는다

   - filter(_:)의 목적은 배열을 어떤 기준에 따라 *걸러 내는(filter)* 것이다. 결과 배열은 테스트를 통과한 원래 배열의 값을 담게 된다.

   - ~~~swift
     let arr1 = [1244,2021,2157]
     let arr2 = arr1.filter { (num: Int) -> Bool in
         return num > 2000
     }
     print(arr2) // [2021, 2157]
     ~~~

   - 앞에서 처럼 뒤에 붙는 클로저 문법을 사용했다. 

3. **reduce(_: _ :)**

   - Array 타입의 인스턴스에 reduce(_: _:) 가 호출되면 컬렉션 내 값들을 함수로부터 리턴된 하나의 값으로 *축소(reduce)* 된다.

   - ~~~swift
     let arr1 = [1244,2021,2157]
     let arr2 = arr1.reduce(0) { (num1, num2) -> Int in
         return num1 + num2
     }
     print(arr2) // 5422
     ~~~

   - 첫 번째 인수는 처음에 더해질 수 있는 초기값을 가리킨다. 두 번째 인수는 컬렉션 내 값이 결합되는 방식을 정의하는 클로저이다.

