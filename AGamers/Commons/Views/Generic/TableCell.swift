//
//  CellIdentifiableProtocol.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import UIKit

//MARK: - Gamers Table Cell

protocol TableCell: UITableViewCell, Identifiable { }


//MARK: - Idenfitiable via identifier

protocol Identifiable: AnyObject {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: type(of: self))
    }
}
