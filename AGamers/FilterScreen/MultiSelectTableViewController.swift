//
//  MultiSelectTableViewController.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 12.10.21.
//

import UIKit

/**
 * MultiSelectTableViewController Output
 */
protocol MultiSelectTableViewControllerDelegate: AnyObject {
    func didSelectItems(_ items: [String])
}

final class MultiSelectTableViewController: UITableViewController {

    enum Constants {
        static let reuseID = "multiSelectionCell"
    }
    
    private let items: [String]
    private let preselectedItems: [String]
    private let allowsMultipleSelecton: Bool
    weak var delegate: MultiSelectTableViewControllerDelegate?
    
    init(items: [String],
         preselectedItems: [String],
         allowsMultipleSelecton: Bool,
         title: String) {
        self.items = items
        self.preselectedItems = preselectedItems
        self.allowsMultipleSelecton = allowsMultipleSelecton
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = allowsMultipleSelecton
        navigationItem.title = title
        tableView.reloadData()
        
        /// done button
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = barButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// preselect items
        for item in preselectedItems {
            let index = items.firstIndex(where: { $0 == item }) ?? -1
            let indexPath = IndexPath(row: index, section: 0)
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
            tableView.delegate?.tableView?(self.tableView, didSelectRowAt: indexPath)
        }
    }
    
    @objc private func backButtonTapped() {
        let filteredRows = tableView.indexPathsForSelectedRows?.map { $0.row } ?? []
        var selectedItems = [String]()
        for row in filteredRows  {
            selectedItems.append(items[row])
        }
        delegate?.didSelectItems(selectedItems)
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseID) else {
                return UITableViewCell(style: .default, reuseIdentifier: Constants.reuseID)
            }
            return cell
        }()
        cell.selectionStyle = .none
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.isSelected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        cell?.isSelected = true
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
        cell?.isSelected = false
    }
    
}
