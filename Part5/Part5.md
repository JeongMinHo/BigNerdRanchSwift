# CHAPTER 19(프로포콜)

- CH16 에서는 정보를 숨기기 위한 접근 제어에 관한 내용을 배웠다.
  - **정보 숨기기는 일종의 캡슐화 이며 이를 통해 소프트웨어의 어느 한쪽을 변경하면서 다른 쪽에 영향을 미치지 않도록 소프트웨어를 디자인하는것이 가능하다.**
- *Swift가 제공하는 캡슐화에는 한 가지 형태가 더 있다. 바로 **프로토콜(protocol)** 인데, 프로토콜을 적용하면 어떤 타입 자체를 몰라도 타입의 인터페이스(interface)를 지정하는 등 타입을 다룰 수 있다.*
- Mac이나 iOS 앱들은 기본적으로 데이터의 표현과 소스를 분리한다. 데이터를 표현과 소스로 나눠 처리하는 패턴은 애플이 데이터의 표현을 처리하기 위한 클래스를 제공할 때 대단히 유용하다.
  - 데이터의 저장 방식을 전적으로 사용자에게 맡길 수 있기 때문이다.



### 데이터 테이블 만들기

~~~swift
func printTable(_ data: [[String]], withColumnLabels columnLabels: String...) {
    var firstRow = "|"
    var columnWidths = [Int]()
    for columnLabel in columnLabels {
        let columnHeader = " \(columnLabel) |"
        firstRow += columnHeader
        columnWidths.append(columnLabel.count)
    }
    print(firstRow)
    
    for row in data {
        var out = "|"
        
        for (j, item) in row.enumerated() {
            let paddingNeeded = columnWidths[j] - item.count
            let padding = repeatElement(" ", count: paddingNeeded).joined(separator: "")
            out += " \(padding)\(item) |"
        }
        print(out)
    }
}

struct Person {
    let name: String
    let age: Int
    let yearsOfExperience: Int
}

struct Department {
    let name: String
    var people = [Person]()
    
    init(name: String) {
        self.name = name
    }
    
    mutating func add(_ person: Person) {
        people.append(person)
    }
}

var department = Department(name: "Engineering")
department.add(Person(name: "Joe", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Karen", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Fred", age: 50, yearsOfExperience: 20))

printTable(data, withColumnLabels: "Employee Name", "Age", "Years of Experience")
// | Employee Name | Age | Years of Experience |
// |           Joe |  30 |                   6 |
// |         Karen |  40 |                  18 |
// |          Fred |  50 |                  20 |
~~~

- **프로토콜(protocol)은 타입이 만족시킬 인터페이스를 정의할 때 필요하다.**
  - 타입이 프로토콜을 만족시킬 때 프로토콜은 **준수(conform)** 한다고 말한다.
- printTable(_:withColumnLabels:) 함수에 필요한 인터페이스를 정의해보자.
  - 이 함수는 행과 열이 몇 개인지 알아야 하며 각 열의 제목이 무엇인지, 각 셀에 어떤 데이터를 출력해야 하는지 알아야 한다.

~~~swift
// 프로토콜 정의하기
protocol TabularDataSource {
    var numberOfRows: Int { get }
    var numberOfColumns: Int { get }
    
    func label(forColumn column: Int) -> String
    func itemFor(row: Int, column: Int) -> String
}
~~~

- 프로토콜의 문법은 구조체나 클래스를 정의하는 문법과 비슷하다. 하지만 다른 점이 있다. *계산되는 프로퍼티나 함수의 정의가 모두 생략된다는 점이다.*
- **{ get }** 문법은 프로퍼티가 읽기용이라는 뜻이다.  **{ get set }** 은 읽기/쓰기 전용 프로퍼티라는 뜻이다.
  - 프로퍼티에 { get } 을 적용했다고 해서 준수 타입에 읽기/쓰기 프로퍼티가 없다는 뜻은 되지 않는다.
  - 프로퍼티가 일기용이라는 사실만 나타낼 뿐이다.
