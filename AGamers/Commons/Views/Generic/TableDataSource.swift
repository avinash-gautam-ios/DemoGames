//
//  TableDataSource.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import Foundation

class TableSection<T> {
    let items: [T]
    
    init(items: [T]) {
        self.items = items
    }
}

class TableDataSource<Item, Section: TableSection<Item>> {
    let sections: [Section]
    
    init(sections: [Section]) {
        self.sections = sections
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func item(atIndex index: Int, section: Int) -> Item {
        return sections[section].items[index]
    }
}
