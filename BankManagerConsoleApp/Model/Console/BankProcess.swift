//
//  BankProcess.swift
//  BankManagerConsoleApp
//
//  Created by 우롱차, 민성 on 2022/04/28.
//

import Foundation

struct BankProcess {
    private enum Constant {
        static let minClientCount = 10
        static let maxClientCount = 30
    }

    private var bank: Bank

    init() {
        var clientQueue = Queue<Client>()
        let randomClientCount = Int.random(in: Constant.minClientCount...Constant.maxClientCount)

        for waitingNumber in 1...randomClientCount {
            if waitingNumber % 5 == 0 {
                clientQueue.enqueue(Client(waitingNumber: waitingNumber, workType: WorkType.deposit))
            } else {
                clientQueue.enqueue(Client(waitingNumber: waitingNumber, workType: WorkType.loan))
            }
        }
        bank = Bank(clientQueue: clientQueue)
    }

    func start() {
        bank.startWork()
    }
}
