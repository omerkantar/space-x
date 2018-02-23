//
//  LauchTableViewCell.swift
//  spacex
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit
import AlamofireImage

class LauchTableViewCell: UITableViewCell {

    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var highlightedView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
// MARK: - Build
extension LauchTableViewCell {
    override func build(viewModel: BaseCellViewModel) {
        guard let vm = viewModel as? LaunchCellViewModel,
            let rocketNameLabel = rocketNameLabel,
            let dateLabel = dateLabel,
            let imgView = imgView else {
            return
        }
        rocketNameLabel.text = vm.rocketName
        dateLabel.text = vm.dateText
        imgView.image = nil
        if let url = vm.imageURL {
            imgView.af_setImage(withURL: url)
        }
    }
}
