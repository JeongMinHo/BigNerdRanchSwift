//
//  main.swift
//  Ch20
//
//  Created by jeongminho on 2020/06/05.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

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
        guard let tokens = try? lexer.lex() else {
            print("Lexing failed.")
            return
        }
        print("Lexer output: \(tokens)")
    } catch Lexer.Error.invalidCharacter(let character) {
        print("Input contained an invalid character : \(character)")
    } catch {
        print("An error occured : \(error)")
    }
}

//evaluate("10 + 3 + 5")
//evaluate("1 + 2 + abcd")

class Parser {
    
    enum Error: Swift.Error {
        case unexpectedEndOfInput
        case invalidToken(Token)
    }
    
    let tokens: [Token]
    var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
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
}