- *프로토콜은 타입이 이런 프로퍼티와 메서드만큼은 가져야 한다는 최소 요건을 정의한다.*
- 물론 실제로는 프로토콜에 정의된 이상으로 프로퍼티와 메서드를 가질 수 있다. 다만 프로토콜에서 제시하는 요건을 만족하는 범위 내에서만 프로퍼티와 메서드를 추가로 가질 수 있다.

~~~swift
struct Department: TabularDataSource {
    var numberOfRows: Int {
        return people.count
    }
    
    var numberOfColumns: Int {
        return 3
    }
    
    func label(forColumn column: Int) -> String {
        switch column {
        case 0: return "Employee Name"
        case 1: return "Age"
        case 2: return "Years of Experience"
        default: fatalError("Invalid column!")
        }
    }
    
    func itemFor(row: Int, column: Int) -> String {
        let person = people[row]
        switch column {
        case 0: return person.name
        case 1: return String(person.age)
        case 2: return String(person.yearsOfExperience)
        default: fatalError("Invalid column!")
        }
    }
    
    let name: String
    var people = [Person]()
    
    init(name: String) {
        self.name = name
    }
    
    mutating func add(_ person: Person) {
        people.append(person)
    }
}
~~~

~~~swift
// printTable() 수정
func printTable(_ dataSource: TabularDataSource) {
    var firstRow = "|"
    var columnWidths = [Int]()
    for i in 0 ..< dataSource.numberOfColumns {
        let columnLabel = dataSource.label(forColumn: i)
        let columnHeader = " \(columnLabel) |"
        firstRow += columnHeader
        columnWidths.append(columnLabel.count)
    }
    print(firstRow)
    
    for i in 0 ..< dataSource.numberOfRows {
        var out = "|"
        
        for j in 0 ..< dataSource.numberOfColumns {
            let item = dataSource.itemFor(row: i, column: j)
            let paddingNeeded = columnWidths[j] - item.count
            let padding = repeatElement(" ", count: paddingNeeded).joined(separator: "")
            out += " \(padding)\(item) |"
        }
        print(out)
    }
}
~~~



### 프로토콜 준수

1. 어떤 타입들이 프로토콜을 준수하는가?
   - 타입은 모두 프로토콜을 준수할 수 있다. 구조체, 열거형, 클래스 모두 프로토콜을 준수할 수 있다.
2. 하나의 타입이 여러 프로토콜을 준수할 수 있는가?
   - 타입이 여러 프로토콜을 준수하는 것도 가능하다.프로토콜을 쉼표로 구분하여 여러개를 준수하도록 할 수 있다.
3. 클래스가 슈퍼클래스를 가지면서 프로토콜을 준수할 수 있는가?
   - 가능하다. 클래스에 슈퍼클래스가 있을 때는 슈퍼클래스의 이름이 먼저 오고, 그다음에 프로토콜들이 온다.



### 프로토콜 상속

- **Swift는 프로토콜의 상속(protocol inheritance)를 지원한다.**
- 어떤 프로토콜이 다른 프로토콜을 상속받으면 상속받은 프로토콜에서 준수 타입이 이 두 프로토콜에 필요한 프로퍼티와 메서드를 구현해야 한다. 클래스 상속과는 이 점이 다르다.
- 타입이 여러 프로토콜을 준수할 수 있는 것처럼 프로토콜도 여러 프로토콜을 상속받을 수 있다. 

~~~swift
protocol MyProtocol: MyOtherProtocol, CustomStringConvertible {
  // ... 조건
}
~~~



# CHAPTER 20(오류 처리)



### 오류의 범주

- 오류는 **바로잡을 수 있는(recoverable)** 것과 **바로잡지 못하는(nonrecoverable)** 것, 이렇게 크게 두 범주로 구분할 수 있다.
- 바로잡을 수 있는 오류에는 대처 준비를 해야 하는 이벤트들이 포함된다.
  1. 존재하지 않는 파일을 열려고 시도하는 것
  2. 다운된 서버와 통신하려고 시도하는 것
  3. 인터넷에 연결되지 않은 기기와 통신하려고 시도하는 것
