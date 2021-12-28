//
//  AgeDistancePrefncVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit
import RangeSeekSlider

class AgeDistancePrefncVC: UIViewController {

    @IBOutlet weak var btnAny: ButtonCustom!
    @IBOutlet weak var btnHundred: ButtonCustom!
    @IBOutlet weak var btnFifty: ButtonCustom!
    @IBOutlet weak var btnTen: ButtonCustom!
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        rangeSlider.delegate = self
        
        RegisterModel.shared.age_preference_to = "\(rangeSlider.selectedMaxValue)"
        RegisterModel.shared.age_preference_from = "\(rangeSlider.selectedMinValue)"
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        if RegisterModel.shared.max_distance == ""{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kDistance, control: ["OK"], topController: self)
        }else{
            pushToEthicity()
        }
        
    }
    
    func pushToEthicity(){
        let vc = EthnicityVC.getVC(.Main)
        self.push(vc)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnTenAction(_ sender: Any) {
        selectedVw(selectedBtn: btnTen)
        RegisterModel.shared.max_distance = Distance.Ten.rawValue
    }
    @IBAction func btnFiftyAction(_ sender: Any) {
        selectedVw(selectedBtn: btnFifty)
        RegisterModel.shared.max_distance = Distance.Fifty.rawValue
    }
    @IBAction func btnHundredAction(_ sender: Any) {
        selectedVw(selectedBtn: btnHundred)
        RegisterModel.shared.max_distance = Distance.Hundred.rawValue
    }
    @IBAction func btnAnyAction(_ sender: Any) {
        selectedVw(selectedBtn: btnAny)
        RegisterModel.shared.max_distance = Distance.any.rawValue
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

// MARK: - RangeSeekSliderDelegate
extension AgeDistancePrefncVC: RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === rangeSlider {
            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
            RegisterModel.shared.age_preference_to = "\(maxValue)"
            RegisterModel.shared.age_preference_from = "\(minValue)"
        }
    }

    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
        
    }

    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}
