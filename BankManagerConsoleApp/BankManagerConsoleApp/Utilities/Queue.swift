//
//  Queue.swift
//  BankManagerConsoleApp
//
//  Created by 재재, 나별 on 2022/06/28.
//

protocol Queue {
    associatedtype Element
    var isEmpty: Bool { get }
    var peek: Element? { get }
    
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
    mutating func clear()
}
