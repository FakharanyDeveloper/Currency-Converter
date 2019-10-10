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
    
    var currancies = [Currency]()
    var baseCur = "EUR"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData(){
        currancies.removeAll()
        AF.request("https://api.exchangeratesapi.io/latest?base=\(baseCur)").responseJSON { response in
            if let result = response.value as? Dictionary<String,Any> {
                if let rates = result["rates"] as? Dictionary<String,Double> {
                    for key in rates.keys {
                        print("\(key): \(String(describing: rates[key]!))")
                        self.currancies.append(Currency(code: key, value: rates[key]!))
                    }
                }
            }
            self.currancies = self.currancies.sorted(by: { $0.code < $1.code })
            self.currancies.insert(Currency(code: self.baseCur, value: 1), at: 0)
            self.currencyTable.reloadData()
        }
    }
}
