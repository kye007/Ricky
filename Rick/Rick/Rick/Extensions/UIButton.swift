//
//  UIButton.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// UIAppearance: https://stackoverflow.com/a/42410383
    @objc public dynamic var titleFont: UIFont? {
        get { return titleLabel?.font }
        set { titleLabel?.font = newValue }
    }
}
