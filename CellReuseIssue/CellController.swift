//
//  CellController.swift
//  CellReuseIssue
//
//  Created by Fabio on 3/4/22.
//

import Foundation
import UIKit

protocol CellControllerDelegate {
    func didTapOnDeleteCellButton(on cell: ItemTableViewCell, itemId: String)
}

class CellController {
    private var model: ModelItem
    private var cell: ItemTableViewCell?

    var delegate: CellControllerDelegate?

    init(with model: ModelItem) {
        self.model = model
    }
    
    public func view(in tableView: UITableView, for userId: String) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.Identifier) as? ItemTableViewCell else {
            return UITableViewCell()
        }
        self.cell = cell
        setupBinding(in: cell)
        cell.configure(with: model, for: userId)
        return cell
    }
    
    func setupBinding(in cell: ItemTableViewCell) {
        cell.actionsButton.addTarget(self, action: #selector(onDeleteButtonTap(sender:)), for: .touchUpInside)
    }

    @objc private func onDeleteButtonTap(sender: UIButton) {
        let controller = topController()
        
        let alertController = UIAlertController(title: "",
                                                message: "Are you sure you want to delete this item?",
                                                preferredStyle: .actionSheet)
        let actionDelete = UIAlertAction(title: "Delete",
                                         style: .default) { [weak self] action in
            guard let self = self,
                  let cell = self.cell else { return }
            self.delegate?.didTapOnDeleteCellButton(on: cell, itemId: self.model.id)
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .destructive,
                                         handler: nil)
        alertController.addAction(actionDelete)
        alertController.addAction(cancelAction)
        controller?.present(alertController, animated: true)
    }

    private func topController() -> UIViewController? {
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        return rootViewController
    }
}
