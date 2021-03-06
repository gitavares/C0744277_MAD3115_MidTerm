//
//  TimeOfUseViewController.swift
//  C0744277_MAD3115_MidTerm
//
//  Created by Giselle Tavares on 09/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit

class TimeOfUseViewController: UIViewController {
    
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblMeterNumber: UILabel!
    @IBOutlet weak var lblOffPeakValue: UILabel!
    @IBOutlet weak var lblMidPeakValue: UILabel!
    @IBOutlet weak var lblOnPeakValue: UILabel!
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
        
        navigationItem.title = "Time of Use"
        
        // header
        lblAccountNumber.text = "\(current.customerData.accountNumber ?? "")"
        lblMeterNumber.text = "\(current.customerData.meterNumber ?? "")"
        
        // Peaks
        let monthlyUsage = current.customerData.monthlyUsage
        let offPeak = current.customerData.offPeak
        let midPeak = current.customerData.midPeak
        let onPeak = current.customerData.onPeak
        let oespCredit = current.customerData.oespCredit
        
        let valueOffPeak = calculatePeak(monthlyUsage: monthlyUsage!, peakPercent: offPeak!, ratePeak: 6.5)
        let valueMidPeak = calculatePeak(monthlyUsage: monthlyUsage!, peakPercent: midPeak!, ratePeak: 9.4)
        let valueOnPeak = calculatePeak(monthlyUsage: monthlyUsage!, peakPercent: onPeak!, ratePeak: 13.2)
        let totalPeaks = valueOffPeak + valueMidPeak + valueOnPeak
        
        lblOffPeakValue.text = String(format: "%.2f", valueOffPeak)
        lblMidPeakValue.text = String(format: "%.2f", valueMidPeak)
        lblOnPeakValue.text = String(format: "%.2f", valueOnPeak)
        
        let deliveryCharge = totalPeaks * 0.3 // 30%
        lblDeliveryValue.text = String(format: "%.2f", deliveryCharge)
        
        let regulatoryCharge = totalPeaks * 0.032 // 3.2%
        lblChargesValue.text = String(format: "%.2f", regulatoryCharge)
        
        var totalElectricityCharge = totalPeaks + deliveryCharge + regulatoryCharge
        lblTotalChargesValue.text = "$\(String(format: "%.2f", (totalElectricityCharge)))"
        
        if oespCredit! > 0 {
            totalElectricityCharge -= oespCredit!
            lblOespValue.text = "(-$\(String(format: "%.2f", (oespCredit!))))"
        } else {
            lblOespValue.text = "$\(String(format: "%.2f", (oespCredit!)))"
        }
        
        let totalHST = totalElectricityCharge * 0.13 //13%
        lblHSTValue.text = String(format: "%.2f", (totalHST))
        
        let totalProvincialRebate = (totalElectricityCharge + totalHST) * 0.08 //8%
        lblRebateValue.text = "(-$\(String(format: "%.2f", (totalProvincialRebate))))"
        
        let totalAmount = (totalElectricityCharge + totalHST) - totalProvincialRebate
        lblTotalAmountValue.text = "$\(String(format: "%.2f", (totalAmount)))"
        
        if current.customerData.contractRate == 0 {
            btnRetailContract.isHidden = true
        }
        
    }
    
    func calculatePeak(monthlyUsage: Double, peakPercent: Double, ratePeak: Double) -> Double {
        
        var peak = ((monthlyUsage * (peakPercent/100)) * ratePeak) / 100
        return peak
    }

}
