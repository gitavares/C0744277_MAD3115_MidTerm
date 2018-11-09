//
//  Customer.swift
//  C0744277_MAD3115_MidTerm
//
//  Created by Giselle Tavares on 08/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import Foundation

struct ElectricityBill {
    var name: String?
    var accountNumber: String?
    var meterNumber: String?
    var monthlyUsage: Double?
    var pricePlan: Int?
    var offPeak: Double?
    var midPeak: Double?
    var onPeak: Double?
    var oespCredit: Double?
    var contractRate: Double?
    var totalBillPrice: Double?
    
    init(
        name: String,
        accountNumber: String,
        meterNumber: String,
        monthlyUsage: Double,
        pricePlan: Int,
        offPeak: Double,
        midPeak: Double,
        onPeak: Double,
        oespCredit: Double,
        contractRate: Double,
        totalBillPrice: Double) {
        
        self.name = name
        self.accountNumber = accountNumber
        self.meterNumber = meterNumber
        self.monthlyUsage = monthlyUsage
        self.pricePlan = pricePlan
        self.offPeak = offPeak
        self.midPeak = midPeak
        self.onPeak = onPeak
        self.oespCredit = oespCredit
        self.contractRate = contractRate
        self.totalBillPrice = totalBillPrice
    }
}
