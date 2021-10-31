//
//  CompaitbleVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit

class CompaitbleVC: UIViewController {

    @IBOutlet weak var vwBottomScroll: UIScrollView!
    @IBOutlet weak var vw1WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var vw2WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var vw3WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var favShowClcVw: UICollectionView!
    @IBOutlet weak var photoClcVw: UICollectionView!
    @IBOutlet weak var vwReportBg: UIView!
    @IBOutlet weak var vwReport: UIView!
    
    
    let textArray = ["Despicable Me","Friends","Money Heist"]
    
    let kItemPadding = 17
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let bubbleLayout = MICollectionViewBubbleLayout()
        bubbleLayout.minimumLineSpacing = 12.0
        bubbleLayout.minimumInteritemSpacing = 12.0
        bubbleLayout.delegate = self
        favShowClcVw.setCollectionViewLayout(bubbleLayout, animated: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.vwReport.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }

}

//MARK: ScrollView Delegate
extension CompaitbleVC:UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if vwBottomScroll.currentPage == 1{
            vw1WidthConstraint = vw1WidthConstraint.setMultiplier(multiplier: 0.91)
            self.view.layoutIfNeeded()
            
        }else if vwBottomScroll.currentPage == 2{
            vw1WidthConstraint = vw1WidthConstraint.setMultiplier(multiplier: 1.0)
            vw2WidthConstraint = vw2WidthConstraint.setMultiplier(multiplier: 1.13)
            self.view.layoutIfNeeded()
           
        }else{
            vw2WidthConstraint = vw2WidthConstraint.setMultiplier(multiplier: 1.025)
            vw3WidthConstraint = vw3WidthConstraint.setMultiplier(multiplier: 1.1)
            self.view.layoutIfNeeded()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(vwBottomScroll.currentPage)
    }
    
}


//MARK:- CollectionView Datasource and delegate
extension CompaitbleVC : UICollectionViewDelegate,UICollectionViewDataSource,MICollectionViewBubbleLayoutDelegate,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, itemSizeAt indexPath: NSIndexPath) -> CGSize {
        
        let title = textArray[indexPath.row]
        var size = title.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 18)!])
        size.width = CGFloat(ceilf(Float(size.width + CGFloat(kItemPadding * 2))))
        size.height = 65
        
        //...Checking if item width is greater than collection view width then set item width == collection view width.
        if size.width > collectionView.frame.size.width {
            size.width = collectionView.frame.size.width
        }
        return size
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == favShowClcVw{
        return textArray.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == favShowClcVw{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EthicityClcCell", for: indexPath) as! EthicityClcCell
        cell.btnEthenic.setTitle(textArray[indexPath.item], for: .normal)
        cell.vwTick.isHidden = true
        return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == photoClcVw{
        return CGSize(width: (photoClcVw.frame.size.width / 3 ) - 20, height: ((photoClcVw.frame.size.width / 3 ) - 20) + 21)
        }else{
            return CGSize.zero
        }
    }
    
}
