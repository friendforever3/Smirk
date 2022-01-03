//
//  ProfileImgCell.swift
//  Smirk
//
//  Created by Surinder kumar on 30/12/21.
//

import UIKit

class ProfileImgCell: UICollectionViewCell {
    
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var imgAddIcon: UIImageView!
    @IBOutlet weak var btnDeleteImage: UIButton!
    
    
    var btnDeltImages : ((ProfileImgCell)->Void)?
    
    @IBAction func btnDeleteProfileImgAction(_ sender: Any) {
        self.btnDeltImages?(self)
    }
    
    
}
