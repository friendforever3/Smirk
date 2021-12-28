//
//  SetupProfileShowVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit

class SetupProfileShowVC: UIViewController {
    
    @IBOutlet weak var tfShow: TextFieldCustom!
    @IBOutlet weak var tblVw: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblVw.tableFooterView = UIView(frame: .zero)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        let vc = EnableLocationVC.getVC(.Main)
        self.push(vc)
    }
    
}

//MARK: Tableview delegate and datasource
extension SetupProfileShowVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserVM.shared.getShowsListArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShowTblCell
        
        cell.lblShowName.text = UserVM.shared.getShowsListCell(indexPath: indexPath).title
        UtilityManager.shared.setImage(image: cell.imgShow, urlString: UserVM.shared.getShowsListCell(indexPath: indexPath).Icon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        tfShow.text = UserVM.shared.getShowsListCell(indexPath: indexPath).title + " "
        RegisterModel.shared.shows.append(Int(UserVM.shared.getShowsListCell(indexPath: indexPath).id) ?? 0)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
}
