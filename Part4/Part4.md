# CHAPTER 14(열거형)

- 열거형은 리스트 형태로 정의된 여러 케이스(case)로 인스턴스를 만들 수 있는 방법이다.



### 열거형 기본

~~~swift
enum TextAlignment {
    case left
    case right
    case center
}

var alignment: TextAlignment = TextAlignment.left

switch alignment {
case .left:
    print("Left")
case .right:
    print("right")
case .center:
    print("center")
}
~~~

- 열거형을 정의할 때는 열거형 이름 앞에 **enum** 이라는 키워드를 사용한다.
- 몸체에는 case 구문이 적어도 하나 있어 열거형의 값을 선언해야 한다.
- 열거형의 이름, 즉 *TextAlignment* 는 Int나 String 등 지금처럼 사용한 타임들처럼 이제 **하나의 타입** 으로 사용할 수 있다. 열거형의 이름은 대문자로 시작하는 것이 관례이다. 열거형의 case 등은 소문자로 시작한다.
- 열거형은 새 타입을 선언한 것이므로 열거형 타입으로도 인스턴스를 만드는 것이 가능하다.

- 열거형의 값을 비교할 때는 일반적으로 **switch** 구문을 사용한다.
- 이전에서는 switch 구문에서 생략되는 것이 하나도 없어 소모적이었다. default 케이스 포함되었다. 반면, 열거형 값에 switch를 적용할때는 *default가 필수가 아니다*. -> 컴파일러가 이미 모든 가능한 값을 알고 있기 때문이다.



### 원시값 열거형

- Swift의 열거형은 C나 C++ 등의 언어와 달리 정수형이 없다. 하지만 **원시값(raw value)** 를 사용하여 정수형처럼 처리할 수는 있다.

- ~~~swift
  enum TextAlignment: Int {
      case left
      case right
      case center
      case justify
  }
  
  print("Left has raw value : \(TextAlignment.left.rawValue)") // Left has raw value : 0
  print("Right has raw value : \(TextAlignment.right.rawValue)") // Right has raw value : 1
  
  enum TextAlignment: Int {
  	case left = 20 
    case right = 30
    case center = 40 
    case justify = 50
  }
  ~~~

- TextAlignment에 원시값 타입을 지정하면 이 타입(Int)의 고유 원시값이 각 케이스에 지정된다. 기본적으로 첫 번째 case는 0, 그 다음은 1... 이런 순서가 된다.

- 원한다면 각 케이스에 원시값을 직접 지정하는 것도 가능하다.

- 원시값 열거형은 언제 유용할까? 
  - 원시값을 사용하는 가장 큰 이유는 열거형을 저장하거나 전달할 수 있어서일 것이다. 
  - 변수에 일일이 열거형을 담아 처리하는 함수를 만들지 않아도 rawValue를 사용하면 변수를 해당 원시값으로 전화할 수 있다.



### 메서드

- 메서드는 타입과 연동되는 함수라고 했다.
- 일부 언어에서는 메서드를 클래스와만 연동되는 것으로 정의하고 있기도 하다. Swift의 메서드는 열거형과도 연동된다.

~~~swift
enum Lightbulb {
    case on
    case off
    
    func surfaceTemerature(forAmbientTemperature ambient: Double) -> Double {
        switch self {
        case .on:
            return ambient + 150.0
        case .off:
            return ambient
        }
    }
  
	  mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}

var bulb = Lightbulb.on
bulb.toggle()
let temperature = 77.0


var bulbTemparature = bulb.surfaceTemerature(forAmbientTemperature: temperature)
print("the bulb's temperature : \(bulbTemparature)") // the bulb's temperature : 227.0
~~~

- 여기서는 열거형의 정의 안에 함수를 추가했다. 이 함수는 정의된 위치 때문에 Lightbulb 타입과 연동되는 메서드가 되었다. 이를 가리켜 **Lightbulb의 메서드** 라고 부른다.

- 이 함수는 인수를 하나 맞지만, 메서드이기 때문에 Lightbulb 타입의 *self* 라는 암묵적 인수도 받는다. 이 *self* 인수는 **메서드가 호출되는 인스턴스에 접근하는데 사용된다.**

- **mutating** 키워드 없이 self를 쓰면 컴파일러 오류가 발생한다. *self* 를 메서드 안으로 대입할 수 없다는 의미의 오류다. Swift에서 열거형은 **값 타입(value type)** 이며, 이 값 타입의 메서드는 self를 변경할 수 없다.
- 값 타입의 메서드에서 sel를 변경하도록 허용하려면 *mutating* 이라는 키워드를 붙여야 한다.



### 연동되는 값

- 지금까지 살펴본 열거형의 모든 것은 가능성 있는 값이나 상태가 나열된 정적 케이스 정의라는 일반적인 범주이다.
- Swift는 강력한 다른 종류의 열거형도 제공한다. *연동되는 값의 케이스* 다. 연동되는 값을 적용하면 데이터를 열거형의 인스턴스에 연동할 수 있고, 그럼 케이스마다 다른 연동값을 가질 수 있다.