- Swift는 바로잡을 수 있는 오류들을 처리할 수 있는 도구를 다양하게 제공하고 있다. 
  - 호출된 함수가 바로잡을 수 있는 오류로 인해 오동작한다면 그 원인을 찾아야 한다.
  - 바로잡을 수 없는 오류는 일종의 **버그** 와도 같다. 예시로는 *nil이 포함된 옵셔널의 강제 언래핑, 배열의 끝을 넘어 요소에 접근하려는 것 등이 있다.*



### 입력 문자열 분석하기

- **수식 해석의 1단계는 렉스(lex, 문자열 분석)이다.** 렉스는 입력을 일련의 토큰으로 변환하는 과정을 말한다.
- **토큰(token)은 의미를 가진 무엇이다.** 
- 렉스는 *토근화* 라고도 불린다. 컴파일러에 의미가 없던 입력을 일련의 의미 있는 토큰으로 변환하기 때문이다.

~~~swift
enum Token {
    case number(Int)
    case plus
}

class Lexer {
    let input: String
    var position: String.Index
    
    init(input: String) {
        self.input = input
        self.position = self.input.startIndex
    }
    
    func peek() -> Character? {
        guard position < input.endIndex else {
            return nil
        }
        return input[position]
    }
}
~~~

- assert(_:_:)의 첫 번째 인수는 검사할 조건이다. 이 조건이 true가 되면 아무 일도 일어나지 않는다. 하지만 false가 되면 프로그램은 두 번째 인수에 해당하는 메세지를 출력하며 디버거에서 함정에 빠지게 된다.
- assert 호출은 프로그램이 디버그 모드로 빌드된 경우에만 사용된다. **디버그 모드는 플레이그라운드에서 작업하거나 Xcode에서 프로젝트를 실행할 때 기본 값이다. 릴리스 모드는 앱을 빌드해 앱 스토어에 배보할 때 Xcode가 사용하는 모드다.** 
  - 릴리스 모드에서 앱을 빌드하면 수많은 컴파일러 최적화 기능이 활성화되고 assert() 호출은 전부 제거 된다.
  - 릴리스 모드에서도 assert()를 유지하려면 이와 같은 precondition()을 사용한다. 
  - precondition()은 릴리스 모드에서 앱이 빌드될 때 제거되지 않지만, assert()와 인수도 같고 결과도 같다.
- 그렇다면 왜 guard나 다른 오류 처리 메커니즘을 놔두고 assert()를 사용할까? 
  - assert와 그 파트너 격인 precondition()은 바로잡을 수 없는 오류를 잡아내기 위한 도구다. 
  - 입력 문자열의 endIndex를 지나 진행하려고 하면 디버거가 endIndex에서 멈춰 오류를 찾아낼 수 있도록 하기 때문이다.
  - asssert()를 사용하지 않으려면 렉서의 위치를 앞당기지 않거나 오류를 출력하지 말아야 하는데, 이는 둘 다 말이 안된다.

~~~swift
enum Token {
    case number(Int)
    case plus
}

class Lexer {
    let input: String
    var position: String.Index
    
    enum Error: Swift.Error {
        case invalidCharacter(Character)
    }
    
    init(input: String) {
        self.input = input
        self.position = self.input.startIndex
    }
    
    func getNumber() -> Int {
        var value = 0
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0"..."9":
                let digitValue = Int(String(nextCharacter))
                value = 10 * value + (digitValue ?? 0)
                advance()
            default:
                return value
            }
        }
        return value
    }
    
    func peek() -> Character? {
        guard position < input.endIndex else {
            return nil
        }
        return input[position]
    }
    
    func advance() {
        assert(position < input.endIndex, "Cannot advance past endIndex!")
        position = input.index(after: position)
    }
    
    func lex() throws -> [Token] {
        var tokens = [Token]()
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0"..."9":
                let value = getNumber()
                tokens.append(.number(value))
            case "+":
                advance()
            case " ":
                advance()
            default:
                throw Lexer.Error.invalidCharacter(nextCharacter)
            }
        }
        return tokens
    }
}

