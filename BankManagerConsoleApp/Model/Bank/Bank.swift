//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 우롱차, 민성 on 2022/04/28.
//

import Foundation

final class Bank {
    private enum Constant {
        static let finishMessageFormat = "업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 %d명이며, 총 업무시간은 %.2f초입니다."
    }

    private let depositBankClerkCount = 2
    private let loanBankClerkCount = 1

    private var clientQueue: Queue<Client>
    private var totalWorkingTime: Double = 0
    private var finishedClientCount = 0
    private lazy var loanDispatchSemaphore = DispatchSemaphore(value: loanBankClerkCount)
    private lazy var depositDispatchSemaphore = DispatchSemaphore(value: depositBankClerkCount)

    private lazy var depositBankClerkQueue: Queue<BankClerk> = {
        var bankClerkQueue = Queue<BankClerk>()

        for _ in 1...depositBankClerkCount {
            let bankClerk = DepositBankClerk()
            bankClerkQueue.enqueue(bankClerk)
        }

        return bankClerkQueue
    }()

    private lazy var loanBankClerkQueue: Queue<BankClerk> = {
        var bankClerkQueue = Queue<BankClerk>()

        for _ in 1...loanBankClerkCount {
            let bankClerk = LoanBankClerk()
            bankClerkQueue.enqueue(bankClerk)
        }

        return bankClerkQueue
    }()

    init(clientQueue: Queue<Client>) {
        self.clientQueue = clientQueue
    }

    func startWork() {
        while clientQueue.isEmpty() == false {
            guard let client = clientQueue.dequeue() else {
                return
            }
            DispatchQueue.global().async {
                switch client.workType {
                case .deposit:
                    self.depositDispatchSemaphore.wait()
                    guard let depositBankClerk = self.depositBankClerkQueue.dequeue() else {
                        return
                    }
                    depositBankClerk.work(client: client)
                    self.updateWorkData(spendedTime: depositBankClerk.spendingTimeForClient)
                    self.depositBankClerkQueue.enqueue(depositBankClerk)
                    self.depositDispatchSemaphore.signal()
                case .loan:
                    self.loanDispatchSemaphore.wait()
                    guard let loanBankClerk = self.loanBankClerkQueue.dequeue() else {
                        return
                    }
                    loanBankClerk.work(client: client)
                    self.updateWorkData(spendedTime: loanBankClerk.spendingTimeForClient)
                    self.depositBankClerkQueue.enqueue(loanBankClerk)
                    self.loanDispatchSemaphore.signal()
                }
            }
        }

        print(String(format: Constant.finishMessageFormat), finishedClientCount, totalWorkingTime)
    }

    private func updateWorkData(spendedTime: Double) {
        totalWorkingTime += spendedTime
        finishedClientCount += 1
    }
}
