//
//  HomeVM.swift
//  Smirk
//
//  Created by Surinder kumar on 26/12/21.
//

import UIKit
import SwiftUI

class HomeVM: NSObject {

    public static let shared = HomeVM()
    
    var cardList = [HomeModel]()
    
    private override init() {}
    
    func getCardList(completion:@escaping completionHandler){
     
        serverRequest(url: APIConstant.kSandvboxBaseUrl + APIConstant.kCardsList, param: nil, method: .get, header: UtilityManager.shared.getHeaderToken()) { [weak self] (response, statusCode,errorMsg) in
            
            //print("response home:-",response)
            if response["code"] as? Int == 200{
                if let data = response["data"] as? [[String:Any]]{
                    self?.cardList.removeAll()
                    for elmnt in data{
                        let obj = HomeModel()
                        obj.setData(dict: elmnt)
                        self?.cardList.append(obj)
                    }
                }
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
        }
    }
    
    func actionOnCard(card_id:String,card_action:String,is_completed:String,completion:@escaping completionHandler){
        
        let param = ["card_id":card_id,"card_action":card_action,"is_completed":is_completed]
        
        serverRequest(url: APIConstant.kSandvboxBaseUrl + APIConstant.kActionOnCard, param: param, method: .post, header: UtilityManager.shared.getHeaderToken()) { [weak self] (response, statusCode,errorMsg) in
            
           // print("response home:-",response)
            if response["code"] as? Int == 200{
                completion(true,response["message"] as? String ?? "")
            }else{
                completion(false,response["message"] as? String ?? "")
            }
            
        }
        
    }
    
    //MARK: Get Card List
    func getCardListCount()->Int{
        return cardList.count
    }
    
    func getCardDetailCell(indexPath:Int)->(imgUrl:String,id:Int){
        return (imgUrl:cardList[indexPath].card_image,id:cardList[indexPath].id)
    }
    
}