func evaluate(_ input: String) {
    print("Evaluating: \(input)")
    let lexer = Lexer(input: input)
    
    do {
        let tokens = try lexer.lex()
        print("Lexer output: \(tokens)")
    } catch {
        print("An error occured : \(error)")
    }
}
~~~



### 오류 잡아내기

- Swift가 오류를 처리하기 위해 사용하는 제어 구조에는 **do/catch** 가 있다.

  - *이 안에 적어도 하나의 try 구문이 do 에 있어야 한다.*

- ~~~swift
  do {
          let tokens = try lexer.lex()
          print("Lexer output: \(tokens)")
      } catch {
          print("An error occured : \(error)")
      }
  ~~~

- do는 새 영역(scope)를 만드는데, 이는 마치 if와 흡사하다. do 영역 안에서는 print()를 호출하는 것처럼 평상시대로 코드를 작성하면 된다.

- 또한 throws가 지정된 함수나 메서드로 호출할 수 있다. 이런 호출은 try 키워드로 지정해야 한다.

- do 블록 끝에는 catch 블록을 둔다. do 블록 안에 있는 try 호출 중에서 어느 하나라도 오류를 던지면 catch 블록이 실행되고, 이때 던져진 오류의 값은 상수 error에 바인딩 된다.



### Token 배열 파싱하기

- 입력 문자열을 Token 배열로 변환해 보겠다. Token 배열의 요소는 .number 또는 .plus 둘 중 하나이다. 그 다음은 전달받은 일련의 토큰을 판단하는 파서를 작성하는 단계이다.
  - 예를 들어 [.number(5), .plus, ,number(3)]이 전달되면 8이 출력되어야 한다.

~~~swift
func getNextToken() -> Token? {
        guard position < tokens.count else {
            return nil
        }
        let token = tokens[position]
        position += 1
        return token
    }
    
    func getNumber() throws -> Int {
        guard let token = getNextToken() else {
            throw Parser.Error.unexpectedEndOfInput
        }
        
        switch token {
        case .number(let value):
            return value
        case .plus:
            throw Parser.Error.invalidToken(token)
        }
    }
~~~

- getNumber() 메서드에 **thorws -> Int** 라는 표현이 보인다. 
  - 따라서 이 메서드가 보통은 Int를 리턴하지만, 오류를 던질 수도 있는 함수임을 알 수 있다.

~~~swift
func parse() throws -> Int {
        var value = try getNumber()
        
        while let token = getNextToken() {
            switch token {
            case .plus:
                let nextNumber = try getNumber()
                value += nextNumber
                
            case .number:
                throw Parser.Error.invalidToken(token)
            }
        }
        return value
    }
~~~

- getNumber() 호출에 try 키워드를 붙여 놓았는데, Swift에서는 getNumber()가 던지기용 메서드여야 하기 때문이다. 하지만 do/catch 블록을 사용하지는 않았다. 
  - 여기서는 do 블록 없이도 try를 사용할 수 있는 이유는 무엇일까?
    - Swift에서 try가 붙은 모든 호출은 '오류를 처리' 한다. 오류 처리는 evaluate() 처럼 오류를 잡아내는 것이다. 
    - 하지만 오류를 처리할 수 있는 다른 방법이 또 있다. *던지는 것이다.*
    - parse()는 그 자체로 던지기용 메서드이므로 do/catch 없이도 try 호출을 그 안에 넣을 수 있다. try 호출이 실패하면 parse()가 오류를 다시 던진다.



### 눈 가리고 아웅 격으로 오류 처리하기

