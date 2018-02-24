//
//  FilterTableViewCell.swift
//  spacex
//
//  Created by omer kantar on 25.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var highlightedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        highlightedView.layer.cornerRadius = 5.0
        highlightedView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        var scale: CGFloat = 1.0
        var color: UIColor = .clear
        if highlighted {
            scale = 0.98
            color = .groupTableViewBackground
        }
        UIView.animate(withDuration: 0.21) {
            self.highlightedView.backgroundColor = color
            self.highlightedView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
}

// MARK: - Build
extension FilterTableViewCell {
    override func build(viewModel: BaseCellViewModel) {
        guard let vm = viewModel as? FilterCellViewModel,
            let titleLabel = titleLabel else {
                return
        }
        titleLabel.text = vm.title
        self.accessoryType = vm.isChecked ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
    }
}
