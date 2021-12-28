//
//  HomeModel.swift
//  Smirk
//
//  Created by Surinder kumar on 26/12/21.
//

import Foundation

class HomeModel : Codable{
    
    var id : Int = 0
    var card_image : String = ""
    
    func setData(dict:[String:Any]){
        id = dict["id"] as? Int ?? 0
        card_image = dict["card_image"] as? String ?? ""
    }
    
}
