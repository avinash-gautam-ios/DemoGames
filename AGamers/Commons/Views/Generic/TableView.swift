//
//  TableView.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import UIKit

extension UITableView {
    
    func register(cell: TableCell.Type) {
        self.register(cell, forCellReuseIdentifier: cell.identifier)
    }
    
}
