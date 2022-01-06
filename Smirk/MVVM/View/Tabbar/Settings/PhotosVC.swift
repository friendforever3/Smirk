//
//  PhotosVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit
import OpalImagePicker
import Photos

class PhotosVC: UIViewController {

    @IBOutlet weak var clcVw: UICollectionView!
    
    var delegate : ProfileUpdateDelagte?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        uploadPics()
    }
    
}

//MARK:- CollectionView Datasource and Delegate
extension PhotosVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProfileImgCell
        
        if indexPath.row < 10{
            if UserVM.shared.getProfileImageCount() > indexPath.row{
                //cell.imgUser.image = selectedPhots[indexPath.row]
                cell.imgAddIcon.isHidden = true
                if UserVM.shared.getProfileImgsCell(indexPath: indexPath).imgUrl != ""{
                    UtilityManager.shared.setImage(image: cell.imgBg, urlString: UserVM.shared.getProfileImgsCell(indexPath: indexPath).imgUrl)
                }else{
                    let image = UIImage(data: UserVM.shared.getProfileImgsCell(indexPath: indexPath).imgData)
                    cell.imgBg.image = image
                }
                cell.btnDeleteImage.isHidden = false
            }else{
                cell.imgBg.image = UIImage(named: "clcBg")
                cell.btnDeleteImage.isHidden = true
                cell.imgAddIcon.isHidden = false
            }
        }
        
        cell.btnDeltImages = { [weak self] btn in
            UserVM.shared.removeProfileImage(indexPath: indexPath)
            self?.clcVw.reloadData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        if (UserVM.shared.getProfileImageCount() - 1) < indexPath.row{
            let imagePicker = OpalImagePickerController()
            imagePicker.imagePickerDelegate = self
            imagePicker.maximumSelectionsAllowed = (10 - UserVM.shared.getProfileImageCount())
            imagePicker.view.backgroundColor = .white
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (clcVw.frame.size.width / 3 ) - 10, height: ((clcVw.frame.size.width / 3 ) - 10) + 21)
        
    }
    
    
    
}

extension PhotosVC: OpalImagePickerControllerDelegate {
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        //Cancel action?
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
        //Save Images, update UI
       
        let selectedPhots = UtilityManager.shared.getAssetThumbnail(assets: assets)
        
        for img in selectedPhots{
            UserVM.shared.setProfileImageData(imgData: img.pngData() ?? Data())
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

//MARK: API
extension PhotosVC{
    
    func uploadPics(){
        
        UserVM.shared.uploadProfileImages(imgData: UserVM.shared.getProfileImagesData(), fileName: "profile_pic") { [weak self] (success,msg) in
            if success{
                self?.delegate?.didProfileUpdate()
                self?.popVc()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KError, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
        
    }
    
}
