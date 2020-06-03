# CHAPTER 17(초기화)

- 초기화란 어떤 타입의 인스턴스를 설정하는 과정이다. 이 과정에서 저장형 프로퍼티마다 초깃값을 지정하는 등 일련의 준비 과정을 진행하게 된다. 이 과정 이후 인스턴스는 사용될 준비가 완료된 것이다.



### 이니셜라이저의 문법

- 구조체와 클래스에서는 초기화 완료 시점에 저장형 프로퍼티에 초기값을 지정해야 한다.
  - 그렇기 때문에 저장형 프로퍼티에는 기본값을 일일이 지정해야 했던 것이다.
  - 기본값을 지정하지 않으면 컴파일러는 프로퍼티가 사용할 준비가 되지 않았다며 오류를 토해 낸다.
  - **이니셜라이저의 정의는 인스턴스가 만들어질 때 프로퍼티가 값을 가지도록 하는 방법** 이기도 하다.

~~~swift
struct CustomType {
  init(someValue: SomeType) {
    // 초기화 코드
  }
}
~~~

- 이니셜라이저는 **init** 키워드로 시작하여, 이니셜라이저가 타입의 메서드인 경우라도 그 앞에 func 키워드를 붙이지 않는다.



### 구조체의 기본 이니셜라이저

- Town 타입의 인스턴스를 생성했을때 Town 타입의 저장형 프로퍼티에 기본값을 지정했는데, 이 과정에서 Swift 컴파일러가 자동으로 제공한 **빈 이니셜라이저(empty initializer, 파라미터가 없는 이니셜라이저)** 가 사용되었다. 

- ~~~swift
  var myTown = Town()
  ~~~

- 위 코드를 입력했을 때 빈 이니셜라이저가 호출되었고, 지정한 기본값이 새 인스턴스의 프로퍼티에 설정된 것이다.

- 기본 이니셜라이저의 다른 형태로 **멤버와이즈 이니셜라이저(memberwise initializer)** 라는 것도 있다.

  - 멤버와이즈 이니셜라이저는 저장형 프로퍼티 하나당 파라미터 하나를 가진다.
  - 여기서는 다른 곳에서 지정한 기본값에 따라 새 인스턴스의 프로퍼티 값을 채우지 않고, 멤버와이즈 이니셜라이저가 값이 필요한 모든 저장형 프로퍼티의 인수를 담당한다.

- **초기화의 주 목적은 모든 저장형 프로퍼티에 값을 지정하여 새 인스턴스를 사용할 수 있는 상태로 만드는 것이다.**

  - 따라서 인스턴스를 새로 만들 때 그 저장형 프로퍼티에 값을 지정해야 한다.
  - 구조체를 정의해 놓고 이니셜라이저를 지정하지 않으면 기본값이나 멤버와이즈 이니셜라이저를 통해 필요한 값을 제공해야 한다.

  ~~~swift
  var myTown = Town(population: 10000, numberOfStoplights: 6)
  ~~~

  

### 구조체의 커스텀 이니셜라이저

- 직접 만든 이니셜라이저는 더욱 강력하다. 다만 그만큼 책임도 따르게 된다
  - 이니셜라이저를 직접 만들면 Swift의 기본 멤버와이즈 이니셜라이저는 제공되지 안흔ㄴ다.
  - 인스턴스의 프로퍼티에 올바른 값을 지정하는 것은 내 몫이 된다.

~~~swift
// 멤버와이즈 이니셜라이저 이니셜라이저 추가하기
init(region: String, population: Int, stoplights: Int) {
        self.region = region
        self.population = population
				numberOfStoplights = stoplights
}
~~~

