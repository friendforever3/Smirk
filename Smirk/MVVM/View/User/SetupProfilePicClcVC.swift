//
//  SetupProfilePicClcVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit
import OpalImagePicker
import Photos

class SetupProfilePicClcVC: UIViewController {

    @IBOutlet weak var clcVw: UICollectionView!
    
    var selectedPhots = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        if selectedPhots.count == 0{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kUploadPic, control: ["OK"], topController: self)
        }else if selectedPhots.count < 2{
            UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: AppConstant.kUploadMinPic, control: ["OK"], topController: self)
        }else{
            pushToProfileBio()
        }
        
    }
    
    func pushToProfileBio(){
        let vc = SetupProfileBioVC.getVC(.Main)
        self.push(vc)
    }
    
}

//MARK:- CollectionView Datasource and Delegate
extension SetupProfilePicClcVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotosClcCell
        if indexPath.row < 10{
            if selectedPhots.count > indexPath.row{
                cell.imgUser.image = selectedPhots[indexPath.row]
                cell.imgAddIcon.isHidden = true
                cell.btnDeleteImage.isHidden = false
            }else{
                cell.btnDeleteImage.isHidden = true
                cell.imgAddIcon.isHidden = false
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        imagePicker.maximumSelectionsAllowed = 10
        imagePicker.view.backgroundColor = .white
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (clcVw.frame.size.width / 3 ) - 10, height: ((clcVw.frame.size.width / 3 ) - 10) + 21)
        
    }
    
    
    
}


extension SetupProfilePicClcVC: OpalImagePickerControllerDelegate {
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        //Cancel action?
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
        //Save Images, update UI
       
        selectedPhots = UtilityManager.shared.getAssetThumbnail(assets: assets)
        
        for img in selectedPhots{
            RegisterModel.shared.images.append(img.pngData() ?? Data())
        }
        
        
        clcVw.reloadData()
        print(assets.count)
        //Dismiss Controller
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerNumberOfExternalItems(_ picker: OpalImagePickerController) -> Int {
        return 1
    }
    
    func imagePickerTitleForExternalItems(_ picker: OpalImagePickerController) -> String {
        return NSLocalizedString("External", comment: "External (title for UISegmentedControl)")
    }
    
    func imagePicker(_ picker: OpalImagePickerController, imageURLforExternalItemAtIndex index: Int) -> URL? {
        return URL(string: "https://placeimg.com/500/500/nature")
    }
    
    
}
