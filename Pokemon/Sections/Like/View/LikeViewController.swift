//
//  LikeViewController.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 2/07/21.
//

import UIKit
import Koloda
import Alamofire
import AlamofireImage

class LikeViewController: UIViewController {

    @IBOutlet weak var likeView: KolodaView!
    
    // MARK: - Vars
    private var numberOfPokemons: Int = 5
    private lazy var modelController: LikeViewModelController = {
        let modelController = LikeViewModelController()
        modelController.attach(view: self)
        return modelController
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        likeView.delegate = self
        likeView.dataSource = self
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }
    
    // MARK: IBActions
    @IBAction func leftButtonTapped() {
        likeView?.swipe(.left)
    }
    
    @IBAction func rightButtonTapped() {
        likeView?.swipe(.right)
    }
}

// MARK: KolodaViewDelegate
extension LikeViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let position = likeView.currentCardIndex
        numberOfPokemons += 5
        likeView.insertCardAtIndexRange(position..<position + 5, animated: true)
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction.rawValue == "right" {
            modelController.saveImage(urlImage: "\(index)")
        }
    }
}

// MARK: KolodaViewDataSource
extension LikeViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return numberOfPokemons
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let customView = CustomView()
        customView.imageView.setImage(with: Constants.Request.baseImage + "\(index)" + ".png")
        return customView
    }
}
// MARK: - View Model Protocol
extension LikeViewController: LikeProtocol {
    func reloadUI() {
        self.likeView.reloadData()
    }
}
