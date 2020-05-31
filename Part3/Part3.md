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