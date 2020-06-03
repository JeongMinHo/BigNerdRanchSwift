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