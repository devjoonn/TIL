//
//  UITableViewController+SpinnerLast.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/18/23.
//

import UIKit

extension UITableViewController {
    func addSpinnerLastCell() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: .zero, y: .zero, width: tableView.bounds.width, height: 44)
        tableView.tableFooterView = spinner
    }
}