~~~swift
enum ShapeDimensions {
    case square(side: Double) // 8바이트
    case rectangle(width: Double, height: Double) // 16바이트
}

var squareShape = ShapeDimensions.square(side: 10.0)
var rectangleShape = ShapeDimensions.rectangle(width: 5.0, height: 10.0)

print("square's area = \(squareShape.area())") // square's area = 100.0
print("rectangle's area = \(rectangleShape.area())") // rectangle's area = 50.0
~~~



### 재귀적 열거형

- 지금까지는 연동값을 열거형 케이스와 함께 사용했다. 그렇다면 열거형 자체의 타입의 연동값을 그 케이스 중 하나에 사용할 수 있을까?
- 데이터 구조의 *트리(tree)* 는 계층성을 띠는 데이터를 표현할 수 있다. ex) 가계도

~~~swift
// 1
indirect enum FamilyTree {
    case noKnownParents
    case oneKnownParents(name: String, ancestor: FamilyTree)
    case twoKnownParents(fatherName: String, fatherAncestor: FamilyTree, motherName: String, motherAncestor: FamilyTree)
}

// 2
enum FamilyTree {
    case noKnownParents
    indirect case oneKnownParents(name: String, ancestor: FamilyTree)
    indirect case twoKnownParents(fatherName: String, fatherAncestor: FamilyTree, motherName: String, motherAncestor: FamilyTree)
}
~~~

- **indirect** 키워드를 입력하지 않으면 오류가 뜬다. FamilyTree는 *재귀적(recursive)* 이다. 각 케이스가 FamilyTree 타입인 연동값을 가지기 때문이다. 그렇다면 Swift는 열거형의 재귀 여부에 왜 관심이 있을까?
  - **Swift 컴파일러는 타입마다 그 인스턴스들이 얼마나 많은 메모리를 차지하고 있는지 알아야 한다.**
  - 일반적으로 컴파일러가 모든 것을 알아서 하기 때문에 이를 걱정할 필요가 없지만 *열거형은 조금 다르다.*
  - **Swift는 열거형의 어떤 인스턴스든 한 번에 하나의 케이스에만 있어야 한다.** 따라서 컴파일러가 열거형 인스턴스에 필요한 메모리를 결정하면 어느 케이스가 가장 많은 메모리를 요구하는지 파악하고, 그 인스턴스는 해당 메모리를 요구한다.
- *indirect* 키워드가 지정되면 열거형의 데이터가 포인터 뒤에 저장된다는 개념이다.
- 포인터를 사용하면 어떻게 무한 메모리 문제가 해결될까?
  - 컴파일러는 이제 연동된 데이터의 포인터를 저장하는데, FamilyTree의 인스턴스에 데이터가 담길 충분한 메모리를 제공하지 않고 메모리 내 다른 공간에 데이터를 둔다.
  - FamilyTree의 인스턴스의 크기는 이제 64비트 아키텍쳐에서 포인터 하나의 크기인 8바이트이다.



# CHAPTER 15(구조체와 클래스)

- 구조체와 클래스는 애플리케이션을 만들 때 튼튼한 기둥과 같다. 이 두 기둥은 코드로 나타내려는 대상을 구체화하기 위한 핵심 메커니즘이다.



- import Foundation은 **프레임워크(framework)** 를 main.swift 파일로 가져오겠다라는 의미이다.
  - 이 프레임워크는 Objective-C와 연동하기 위한 클래스들로 구성되어있다.



## 구조체

- **구조체(struct)**는 서로 연관된 데이터들을 한데 묶은 타입이다. 구조체는 데이터를 어떤 하나의 타입에 두고 싶을 때 사용한다.
- 구조체로 만들면 그 데이터는 하나의 타입으로 *캡슐화* 된다.

~~~swift
// 구조체 선언
struct Town {
	var population = 5422
  var numberOfStoplights = 4
  
  func printDescription() {
        print("Population: \(population); number of stoplights: \(numberOfStoplights)")
    }
}

// 구조체의 인스턴스 만들기
var myTown = Town()
~~~

- 구조체에 변수를 추가하면 필요한 데이터 등을 담을 수 있다. 이런 변수를 **프로퍼티(property)** 라고 부른다.
- 타입의 이름 뒤에 **()** 를 붙이면 타입의 인스턴스를 만들 수 있다. 빈 괄호를 붙인 것을 가리켜 **기본 이니셜라이저** 라고 부른다.



### 인스턴스 메서드

- printDescription()은 메서드다. *특정 타입과 연동되는 함수이기 때문이다.*
- **전역 함수(global function)** 은 특정 타입에 정의하는 것이 아니므로 **자유 함수(free function)** 으로 통용되기도 한다.
- printDescription() 메서드는 인수도 없고 리턴하는 것도 없다. 이런 특성 탓에 printDescription()을 **인스턴스 메서드(instance method)** 라고 부르기도 한다. 다시 말해 인스턴스 메서드는 Town의 특정 인스턴스에 호출된다.
  - 인스턴스 메서드를 사용하려면 Town의 인스턴스에 호출해야 한다.



