//
//  LauncherViewController.swift
//  C0744277_MAD3115_MidTerm
//
//  Created by Giselle Tavares on 08/11/18.
//  Copyright © 2018 Giselle Tavares. All rights reserved.
//

import UIKit

class LauncherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = sb.instantiateViewController(withIdentifier: "mainVC")
            self.present(loginVC, animated: true, completion: nil)
        }
    }

}
