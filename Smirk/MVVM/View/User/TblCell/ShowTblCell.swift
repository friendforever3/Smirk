//
//  ShowTblCell.swift
//  Smirk
//
//  Created by Surinder kumar on 26/12/21.
//

import UIKit

class ShowTblCell: UITableViewCell {

    @IBOutlet weak var lblShowName: UILabel!
    @IBOutlet weak var imgShow: ImageCustom!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
