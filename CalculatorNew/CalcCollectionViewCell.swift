//
//  CalcCollectionViewCell.swift
//  CalculatorNew
//
//  Created by Ali Siddiqui on 1/28/24.
//

import UIKit

class CalcCollectionViewCell: UICollectionViewCell {
    static let identifier = "CalcCollectionViewCell"
            
    let calKeyLabel: UILabel = {
        let calKeyLabel = UILabel()
        calKeyLabel.translatesAutoresizingMaskIntoConstraints = false
        calKeyLabel.layer.masksToBounds = false
        calKeyLabel.layer.cornerRadius = 5.0
        calKeyLabel.textAlignment = .center
        calKeyLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        return calKeyLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(calKeyLabel)
        NSLayoutConstraint.activate([
            calKeyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            calKeyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            calKeyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            calKeyLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0)
        ])
        contentView.layer.masksToBounds = true
        
        let numCols: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width - 25
        let cellWidth: CGFloat = screenWidth / numCols
        
        contentView.layer.cornerRadius = cellWidth / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(viewModel: CalcCollectionViewCellViewModel) {
        calKeyLabel.text = viewModel.title
        contentView.backgroundColor = viewModel.btnBackgroundColor
    }
}
