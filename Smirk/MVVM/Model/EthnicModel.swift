//
//  EthnicModel.swift
//  Smirk
//
//  Created by Surinder kumar on 22/12/21.
//

import Foundation

class EthenicModel : Codable{
    
    var id : Int = 0
    var title : String = ""
    var status : Int = 0
    var show_icon : String = ""
    
    func setData(dict:[String:Any]){
        id = dict["id"] as? Int ?? 0
        title = dict["title"] as? String ?? ""
        status = dict["status"] as? Int ?? 0
        show_icon = dict["show_icon"] as? String ?? ""
    }
    
}
