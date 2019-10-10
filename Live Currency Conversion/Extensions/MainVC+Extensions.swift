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
        let count = currancies.count > 0 ? currancies.count : 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = currencyTable.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as? CurrencyTableViewCell {
            if indexPath.row == 0 {
                cell.backgroundColor = .black
                cell.codeLbl.textColor = .white
                cell.nameLbl.textColor = .white
                cell.valueTxtField.textColor = .white
            }else {
                cell.backgroundColor = .white
                cell.codeLbl.textColor = .black
                cell.nameLbl.textColor = .black
                cell.valueTxtField.textColor = .black
            }
            cell.codeLbl.text = currancies[indexPath.row].code
            cell.valueTxtField.text = "\(String(describing: currancies[indexPath.row].value))"
            cell.nameLbl.text = currancies[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ind = IndexPath(row: 0, section: 0)
        print(indexPath.row)
        let cell = currencyTable.cellForRow(at: indexPath) as! CurrencyTableViewCell
        currencyTable.moveRow(at: indexPath, to: ind)
        baseCur = cell.codeLbl.text!
        var choosenCurrency : Currency!
        for i in 0..<currancies.count-1 {
            if currancies[i].code == baseCur {
                choosenCurrency = currancies[i]
                currancies.remove(at: i)
                break
            }
        }
        self.currancies = self.currancies.sorted(by: { $0.code < $1.code })
        if choosenCurrency.code == "EUR" {
            choosenCurrency.value = 1.0
        }
        self.currancies.insert(choosenCurrency, at: 0)
        getData()
    }
}
