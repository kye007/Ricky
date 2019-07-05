//
//  ThemeImageView.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import UIKit

open class RoundedImageView: UIImageView {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}