- 여기서 **init(region: String, population: Int, stoplights: Int)** 이니셜라이전는 Town 타입의 저장형 프로퍼티마다 하나씩 모두 세 개의 인수를 받는다. 인수로 지정된 값들은 실제 프로퍼티로 전달된다.
- *이니셜라이저의 파라미터 이름은 프로퍼티 이름과 같으므로 self를 통해 프로퍼티에 명시적으로 접근해야 한다.*
- region 프로퍼티의 경우 let으로 선언했지만, 값을 설정했단느 점에 유의해야 한다.
  - *Swift에서는 초기화 과정 동안 어느 시점에 상수 프로퍼티를 초기화 할 수 있도록 했다.*
  - **초기화는 초기화가 완료되었을 때 타입의 프로퍼티에 값이 있다는 것을 보장하는 데 그 목적이 있다.**



### 이니셜라이저 델리게이션

- 한 타입 안에서 다른 이니셜라이저를 호출하는 이니셜라이저를 정의할 수도 있다.
  - 이를 가리켜 **이니셜라이저 델리게이션(initializer delegation)** 이라고 부른다.
  - 흔히 인스턴스 생성 방법을 여럿으로 제공할 때 사용된다.
- 값 타입의 이니셜라이저 델리게이션은 대체로 직관적이다.
  - 값 타입의 경우 상속을 지원하지 않으므로 이니셜라이저 델리게이션은 같은 타입 안에 정의된 다른 이니셜라이저만 호출한다.

~~~swift
init(region: String, population: Int, stoplights: Int) {
        self.region = region
        self.population = population
        self.numberOfStoplights = stoplights
}    
init(population: Int, stoplights: Int) {
        self.init(population: population, stoplights: stoplights)
}
~~~

- Town 타입의 새 이니셜라이저를 정의했다. 이 이니셜라이저는 앞에서 만든 이니셜라이저와 달리 인수를 두 개만 받는다. 

????



### 클래스의 초기화

- 클래스에서는 **지정형(designated)** 이니셜라이저와 **편의성(convenience)** 이니셜라이저라는 개념이 적용되었다.
  - 지정형 이니셜라이저는 인스턴스의 프로퍼티에 초기화 완료 전이라도 값이 있어야 할 때 사용된다.
  - 편의성 이니셜라이저는 지정형 이니셜라이저의 보완재로서, 지정형 이니셜라이저에 맞춰 클래스를 호출한다. 따라서 인스턴스는 사용될 준비가 완료된 셈이다. *편의성 이니셜라이저는 구체적으로 사용할 클래스의 인스턴스를 만들 때 주료 사용된다.*



### 클래스의 기본 이니셜라이저

- 클래스는 모든 프로퍼티에 기본값을 지정하고 따로 이니셜라이저를 만들지 않으면 빈 기본 이니셜라이저를 가진다.
- 클래스는 구조체와 달리 멤버와이즈 이니셜라이저를 가지지 않는다.
  - 앞에서 클래스는 기본값을 지정한다고 한 이유가 이 때문이다.
- 멤버와이즈 이니셜라이저 대신 빈 기본 이니셜라이저를 이용하도록 하는 것이다.

~~~swift
let fredTheZombie = Zombie()
~~~

- 여기서 빈 괄호는 기본 이니셜라이저를 사용한다는 뜻이다.



### 초기화와 클래스 상속

~~~swift
init(town: Town?, monsterName: String) {
        self.town = town
        name = monsterName
}
~~~



### 이니셜라이저 자동 상속

- 일반적으로 클래스는 슈퍼클래스의 이니셜라이저를 상속하지 않는다.
  - 이는 서브클래스가 서브클래스 타입의 모든 프로퍼티에 값을 설정하지 않는 이니셜라이저를 의도치 않게 제공하지 않도록 하기 위한 Swift의 방침이다.
  - *서브클래스에는 슈퍼클래스에 없는 프로퍼티가 추가 될 때가 많은 탓에 이런 방침이 마련된 것이다.*
  - 서브클래스에서 자신의 이니셜라이저를 가지도록 제한을 두면 온전하지 못한 이니셜라이저로 타입이 일부분만 초기화되는 것을 막을 수 있다.
