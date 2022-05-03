//
//  BankClerk.swift
//  BankManagerConsoleApp
//
//  Created by 우롱차, 민성 on 2022/04/28.
//

import Foundation

protocol BankClerk {
    var spendingTimeForClient: Double { get }
    var workType: WorkType { get }
    func work(client: Client)
}

extension BankClerk {
    var startWorkMessage: String { return "고객 업무 시작" }
    var finishedWorkMessage: String { return "고객 업무 완료" }

    func work(client: Client) {
        print("\(client.workType) \(client.waitingNumber) \(startWorkMessage)")
        let usecondsTimeForAClient = useconds_t(spendingTimeForClient * 1000000)
        usleep(usecondsTimeForAClient)
        print("\(client.workType) \(client.waitingNumber) \(finishedWorkMessage)")
    }
}
