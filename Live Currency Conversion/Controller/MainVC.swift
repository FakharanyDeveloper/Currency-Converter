//
//  ViewController.swift
//  Live Currency Conversion
//
//  Created by Khaled Fakharany on 10/10/19.
//  Copyright © 2019 Khaled Fakharany. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var currencyTable: UITableView!
    
    var currancies: [Currency]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
