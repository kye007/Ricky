//
//  ShowEpisodeCharacterCell.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Foundation
import UIKit

class ShowEpisodeCharacterCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
}

extension ShowEpisodeCharacterCell {
    
    func bind(_ model: CharacterViewModel) {
        self.titleLabel.text = model.name
        self.speciesLabel.text = model.species
        self.profileImageView.image(from: model.profileIconURL)
    }
}
