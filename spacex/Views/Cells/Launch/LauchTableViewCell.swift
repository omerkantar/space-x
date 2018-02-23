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
    @IBOutlet weak var imgContainerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        highlightedView.layer.cornerRadius = 5.0
        imgContainerView.layer.cornerRadius = 5.0
        dateLabel.layer.cornerRadius = 3.0
        dateLabel.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        var scale: CGFloat = 1.0
        var color: UIColor = .clear
        var imageAlpha: CGFloat = 1.0
        
        if highlighted {
            scale = 0.98
            color = .groupTableViewBackground
            imageAlpha = 0.69
        }
        UIView.animate(withDuration: 0.24) {
            self.highlightedView.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.highlightedView.backgroundColor = color
            self.imgView.alpha = imageAlpha
        }
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
