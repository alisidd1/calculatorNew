//
//  CollectionView.swift
//  CalculatorNew
//
//  Created by Ali Siddiqui on 2/21/24.
//
// UICollectionViewDelegate inheritance is not neeeded
// UICollectionViewDelegateFlowLayout inherits from UICollectionViewDelegate so just implement the UICollectionViewDelegateFlowLayout

import UIKit

class CalcCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UpdateResultDelegate  {
    
    var result: String?

    func getResultViewLabel() -> String {
        return resultViewLabel.text!
    }
    
    func updateResultViewLabel(result: String) {
        resultViewLabel.text = result
    }
    
    let calcCollectionViewViewModel = CalcCollectionViewViewModel()

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
    
    override init( frame: CGRect) {
        super.init(frame: frame)
        addSubview(calcView)
        addSubview(resultViewLabel)

        NSLayoutConstraint.activate([
            resultViewLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            resultViewLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 0),
            resultViewLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 0),
            resultViewLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),

            calcView.topAnchor.constraint(equalTo: resultViewLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            calcView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            calcView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            calcView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor , constant: 5)
            
        ])
        calcCollectionViewViewModel.delegate = self
        resultViewLabel.font = resultViewLabel.font.withSize(50)
        calcView.delegate = self
        calcView.dataSource = self
        calcView.register(CalcCollectionViewCell.self, forCellWithReuseIdentifier: CalcCollectionViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calcCollectionViewViewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 25
        if indexPath.item == 16 {
            return CGSize(width: (screenWidth + 22) / 2,
                          height: (screenWidth + 25) / 4)
        } else {
            return CGSize(width: screenWidth / 4,
                          height: screenWidth / 4)
        }
     }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = calcView.dequeueReusableCell(withReuseIdentifier: CalcCollectionViewCell.identifier, for: indexPath) as? CalcCollectionViewCell else{
            return UICollectionViewCell()
        }
        let viewModel = calcCollectionViewViewModel.cellViewModels[indexPath.row]
        cell.configure(viewModel: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        calcCollectionViewViewModel.setupViewModelFor(index: indexPath.row)
        
    }
}
