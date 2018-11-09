//
//  ContractPriceViewController.swift
//  C0744277_MAD3115_MidTerm
//
//  Created by Giselle Tavares on 09/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit

class ContractPriceViewController: UIViewController {
    
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblMeterNumber: UILabel!
    @IBOutlet weak var lblKwhPeak: UILabel!
    @IBOutlet weak var lblKwhPeakValue: UILabel!
    @IBOutlet weak var lblGlobalValue: UILabel!
    @IBOutlet weak var lblDeliveryValue: UILabel!
    @IBOutlet weak var lblChargesValue: UILabel!
    @IBOutlet weak var lblTotalChargesValue: UILabel!
    @IBOutlet weak var lblOespValue: UILabel!
    @IBOutlet weak var lblHSTValue: UILabel!
    @IBOutlet weak var lblRebateValue: UILabel!
    @IBOutlet weak var lblTotalAmountValue: UILabel!
    
    let current = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Retail Contract Price"
        
        // header
        lblAccountNumber.text = "\(current.customerData.accountNumber ?? "")"
        lblMeterNumber.text = "\(current.customerData.meterNumber ?? "")"
        
        // Calcs
        let monthlyUsage = current.customerData.monthlyUsage!
        let contractRate = current.customerData.contractRate!
        let oespCredit = current.customerData.oespCredit
        
        lblKwhPeak.text = "\(monthlyUsage) kWh @ \(contractRate) ¢/kWh"
        let totalRetailContractRate = (monthlyUsage * contractRate) / 100
        lblKwhPeakValue.text = String(format: "%.2f", totalRetailContractRate)
        
        let globalAdjustment = totalRetailContractRate * 0.2 // 20%
        lblGlobalValue.text = String(format: "%.2f", globalAdjustment)
        
        let deliveryCharge = totalRetailContractRate * 0.3 // 30%
        lblDeliveryValue.text = String(format: "%.2f", deliveryCharge)
        
        let regulatoryCharge = totalRetailContractRate * 0.032 // 3.2%
        lblChargesValue.text = String(format: "%.2f", regulatoryCharge)
        
        var totalElectricityCharge = totalRetailContractRate + deliveryCharge + regulatoryCharge
        lblTotalChargesValue.text = "$\(String(format: "%.2f", (totalElectricityCharge)))"
        
        if oespCredit! > 0 {
            totalElectricityCharge -= oespCredit!
            lblOespValue.text = "(-$\(String(format: "%.2f", (oespCredit!))))"
        } else {
            lblOespValue.text = "$\(String(format: "%.2f", (oespCredit!)))"
        }
        
        let totalHST = totalElectricityCharge * 0.13 // 13%
        lblHSTValue.text = String(format: "%.2f", (totalHST))
        
        let totalProvincialRebate = (totalElectricityCharge + totalHST) * 0.08 //8%
        lblRebateValue.text = "(-$\(String(format: "%.2f", (totalProvincialRebate))))"
        
        let totalAmount = (totalElectricityCharge + totalHST) - totalProvincialRebate
        lblTotalAmountValue.text = "$\(String(format: "%.2f", (totalAmount)))"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
