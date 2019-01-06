//
//  SocketTableViewModel.swift
//  SenecCheck
//
//  Created by André Rohrbeck on 01.01.19.
//  Copyright © 2019 André Rohrbeck. All rights reserved.
//

import UIKit


internal class SocketTableViewModel: NSObject, UITableViewDataSource {

    public var viewModel: [SocketTableCellViewModel]?

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "socketCell")
        if cell == nil {
            cell = SocketTableCellView(reuseIdentifier: "socketCell")
            cell?.accessoryType = .disclosureIndicator
        }
        guard let mycell = cell as? SocketTableCellView else {
            return cell!
        }
        mycell.viewModel = viewModel?[indexPath.row]
        return cell!
    }


}
