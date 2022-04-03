//
//  ListDataSource.swift
//  CellReuseIssue
//
//  Created by Fabio on 3/4/22.
//

import Foundation
import UIKit

class ListDataSource: NSObject, UITableViewDataSource, CellControllerDelegate {
    private var datasource = [ModelItem]()
    private (set) var cellControllers = [CellController]()
    private var userId: String
    
    var deleteItem: ((_ id: String, _ indexPath: IndexPath) -> Void)?

    init(userId: String) {
        self.userId = userId
        super.init()
    }
    
    @objc func setDataSource(with items: [ModelItem]) {
        datasource = items
        let cellControllers = datasource.map { [weak self] item -> CellController in
            let controller = CellController(with: item)
            controller.delegate = self
            return controller
        }
        self.cellControllers = cellControllers
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell()

            var content = cell.defaultContentConfiguration()
            content.text = "The cell at index 0 is SPECIAL ⭐️!!"
            cell.contentConfiguration = content
            
            return cell
        } else {
            let controller = cellControllers[indexPath.row - 1]
            return controller.view(in: tableView, for: userId)
        }
    }

    func didTapOnDeleteCellButton(on cell: ItemTableViewCell, itemId: String) {
        print("ItemId to delete: \(itemId)")
        if let item = datasource.first(where: { $0.id == itemId }),
           let index = datasource.firstIndex(of: item) {
            datasource.remove(at: index)
            cellControllers.remove(at: index)
            print("Item content: \(item.content)")
            deleteItem?(itemId, IndexPath(row: index + 1, section: 0))
        }
    }
}
