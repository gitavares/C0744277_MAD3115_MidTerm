//
//  CalculatorViewController.swift
//  C0744277_MAD3115_MidTerm
//
//  Created by Giselle Tavares on 08/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblMeterNumber: UILabel!
    @IBOutlet weak var txtMonthlyUsage: UITextField!
    @IBOutlet weak var segPricingPlan: UISegmentedControl!
    @IBOutlet weak var lblTmuText: UILabel!
    @IBOutlet weak var lblTmuOffPeak: UILabel!
    @IBOutlet weak var lblTmuMidPeak: UILabel!
    @IBOutlet weak var lblTmuOnPeak: UILabel!
    @IBOutlet weak var txtTmuOffPeak: UITextField!
    @IBOutlet weak var txtTmuMidPeak: UITextField!
    @IBOutlet weak var txtTmuOnPeak: UITextField!
    @IBOutlet weak var lblTmuPerc1: UILabel!
    @IBOutlet weak var lblTmuPerc2: UILabel!
    @IBOutlet weak var lblTmuPerc3: UILabel!
    @IBOutlet weak var txtOespCredit: UITextField!
    @IBOutlet weak var txtContractRate: UITextField!
    @IBOutlet weak var viewPeaks: UIView!
    
    
    let current = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        navigationItem.title = "Calculator"
        
        // header
        lblName.text = "\(current.customerData.name ?? "")"
        lblAccountNumber.text = "\(current.customerData.accountNumber ?? "")"
        lblMeterNumber.text = "\(current.customerData.meterNumber ?? "")"
        
        // form
        txtMonthlyUsage.text = "\(current.customerData.monthlyUsage ?? 750)"
        segPricingPlan.selectedSegmentIndex = current.customerData.pricePlan ?? 0
        txtTmuOffPeak.text = "\(current.customerData.offPeak ?? 65)"
        txtTmuMidPeak.text = "\(current.customerData.midPeak ?? 17)"
        txtTmuOnPeak.text = "\(current.customerData.onPeak ?? 18)"
        txtOespCredit.text = "\(current.customerData.oespCredit ?? 0)"
        txtContractRate.text = "\(current.customerData.contractRate ?? 0)"
        txtContractRate.allowsEditingTextAttributes = false
    }
    
    
    @IBAction func btnCalculate(_ sender: UIButton) {
        let pricePlan = segPricingPlan.selectedSegmentIndex
        var message = "All fields must be filled and with numbers only"
        guard let monthlyUsage = Double(txtMonthlyUsage.text!) else { return alertMessage(message: message) }
        guard let offPeak = Double(txtTmuOffPeak.text!) else { return alertMessage(message: message) }
        guard let midPeak = Double(txtTmuMidPeak.text!) else { return alertMessage(message: message) }
        guard let onPeak = Double(txtTmuOnPeak.text!) else { return alertMessage(message: message) }
        guard let oespCredit = Double(txtOespCredit.text!) else { return alertMessage(message: message) }
        guard let contractRate = Double(txtContractRate.text!) else { return alertMessage(message: message) }
        
        if pricePlan == 0 {
            let totalPeak = offPeak + midPeak + onPeak
            if totalPeak != 100 {
                message = "The total Peak (Off, Mid and On) must be 100%"
                alertMessage(message: message)
            }
        }
        
        if monthlyUsage < 0 || oespCredit < 0 || contractRate < 0 {
            message = "The values must be $0 or more"
            alertMessage(message: message)
        }
        
        current.setMonthlyUsage(monthlyUsage: monthlyUsage)
        current.setPricePlan(pricePlan: pricePlan)
        current.setOffPeak(offPeak: offPeak)
        current.setMidPeak(midPeak: midPeak)
        current.setOnPeak(onPeak: onPeak)
        current.setOespCredit(oespCredit: oespCredit)
        current.setContractRate(contractRate: contractRate)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        if pricePlan == 0 {
            let timeOfUseVC = sb.instantiateViewController(withIdentifier: "timeOfUseVC")
            self.navigationController?.pushViewController(timeOfUseVC, animated: true)
        } else {
            let tieredVC = sb.instantiateViewController(withIdentifier: "tieredVC")
            self.navigationController?.pushViewController(tieredVC, animated: true)
        }
        
    }
    
    func alertMessage(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func segPricingAction(_ sender: UISegmentedControl) {
        if segPricingPlan.selectedSegmentIndex == 1 {
            viewPeaks.isHidden = true
        } else {
            viewPeaks.isHidden = false
        }
    }
    
    
    @IBAction func btnLogout(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

}
