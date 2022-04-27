//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 우롱차, 민성 on 2022/04/27.
//

import Foundation

class Bank {
    private let clientQueue: Queue<Client>
    private let clerkCount: Int
    private let spendingTimeForAClient: Float
    private var totalWorkingTime: Float = 0
    private var finishedClientCount = 0
    
    private lazy var bankClerkQueue: Queue<BankClerk> = {
        return makeBankClerkQueue()
    }()
    
    init(clientQueue: Queue<Client>, clerkCount: Int, spendingTimeForAClient: Float) {
        self.clientQueue = clientQueue
        self.clerkCount = clerkCount
        self.spendingTimeForAClient = spendingTimeForAClient
    }
    
    private func makeBankClerkQueue() -> Queue<BankClerk> {
        var bankClerkQueue = Queue<BankClerk>()
        
        for _ in 1...clerkCount {
            let bankClerk = BankClerk(isWorking: false)
            bankClerkQueue.enqueue(bankClerk)
        }
        
        return bankClerkQueue
    }
}
