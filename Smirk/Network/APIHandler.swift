//
//  APIHandler.swift
//  Gospel
//
//  Created by Surinder kumar on 21/09/21.
//

import Foundation
import Alamofire
import UIKit

typealias responseCompletion = ([String:Any],Int,String)
typealias responseCompletionArray = ([[String:Any]],Int,String)

func serverRequest(url:String,param:[String:Any]?,method:HTTPMethod,header:HTTPHeaders? ,completion:@escaping(responseCompletion)->()){
    
    //Indicator.shared.start("")
    UIApplication.getTopViewController()?.showIndicator(withTitle: "", and: "")
    print("url:-",url)
    print("param:-",param)
    print(header)
    AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: method, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { response in
       // Indicator.shared.stop()
        UIApplication.getTopViewController()?.hideIndicator()
        
        if let data = response.data, let str = String(data: data, encoding: .utf8){
            print("server error:-",str)
        }
        
        print(response)
        switch response.result {
        case .success(_):
            print("data:-",response.response?.statusCode)
            if let dict = response.value as? [String:Any]{
                completion((dict,response.response?.statusCode ?? -1,""))
            }
            
            
            break
        case .failure(let error):
            completion(([:],response.response?.statusCode ?? -1,error.localizedDescription ))
            break
        }
        
    }
    
    
    
}

func serverRequesArrayt(url:String,param:[String:Any]?,method:HTTPMethod,header:HTTPHeaders? ,completion:@escaping(responseCompletionArray)->()){
    
   // Indicator.shared.start("")
    UIApplication.getTopViewController()?.showIndicator(withTitle: "", and: "")
    print("url:-",url)
    AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: method, parameters: param, headers: header).responseJSON { response in
       // Indicator.shared.stop()
        UIApplication.getTopViewController()?.hideIndicator()
        
        print(response)
        
        switch response.result {
        case .success(_):
            print("dataUrl:-",response.response?.statusCode)
            if let dict = response.value as? [[String:Any]]{
                completion((dict,response.response?.statusCode ?? -1,""))
            }else{
                completion(([[:]],response.response?.statusCode ?? -1,"" ))
            }
            
            
            break
        case .failure(let error):
            completion(([[:]],response.response?.statusCode ?? -1,error.localizedDescription ))
            break
        }
        
    }
    
    
    
}

func uploadDataToServerHandler(url:String,param:[String:Any]?,imgData:[Data]?,fileName:String,header:HTTPHeaders?,completion:@escaping ([String:Any]?)->()){
    
    print(url)
    print(param)
    //Indicator.shared.start("")
    UIApplication.getTopViewController()?.showIndicator(withTitle: "", and: "")
    AF.upload(multipartFormData: { (multipartData) in
        
        if let parm = param{
            for (key,value) in parm{
                
                if  (value as AnyObject).isKind(of: NSArray.self)
                {
                    print(value)
                    let arrayObj = value as? [Int] ?? []
                    //let data2 = NSData(bytes: &arrayObj, length: arrayObj.count)
                    let count : Int  = arrayObj.count
                    for i in 0  ..< count
                    {
                        let value = arrayObj[i]
                        let encoder = JSONEncoder()
                        if let jsonData = try? encoder.encode(value) {
                            
                            let keyObj = key + "[\(i)]"
                            print("key value:-",keyObj,value)
                            multipartData.append(jsonData, withName: keyObj)
                        }
                    }
                }
                else{
                    
                    multipartData.append("\(value)".data(using: .utf8) ?? Data(), withName: key)
                }
            }
        }
        
        if let imageData = imgData{
            print("imgcount:-",imageData.count)
            for (index,imgDat) in imageData.enumerated(){
                multipartData.append(imgDat, withName: "\(fileName)[\(index)]", fileName: "\(UUID().uuidString).png", mimeType: "\(UUID().uuidString)/png")
            }
        }
        
        
    }, to: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, usingThreshold: UInt64.init(), method: .post, headers: header).response { (response) in
        print("ghgg",response)
        //Indicator.shared.stop()
        UIApplication.getTopViewController()?.hideIndicator()
        if let data = response.data, let str = String(data: data, encoding: .utf8){
            print("server error:-",str)
        }
        
        switch (response.result){
        case .success(_):
            if let responseData = response.value as? Data{
                do {
                    let data = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String:Any]
                    completion(data)
                }catch{
                    completion([:])
                }
            }
            
            break
        case .failure(let error):
            print("errr",error.localizedDescription)
            completion([:])
            break
        }
        
    }
    
    
}

func uploadDataToServerHandlerSingle(url:String,param:[String:Any]?,imgData:Data?,fileName:String,header:HTTPHeaders?,completion:@escaping ([String:Any]?)->()){
    
    print(url)
    print(param)
    //Indicator.shared.start("")
    UIApplication.getTopViewController()?.showIndicator(withTitle: "", and: "")
    AF.upload(multipartFormData: { (multipartData) in
        
        if let parm = param{
            for (key,value) in parm{
                
                if  (value as AnyObject).isKind(of: NSArray.self)
                {
                    print(value)
                    let arrayObj = value as? [Int] ?? []
                    //let data2 = NSData(bytes: &arrayObj, length: arrayObj.count)
                    let count : Int  = arrayObj.count
                    for i in 0  ..< count
                    {
                        let value = arrayObj[i]
                        let encoder = JSONEncoder()
                        if let jsonData = try? encoder.encode(value) {
                            
                            let keyObj = key + "[\(i)]"
                            print("key value:-",keyObj,value)
                            multipartData.append(jsonData, withName: keyObj)
                        }
                    }
                }
                else{
                    
                    multipartData.append("\(value)".data(using: .utf8) ?? Data(), withName: key)
                }
            }
        }
        
        if let imageData = imgData{
            print("imgcount:-",imageData.count)
            
                multipartData.append(imageData, withName: "\(fileName)", fileName: "\(UUID().uuidString).png", mimeType: "\(UUID().uuidString)/png")
           
        }
        
        
    }, to: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, usingThreshold: UInt64.init(), method: .post, headers: header).response { (response) in
        print("ghgg",response)
        //Indicator.shared.stop()
        UIApplication.getTopViewController()?.hideIndicator()
        if let data = response.data, let str = String(data: data, encoding: .utf8){
            print("server error:-",str)
        }
        
        switch (response.result){
        case .success(_):
            if let responseData = response.value as? Data{
                do {
                    let data = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String:Any]
                    completion(data)
                }catch{
                    completion([:])
                }
            }
            
            break
        case .failure(let error):
            print("errr",error.localizedDescription)
            completion([:])
            break
        }
        
    }
    
    
}


extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}