- 하지만 클래스에서 슈퍼클래스의 이니셜라이저를 자동으로 상속하는 경우도 있다.
  1. 서브클래스에 지정형 이니셜라이저가 정의되어 있지 않다면, 슈퍼클래스의 지정형 이니셜라이저를 상속한다.
  2. 서브클래스에 슈퍼클래스의 모든 지정형 이니셜라이저가 구현되어 있다면 명시적인 방법이든 상속을 통해서든 슈퍼클래스의 모든 편의성 이니셜라이저를 상속한다.



### 클래스의 지정형 이니셜라이저

- 클래스의 주 이니셜라이저는 지정형이다.
- **지정형 이니셜라이저는 지정형이라는 역할의 일환으로 클래스의 프로퍼티가 모두 초기화 완료 전에 값을 받는지 확인한다.**
- 슈퍼클래스가 지정된 클래스의 지정형 이니셜라이저는 슈퍼클래스의 지정형 이니셜라이저도 함께 호출해야한다.

~~~swift
// Monster 클래스
init(town: Town? monsterName: String) {
  self.town = town
  name = monsterName
}
~~~

- 지정형 이니셜라이저는 **무지정 방식(unadorned)** 을 취한다. 다시 말해 Init 앞에 어떤 특별환 키워드도 지정되지 않는다.
  - 이런 문법 구조는 지정형 이니셜라이저와 편의성 이니셜라이저가 구별되는 특징이다.
  - 편의성 이니셜라이저는 앞에 **convenience** 가 붙는다.
- Monster 클래스의 이니셜라이저는 자신의 프로퍼티가 모두 초기화 완료 전에 값을 받는지 확인한다. 

~~~swift
init(limp: Bool, fallingApart: Bool, town: Town?, monsterName: String) {
        walksWithLimp = limp
        isFallingApart = fallingApart
        super.init(town: town, monsterName: monsterName)
}
~~~

- Zombie의 슈퍼클래스의 지정형 이니셜라이저를 호추했다. **super는 서브클래스의 슈퍼클래스를 가리킨다.**
  - super.init(town: town, monsterName: monsterName) 행은 Zombie 클래스의 이니셜라이저로부터 가져온 town과 monsterName 파라미터의 값을 Monster 클래스의 지정형 이니셜라이저로 전달한다는 뜻이다.
- 슈퍼클래스의 이니셜라이저를 마지막에 호출한 이유는 무엇일까?
  - Zombie의 이니셜라이저는 Zombie 클래스의 지정형 이니셜라이저이므로 프로퍼티 전체의 초기화 책임을 맡고 있다.
  - **프로퍼티가 모두 값을 받게 되면 서브클래스의 지정형 이니셜라이저는 슈퍼클래스의 프로퍼티들을 초기화할 수 있도록 슈퍼클래스의 이니셜라이저를 호출해야한다.**



### 클래스의 편의성 이니셜라이저

- **편의성 이니셜라이저는 지정형 이니셜라이저와 달리 클래스의 모든 프로퍼티에 값이 있다고 보장하지 않는다.**
- 그대신 다른 편의성 이니셜라이저나 지정형 이니셜라이저에 자신이 정의된 목적 등을 전달한다.
- 모든 편의성 이니셜라이저는 같은 클래스의 다른 이니셜라이저를 호출할 수 있다.
- *편의성 이니셜라이저와 지정형 이니셜라이저 사이의 관계는 클래스의 저장형 프로퍼티가 초깃값을 받는 방법의 정의라 할 수 있다.*

~~~swift
init(limp: Bool, fallingApart: Bool, town: Town?, monsterName: String) {
        walksWithLimp = limp
        isFallingApart = fallingApart
        super.init(town: town, monsterName: monsterName)
    }
    
    convenience init(limp: Bool, fallingApart: Bool) {
        self.init(limp: limp, fallingApart: fallingApart, town: nil, monsterName: "Minho")
        if walksWithLimp {
            print("This zombie has a bad knee.")
        }
    }
~~~