### 변경용 메서드

~~~swift
struct Town {
    var population = 5422
    var numberOfStoplights = 4
  
    mutating func changePopulation(by amount: Int) {
        population += amount
    }
}
~~~

- *구조체의 인스턴스 메서드가 구조체의 프로퍼티를 변경하려면* **mutating(변경용)** 이라는 이름표가 필요하다.
- **mutating** 키워드가 붙으면 이 메서드가 구조체의 값을 변경할 수 있다는 뜻이 된다.
  - **구조체와 열거형은 값 타입이라서 인스턴스의 프로퍼티 값을 변경할 메서드에는 mutating 키워드가 붙어야 한다.**





## 클래스

- **클래스(class)** 는 구조체처럼 하나의 타입으로 서로 관련된 데이터를 구체화하는 데 사용된다.

~~~swift
// 클래스 선언
class Monster {
    var town: Town?
    var name = "Monster"
    
    func terrorizeTown() {
        if town != nil {
            print("\(name) is terrorizing a town!")
        } else {
            print("\(name) hasn't found a town to terrorize yet...")
        }
    }
}

var myTown = Town()
myTown.printDescription()
let genericMonster = Monster()
genericMonster.town = myTown
genericMonster.terriorizeTown()
~~~

- terrorizeTown() 메서드는 Monster의 인스턴스에 호출된다.



### 상속

- 구조체에 없는 클래스만의 특징 중 가장 핵심적인 것이 **상속(inheritance)** 이다. 
  - **상속이란 한 클래스가 다른 클래스 안에서 정의되는 관계를 말한다.**
  - 정의된 클래스는 *서브클래스(subclass)* 라고 부르며, 이 서브클래스를 포함한 클래스는 *슈퍼클래스(superclass)* 라고 부른다.
  - **서브클래스는 슈퍼클래스의 프로퍼티와 메서드를 상속한다.**
  - 어떤 의미에서 상속은 클래스 타입의 족보를 정의한다고 볼 수 있다.



~~~swift
// Zombie 서브클래스 
class Zombie: Monster {
    var walksWithLimp = true
    
    override func terriorizeTown() {
        town?.changePopulation(by: -10)
        super.terriorizeTown()
    }
}
~~~

- Zombie 타입은 Monster 타입을 상속한다. Monster를 상속한다는 것은 Zombie가 town 프로퍼티와 terrorizeTown() 메서드 등 Monster의 모든 프로퍼티와 메서드를 가진다는 뜻이다.
- *Zombie는 terrorizeTown() 메서드를 오버라이드(override) 한다.*
- 메서드를 오버라이드 한다는 것은 슈퍼클래스에 정의된 메서드를 다시 정의한다는 뜻이다.
  - 이때 **override** 키워드를 사용해야 한다. 이 키워드를 사용하지 않으면 컴파일 오류가 발생한다.
- **super.terrorizeTown()** 에서 super는 슈퍼클래스의 메서드 구현 코드에 접근하는 데 사용되는 일종의 접두어다. *Monster 클래스의 terrorizeTown() 구현 코드를 호출하기 위해 super를 사용한다.*
- super는 상속이라는 개념에 입각하고 있으므로 열거형이나 구조체 같은 값 타입에는 사용할 수 없다.



- Monster 클래스를 상속한 Zombie의 town 프로퍼티는 Town? 타입의 옵셔널이다. 

- 따라서 town의 메서드를 호출하기 전에 Zombie의 인스턴스에 공격할 도시가 있는지 확인해야 한다.

  ~~~swift
  // 옵셔널 바인딩
  if let terrorTown = town {
    // 실행코드
  }
  
  // 옵셔널 체이닝
  town?.changePopulation(by: -10)
  ~~~

  - 하지만, 구조체의 값에 해당하는 문법 구조를 따져 보면 terrorTown인스턴스는 town 인스턴스와 다르다는 것을 알 수 있다.
    - 구조체를 비롯한 값 타입은 전달될 때 복사되기 때문이다.
    - 옵셔널 체이닝을 사용하면 한 행으로 조건을 검사할 수 있다. Town 인스턴스가 직접 변경되기 때문에 복사 문제도 막을 수 있다.



### 오버라이드 막기

- 경우에 따라서는 서브클래스에서 슈퍼클래스의 메서드나 프로퍼티를 오버라이드 하지 못하게 막아야 할 필요가 있다.
- 오버라이드를 금지해야 할 경우에는 **final 키워드** 를 사용한다.

~~~swift
class Monster {
    var town: Town?
    var name = "Monster"
    
    final func terrorizeTown() {
        if town != nil {
            print("\(name) is terrorizing a town!")
        } else {
            print("\(name) hasn't found a town to terrorize yet...")
        }
    }
}
~~~

