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
                cell.background.backgroundColor = .black
                cell.codeLbl.textColor = .white
                cell.nameLbl.textColor = .white
                cell.valueTxtField.textColor = .white
                cell.valueTxtField.isUserInteractionEnabled = true
                cell.exchangeRate.isHidden = true
            }else {
                cell.background.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.05)
                cell.codeLbl.textColor = .black
                cell.nameLbl.textColor = .black
                cell.valueTxtField.textColor = .black
                cell.valueTxtField.isUserInteractionEnabled = false
                cell.exchangeRate.isHidden = false
            }
            cell.background.layer.cornerRadius = cell.layer.frame.height/8
            cell.codeLbl.text = currancies[indexPath.row].code
            cell.valueTxtField.text = "\(Double(round(1000*(currancies[indexPath.row].value*currentMultiplier))/1000))"
            cell.nameLbl.text = currancies[indexPath.row].name
            cell.exchangeRate.text = "1 \(baseCur) = \(Double(round(10000*(currancies[indexPath.row].value))/10000))"
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ind = IndexPath(row: 0, section: 0)
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
        currentMultiplier = 1.0
        self.currancies = self.currancies.sorted(by: { $0.code < $1.code })
        if choosenCurrency.code == "EUR" {
            choosenCurrency.value = 1.0
        }
        self.currancies.insert(choosenCurrency, at: 0)
        changedBaseCur = true
        getData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

extension MainVC: CurrencyTableViewCellDelegate {
    func textFieldEdited(multiplier: Double) {
        self.currentMultiplier = multiplier
        updateCellValue()
    }
    
    func updateCellValue() {
        for cell in currencyTable.visibleCells {
            if let row = cell as? CurrencyTableViewCell {
                if !(row.codeLbl.text == baseCur) {
                    if let index = self.currencyTable.indexPath(for: row) {
                        let value = currancies[index.row].value
                        row.valueTxtField.text = "\(Double(round(1000*(value*currentMultiplier))/1000))"
                        row.exchangeRate.text = "1 \(baseCur) = \(Double(round(10000*(value))/10000))"
                    }
                }
            }
        }
    }
}