- **오류를 던질 수도 있는 함수를 호출할 때는, try를 붙였고, try를 붙여 호추하는 코드는 do/catch 블록 안이나 함수 자체에 throws가 붙은 함수안에 들어가야 한다.**

- **try!!** 키워드는 옵셔널의 강제 언래핑처럼 강제 키워드인 try!를 적용하면 오류가 던져질 때 프로그램이 함정에 빠진다.

  - 우리는 앞에서 강제 언래핑과 암묵적으로 언래핑된 옵셔널은 피하는 것이 좋다고 했다.
  - *try! 는 그보다 훨씬 더 피해야 한다고 권고한다.*

- 오류가 일어날 때 함정에 빠지지 않고 오류를 무시할 수 있는 try 종류가 있다.

  - **try?** 로 던지기용 함수를 호출하면 함수가 리턴하던 타입이 무엇이든 그 타입의 옵셔널을 리턴값으로 가져온다.
  - 다시 말해 guard 같은 것을 사용해야 그 옵셔널이 정말로 값을 가지고 있는지 확인할 수 있다.

- ~~~swift
  guard let tokens = try? lexer.lex() else {
  	print("Lexing failed.")
  	return
  }
  ~~~

  - try?는 try! 보다 나쁘지는 않지만 사용하지 않는 것이 좋다. 
    - try?로 함수를 호출하면 nil을 리턴받을 상황에 대비해야 한다. 
    - **일반적으로는 catch에서 오류를 처리하는 것이 더 낫다. 함수가 던진 오류에 접근해야 하기 때문이다.**



## Swift의 오류 처리 철학

- Swift는 안전하고 읽기 쉬운 코드를 지향하도록 설계되었고, 그 오류 처리 체계도 마찬가지다. 잘못될 수도  있는 함수에는 **throws** 가 예외 없이 붙어야 한다. 그래야 함수의 타입을 보고 잠재적인 오류를 처리해아 하는지 알 수 있다.
- Swift는 또한 잘못될 수도 있는 함수를 호출할 때 try를 붙이도록 하고 있다. 이렇게 하면 함수 호출에 try가 붙어 있으면 처리해야 하는 잠재적인 오류의 원인이 있다는 것을 알 수 있다. 이와 반대로 try가 없다면 처리해야 할 오류가 없다는 의미이다.
- C++나 자바를 사용해 봤다면 Swift의 오류 처리 방식과 예외 기반 오류 처리 방식의 차이에 유의해야 한다.
  - Swift가 try, catch, throw 같은 용어를 사용한다고 해서 오류 처리를 구현하는 데 예외를 적용하지는 않는다.
  - 함수에 throws를 붙이면 그 함수의 리턴 타입을 원래 리턴하던 타입과 상관없이 '원래 리턴하던 타입이나 Error프로토콜의 인스턴스'로 효과적인 변경이 이뤄진다.
- Swift에는 오류 처리 철학이 한 가지 더 있다.
  - throws가 붙은 함수는 자신이 던질 오류의 종류를 나타내지 않는다는 것이다.
    1. 우선 함수가 던질 수도 있는 잠재적 Error들을 함수의 API가 변경되지 않아도 언제든 추가할 수 있다.
    2. catch로 오류를 처리할 때는 알 수 었는 오류를 처리할 준비를 갖춰 놓아야 한다.



# CHAPTER 21(확장)

- Swift의 표준 라이브러리 제공되는 특정 타입, 예를 들어 Double을 빈번하게 사용하여 애플리케이션을 개발한다고 할때, 만일 Double 타입이 우리의 앱에서 어떻게 사용되는지에 맞춰 추가 기능을 지원한다면 개발 과정이 더욱 수월해질 것이다.
- *Swift는 **확장(extension)** 이라는 기능을 제공하여 기존 타입에 새로운 기능을 추가할 수 있도록 하고 있다.*
  - 이를 바탕으로 구조체, 열거형, 클래스를 확장하는 것이 가능하다.
- 타입에 확장을 적용할 수 있는 경우는 다음과 같다.
  1. 계산형 프로퍼티
  2. 새 이니셜라이저
  3. 프로토콜 준수
  4. 내장 타입



