//
//  UILabel+Extension.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 2/07/21.
//

import UIKit
extension UILabel {
    func set(sub: String, des: String, fontSize: CGFloat, fontUI: String = Constants.AppFonts.bold) {
        let textCombination = NSMutableAttributedString()
        let secondText = NSMutableAttributedString(string: des)
        let boldFont = UIFont(name: "HelveticaNeue-Bold", size: fontSize)!

        let myAttribute = [ NSAttributedString.Key.font: boldFont]
        let firstText = NSMutableAttributedString(string: sub, attributes: myAttribute )
        textCombination.append(firstText)
        textCombination.append(secondText)
        
        self.attributedText = textCombination
    }
}
