//
//  CalcCollectionViewCell.swift
//  CalculatorNew
//
//  Created by Ali Siddiqui on 1/28/24.
//

import UIKit

class CalcCollectionViewCell: UICollectionViewCell {
    static let identifier = "CalcCollectionViewCell"
    
    private let numberImageView: UIImageView = {
        let numberImageView = UIImageView()
        numberImageView.contentMode = .scaleAspectFill
        numberImageView.clipsToBounds = true
        return numberImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        numberImageView.frame = contentView.bounds
        struct S { static var index = 0 }

        var numberImages = [UIImage]()
        
        numberImages.append(UIImage(named: "Clear")!)
        numberImages.append(UIImage(named: "plusMinus")!)
        numberImages.append(UIImage(named: "percentage")!)
        numberImages.append(UIImage(named: "divide")!)
        
        numberImages.append(UIImage(named: "seven")!)
        numberImages.append(UIImage(named: "eight")!)
        numberImages.append(UIImage(named: "nine")!)
        numberImages.append(UIImage(named: "mult")!)

        numberImages.append(UIImage(named: "four")!)
        numberImages.append(UIImage(named: "five")!)
        numberImages.append(UIImage(named: "six")!)
        numberImages.append(UIImage(named: "minus")!)
        
        numberImages.append(UIImage(named: "one")!)
        numberImages.append(UIImage(named: "two")!)
        numberImages.append(UIImage(named: "three")!)
        numberImages.append(UIImage(named: "plus")!)
        
        numberImages.append(UIImage(named: "zero")!)
        numberImages.append(UIImage(named: "dot")!)
        numberImages.append(UIImage(named: "equal")!)
        numberImageView.image = numberImages[S.index]
        S.index = S.index + 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(numberImageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        numberImageView.image = nil
    }
}
