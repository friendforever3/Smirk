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
        if RegisterModel.shared.laugh_id == ""{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kLaughWith, control: ["OK"], topController: self)
        }else{
            pushToGenderPerf()
        }
    }
    
    func pushToGenderPerf(){
        let vc = GenderPrefernceVC.getVC(.Main)
        self.push(vc)
    }
    
    @IBAction func btnRomanticAction(_ sender: Any) {
        selectedVw(selectedBtn: btnRomantic)
        RegisterModel.shared.laugh_id = LaughWith.RomanticInterest.rawValue
    }
    
    @IBAction func btnJustFrndAction(_ sender: Any) {
        selectedVw(selectedBtn: btnJustFrnd)
        RegisterModel.shared.laugh_id = LaughWith.justFriend.rawValue
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
