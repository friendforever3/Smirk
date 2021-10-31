//
//  AgeDistancePrefncVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit

class AgeDistancePrefncVC: UIViewController {

    @IBOutlet weak var btnAny: ButtonCustom!
    @IBOutlet weak var btnHundred: ButtonCustom!
    @IBOutlet weak var btnFifty: ButtonCustom!
    @IBOutlet weak var btnTen: ButtonCustom!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        let vc = EthnicityVC.getVC(.Main)
        self.push(vc)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
   
    
    @IBAction func btnTenAction(_ sender: Any) {
        selectedVw(selectedBtn: btnTen)
    }
    @IBAction func btnFiftyAction(_ sender: Any) {
        selectedVw(selectedBtn: btnFifty)
    }
    @IBAction func btnHundredAction(_ sender: Any) {
        selectedVw(selectedBtn: btnHundred)
    }
    @IBAction func btnAnyAction(_ sender: Any) {
        selectedVw(selectedBtn: btnAny)
    }
    
    func selectedVw(selectedBtn:ButtonCustom){
        
        let btns = [btnTen,btnFifty,btnHundred,btnAny]

        for btn in btns{
            if btn == selectedBtn{
                btn?.backgroundColor = .white
                btn?.setTitleColor(UIColor(named: "blackColor"), for: .normal)
            }else{
                btn?.backgroundColor = .clear
                btn?.borderColor = .white
                btn?.setTitleColor(.white, for: .normal)
            }
        }
        
    }
    
}
