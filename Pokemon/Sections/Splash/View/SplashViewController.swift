//
//  SplashViewController.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit

class SplashViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var progressView: CircularView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.startIndeterminate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.goToSearchView()
        }
    }
    
    // MARK: - Actions
    func goToSearchView() {
        guard let loginVC = ViewControllerCatalog.HomeNavigation.createInstance() else { return }
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
}
