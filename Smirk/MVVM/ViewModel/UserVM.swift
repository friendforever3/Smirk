//
//  UserVM.swift
//  Smirk
//
//  Created by Surinder kumar on 22/12/21.
//

import UIKit

class UserVM: NSObject {
    
    public static let shared = UserVM()
    
    var ethnicListArray = [EthenicModel]()
    var preferEthicArray = [EthenicModel]()
    var shows = [EthenicModel]()
    
    var objUserDetailModel = UserModel()
    
    private override init() {}
    
    
    func sendOtpApi(mobileNo:String,completion:@escaping completionHandler){
        let param = ["mobile":mobileNo,"device_id":AppConstant.kGetDeviceId,"notification_token":AppConstant.kDeviceToken,"device_type":AppConstant.kDevice]
        
        serverRequest(url: APIConstant.kSandvboxBaseUrl + APIConstant.kLogin, param: param, method: .post, header: nil) { [weak self] (response, statusCode,errorMsg) in
            if response["code"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
            
        }
    }
    
    func submitOtpApi(mobileNo:String,otp:String,completion:@escaping completionHandler){
        let param = ["mobile":mobileNo,"otp":otp]
        
        serverRequest(url: APIConstant.kSandvboxBaseUrl + APIConstant.kVerifyOTP, param: param, method: .post, header: nil) { [weak self] (response, statusCode,errorMsg) in
            if response["code"] as? Int == 200{
                
                if let data = response["data"] as? [String:Any]{
                    let obj = UserModel()
                    obj.setData(dict: data)
                    UtilityManager.shared.userDataEncode(obj)
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
            
        }
    }
    
    func retrieveList(completion:@escaping completionHandler){
        
        serverRequest(url: APIConstant.kSandvboxBaseUrl + APIConstant.kRetrieveList, param: nil, method: .get, header: nil) { [weak self] (response, statusCode,errorMsg) in
         
            if response["code"] as? Int == 200{
                if let data = response["data"] as? [String:Any]{
                    if let ethnicities = data["ethnicities"] as? [[String:Any]]{
                        self?.ethnicListArray.removeAll()
                        for elmnt in ethnicities{
                            let obj = EthenicModel()
                            obj.setData(dict: elmnt)
                            self?.ethnicListArray.append(obj)
                        }
                    }
                    
                    if let ethnicities = data["preferences"] as? [[String:Any]]{
                        self?.preferEthicArray.removeAll()
                        for elmnt in ethnicities{
                            let obj = EthenicModel()
                            obj.setData(dict: elmnt)
                            self?.preferEthicArray.append(obj)
                        }
                    }
                    
                    if let shows = data["shows"] as? [[String:Any]]{
                        self?.shows.removeAll()
                        for elmnt in shows{
                            let obj = EthenicModel()
                            obj.setData(dict: elmnt)
                            self?.shows.append(obj)
                        }
                    }
                    
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
            
        }
    }
    
    func registerUser(completion:@escaping completionHandler){
        
        let param = ["laugh_id":RegisterModel.shared.laugh_id,"matching_id":RegisterModel.shared.matching_id,"max_distance":RegisterModel.shared.max_distance,"full_name":RegisterModel.shared.full_name,"gender":RegisterModel.shared.gender,"date_of_birth":RegisterModel.shared.date_of_birth,"about":RegisterModel.shared.about,"age_preference_from":RegisterModel.shared.age_preference_from,"age_preference_to":RegisterModel.shared.age_preference_to,"ethnicities":RegisterModel.shared.ethnicities,"preferences":RegisterModel.shared.preferences,"shows":RegisterModel.shared.shows,"mobile":RegisterModel.shared.mobile,"latitude":LocationManager.shared.getLoc().lat,"longitude":LocationManager.shared.getLoc().long] as [String : Any]
        
        
        uploadDataToServerHandler(url: APIConstant.kSandvboxBaseUrl + APIConstant.kRegister, param: param, imgData: RegisterModel.shared.images, fileName: "profile_pic", header: nil) { (response) in
            
           // print("respinse register:-",response)
            if response?["code"] as? Int == 200{
                completion(true,response?["message"] as? String ?? "")
            }else{
                completion(false,response?["message"] as? String ?? "")
            }
        }
        
    }
    
    func getUserDetail(completion:@escaping completionHandler){
        
        let param = ["id":"\(UtilityManager.shared.userDecodedDetail().id)"]
        
        serverRequest(url: APIConstant.kSandvboxBaseUrl + APIConstant.kUserDetail, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { [weak self] (response, statusCode,errorMsg) in
            
            if response["code"] as? Int == 200{
                
                if let data = response["data"] as? [String:Any]{
                    self?.objUserDetailModel.setData(dict: data)
                    UtilityManager.shared.userDataEncode(self?.objUserDetailModel ?? UserModel())
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func updateProfileInfo(name:String,dob:String,gender:String,about:String,show:[Int],completion:@escaping completionHandler){
        
        let param = ["full_name":name,"date_of_birth":dob,"gender":gender,"about":about,"shows":show] as [String : Any]
        
        uploadDataToServerHandler(url: APIConstant.kSandvboxBaseUrl + APIConstant.kUpdateProfile, param: param, imgData: nil, fileName: "", header: UtilityManager.shared.getHeaderToken()) { (response) in
            
           // print("respinse register:-",response)
            if response?["code"] as? Int == 200{
                completion(true,response?["message"] as? String ?? "")
            }else{
                completion(false,response?["message"] as? String ?? "")
            }
        }
        
    }
    
    func updateProfileSetting(laugh_id:String,interestedIn:String,rangeFrom:String,rangeTo:String,maxDist:String,preEthncity:[Int],completion:@escaping completionHandler){
        
        let param = ["laugh_id":laugh_id,"matching_id":interestedIn,"max_distance":maxDist,"age_preference_from":rangeFrom,"age_preference_to":rangeTo,"preferences":preEthncity] as [String : Any]
        
        uploadDataToServerHandler(url: APIConstant.kSandvboxBaseUrl + APIConstant.kUpdateProfile, param: param, imgData: nil, fileName: "", header: UtilityManager.shared.getHeaderToken()) { (response) in
            
           // print("respinse register:-",response)
            if response?["code"] as? Int == 200{
                completion(true,response?["message"] as? String ?? "")
            }else{
                completion(false,response?["message"] as? String ?? "")
            }
        }
        
        
    }
    
    
    func uploadProfileImages(imgData:[Data],fileName:String,completion:@escaping completionHandler){
        
        uploadDataToServerHandler(url: APIConstant.kSandvboxBaseUrl + APIConstant.kUpdateProfile, param: nil, imgData: imgData, fileName: fileName, header: UtilityManager.shared.getHeaderToken()) { (response) in
            
           // print("respinse register:-",response)
            if response?["code"] as? Int == 200{
                completion(true,response?["message"] as? String ?? "")
            }else{
                completion(false,response?["message"] as? String ?? "")
            }
        }
        
    }
    
    func uploadProfileImage(imgData:Data,fileName:String,completion:@escaping completionHandler){
        
        uploadDataToServerHandlerSingle(url: APIConstant.kSandvboxBaseUrl + APIConstant.kUpdateImage, param: nil, imgData: imgData, fileName: fileName, header: UtilityManager.shared.getHeaderToken()) { (response) in
            
           // print("respinse register:-",response)
            if response?["code"] as? Int == 200{
                completion(true,response?["message"] as? String ?? "")
            }else{
                completion(false,response?["message"] as? String ?? "")
            }
        }
        
    }
    
    
    //MARK: Ethenic Data
    func removeEthnicListArray(){
        ethnicListArray.removeAll()
    }
    func getEthnicListArrayCount()->Int{
        return ethnicListArray.count
    }
    
    func getEthnicListCell(indexPath:IndexPath)->(title:String,id:String){
        return (title:ethnicListArray[indexPath.row].title,id:"\(ethnicListArray[indexPath.row].id)")
    }

    //MARK: Prefernce Ethenic Data
    func getPrefEthnicListArrayCount()->Int{
        return preferEthicArray.count
    }
    
    func getPrefEthnicListCell(indexPath:IndexPath)->(title:String,id:String){
        return (title:preferEthicArray[indexPath.row].title,id:"\(preferEthicArray[indexPath.row].id)")
    }
    
    func getPrefEthnicListArray()->[EthenicModel]{
        return preferEthicArray
    }
    
    //MARK: shows Data
    func getShowsListArrayCount()->Int{
        return shows.count
    }
    
    func getShowsListCell(indexPath:IndexPath)->(title:String,id:String,Icon:String){
        return (title:shows[indexPath.row].title,id:"\(shows[indexPath.row].id)",Icon:shows[indexPath.row].show_icon)
    }
    
    
    //MARK: User Detail
    func getLaughId()->String{
        return objUserDetailModel.laugh_id
    }
    
    func getInterestedId()->String{
        return objUserDetailModel.matching_id
    }
    
    func getAgeRange()->(from:String,To:String){
        return (from:objUserDetailModel.age_preference_from,To:objUserDetailModel.age_preference_to)
    }
    
    func getMaxDistance()->String{
        return objUserDetailModel.max_distance
    }
    
    func getPrefEthncity()->[EthenicModel]{
        return objUserDetailModel.user_preferences
    }
    
    func appendPrefEthncity(_ insert:EthenicModel){
        
    }
    
    func removePrefEthncity(id:Int){
        objUserDetailModel.user_preferences.removeAll(where: {$0.id == id})
    }
    
    func getProfileImageCount()->Int{
        return objUserDetailModel.profile_image.count
    }
    
    func setProfileImageData(imgData:Data){
        let obj = ProfileImageModel()
        obj.data = imgData
        objUserDetailModel.profile_image.append(obj)
    }
    
    func removeProfileImage(indexPath:IndexPath){
        objUserDetailModel.profile_image.remove(at: indexPath.row)
    }
    
    func getProfileImgsCell(indexPath:IndexPath)->(imgUrl:String,imgData:Data){
        return (imgUrl:objUserDetailModel.profile_image[indexPath.row].profile_pic,imgData:objUserDetailModel.profile_image[indexPath.row].data ?? Data())
    }
    
    func getProfileImagesData()->[Data]{
        let data = objUserDetailModel.profile_image.filter({$0.data != nil}).map({$0.data ?? Data()})
        print("uploadedImgsCount:-",data.count)
        return data
    }
    
}

