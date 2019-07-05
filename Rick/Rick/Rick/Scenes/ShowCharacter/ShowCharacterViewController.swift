//
//  ShowCharacterViewController.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import Morty
import UIKit

class ShowCharacterViewController: UIViewController {
    
    // MARK: - Controls
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var originLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var statusLabel: UIButton!
    
    // MARK: - Public
    var character: CharacterViewModel?
    
    // MARK: - Internal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let character = character else { return }
        display(character)
    }
}

extension ShowCharacterViewController {
    
    func display(_ character: CharacterViewModel) {
        self.title = character.name
        self.titleLabel.text = character.name
        self.speciesLabel.text = "Species: \(character.species)"
        self.originLabel.text = "Origin: \(character.origin)"
        self.locationLabel.text = "Location: \(character.object.location.name)"
        self.profileImageView.image(from: character.profileIconURL)
        
        self.statusLabel.setTitle(character.object.status.rawValue.uppercased(), for: .normal)
    }
}
