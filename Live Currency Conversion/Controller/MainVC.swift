//
//  ViewController.swift
//  Live Currency Conversion
//
//  Created by Khaled Fakharany on 10/10/19.
//  Copyright © 2019 Khaled Fakharany. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController {

    @IBOutlet weak var currencyTable: UITableView!
    @IBOutlet weak var currancyTableConstraint: NSLayoutConstraint!
    
    var currancies = [Currency]()
    var baseCur = "EUR"
    var firstFitch = false
    var timer = Timer()
    var changedBaseCur = false
    var currentMultiplier = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduledTimerWithTimeInterval()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.currancyTableConstraint.constant = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.currancyTableConstraint.constant  = 0
    }
    
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getData), userInfo: nil, repeats: true)
    }
    
    @objc func getData(){
        print("GetData Refreshed")
        AF.request("https://api.exchangeratesapi.io/latest?base=\(baseCur)").responseJSON { response in
            if let result = response.value as? Dictionary<String,Any> {
                if let rates = result["rates"] as? Dictionary<String,Double> {
                    for key in rates.keys {
                        if self.firstFitch {
                            for item in self.currancies {
                                if item.code == key {
                                    item.value = rates[key]!
                                }
                            }
                        }else {
                            self.currancies.append(Currency(code: key, value: rates[key]!))
                        }
                    }
                }
            }
            if !self.firstFitch {
                self.currancies = self.currancies.sorted(by: { $0.code < $1.code })
                if self.baseCur == "EUR" {
                    self.currancies.insert(Currency(code: self.baseCur, value: 1), at: 0)
                }
                self.firstFitch = true
                self.currencyTable.reloadData()
            }
            
            if self.changedBaseCur {
                self.currencyTable.reloadData()
                self.changedBaseCur = false
            }
            
            self.updateCellValue()
        }
    }
}
