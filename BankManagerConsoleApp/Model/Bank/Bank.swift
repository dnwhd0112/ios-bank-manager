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
        static let loanBankClerkCount = 1
        static let depositBankClerkCount = 2
    }

    private var finishedClientCount = 0
    private let loanSemaphore = DispatchSemaphore(value: Constant.loanBankClerkCount)
    private let depositSemaphore = DispatchSemaphore(value: Constant.depositBankClerkCount)
    private let group = DispatchGroup()
    private let bankUpdateDispatchQueue = DispatchQueue(label: "BankUpdate")
    weak var delegate: ViewControllerDelegate?


    func startWork(clientQueue: inout Queue<Client>) {
        while clientQueue.isEmpty() == false {
            guard let client = clientQueue.dequeue() else {
                return
            }

            switch client.taskType {
            case .deposit:
                delegate?.addWaitingClientLabel(text: "\(client.waitingNumber)고객, \(client.taskType.text)", color: .black)
                DispatchQueue.global().async(group: group) {
                    self.depositSemaphore.wait()
                    DispatchQueue.main.sync {
                        self.delegate?.addWorkingClientLabel(text: "\(client.waitingNumber)고객, \(client.taskType.text)", color: .black)
                    }
                    let depositBankClerk = DepositBankClerk(delegate: self)
                    depositBankClerk.work(client: client)
                    DispatchQueue.main.sync {
                        self.delegate?.removeWorkingClientLable(text: "\(client.waitingNumber)고객, \(client.taskType.text)", color: .black)
                    }
                    self.depositSemaphore.signal()
                }
            case .loan:
                delegate?.addWaitingClientLabel(text: "\(client.waitingNumber)고객, \(client.taskType.text)", color: .purple)
                DispatchQueue.global().async(group: group) {
                    self.loanSemaphore.wait()
                    DispatchQueue.main.sync {
                        self.delegate?.addWorkingClientLabel(text: "\(client.waitingNumber)고객, \(client.taskType.text)", color: .purple)
                    }
                    let loanBankClerk = LoanBankClerk(delegate: self)
                    loanBankClerk.work(client: client)
                    DispatchQueue.main.sync {
                        self.delegate?.removeWorkingClientLable(text: "\(client.waitingNumber)고객, \(client.taskType.text)", color: .purple)
                    }
                    self.loanSemaphore.signal()
                }
            }
        }
    }
}

extension Bank: BankDelegate {
    func updateWorkData() {
        bankUpdateDispatchQueue.async(group: group) {
            self.finishedClientCount += 1
        }
    }
}
