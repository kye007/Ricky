//
//  CardViewCell.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import UIKit


class CardViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    
    var actionHandler: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

private extension CardViewCell {

    @IBAction func actionButtonTapped() {
        actionHandler?()
    }
}

extension CardViewCell {
    
    func bind(_ model: EpisodeViewModel, handler: (() -> Void)? = nil) {
        titleLabel.text = model.name
        subtitleLabel.text = model.episodeMeta
        detailLabel.text = "Originally aired on \(model.airDate)"
        
        actionButton.setTitle("View Episode", for: .normal)
        
        self.actionHandler = handler
    }
}
