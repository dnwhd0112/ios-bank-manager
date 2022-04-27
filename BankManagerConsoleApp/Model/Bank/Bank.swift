//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 우롱차, 민성 on 2022/04/27.
//

import Foundation

class Bank {
    private var clientQueue: Queue<Client>
    private let clerkCount: Int
    private let spendingTimeForAClient: Double
    private(set) var totalWorkingTime: Double = 0
    private(set) var finishedClientCount = 0
    private lazy var bankClerkQueue: Queue<BankClerk> = {
        return makeBankClerkQueue()
    }()

    init(clientQueue: Queue<Client>, clerkCount: Int, spendingTimeForAClient: Double) {
        self.clientQueue = clientQueue
        self.clerkCount = clerkCount
        self.spendingTimeForAClient = spendingTimeForAClient
    }

    private func makeBankClerkQueue() -> Queue<BankClerk> {
        var bankClerkQueue = Queue<BankClerk>()

        for _ in 1...clerkCount {
            let bankClerk = BankClerk(bank: self,
                                      spendingTimeForAClient: spendingTimeForAClient)
            bankClerkQueue.enqueue(bankClerk)
        }

        return bankClerkQueue
    }

    func startWork() {
        while bankClerkQueue.isEmpty() == false {
            let bankClerk = bankClerkQueue.dequeue()
            bankClerk?.work()
        }
    }

    func updateWorkData() {
        totalWorkingTime += spendingTimeForAClient
        finishedClientCount += 1
    }

    func allocateCustomer() -> Client? {
        return clientQueue.dequeue()
    }
}
