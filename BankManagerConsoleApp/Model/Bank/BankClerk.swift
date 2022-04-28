//
//  BankClerk.swift
//  BankManagerConsoleApp
//
//  Created by 우롱차, 민성 on 2022/04/27.
//

import Foundation

struct BankClerk {
    private enum BankClerkMessage {
        static let startWorkMessage = "고객 업무 시작"
        static let finishedWorkMessage = "고객 업무 완료"
    }
    // var isWorking: Bool
    unowned private var bank: Bank
    private let spendingTimeForAClient: Double

    init(bank: Bank, spendingTimeForAClient: Double) {
        self.bank = bank
        self.spendingTimeForAClient = spendingTimeForAClient
    }

    func work() {
        while true {
            guard let client = bank.allocateCustomer() else {
                return
            }

            print("\(client.WaitingNumber) \(BankClerkMessage.startWorkMessage)")
            let usecondsTimeForAClient = useconds_t(spendingTimeForAClient * 1000000)
            usleep(usecondsTimeForAClient)
            bank.updateWorkData(spendedTime: spendingTimeForAClient)
            print("\(client.WaitingNumber) \(BankClerkMessage.finishedWorkMessage)")
        }
    }
}
