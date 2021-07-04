//
//  UIColor+Extension.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit
import Foundation

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return String(format: "#%06x", rgb)
    }
    
    static func withGradient(frame: CGRect, colors: [UIColor], horizontal: Bool = false) -> UIColor {
        let backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.frame = frame
        
        let cgColors = colors.map({$0.cgColor})
        
        backgroundGradientLayer.colors = cgColors
        
        if !horizontal {
            backgroundGradientLayer.locations = [0.0, 1.0]
        } else {
            backgroundGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            backgroundGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        }
        
        UIGraphicsBeginImageContext(backgroundGradientLayer.bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            backgroundGradientLayer.render(in: context)
        }
        let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return UIColor(patternImage: backgroundColorImage ?? UIImage())
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    func solid(whenOverlayedBy overlayColor: UIColor) -> UIColor {
        // Helper function to clamp values to range (0.0 ... 1.0)
        func clampValue(_ v: CGFloat) -> CGFloat {
            guard v > 0 else { return  0 }
            guard v < 1 else { return  1 }
            return v
        }
        
        var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        
        getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        overlayColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        // Make sure the input colors are well behaved
        // Components should be in the range (0.0 ... 1.0)
        // This to compensate for any "bad" colors = colors which have component values out of range
        r1 = clampValue(r1)
        g1 = clampValue(g1)
        b1 = clampValue(b1)
        
        r2 = clampValue(r2)
        g2 = clampValue(g2)
        b2 = clampValue(b2)
        a2 = clampValue(a2)
        
        return UIColor(  red: r1 * (1 - a2) + r2 * a2,
                         green: g1 * (1 - a2) + g2 * a2,
                         blue: b1 * (1 - a2) + b2 * a2,
                         alpha: 1)
    }

    @nonobjc class var pokemonDisable: UIColor {
        return UIColor(named: "pokemonDisable") ?? .init(hex: "ADADAD")
    }
    
    // MARK: - Primary
    
    @nonobjc class var pokemonPrimary: UIColor {
        return UIColor(named: "pokemonPrimary") ?? .init(hex: "343EFF")
    }
    
    @nonobjc class var pokemonPrimaryAlpha5: UIColor {
        return UIColor(named: "pokemonPrimary-alpha-5") ?? UIColor.pokemonPrimary.withAlphaComponent(0.05)
    }

    @nonobjc class var pokemonPrimaryAlpha10: UIColor {
        return UIColor(named: "pokemonPrimary-alpha-10") ?? UIColor.pokemonPrimary.withAlphaComponent(0.10)
    }
    
    // MARK: - Secondary
    @nonobjc class var pokemonSecondary: UIColor {
        return UIColor(named: "pokemonSecondary") ?? .init(hex: "ED881D")
    }
    
    // MARK: - Surface
    @nonobjc class var pokemonSurface: UIColor {
        return UIColor(named: "pokemonSurface") ?? .init(hex: "FAFAFA")
    }

}
