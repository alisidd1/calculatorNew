//
//  CalcCollectionViewController.swift
//  CalculatorNew
//
//  Created by Ali Siddiqui on 1/28/24.
//
// opeation cell, number cell, other cell

import UIKit

class CalcCollectionViewController: UIViewController {
    
    private let _view = CalcCollectionView()
    
    override func loadView() {
        super.loadView()
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
}
