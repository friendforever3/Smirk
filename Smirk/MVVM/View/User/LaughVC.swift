//
//  LaughVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit

class LaughVC: UIViewController {
    
    
    @IBOutlet weak var btnJustFrnd: ButtonCustom!
    @IBOutlet weak var btnRomantic: ButtonCustom!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        let vc = GenderPrefernceVC.getVC(.Main)
        self.push(vc)
    }
    
    @IBAction func btnRomanticAction(_ sender: Any) {
        selectedVw(selectedBtn: btnRomantic)
    }
    
    @IBAction func btnJustFrndAction(_ sender: Any) {
        selectedVw(selectedBtn: btnJustFrnd)
    }
    
    func selectedVw(selectedBtn:ButtonCustom){
        
        let btns = [btnJustFrnd,btnRomantic]

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
