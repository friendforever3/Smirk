//
//  GenderPrefernceVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit

class GenderPrefernceVC: UIViewController {
    @IBOutlet weak var btnMale: ButtonCustom!
    @IBOutlet weak var btnFemale: ButtonCustom!
    @IBOutlet weak var btnNonBinary: ButtonCustom!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        let vc = AgeDistancePrefncVC.getVC(.Main)
        self.push(vc)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
   
    @IBAction func btnMaleAction(_ sender: Any) {
        selectedVw(selectedBtn: btnMale)
    }
    
    @IBAction func btnFemaleAction(_ sender: Any) {
        selectedVw(selectedBtn: btnFemale)
    }
    
    @IBAction func btnNonBinaryAction(_ sender: Any) {
        selectedVw(selectedBtn: btnNonBinary)
    }
    
    func selectedVw(selectedBtn:ButtonCustom){
        
        let btns = [btnMale,btnFemale,btnNonBinary]

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
