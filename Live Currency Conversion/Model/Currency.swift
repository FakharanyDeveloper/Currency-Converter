//
//  Currency.swift
//  Live Currency Conversion
//
//  Created by Khaled Fakharany on 10/10/19.
//  Copyright © 2019 Khaled Fakharany. All rights reserved.
//

import Foundation

class Currency {
    var code: String = ""
    var value: Double = 0.0
    
    init(code: String, value: Double) {
        self.code = code
        self.value = value
    }
    
}
