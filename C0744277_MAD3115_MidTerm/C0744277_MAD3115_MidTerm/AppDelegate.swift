//
//  AppDelegate.swift
//  C0744277_MAD3115_MidTerm
//
//  Created by Giselle Tavares on 08/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var customerData: ElectricityBill!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func setCurrentCustomerData(customerData: ElectricityBill)
    {
        self.customerData = customerData
    }
    
    func getCurrentCustomerData() -> ElectricityBill
    {
        return self.customerData
    }
    
    func setMonthlyUsage(monthlyUsage: Double) {
        self.customerData.monthlyUsage  = monthlyUsage
    }
    
    func getMonthlyUsage() -> Double {
        return self.customerData.monthlyUsage ?? 0
    }
    
    func setPricePlan(pricePlan: Int) {
        self.customerData.pricePlan  = pricePlan
    }
    
    func getPricePlan() -> Int {
        return self.customerData.pricePlan ?? 0
    }
    
    func setOffPeak(offPeak: Double) {
        self.customerData.offPeak  = offPeak
    }
    
    func getOffPeak() -> Double {
        return self.customerData.offPeak ?? 0
    }
    
    func setMidPeak(midPeak: Double) {
        self.customerData.midPeak  = midPeak
    }
    
    func getMidPeak() -> Double {
        return self.customerData.midPeak ?? 0
    }
    
    func setOnPeak(onPeak: Double) {
        self.customerData.onPeak  = onPeak
    }
    
    func getOnPeak() -> Double {
        return self.customerData.onPeak ?? 0
    }
    
    func setOespCredit(oespCredit: Double) {
        self.customerData.oespCredit  = oespCredit
    }
    
    func getOespCredit() -> Double {
        return self.customerData.oespCredit ?? 0
    }
    
    func setContractRate(contractRate: Double) {
        self.customerData.contractRate  = contractRate
    }
    
    func getContractRate() -> Double {
        return self.customerData.contractRate ?? 0
    }
    
    func setTotalBillPrice(totalBillPrice: Double) {
        self.customerData.totalBillPrice  = totalBillPrice
    }
    
    func getTotalBillPrice() -> Double {
        return self.customerData.totalBillPrice ?? 0
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

