//
//  UIApplication+Extension.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit

extension UIApplication {
    // MARK: - HUD
    static func showHUD(in view: UIView? = nil, title: String? = nil, progress: CGFloat? = nil) {
        let hud = HUDView.shared
        hud.show(in: view, title: title, progress: progress)

    }
    
    static func updateHUD(in view: UIView? = nil, title: String? = nil, progress: CGFloat? = nil) {
        let hud = HUDView.shared
        hud.update(title: title, progress: progress)
    }
    
    static func dismissHUD(animated: Bool = false) {
        let hud = HUDView.shared
        hud.dismiss(animated: animated)
    }
    
    static func showSuccessHUD(duration: TimeInterval = 3.0, title: String? = nil, completion: (() -> Void)? = nil) {
        let hud = HUDView.shared
        hud.showSuccess(duration: duration, title: title, completion: completion)
    }

}
