//
//  CurrencyTableViewCellDelegate.swift
//  Live Currency Conversion
//
//  Created by Khaled Fakharany on 10/11/19.
//  Copyright © 2019 Khaled Fakharany. All rights reserved.
//

import Foundation

protocol CurrencyTableViewCellDelegate: AnyObject {
    func textFieldEdited(multiplier: Double)
}
