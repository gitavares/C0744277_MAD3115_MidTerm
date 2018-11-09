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
        guard let monthlyUsage = Double(txtMonthlyUsage.text!) else { return }
        guard let offPeak = Double(txtTmuOffPeak.text!) else { return }
        guard let midPeak = Double(txtTmuMidPeak.text!) else { return }
        guard let onPeak = Double(txtTmuOnPeak.text!) else { return }
        guard let oespCredit = Double(txtOespCredit.text!) else { return }
        guard var contractRate = Double(txtContractRate.text!) else { return }
        
        if pricePlan == 0 {
            let totalPeak = offPeak + midPeak + onPeak
            if totalPeak != 100 {
                let alert = UIAlertController(title: "Error", message: "The total Peak (Off, Mid and On) must be 100%", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            if monthlyUsage <= 600 {
                contractRate = 7.7
            } else {
                contractRate = 8.9
            }
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
    
    @IBAction func segPricingAction(_ sender: UISegmentedControl) {
        if segPricingPlan.selectedSegmentIndex == 1 {
            lblTmuText.isHidden = true
            lblTmuOffPeak.isHidden = true
            lblTmuMidPeak.isHidden = true
            lblTmuOnPeak.isHidden = true
            txtTmuOffPeak.isHidden = true
            txtTmuMidPeak.isHidden = true
            txtTmuOnPeak.isHidden = true
            lblTmuPerc1.isHidden = true
            lblTmuPerc2.isHidden = true
            lblTmuPerc3.isHidden = true
            txtContractRate.isEnabled = true
        } else {
            lblTmuText.isHidden = false
            lblTmuOffPeak.isHidden = false
            lblTmuMidPeak.isHidden = false
            lblTmuOnPeak.isHidden = false
            txtTmuOffPeak.isHidden = false
            txtTmuMidPeak.isHidden = false
            txtTmuOnPeak.isHidden = false
            lblTmuPerc1.isHidden = false
            lblTmuPerc2.isHidden = false
            lblTmuPerc3.isHidden = false
            txtContractRate.isEnabled = false
        }
    }
    
    
    @IBAction func btnLogout(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

}
