//
//  UITableView+Extensions.swift
//  spacex
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

// MARK: - Build
extension UITableView {
    func build() {
        self.separatorStyle = .none
        self.tableFooterView = UIView(frame: .zero)
        self.tableHeaderView = UIView(frame: .zero)
    }
}

// MARK: - Register & Dequeue
extension UITableView {
    func register(_ cellType: UITableView.CellType) {
        self.register(UINib(nibName: cellType.nibName, bundle: nil), forCellReuseIdentifier: cellType.identifier)
    }
    
    // MARK: - Burada (SOLID'in Dsini) Dependency Inversion yaparak hem cell type dequeue edebilmekteyiz hem de ozel class'in build fonksiyonunu override ederek cell configuration yapabiliriz. ViewController'dan Cell configure logicini uzaklastirmis - Cell'e gondermis olduk Single responsibility principle - ViewController'in yukunu hafifletmis olacagiz. 🦄
    
    func dequeue(_ cellType: UITableView.CellType, indexPath: IndexPath, viewModel: BaseCellViewModel? = nil) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
        if let vm = viewModel {
            cell.build(viewModel: vm)
        }
        return cell
    }

}



// MARK: - CellType
extension UITableView {
    enum CellType: ViewCellTypeProtocol {
        case coffee
        case launch
        case filter
        // Acikcasi identifier ile nibName ayni string kullanilmasinda hic bir sakinca gormedigimden boyle yaptim istenildigi vakit degistiriline bilinir 
        var identifier: String {
            switch self {
            case .launch:
                return String(describing: LauchTableViewCell.self)
            case .filter:
                return String(describing: FilterTableViewCell.self)
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
