//
//  CellProtocol.swift
//  spacex
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

protocol ViewCellProtocol: NSObjectProtocol {
    func build(viewModel: BaseCellViewModel) -> Void
}


protocol ViewCellTypeProtocol {
    var identifier: String { get }
    var nibName: String { get }
}


// MARK: - Bu fonksiyonu override edebilmemiz icin @objc func yapiyoruz 🦄
extension UITableViewCell: ViewCellProtocol {
    @objc func build(viewModel: BaseCellViewModel) { }
}

extension UICollectionView: ViewCellProtocol {
    @objc func build(viewModel: BaseCellViewModel) { }
}
