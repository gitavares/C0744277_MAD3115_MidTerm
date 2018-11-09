//
//  ViewController.swift
//  C0744277_MAD3115_MidTerm
//
//  Created by Giselle Tavares on 08/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.txtUsername.text = "gitavares"
        self.txtPassword.text = "123456"
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        if let path = Bundle.main.path(forResource: "BillCalculator", ofType: "plist") {
            if let content = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
                
                let users = content["User"] as! [AnyObject]
                
                var userLogin  = false
                
                for user in users {
                    let username = user["username"] as! String
                    let password = user["password"] as! String
                    
                    if username == txtUsername.text && password == txtPassword.text {
                        let firstName = user["firstName"] as! String
                        let lastName = user["lastName"] as! String
                        let accountNumber = user["accountNumber"] as! String
                        let meterNumber = user["meterNumber"] as! String
                        
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        let calculatorVC = sb.instantiateViewController(withIdentifier: "calculatorVC")
                        
                        let customerData = ElectricityBill(name: "\(firstName) \(lastName)", accountNumber: accountNumber, meterNumber: meterNumber, monthlyUsage: 750, pricePlan: 0, offPeak: 65, midPeak: 17, onPeak: 18, oespCredit: 0, contractRate: 8.9, totalBillPrice: 0)
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.setCurrentCustomerData(customerData: customerData)
                        
                        self.navigationController?.pushViewController(calculatorVC, animated: true)
                        
                        userLogin = true
                    }
                }
                
                if !userLogin {
                    // alert for incorrect username/password
                    let alert = UIAlertController(title: "Error", message: "Username/Password incorrect", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
        
            }
            
        }
        
    }
    
    
    


}

