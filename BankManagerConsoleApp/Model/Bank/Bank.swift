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

    private let depositBankClerkCount = 1
    private let loanBankClerkCount = 2

    private var clientQueue: Queue<Client>
    private var totalWorkingTime: Double = 0
    private var finishedClientCount = 0
    private var loanDispatchSemaphore: DispatchSemaphore
    private var depositDispatchSemaphore: DispatchSemaphore

    static var dispatchQueue = DispatchQueue(label: "순차")

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
        loanDispatchSemaphore = DispatchSemaphore(value: loanBankClerkCount)
        depositDispatchSemaphore = DispatchSemaphore(value: depositBankClerkCount)
    }

    func startWork() {
        let group = DispatchGroup()
        while clientQueue.isEmpty() == false {
            guard let client = clientQueue.dequeue() else {
                return
            }
            Bank.dispatchQueue.async(group: group) {
                switch client.workType {
                case .deposit:
                    self.depositDispatchSemaphore.wait()
                    DispatchQueue.global().async(group: group) {
                        let depositBankClerk = DepositBankClerk()
                        depositBankClerk.work(client: client) {updateData in
                            self.updateWorkData(spendedTime: updateData)
                        }
                        self.depositDispatchSemaphore.signal()
                    }
                    case .loan:
                    self.loanDispatchSemaphore.wait()
                    DispatchQueue.global().async(group: group) {
                        let loanBankClerk = LoanBankClerk()
                        loanBankClerk.work(client: client) { updateData in
                            self.updateWorkData(spendedTime: updateData)
                        }
                        self.loanDispatchSemaphore.signal()

                    }
                }
            }
        }
        group.wait()
        print(String(format: Constant.finishMessageFormat), finishedClientCount, totalWorkingTime)
    }

    private func updateWorkData(spendedTime: Double) {
        totalWorkingTime += spendedTime
        finishedClientCount += 1
    }
}