### 기존 타입 확장하기

~~~swift
typealias Velocity = Double

extension Velocity {
    var kph: Velocity { return self * 1.60934 }
    var mph: Velocity { return self }
}
~~~

- **typealias** 키워드를 적용하면 Double 타입의 새 이름을 Velocity로 정의할 수 있다. 이를 사용하여 독해력을 높일 수 있다.

- *extension 키워드는 Velocity 타입을 확장하겠다는 표시다.*

~~~swift
// 프로토콜 
protocol Vehicle {
    var topSpeed: Velocity { get }
    var numberOfDoors: Int { get }
    var hasFlatbed: Bool { get }
}
~~~

- Vehicle은 세 개의 프로퍼티를 선언했다. 각 프로퍼티는 준수하는 타입을 요건으로 게터를 구현한다. 
  - 이 프로토콜을 준수하는 타입은 자동차의 일반적 특징을 나타내는 이 프로퍼티들을 반드시 제공해야 한다.



### 직접 만든 타입 확장하기

~~~SWIFT
// Car 구조체 정의
struct Car {
    let make: String
    let model: String
    let year: Int
    let color: String
    let nickname: String
    var gasLevel: Double {
        willSet {
            precondition(newValue <= 1.0 && newValue >= 0.0 , "New value must be between 0 and 1.")
        }
    }
}
~~~

- 확장은 서로 관련된 기능을 한데 묶을 수 있는 뛰어난 구조를 제공한다. 
  - **서로 관련된 기능을 하나의 확장으로 묶으면 코드의 가독성이 높아지고 유지 보수도 수월해진다.** 
  - 또한, 이 패턴은 그 인터페이스를 정돈하는 데도 도움이 된다.

~~~swift
extension Car: Vehicle {
    var topSpeed: Velocity { return 100 }
    var numberOfDoors: Int { return 4 }
    var hasFlatbed: Bool { return false }
}
~~~

- 프로토콜의 필수 프로퍼티를 확장의 몸체 코드에서 구현했다.



### 확장이 적용된 이니셜라이저 추가하기

- 앞에서 구조체에는 이니셜라이저를 직접 정의하지 않으면 멤버와이즈 이니셜라이저가 제공된다고 했다. 
- 구조체의 멤버와이즈 이니셜라이저를 그대로 사용하면서도 새 이니셜라이저를 작성하려면 타입에 확장을 적용하고 이니셜라이저를 추가해야 한다.

~~~swift
extension Car {
    init(make: String, model: String, year: Int) {
        self.init(make: make, model: model, year: year, color: "Black": nickname: "N\A", gasLevel: 1.0)
    }
}

var c = Car(make: "Ford", model: "Fusion", year: 2013)
~~~

- **Car의 새 확장에는 인스턴스의 make, model, year에 해당하는 인수만 받는 이니셜라이저가 추가되었다.**
- 이 새 이니셜라이저 인수들은 Car 구조체에 공짜 멤버와이즈 이니셜라이저로 전달되고, 없는 인수에는 기본값이 전달된다. 
  - 이 두 이니셜라이저를 함께 사용하면 Car 타입의 인스턴스는 프로퍼티 모두가 값을 가질 수 있다



### 중첩된 타입과 확장

- Swift의 확장은 중첩된 타입을 기존 타입에 추가할 수 있다. 예를 들어 열거형을 Car 구조체에 추가해 자동차의 종류를 구분할 수 있다.

~~~swift
extension Car {
    enum Kind {
        case coupe, sedan
    }
    
    var kind: Kind {
        if numberOfDoors == 2 {
            return .coupe
        } else {
            return .sedan
        }
    }
}
~~~



### 함수의 확장

- 기존 타입을 함수에 지정하는 데 확장을 사용할 수도 있다.

