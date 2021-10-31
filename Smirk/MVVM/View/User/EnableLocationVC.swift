//
//  EnableLocationVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit

class EnableLocationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnEnableAction(_ sender: Any) {
        let vc = SmirkTabbarVC.getVC(.SmirkTabbar)
        self.push(vc)
    }
    
    @IBAction func btnSkipAction(_ sender: Any) {
        let vc = SmirkTabbarVC.getVC(.SmirkTabbar)
        self.push(vc)
    }
    
}
