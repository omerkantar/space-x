//
//  LaunchDescriptionTableViewCell.swift
//  spacex
//
//  Created by omer kantar on 25.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

class LaunchDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var rocketImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        imageContainerView.layer.cornerRadius = imageContainerView.bounds.width / 2.0
        imageContainerView.layer.cornerRadius = 20.0
        imageContainerView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        imageContainerView.layer.borderWidth = 1.0
        imageContainerView.clipsToBounds = true
        
        dateLabel.layer.cornerRadius = 3.0
        dateLabel.layer.masksToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension LaunchDescriptionTableViewCell {
    override func build(viewModel: BaseCellViewModel) {
        guard let vm = viewModel as? LaunchDetailViewModel,
            let titleLabel = titleLabel,
            let dateLabel = dateLabel,
            let imageView = rocketImageView,
            let detailLabel = detailLabel else {
            return
        }
        
        titleLabel.text = vm.title
        dateLabel.text = vm.dateText
        detailLabel.text = vm.descriptionText
        
        if let url = vm.imageURL {
            imageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "spaceX_icon"), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.flipFromTop(0.2), runImageTransitionIfCached: true, completion: nil)

        }
    }
}