~~~swift
extension Car {
    mutating func emptyGas(by amount: Double) {
        precondition(amount <= 1 && amount > 0 , "Amount to remove must be between 0 and 1.")
        gasLevel -= amount
    }
    
    mutating func fillGas() {
        gasLevel = 1.0
    }
}
~~~

- 이 두 함수에는 mutating 키워드는 왜 붙었을까?
  - Car 타입은 구조체다. 따라서 어떤 함수가 구조체에서 프로퍼티의 값을 변경하기 위해서는 반드시 mutating 키워드가 붙어야 한다.



# CHAPTER 22(제네릭)

- 지금까지 작성했던 프로퍼티와 함수드른 모두 Int, String, Monster 등 구체적인 타입을 바탕으로 동작했다.
  - Swift에서는 어떤 타입이든 배열을 만들어 담을 수 있다.
  - Swift의 내장 타입, 예를 들어 [Int]나 [Double] 등으로 구성되는 배열뿐만 아니라 [Monster] 등 직접 만든 타입으로 구성되는 배열도 만들 수 있다.
- 그렇다면 Array는 어떻게 구현되어 있을까? 그리고 다양한 타입이 같은 방식으로 동작하는 코드는 어떻게 작성할 수 있을까?
  - **제네릭(Generic)** 을 이용하면 된다.



### 제네릭 데이터 구조

~~~swift
// Stack을 제네릭으로 만들어보기

struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
}
~~~

- **Element** 라는 일종의 **자리 맡기(placeholder) 타입** 을 Stack의 선언 부분에 추가했다.
- Swift에서 제네릭을 선언하려면 **< >** 를 사용하여 묶고 타입 이름을 바로 표기한다.
  - 부등호 기호 사이의 이름은 플레이스 홀더 타입인 <Element> 를 나타낸다. 
  - Element라는 플레이스 홀더 타입은 Stack 구조체 안에서 사용이 가능하며, 그곳에 구체적인 타입이 적용된다. 따라서 프로퍼티 선언 부분을 포함하여 리턴값 타입 자리를 Element로 대체하면 된다.
- Element 자리 맡기 타입이 실제로 어떤 타입으로 대체될지는 명시하지 않았기 때문에 컴파일러가 플레이스스홀더 타입을 구체적인 타입으로 대체하는 과정을 가리켜 **구체화(specialization)** 이라고 한다.

~~~swift
// intStack 구체화하기
var intStack = Stack<Int>()
~~~



### 제니릭 함수와 메서드

~~~swift
func myMap<T,U>(_ items: [T], _ f: (T) -> (U)) -> [U] {
    var result = [U]()
    for item in items {
        result.append(f(item))
    }
    return result
}
~~~

- 기존의 구체적인 타입 대신 T와 U가 있는데, 이들 말고도 사용할 수 있는 기호나 구두점이 더 있다. T와 U는 플레이스 홀더 타입 두 가지를 각각 선언한다.

<img width="1000" alt="스크린샷 2020-06-11 오후 12 18 35" src="https://user-images.githubusercontent.com/48345308/84341284-b02bbd00-abdd-11ea-8183-64b1cc6ff3dd.png">

~~~swift
let strings = ["one","minho","three"]
let stringsLength = myMap(strings) { $0.count }
print(stringsLength) // [3, 5, 5]
~~~

- myMap(_: _:)에 전달된 클로저는 items 배열에 포함된 타입과 일치하는 인수를 받아야 하지만 리턴값은 타입은 어떤 것도 될 수 있다.

- 메서드도 제네릭이 될 수 있다. 심지어는 이미 제네릭인 타입 안에서도 가능하다.
- 위의 myMap() 함수는 배열에만 동작하지만, Stack을 매핑할 수도 있다

~~~swift
struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
    
	  // **
    func map<U>(_ f: (Element) -> U) -> Stack<U> {
        var mappedItems = [U]()
        for item in items {
            mappedItems.append(f(item))
        }
        return Stack<U>(items: mappedItems)
    }
}
~~~



## 타입 제한 조건

 

​     

 

