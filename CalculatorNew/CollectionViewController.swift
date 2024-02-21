//
//  CollectionViewController.swift
//  CalculatorNew
//
//  Created by Ali Siddiqui on 1/28/24.
//
// opeation cell, number cell, other cell

import UIKit

class CollectionViewController: UIViewController {
    
    private let _view = CollectionView()
    
    override func loadView() {
        super.loadView()
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
}
