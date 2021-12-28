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
        LocationManager.shared.initialiseLoc()
    }
    
    @IBAction func btnSkipAction(_ sender: Any) {
        registerUser()
    }
    
    func pushToHome(){
        let vc = SmirkTabbarVC.getVC(.SmirkTabbar)
        self.push(vc)
    }
}

//MARK: API
extension EnableLocationVC{
    
    func registerUser(){
        
        UserVM.shared.registerUser { [weak self] (success,msg) in
            
            if success{
                self?.pushToHome()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KError, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
            
        }
        
    }
}
