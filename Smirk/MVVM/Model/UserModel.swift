//
//  UserModel.swift
//  Smirk
//
//  Created by Surinder kumar on 26/12/21.
//

import Foundation


class UserModel : Codable{
    
    var about : String = ""
    var age_preference_from : String = ""
    var age_preference_to : String = ""
    var age_range : String = ""
    var date_of_birth : String = ""
    var email : String = ""
    var ethnicity_preference : String = ""
    var full_name : String = ""
    var gender : Int = 0
    var id : Int = 0
    var is_registered : Int = 0
    var is_verified : String = ""
    var latitude : String = ""
    var longitude : String = ""
    var laugh_id : String = ""
    var matching_id : String = ""
    var max_distance : String = ""
    var mobile : String = ""
    var name : String = ""
    var profile_photo : String = ""
    var show_id : String = ""
    var token : String = ""
    var laugh = EthenicModel()
    var matching = EthenicModel()
    var user_shows = [EthenicModel]()
    var user_preferences = [EthenicModel]()
    var user_ethinicities = [EthenicModel]()
    var profile_image = [ProfileImageModel]()
    
    func setData(dict:[String:Any]){
        
        about = dict["about"] as? String ?? ""
        age_preference_from = dict["age_preference_from"] as? String ?? ""
        age_preference_to = dict["age_preference_to"] as? String ?? ""
        age_range = dict["age_range"] as? String ?? ""
        date_of_birth = dict["date_of_birth"] as? String ?? ""
        email = dict["email"] as? String ?? ""
        ethnicity_preference = dict["ethnicity_preference"] as? String ?? ""
        full_name = dict["full_name"] as? String ?? ""
        gender = dict["gender"] as? Int ?? 0
        id = dict["id"] as? Int ?? 0
        is_registered = dict["is_registered"] as? Int ?? 0
        is_verified = dict["is_verified"] as? String ?? ""
        latitude = dict["latitude"] as? String ?? ""
        longitude = dict["longitude"] as? String ?? ""
        laugh_id = dict["laugh_id"] as? String ?? ""
        matching_id = dict["matching_id"] as? String ?? ""
        max_distance = dict["max_distance"] as? String ?? ""
        mobile = dict["mobile"] as? String ?? ""
        name = dict["name"] as? String ?? ""
        profile_photo = dict["profile_photo"] as? String ?? ""
        show_id = dict["show_id"] as? String ?? ""
        
        if dict["token"] as? String ?? "" != ""{
           token = dict["token"] as? String ?? ""
        }else{
            token = UtilityManager.shared.userDecodedDetail().token
        }
        
        if let laugh = dict["laugh"] as? [String:Any]{
            self.laugh.setData(dict: laugh)
        }
        
        if let matching = dict["matching"] as? [String:Any]{
            self.matching.setData(dict: matching)
        }
        
        if let user_shows = dict["user_shows"] as? [[String:Any]]{
            self.user_shows.removeAll()
            for value in user_shows{
                if let show = value["show"] as? [String:Any]{
                    let obj = EthenicModel()
                    obj.setData(dict: show)
                    self.user_shows.append(obj)
                }
            }
        }
        
        if let user_preferences = dict["user_preferences"] as? [[String:Any]]{
            self.user_preferences.removeAll()
            for value in user_preferences{
                if let preference = value["preference"] as? [String:Any]{
                    let obj = EthenicModel()
                    obj.setData(dict: preference)
                    self.user_preferences.append(obj)
                }
            }
        }
        
        if let user_ethinicities = dict["user_ethinicities"] as? [[String:Any]]{
            self.user_ethinicities.removeAll()
            for value in user_ethinicities{
                if let ethnicity = value["ethnicity"] as? [String:Any]{
                    let obj = EthenicModel()
                    obj.setData(dict: ethnicity)
                    self.user_ethinicities.append(obj)
                }
            }
        }
        
        if let profile_image = dict["profile_image"] as? [[String:Any]]{
            self.profile_image.removeAll()
            for value in profile_image{
                let obj = ProfileImageModel()
                obj.setData(dict: value)
                self.profile_image.append(obj)
                
            }
        }

        
    }
    
    
}


class ProfileImageModel:Codable{
    var id : Int = 0
    var user_id : Int = 0
    var profile_pic : String = ""
    var data : Data?
    
    func setData(dict:[String:Any]){
        self.id = dict["id"] as? Int ?? 0
        self.user_id = dict["user_id"] as? Int ?? 0
        self.profile_pic = dict["profile_pic"] as? String ?? ""
    }
    
}
