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