//
//  MainVC+Extensions.swift
//  Live Currency Conversion
//
//  Created by Khaled Fakharany on 10/10/19.
//  Copyright © 2019 Khaled Fakharany. All rights reserved.
//

import Foundation
import UIKit

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = currancies?.count ?? 0 > 0 ? currancies!.count : 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .red
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.layer.frame.width, height: cell.layer.frame.height))
        label.text = "\(indexPath.row)"
        cell.addSubview(label)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ind = IndexPath(row: 0, section: 0)
        currencyTable.moveRow(at: indexPath, to: ind)
    }
}
