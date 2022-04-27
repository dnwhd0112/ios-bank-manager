//
//  BankClerk.swift
//  BankManagerConsoleApp
//
//  Created by 우롱차, 민성 on 2022/04/27.
//

import Foundation

struct BankClerk {
    // var isWorking: Bool
    unowned private var bank: Bank

    init(bank: Bank) {
        self.bank = bank
    }

    func work() {

    }
}
