//
//  Queue.swift
//  BankManagerConsoleApp
//
//  Created by 우롱차, 민성 on 2022/04/26.
//

import Foundation

struct Queue<T> {
    private var linkedList = LinkedList<T>()

    mutating func enqueue(_ element: T) {
        linkedList.appendTail(element: element)
    }

    mutating func dequeue() -> T? {
        return linkedList.removeFirst()
    }

    mutating func clear() {
        linkedList.clear()
    }

    func peek() -> T? {
        return linkedList.headData()
    }

    func isEmpty() -> Bool {
        return linkedList.isNil
    }
}
