//
//  APIConstant.swift
//  CoupleCare
//
//  Created by Surinder kumar on 14/12/21.
//

import Foundation
import UIKit

struct APIConstant{
 
    static let kSandvboxBaseUrl = "https://smirkapp.us/api/v1/"
    static let kAuth = "auth/"
    static let kLogin = kAuth + "login"
    static let kRegister = kAuth + "sign-up"
    static let kRetrieveList = "retrieve-list"
    static let kVerifyOTP = kAuth + "verify"
    static let kCardsList = "cards-list"
    static let kActionOnCard = "action-on-card"
    static let kUserDetail = "user-detail"
    static let kUpdateProfile = "update-profile"
}

struct AppConstant{
    
    static let kGetDeviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    static let kDevice = "1"
    static let kDeviceToken = "asxzsdd"
    
    static let KOops = "Oops"
    static let KError = "Error"
    static let kMsgMobile = "Please enter the mobile number"
    static let kOTP = "Please enter the valid otp"
    static let kMsgFullName = "Please enter the full name"
    static let kMsgDOB = "Please enter your birthday"
    static let kMsgGender = "Please select the gender"
    static let kMsgInterestedIn = "Please select the interested in"
    static let kMsgInterest = "Please select any interest"
    static let kMsgImage = "Please select the image"
    static let kMsgSelectImgCount = "Please select at least two images"
    static let kLaughWith = "Please select the laugh with"
    static let kMatchWith = "Please select the match with"
    static let kDistance = "Please select the distance"
    static let kEthnicity = "Please select the Ethnicity"
    static let kEthnicityPerf = "Please select the Ethnicity preference"
    static let kUploadPic = "Please upload the pictures"
    static let kUploadMinPic = "Please upload min 2 pictures"
    static let kAbout = "Please enter the about"
    
}

enum LaughWith : String{
    case justFriend = "1"
    case RomanticInterest = "2"
}

enum MatchWith : String{
    case Male = "1"
    case Female = "2"
    case NonBinary = "3"
}

enum Distance : String {
   case Ten = "10"
   case Fifty = "50"
   case Hundred = "100"
   case any = "Any"
}

enum Gender : String{
    case Male = "0"
    case Female = "1"
    case NonBinary = "2"
}
