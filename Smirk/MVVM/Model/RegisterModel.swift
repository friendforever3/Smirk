//
//  RegisterModel.swift
//  Smirk
//
//  Created by Surinder kumar on 22/12/21.
//

import Foundation

class RegisterModel : NSObject{
    
    public static var shared = RegisterModel()
    
    private override init() {}
    
    var laugh_id : String = ""
    var matching_id : String = ""
    var max_distance : String = ""
    var mobile : String = ""
    var full_name : String = ""
    var gender : String = "" //0->male/1->female
    var date_of_birth : String = ""
    var about : String = ""
    var profile_photo = Data()
    var age_preference_from : String = ""
    var age_preference_to : String = ""
    var ethnicities = [Int]()
    var preferences = [Int]()
    var images = [Data]()
    var shows = [Int]()
    
}
