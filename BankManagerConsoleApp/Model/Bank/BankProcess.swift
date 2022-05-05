//
//  BankProcess.swift
//  BankManagerConsoleApp
//
//  Created by 우롱차, 민성 on 2022/04/28.
//

import Foundation

struct BankProcess {
    private enum Constant {
        static let clientCount = 10
    }

    private var bank: Bank

    init() {
        bank = Bank()
    }

    mutating func addClientQueue() {
        var clientQueue = Queue<Client>()
        for waitingNumber in 1...Constant.clientCount {
            clientQueue.enqueue(Client(waitingNumber: waitingNumber))
        }
//      bank.처리하는메서드(clientQueue)
    }
}
