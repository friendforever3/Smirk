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
    
    let cardImages = [
          UIImage(named: "10hrithik-roshan15"),
          UIImage(named: "Rectangle 23"),
          UIImage(named: "Rectangle 23"),
          UIImage(named: "Rectangle 23")
      ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDelegateDatasource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
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

      card.content = TinderCardContentView(withImage: cardImages[index])
      
      return card
  }

  func numberOfCards(in cardStack: SwipeCardStack) -> Int {
      return cardImages.count
  }

  func didSwipeAllCards(_ cardStack: SwipeCardStack) {
    print("Swiped all cards!")
      
  }

  func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
    //print("Undo \(direction) swipe on \(cardModels[index].name)")
     print("Undo \(direction)")
  }

  func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
    //print("Swiped \(direction) on \(cardModels[index].name)")
      print("Swiped \(direction)")
  }

  func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
    print("Card tapped")
      
      let vc = CompaitbleVC.getVC(.Home)
      self.push(vc)
      
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