- town과 monsterName 파라미터는 생략되며, 이 이니셜라이저 콜러는 이 니니셜라이저의 파라미터에 인수만 제공하면 된다.
- 편의성 이니셜라이저를 만들 때 필요한 키워드는 **convenience** 이다.
  - 이 키워드가 붙은 이니셜라이저는 클래스의 다른 이니셜라이저에 위임되고 결국에는 지정형 이니셜라이저가 호출된다.
- 편의성 이니셜라이저가 그 값을 받지 못한 파라미터인 town과 monsterName의 경우에는 nil과 "Minho"를 Zombie의 지정형 이니셜라이에 전달한다.
- 편의성 이니셜라이저가 지정형 이니셜라이저를 호출하면 인스턴스는 사용될 준비를 끝낸다.

~~~swift
var convenientZombie = Zombie(limp: true, fallingApart: false)
~~~



### 클래스의 요구형 이니셜라이저

- 클래스는 자신의 서브클래스에 특정 이니셜라이저를 제공하라고 요구할 수 있다. 
- 그러기 위해서는 이니셜라이저에 **required** 키워드를 붙여 이 타입의 모든 서브클래스에서 해당 이니셜라이저를 제공하도록 강제할 수 있다.

~~~swift
// Monster
required init(town: Town?, monsterName: String) {
        self.town = town
        name = monsterName
}
~~~

- 이렇게 하면 Zombie 클래스에서 오류가 생긴다.

~~~swift
// Zombie
convenience init(limp: Bool, fallingApart: Bool) {
        self.init(limp: limp, fallingApart: fallingApart, town: nil, monsterName: "Minho")
        if walksWithLimp {
            print("This zombie has a bad knee.")
        }
    }
    
    required init(town: Town?, monsterName: String) {
        walksWithLimp = false
        isFallingApart = false
        super.init(town: town, monsterName: monsterName)
}
~~~

- 슈퍼클래스의 요구형 이니셜라이저를 구현하려면 서브 클래스의 구현 코드에 **required** 키워드를 붙여야한다.
- 슈퍼클래스를 상속하고 오버라이드할 수 있는 함수들과 달리 요구형 이니셜라이저에는 required로 지정되었으므로 **override 키워드를 붙일 수 없다.**



### 해제

- **해제(deinitialization)** 는 인스턴스가 더 이상 필요하지 않을 때 메모리에서 제거하는 과정을 가리킨다. 개념적으로는 초기화와 반대다.
- *해제는 타입을 참조하고 값 타입에는 사용할 수 없도록 제한된다.*
- Swift에서 **디이니셜라이저(deinitializer)** 는 인스턴스가 메모리에서 제거되기 바로 직전에 호출된다. 인스턴스가 메모리 할당이 취소되기 전에 최종 관리를 위한 여유를 제공하는 것으로 생각할 수 있다.
- 클래스는 하나의 디이니셜라이저만 가질 수 있다. 디이니셜라이저는 **deinit** 으로 정의되며, 인수는 없다.

~~~swift
// Zombie
deinit {
        print("Zombie named \(name) is no longer with us.")
}
~~~

- 디이니셜라이저는 인스턴스의 프로퍼티와 메서드에 온전한 접근 권한을 가진다.

~~~swift
var minhoZombie: Zombie? = Zombie(limp: true, fallingApart: true, town: myTown, monsterName: "Minho")
minhoZombie = nil // Zombie named Minho is no longer with us.
~~~

- Swift에서는 옵셔널 타입만 nil이거나 nil이 될 수 있다. 따라서 옵셔널로 선언하고 nil로 만들어줘야 한다.



## 실패 가능 이니셜라이저

- 경우에 따라서는 초기화가 실패할 수도 있는 타입을 정의해야 할 때도 있다. 그럴 때에는 콜러에서 인스턴스를 초기화할 수 없다는 사실을 알릴 방법이 필요하다

  - 이때 사용하는 것이 **실패 가능(failable) 이니셜라이저** 이다.

