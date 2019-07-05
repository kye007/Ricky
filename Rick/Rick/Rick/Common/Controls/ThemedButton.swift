//
//  ThemedButton.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import UIKit

protocol Themeable {
    func style()
}

class ThemedPrimaryButton: UIButton, Themeable {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
        layer.masksToBounds = false
        layer.cornerRadius = 10
    }
    
    func style() {
        ThemedPrimaryButton.appearance().with {
            $0.setTitleColor(#colorLiteral(red: 0.1880519688, green: 0.4803432226, blue: 0.8748294711, alpha: 1), for: .normal)
            $0.backgroundColor = #colorLiteral(red: 0.9084708095, green: 0.948328197, blue: 0.9982554317, alpha: 1)
            
            $0.titleFont = UIFont.preferredFont(forTextStyle: .headline)
            $0.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            
            $0.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .selected)
        }
    }
}
