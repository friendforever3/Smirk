//
//  EthnicityVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit

class EthnicityVC: UIViewController {

    @IBOutlet weak var clcVw: UICollectionView!
    
    let textArray = ["American Indian","East Asian","Black/African Descent","Hispanic/Latino","Middle Eastern","Pacific Islander","South Asian","White/Caucasian","Other","Open to All"]
    
     let kItemPadding = 25
    
    var selectedIndexPath = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let bubbleLayout = MICollectionViewBubbleLayout()
        bubbleLayout.minimumLineSpacing = 12.0
        bubbleLayout.minimumInteritemSpacing = 25.0
        bubbleLayout.delegate = self
        clcVw.setCollectionViewLayout(bubbleLayout, animated: false)
        
        UserVM.shared.removeEthnicListArray()
        listAPI()
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        if RegisterModel.shared.ethnicities.count == 0{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kEthnicity, control: ["OK"], topController: self)
        }else{
            pushToEthnicPref()
        }
        
    }
    
    func pushToEthnicPref(){
        let vc = EthnicityPrefrncVC.getVC(.Main)
        self.push(vc)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
}

//MARK:- CollectionView Datasource and delegate
extension EthnicityVC : UICollectionViewDelegate,UICollectionViewDataSource,MICollectionViewBubbleLayoutDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, itemSizeAt indexPath: NSIndexPath) -> CGSize {
        
        let title = UserVM.shared.getEthnicListCell(indexPath: indexPath as IndexPath).title //textArray[indexPath.row]
        var size = title.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15)!])
        size.width = CGFloat(ceilf(Float(size.width + CGFloat(kItemPadding * 2))))
        size.height = 65
        
        //...Checking if item width is greater than collection view width then set item width == collection view width.
        if size.width > collectionView.frame.size.width {
            size.width = collectionView.frame.size.width
        }
        return size
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserVM.shared.getEthnicListArrayCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EthicityClcCell", for: indexPath) as! EthicityClcCell
        
        cell.btnEthenic.isUserInteractionEnabled = false
        cell.btnEthenic.isHighlighted = false
        //cell.btnEthenic.setTitle(textArray[indexPath.item], for: .normal)
        cell.btnEthenic.setTitle(UserVM.shared.getEthnicListCell(indexPath: indexPath).title, for: .normal)
        if selectedIndexPath[indexPath.row] == indexPath{
            cell.btnEthenic.backgroundColor = .white
            cell.btnEthenic.setTitleColor(UIColor(named: "blackColor"), for: .normal)
            cell.vwTick.isHidden = false
        }else{
            cell.btnEthenic.backgroundColor = .clear
            cell.btnEthenic.setTitleColor(.white, for: .normal)
            cell.vwTick.isHidden = true
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if selectedIndexPath[indexPath.row] == indexPath{
            let index = IndexPath(row: -1, section: 0)
            self.selectedIndexPath[indexPath.row] = index
            RegisterModel.shared.ethnicities.removeAll(where: {$0 == Int(UserVM.shared.getEthnicListCell(indexPath: indexPath).id) ?? 0})
        }else{
            selectedIndexPath[indexPath.row] = indexPath
            RegisterModel.shared.ethnicities.append(Int(UserVM.shared.getEthnicListCell(indexPath: indexPath).id) ?? 0)
        }
        
        clcVw.reloadData()
    }
    
}

//MARK: API
extension EthnicityVC{
    
    func listAPI(){
        UserVM.shared.retrieveList { [weak self] (success,msg) in
            if success{
                
                for _ in 0...UserVM.shared.getEthnicListArrayCount(){
                    let index = IndexPath(row: -1, section: 0)
                    self?.selectedIndexPath.append(index)
                }
                
                self?.clcVw.reloadData()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KError, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
}
