//
//  CollectionView.swift
//  CalculatorNew
//
//  Created by Ali Siddiqui on 2/21/24.
//

import UIKit

class CollectionView: UIView {

    let resultViewLabel: UILabel = {
        let resultViewLabel = UILabel()
        resultViewLabel.text = "0"
        resultViewLabel.textColor = .white
        resultViewLabel.layer.borderWidth = 2
        resultViewLabel.textAlignment = .right
        resultViewLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        resultViewLabel.backgroundColor = .systemBackground
        resultViewLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultViewLabel
    }()

    let calcView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 3
        layout.itemSize = CGSize(width: 90, height: 90)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        let calcView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        calcView.backgroundColor = .black
        calcView.showsHorizontalScrollIndicator = false
        calcView.isScrollEnabled = false
        calcView.contentInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        calcView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CalcCollectionViewCell")
        calcView.translatesAutoresizingMaskIntoConstraints = false
        return calcView
    }()
    
//    func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        NSLayoutConstraint.activate([
//            resultViewLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
//            resultViewLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
//            resultViewLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
//            resultViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
//
//            calcView.topAnchor.constraint(equalTo: resultViewLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
//            calcView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
//            calcView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
//            calcView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor , constant: 5)
//        ])
//    }


}
