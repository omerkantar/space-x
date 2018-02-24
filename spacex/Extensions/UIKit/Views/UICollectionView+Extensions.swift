//
//  UICollectionView+Extensions.swift
//  spacex
//
//  Created by omer kantar on 24.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit


// MARK: - Register & Dequeue
extension UICollectionView {
    func register(_ cellTypes: [UICollectionView.CellType]) {
        for type in cellTypes {
            self.register(UINib(nibName: type.nibName, bundle: nil), forCellWithReuseIdentifier: type.identifier)
        }
    }
    
    
    func dequeue(_ cellType: UICollectionView.CellType, indexPath: IndexPath, viewModel: BaseCellViewModel? = nil) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath)
        if let vm = viewModel {
            cell.build(viewModel: vm)
        }
        return cell
    }
    
}



// MARK: - CellType
extension UICollectionView {
    enum CellType: ViewCellTypeProtocol {
        case coffee
        case launch
        var identifier: String {
            switch self {
            case .launch:
                return String(describing: LaunchCollectionViewCell.self)
            default:
                break
            }
            return "cellIdentifier"
        }
        
        var nibName: String {
            return identifier
        }
    }
}
