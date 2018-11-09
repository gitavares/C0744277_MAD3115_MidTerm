//
//  TieredViewController.swift
//  C0744277_MAD3115_MidTerm
//
//  Created by Giselle Tavares on 09/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit

class TieredViewController: UIViewController {
    
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblMeterNumber: UILabel!
    @IBOutlet weak var lblKwhPeak: UILabel!
    @IBOutlet weak var lblKwhPeakValue: UILabel!
    @IBOutlet weak var lblDeliveryValue: UILabel!
    @IBOutlet weak var lblChargesValue: UILabel!
    @IBOutlet weak var lblTotalChargesValue: UILabel!
    @IBOutlet weak var lblOespValue: UILabel!
    @IBOutlet weak var lblHSTValue: UILabel!
    @IBOutlet weak var lblRebateValue: UILabel!
    @IBOutlet weak var lblTotalAmountValue: UILabel!
    
    @IBOutlet weak var btnRetailContract: UIButton!

    let current = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Tiered"
        
        // header
        lblAccountNumber.text = "\(current.customerData.accountNumber ?? "")"
        lblMeterNumber.text = "\(current.customerData.meterNumber ?? "")"
        
        // Calcs
        let monthlyUsage = current.customerData.monthlyUsage!
        let contractRate = current.customerData.contractRate!
        let oespCredit = current.customerData.oespCredit
        var contractRateMonthlyBased: Double?
        
        if monthlyUsage <= 600 {
            contractRateMonthlyBased = 7.7
        } else {
            contractRateMonthlyBased = 8.9
        }
        
        lblKwhPeak.text = "\(monthlyUsage) kWh @ \(contractRateMonthlyBased!) ¢/kWh"
        let totalTieredRate = (monthlyUsage * contractRateMonthlyBased!) / 100
        lblKwhPeakValue.text = String(format: "%.2f", totalTieredRate)
        
        let deliveryCharge = (totalTieredRate * 30) / 100
        lblDeliveryValue.text = String(format: "%.2f", deliveryCharge)
        
        let regulatoryCharge = (totalTieredRate * 3.2) / 100
        lblChargesValue.text = String(format: "%.2f", regulatoryCharge)
        
        var totalElectricityCharge = totalTieredRate + deliveryCharge + regulatoryCharge
        lblTotalChargesValue.text = "$\(String(format: "%.2f", (totalElectricityCharge)))"
        
        if oespCredit! > 0 {
            totalElectricityCharge -= oespCredit!
            lblOespValue.text = "(-$\(String(format: "%.2f", (oespCredit!))))"
        } else {
            lblOespValue.text = "$\(String(format: "%.2f", (oespCredit!)))"
        }
        
        let totalHST = (totalElectricityCharge * 13) / 100
        lblHSTValue.text = String(format: "%.2f", (totalHST))
        
        let totalProvincialRebate = ((totalElectricityCharge + totalHST) * 8) / 100
        lblRebateValue.text = "(-$\(String(format: "%.2f", (totalProvincialRebate))))"
        
        let totalAmount = (totalElectricityCharge + totalHST) - totalProvincialRebate
        lblTotalAmountValue.text = "$\(String(format: "%.2f", (totalAmount)))"
        
        if contractRate == 0 {
            btnRetailContract.isHidden = true
        }
        
    }

}
