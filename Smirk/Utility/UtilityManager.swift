//
//  UtilityManager.swift
//  Rams
//
//  Created by Surinder on 26/05/20.
//  Copyright © 2020 Surinder. All rights reserved.
//

import Foundation
import UIKit
import Photos
//import Kingfisher


//completion:@escaping(Bool)->()
typealias completionHandler = (Bool,String)->()

class UtilityManager : NSObject{
    
     public static let shared = UtilityManager()
    
    private override init() {
    }
    
     var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
     var appLaunch : Bool = false
    
     let noInternet : String = "No Internet Connection Available"
    
    
    
    var appColor : UIColor{
        get{
            //return UIColor(r: 17/255, g: 86/255, b: 166/255)
            return UIColor(red: 17/255, green: 86/255, blue: 166/255, alpha: 1.0)
        }
    }
    
     var loaderBgColor : UIColor {
        get{
            return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.35)
        }
    }
    
    //MARK:-  Display alert with completion
    func displayAlertWithCompletion(title:String,message:String,control:[String],topController:UIViewController,completion:@escaping (String)->()){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for str in control{
            
            let alertAction = UIAlertAction(title: str, style: .default, handler: { (action) in
                
                completion(str)
            })
            
            alertController.addAction(alertAction)
        }
        
        
        // let topController = UIApplication.topViewController()
        topController.present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK:-  Display alert without completion
    func displayAlert(title:String,message:String,control:[String],topController:UIViewController){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for str in control{
            
            let alertAction = UIAlertAction(title: str, style: .default, handler: { (action) in
                
                
            })
            
            alertController.addAction(alertAction)
        }
        
        topController.present(alertController, animated: true, completion: nil)
        
    }
    
    func attributeText(sub:String, des:String,subSize:CGFloat,desSize:CGFloat,subFontName:String,desFontName:String)->NSAttributedString{
        let textAttributesOne = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: subFontName, size: subSize)!]
        let textAttributesTwo = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: desFontName, size: desSize)!]

        let textPartOne = NSMutableAttributedString(string: sub, attributes: textAttributesOne)
        let textPartTwo = NSMutableAttributedString(string: des, attributes: textAttributesTwo)

        let textCombination = NSMutableAttributedString()
        textCombination.append(textPartOne)
        textCombination.append(textPartTwo)
        return textCombination
    }
    
    func validateMobile(number: String) -> Bool {
        let numSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = number.components(separatedBy: numSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return number == numberFiltered
    }
    
    func getDate(dateString:String,inputDateformat:String,outputDateFormate:String)->String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = inputDateformat //"yyyy-MM-dd'T'HH:mm:ss.SSS"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = outputDateFormate //"MM/dd/yyyy HH:mm:ss a"
        var dateStr : String = ""
        if let date = dateFormatterGet.date(from: dateString) {
            print(dateFormatterPrint.string(from: date))
            dateStr = dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
            dateStr = dateString
        }
        return dateStr
    }
    
    func logoutUserNumber(){
        UserDefaults.standard.removeObject(forKey: "userNumber")
    }
    
    func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
         var arrayOfImages = [UIImage]()
         for asset in assets {
             let manager = PHImageManager.default()
             let option = PHImageRequestOptions()
             var image = UIImage()
             option.isSynchronous = true
             manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                 image = result!
                 arrayOfImages.append(image)
             })
         }

         return arrayOfImages
     }
    
    /*
     func LoginUserDecodedDetail()->UserValidateLoginModel{
           let decoder = JSONDecoder()
           var loginData = UserValidateLoginModel()
           if let questionData = UserDefaults.standard.data(forKey: "loginUserDetail"),
               let data = try? decoder.decode(UserValidateLoginModel.self, from: questionData) {
               loginData = data
           }
           return loginData
    }
    
     func setImage(image:UIImageView,urlString:String){
           let url = URL(string: urlString)
           image.kf.indicatorType = .activity
           DispatchQueue.main.async {
               image.kf.setImage(
                          with: url,
                          placeholder: UIImage(named: "profile-placeholder"))
                      {
                          result in
                          switch result {
                          case .success(let value): break
                            //  print("Task done for: \(value.source.url?.absoluteString ?? "")")
                          case .failure(let error): break
                             // print("Job failed: \(error.localizedDescription)")
                          }
                      
           }
          }
       }
     */

}
