//
//  PaymentParser.swift
//  ZWallet
//
//  Created by loj on 12.04.19.
//  Copyright © 2019 XMR Systems LLC. All rights reserved.
//

import Foundation


internal protocol PaymentParserProtocol {
    func process(uri: String) -> Result<Payment, InvalidPaymentError>
}


internal class PaymentParser: PaymentParserProtocol {

    func process(uri: String) -> Result<Payment, InvalidPaymentError> {
        #warning("implement parsing of ZEC URI")

        let payment = Payment()
        payment.amount = 2208_000_000_000
        payment.targetAddress = "target.22of8.ch"
        payment.memo = uri
        return .success(payment)

//        return .failure(.badUri)
    }
}
