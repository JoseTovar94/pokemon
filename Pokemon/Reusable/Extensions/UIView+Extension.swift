//
//  UIView+Extension.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import UIKit

extension UIView {
    public func removeAllConstraints() {
        DispatchQueue.main.async {
            var _superview = self.superview
            
            while let superview = _superview {
                for constraint in superview.constraints {
                    if let first = constraint.firstItem as? UIView, first == self {
                        superview.removeConstraint(constraint)
                    }
                    
                    if let second = constraint.secondItem as? UIView, second == self {
                        superview.removeConstraint(constraint)
                    }
                }
                _superview = superview.superview
            }
            
            self.removeConstraints(self.constraints)
            self.translatesAutoresizingMaskIntoConstraints = true
        }
    }
}
