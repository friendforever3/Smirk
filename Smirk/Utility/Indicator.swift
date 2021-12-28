//
//  Indicator.swift
//  Gospel
//
//  Created by Surinder kumar on 21/09/21.
//

import Foundation
import NVActivityIndicatorView
import UIKit
import MBProgressHUD


class Indicator : UIViewController,NVActivityIndicatorViewable{
   static var shared = Indicator()
    let size = CGSize(width:35, height: 35)
    func start(_ msg : String){
        startAnimating(size, message: msg, messageFont: UIFont.systemFont(ofSize: 18), type: NVActivityIndicatorType.lineSpinFadeLoader, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.1), textColor: .black)
    }
    
    func stop(){
        stopAnimating()
    }
    
}

/*
class MBProgressVw : UIViewController{
    static var shared = MBProgressVw()
   func showIndicator(withTitle title: String, and Description:String) {
      let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
      Indicator.label.text = title
      Indicator.isUserInteractionEnabled = false
      Indicator.detailsLabel.text = Description
      Indicator.show(animated: true)
   }
   func hideIndicator() {
      MBProgressHUD.hide(for: self.view, animated: true)
   }
}

*/
