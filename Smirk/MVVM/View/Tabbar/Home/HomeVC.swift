//
//  HomeVC.swift
//  Smirk
//
//  Created by Surinder kumar on 30/10/21.
//

import UIKit
import Shuffle_iOS

class HomeVC: UIViewController {

    @IBOutlet weak var vwCard: SwipeCardStack!
    @IBOutlet weak var vwAction: UIView!
    
    var cardIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDelegateDatasource()
        getCardList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    @IBAction func btnDislikeAction(_ sender: Any) {
        if HomeVM.shared.getCardListCount() > cardIndex{
            vwCard.swipe(.left, animated: true)
            if (HomeVM.shared.getCardListCount() - 1) == cardIndex{
                print("last")
                swipe(direction: 0, index: cardIndex, isCompleted: "1")
            }else{
                print("not last")
                swipe(direction: 0, index: cardIndex, isCompleted: "0")
            }
        }
    }
    
    @IBAction func btnLikeAction(_ sender: Any) {
        if HomeVM.shared.getCardListCount() > cardIndex{
            if (HomeVM.shared.getCardListCount() - 1) == cardIndex{
                print("last")
                swipe(direction: 1, index: cardIndex, isCompleted: "1")
            }else{
                print("not last")
                swipe(direction: 1, index: cardIndex, isCompleted: "0")
            }
            vwCard.swipe(.right, animated: true)
        }
    }
    
}

// MARK: Shuffle Card Data Source + Delegates

extension HomeVC: SwipeCardStackDataSource, SwipeCardStackDelegate {

    func setDelegateDatasource(){
        vwCard.dataSource = self
        vwCard.delegate = self
        
        
    }
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let card = SwipeCard()
        card.footerHeight = 80
        card.swipeDirections = [.left, .right]
        for direction in card.swipeDirections {
            //card.setOverlay(TinderCardOverlay(direction: direction), forDirection: direction)
        }
        
        //    let model = cardModels[index]
        //    card.content = TinderCardContentView(withImage: model.image)
        //    card.footer = TinderCardFooterView(withTitle: "\(model.name), \(model.age)", subtitle: model.occupation)
        
        //cardIndex = index
        if let url = URL(string: (HomeVM.shared.getCardDetailCell(indexPath: index).imgUrl)){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    //imageView.image = UIImage(data: data!)
                    let defaultImgData = UIImage(named: "icon-user-default")?.pngData() ??  Data()
                    card.content = TinderCardContentView(withImage: UIImage(data: data ?? defaultImgData))
                }
            }
        }else{
            print("emopty url")
        }
     //   card.content = TinderCardContentView(withImage: cardImages[index])
        
        
        return card
    }

  func numberOfCards(in cardStack: SwipeCardStack) -> Int {
      return HomeVM.shared.getCardListCount()
  }

  func didSwipeAllCards(_ cardStack: SwipeCardStack) {
    print("Swiped all cards!")
      vwAction.isHidden = true
  }

  func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
    //print("Undo \(direction) swipe on \(cardModels[index].name)")
     print("Undo \(direction)")
  }

  func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
    //print("Swiped \(direction) on \(cardModels[index].name)")
      
      cardIndex = index + 1
      //print("Swiped index + 1 \(cardIndex)")
      if (HomeVM.shared.getCardListCount() - 1) == index{
         // print("i am last")
          swipe(direction: direction.rawValue, index: index, isCompleted: "1")
      }else{
         // print("i am not")
          swipe(direction: direction.rawValue, index: index, isCompleted: "0")
      }
  }

  func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
    print("Card tapped")
      let vc = CompaitbleVC.getVC(.Home)
      self.push(vc)
      
  }
    
    func swipe(direction: Int,index:Int,isCompleted:String){
        
        if direction == 1{
            actionOnCard(actionCard: "1", card_id: "\(HomeVM.shared.getCardDetailCell(indexPath: index).id)", is_completed: isCompleted)
        }else if direction == 0{
            actionOnCard(actionCard: "0", card_id: "\(HomeVM.shared.getCardDetailCell(indexPath: index).id)", is_completed: isCompleted)
        }
        
    }
    
    

//  func didTapButton(button: TinderButton) {
//    switch button.tag {
//    case 1:
//      cardStack.undoLastSwipe(animated: true)
//    case 2:
//      cardStack.swipe(.left, animated: true)
//    case 3:
//      cardStack.swipe(.up, animated: true)
//    case 4:
//      cardStack.swipe(.right, animated: true)
//    case 5:
//      cardStack.reloadData()
//    default:
//      break
//    }
//  }
}

//MARK: API
extension HomeVC{
    
    func getCardList(){
        HomeVM.shared.getCardList { [weak self] (success,msg) in
            if success{
                self?.vwCard.reloadData()
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KError, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func actionOnCard(actionCard:String,card_id:String,is_completed:String){
        
        HomeVM.shared.actionOnCard(card_id: card_id, card_action: actionCard, is_completed: is_completed) { [weak self] (success,msg) in
            if success{
                
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KError, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
        
    }
    
}
