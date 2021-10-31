//
//  OtherProfileVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit

class OtherProfileVC: UIViewController {

    @IBOutlet weak var vw3: UIView!
    @IBOutlet weak var vw2: UIView!
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var vwBottomScroll: UIScrollView!
    @IBOutlet weak var vw1WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var vw2WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var vw3WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var vwReport: UIView!
    @IBOutlet weak var vwReportBg: UIView!
    
    @IBOutlet weak var photosClcVw: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.vwReport.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    @IBAction func btnOpenReportVwAction(_ sender: Any) {
        vwReportBg.isHidden = false
    }
    @IBAction func btnCloseReportVwAction(_ sender: Any) {
        vwReportBg.isHidden = true
    }
    
}

//MARK: ScrollView Delegate
extension OtherProfileVC:UIScrollViewDelegate{
    
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

//MARK:- CollectionView Datasource and Delegate
extension OtherProfileVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (photosClcVw.frame.size.width / 2 ) - 10, height: ((photosClcVw.frame.size.width / 2 ) - 10) + 21)
        
    }
    
    
    
}

