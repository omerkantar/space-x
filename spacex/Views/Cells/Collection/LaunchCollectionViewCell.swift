//
//  LaunchCollectionViewCell.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit
import AlamofireImage

class LaunchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var highlightedView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        highlightedView.layer.cornerRadius = 5.0
        highlightedView.layer.masksToBounds = true
        imageContainerView.layer.cornerRadius = 5.0
        imageContainerView.layer.masksToBounds = true
        dateLabel.layer.cornerRadius = 3.0
        dateLabel.layer.masksToBounds = true

    }
    
    override var isHighlighted: Bool {
        didSet {
            guard let highlightedView = highlightedView, let imageView = imageView else {
                return
            }
            var scale: CGFloat = 1.0
            var color: UIColor = .clear
            var imageAlpha: CGFloat = 1.0
            
            if isHighlighted {
                scale = 0.98
                color = .groupTableViewBackground
                imageAlpha = 0.69
            }
            
            UIView.animate(withDuration: 0.24) {
                highlightedView.transform = CGAffineTransform(scaleX: scale, y: scale)
                highlightedView.backgroundColor = color
                imageView.alpha = imageAlpha
            }

        }
    }

}


// MARK: - Build
extension LaunchCollectionViewCell {
    override func build(viewModel: BaseCellViewModel) {
        guard let vm = viewModel as? LaunchCellViewModel,
            let titleLabel = titleLabel,
            let dateLabel = dateLabel,
            let imageView = imageView else {
                return
        }
        titleLabel.text = vm.rocketName
        dateLabel.text = vm.dateText
        imageView.image = nil
        if let url = vm.imageURL {
            imageView.af_setImage(withURL: url)
        }
    }
}