- 초기화 실패를 원하는 이유는 한둘이 아니다.

  - 타입의 이니셜라이저가 유효하지 않은 파라미터를 받을 수도 있다. 

    ex) Town의 인스턴스가 음수의 인구로 초기화될 수도 있고,  let image = UIImage(named: "Minho") 에서처럼 타입의 초기화가 사용할 수 없는 외부 리소스에 의존할 수도 있다. 이 코드는 이미지 리소스가 존재하지 않으므로 UIImage 인스턴스를 만들 수 없는 것이다.이런 상황에서 UIImage의 실패 가능 이니셜라이저는 초기화가 실패했다는 의미로 *nil을 리턴한다*.



### 실패 가능 Town 이니셜라이저

- 실패 가능 이니셜라이저는 타입의 옵셔널 인스턴스를 리턴한다.
- **init 키워드 다음에 물음표를 붙이면(init?) 이니셜라이저가 실패 가능임을 나타낸다.**
- **init 다음에 느낌표를 붙이면(init!) 암묵적으로 언래핑되는 옵셔널을 리턴하는 실패 가능 이니셜라이저를 만들 수 있다.**
  - 암묵적으로 언래핑되는 옵셔널을 리턴한다는 것은 옵셔널을 안전하게 사용할 수 있도록 Swift가 제공하는 옵셔널 언래핑 문법 구조들을 모두 피할 수도 있다는 뜻이다.
  - 이런 이유에서 암묵적으로 언래핑되는 옵셔널의 리턴은 사용하기에 조금 더 쉽지만 안전성이 떨어지므로 주의해야 한다.

~~~swift
init?(region: String, population: Int, stoplights: Int) {
        guard population > 0 else {
            return nil
        }
        self.region = region
        self.population = population
        self.numberOfStoplights = stoplights
}

var myTown = Town(region: "South", population: 1, stoplights: 6)
myTown?.printDescription()
~~~

- population이 0보다 작거나 같으면 nil이 리턴되고 이니셜라이저는 실패하게 된다.
- myTown 대신 myTown? 으로 바뀌었다. 
  - 코드에서 확인할 수 있듯이 Swift에서 nil은 코드에 미치는 영향력이 크다.
  - 코드의 양이 늘어나 프로젝트가 더 복잡해지며, 해결하기 어려운 실수가 생길 개연성도 커진다.
  - 따라서 옵셔널은 꼭 필요할 때만 최소로 사용하는 것이 바람직하다.



- 이니셜라이저의 파라미터도 대가 원하는 파라미터 이름을 정하는 것이 가능하다.





# CHAPTER 18(값 타입 vs 참조 타입)



### 값의 세만틱스

~~~swift
var str = "Hello, Swift!"
var swiftGreeting = str
swiftGreeting += " How are you?"
print(str) // Hello, Swift!
print(swiftGreeting) // Hello, Swift! How are you?
~~~

- swiftGreeting의 값은 견경됐지만 str은 그대로이다.

  - **값의 세만틱스(value semantics)** 와 관련이 있다.

- String 타입의 정보를 보게 되면 구조체로 설명되어 있다.

  - String은 표준 라이브러리의 **구조체** 로 구현되어 있다. 또한 String은 **값 타입** 이기도 하다.

  - *값 타입은 인스턴스에 대입될 때 또는 함수의 인수로 전달될 때 항상 복사된다.*

  - str을 swiftGreeting에 대입하면 str 값이 swiftGreeting로 복사된다.(**복사본(copy)**)

    -> *같은 인스턴스를 가리키는 것이 아니라는 뜻이다.*

  - 따라서 swiftGreeting의 값을 변경하더라도 str의 값에는 아무런 영향을 미치지 않는다.

- **Swift의 기본 타입인 Array, Dictionary, Int, String 등은 모두 구조체로 구현되어 있다. 따라서 모두 값 타입이다.** 

- *데이터를 구성할  항상 구조체부터 고려해야 하며, 필요할 때만 클래스를 사용하는 것이 바람직하다.*



### 참조의 세만틱스

