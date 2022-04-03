//
//  ListViewController.swift
//  CellReuseIssue
//
//  Created by Fabio on 3/4/22.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var datasource: ListDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.Identifier)
        
        datasource = ListDataSource(userId: "abc 1")
        datasource?.setDataSource(with: generateItem(50))
        datasource?.deleteItem = { [weak self] id, indexPath in
            print("Index path (row) to be deleted: \(indexPath.row)")
            self?.tableView.deleteRows(at: [indexPath], with: .none)
        }
        tableView.dataSource = datasource
    }

    private func generateItem(_ n: Int) -> [ModelItem] {
        var item = [ModelItem]()
        for i in 0..<n {
            item.append(
                ModelItem(id: "\(i)", username: "Row item: \(i)",
                          content: "\(i). Lorem ipsum dolor sit amet. t, consectetur adipiscing elit. Maecenas luctus id dui id fringilla.", createdAt: Date())
            )
        }
        return item
    }
}

