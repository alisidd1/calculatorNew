//
//  CalcCollectionViewCellViewModel.swift
//  Calculator-2
//
//  Created by Ali Siddiqui on 2/17/24.
//

import UIKit

enum CalcKeyPressed {
    case number(Int)
    case operation(Int)
}

class CalcCollectionViewCellViewModel {
    let title: String
    let btnBackgroundColor: UIColor
    let type: Int
    
    init(title: String, btnBackgroundColor: UIColor, type: Int) {
        self.title = title
        self.btnBackgroundColor = btnBackgroundColor
        self.type = type
    }
}