- 참조의 세만틱스는 값의 세만틱스와 다르게 동작한다.
- 값 타입에서는 새 상수나 변수에 값을 대입할 때 인스턴스의 복사본이 사용된다. 

~~~swift
class GreekGod {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let hecate = GreekGod(name: "Hecate")
let anotherHecate = hecate

anotherHecate.name = "AnotherHecate"
print(hecate.name) // AnotherHecate
print(anotherHecate.name) // AnotherHecate
~~~

- 두 name 프로퍼티는 모두 "AnotherHecate"로 변경되었다.
- GreekGod(name: "Hecate") 코드에서 GreekGod 클래스의 인스턴스를 만들었다. 
- *hecate에서처럼 클래스의 인스턴스를 상수나 변수에 대입하면 그 상수나 변수는 인스턴의 참조를 가지게 된다.*
- **상수나 변수는 참조를 사용하여 메모리 내 클래스의 인스턴스를 가리킨다.**



### 상수의 값 타입과 참조 타입

- 값 타입과 참조 타입은 상수 일 때 서로 다르게 동작한다.

~~~swift
struct Pantheon {
    var chiefGod: GreekGod
}

let pantheon = Pantheon(chiefGod: hecate)
let zeus = GreekGod(name: "Zeus")
pantheon.chiefGod = zeus // Cannot assign to property: 'pantheon' is a 'let' constant
~~~

- 이 오류는 Pantheon이 immutable 인스턴스라는 의미이다.



~~~swift
struct Pantheon {
    var chiefGod: GreekGod
}

let pantheon = Pantheon(chiefGod: hecate)
let zeus = GreekGod(name: "Zeus")
zeus.name = "Zeus Jr."
print(zeus.name) // Zeus Jr.
~~~

- zeus는 let으로 선언되었지만 오류 없이 실행이 가능하다.
- 값 타입의 인스턴스인 상수는 프로퍼티의 값을 변경할 수 없지만, 참조 타입의 인스턴스인 상수는 변경할 수 있는 이유는 무엇일까?
  - zeus는 참조 타입의 인스턴스이기 때문에 GreekGod(name: "Zeus") 코드에서 만들어지는 **GreekGod 의 인스턴스**를 가리킨다.
  - name 프로퍼티에 저장된 값을 변경하면 실제로는 GreekGod의 참조인 zeus가 변경된다.
  - GreekGod 클래스를 정의할 때 name을 변수로 선언하였다.



### 값 타입과 참조 타입 함께 사용하기

- 값 타입 안에서 참조 타입을 사용하려면 조심해야 한다.
  - 참조 타입 안에서 값 타입을 사용할때는 문제가 발생하지는 않는다.

~~~swift
class GreekGod {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let hecate = GreekGod(name: "Hecate")
let anotherHecate = hecate

anotherHecate.name = "AnotherHecate"

struct Pantheon {
    var chiefGod: GreekGod
}

let pantheon = Pantheon(chiefGod: hecate)
let zeus = GreekGod(name: "Zeus")
zeus.name = "Zeus Jr."

let greekPantheon = pantheon
hecate.name = "Trivia"
print(greekPantheon.chiefGod.name) // Trivia
~~~

- chiefGod의 타입은 GreekGod이고 GreekGod는 클래스이므로 참조 타입이다.

- 값 타입 안에 참조 타입을 두면 복잡해진다.
- 값 타입의 인스턴스는 새 변수나 상수에 대입될 때나 함수로 전달될 때 복사한다는 점을 기억해야한다.
- 프로퍼티로 참조 타입을 가지는 값 타입은 새 변수나 상수를 가리키는 같은 참조를 전달하게 된다.
  - 이 참조는 원래 참조가 가리켰던 인스턴스를 그대로 가리키므로 무턱대고 참조를 변경하면 예상치 못한 결과를 초래할 수 있다.
  - 구조체에 참조 타입의 프로퍼티가 필요할 때는 변경 불가능한 인스턴스를 사용하는 것이 최선이다.



### 복사하기

- 개발자들에게 인스턴스의 복사가 **얇은 복사(shallow copy)** 와 **깊은 복사(deep copy)** 중 어느 경우에 해당하는지는 관심사이기도 하다.
- *Swift에서는 깊은 복사를 언어 차원에서 지원하지 않으며 얕은 복사다.*
- **얕은 복사는 인스턴스의 복사본을 별도로 만들지 않는다. 그저 같은 인스턴스를 가리키는 참조가 하나 더 생길 뿐이다.**
- 반면, **깊은 복사** 는 참조의 목적지에 해당하는 인스턴스를 복제한다. 자체 인스턴스를 가리키는 참조로 새 배열을 만든다.



### 동일성 vs 정체성

- **동일성(equality)은 텍스트가 같은 String타입의 두 인스턴스처럼 관찰 가능한 특징으로서 두 인스턴스가 동일한 값을 가질 때를 나타낸다.**
- **정체성(identity)은 두 변수나 상수가 메모리에서 같은 인스턴스를 가리킬 때를 나타낸다.**

~~~swift
let x = 1
let y = 1
print(x==y) // true
~~~

- 두 인스턴스는 1이라는 같은 값을 가지게 되고 동일하므로 true가 리턴된다.
  - 두 인스턴스가 같은 값을 가지고 있느냐는 동일성 확인을 통해 우리가 알고자 하는 내용이다.
  - Swift의 모든 타입(**String, Int, Float, Double, Array, Dictionary**)에는 동일성 확인을 진행할 수 있다.

~~~swift
print(athena === hecate) // false
~~~

- 두 상수나 변수가 같은 값을 가지면 서로 동일하다고 할 수 있으나 그 정체성까지는 같다고는 할 수 없다.(가리키는 타입의 인스턴스가 서로 다름)
- 하지만 두 변수나 상수가 메모리에서 같은 인스턴스를 가리키면 서로 동일하다고 할 수 있다.



### 무엇을 사용해야 할까?

1. 값을 전달하는 타입이 필요하다면 **구조체** 를 사용한다. 그래야 함수의 인수로 대입될때나 전달될 때 타입이 복사된다.
2. 서브클래스에서 상속해야 하는 타입이 아니라면 **구조체** 를 사용한다. 구조체는 상속을 지원하지 않으므로 서브클래스가 존재할 수 없다.
3. 타입으로 표현해야 할 동작이 비교적 직관적이고 단순 값 몇 가지를 포함하는 경우에는 **구조체** 가 어울린다. 나중에 이 타입을 클래스로 변경해도 늦지 않다.
4. 나머지 경우에는 **클래스** 를 사용한다.



### 쓰기 시 복사(Copy on write)

- 값 타입의 복사 동작에 어떤 성능상 장점이 있는지 궁금할 것이다.

- 예를 들어 Array 타입을 함수에 전달하거나 새 상수나 변수에 대입할 때마다 Array의 새 복사본이 생긴다면 복사본이 많이 생겨 낭비이지 않을까?

  - 실제로는 데이터에 따라 그리고 데이터를 어떻게 사용하느냐에 따라 다른다
  - Swift의 표준 라이브러리에 저공되는 값 타입은 **쓰기 시 복사(copy on write)** 로 구현되어 있다.

- 쓰기 시 복사(copy on write), 즉 COW는 값 타입의 기본 저장 대상을 암묵적으로 공유하는 것을 가리킨다.

  - 이 최적화 방법을 적용하면 값 타입의 인스턴스들은 기본 저장 대상을 공유한다.

  - *다시 말해 각 인스턴스는 데이터의 자체 복사본을 가지지 않고, 데이터의 자체 참조만을 유지한다.*
  - 나중에 인스턴스가 데이터를 변경하면, 즉 데이터에 쓰기를 수행하면, 그때 자체 복사본을 가진다는 것이다. 
  - **값 타입의 불필요한 데이터 복사를 방지하는 수단이다.**

