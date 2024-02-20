//
//  CollectionViewController.swift
//  CalculatorNew
//
//  Created by Ali Siddiqui on 1/28/24.
//
// opeation cell, number cell, other cell

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var number1 = 0, number2 = 0, operation = 0 // operartion 1=add, 2=sub, 3=div, 4=mul,  5=modulo
    var calcIntermediateResult = 0
    var lastNumberTapped = 0
    var operationToPerform = 0

    let viewModels = [
        CalcCollectionViewCellViewModel(title: "AC", btnBackgroundColor: .systemGray, type: 1),  // 0 = value,   1= operfation
        CalcCollectionViewCellViewModel(title: "+/-", btnBackgroundColor: .systemGray, type: 1),
        CalcCollectionViewCellViewModel(title: "%", btnBackgroundColor: .systemGray, type: 1),
        CalcCollectionViewCellViewModel(title: "/", btnBackgroundColor: .systemOrange, type: 1),
        CalcCollectionViewCellViewModel(title: "7", btnBackgroundColor: .systemGray4, type: 0),
        CalcCollectionViewCellViewModel(title: "8", btnBackgroundColor: .systemGray4, type: 0),
        CalcCollectionViewCellViewModel(title: "9", btnBackgroundColor: .systemGray4, type: 0),
        CalcCollectionViewCellViewModel(title: "X", btnBackgroundColor: .systemOrange, type: 1),
        CalcCollectionViewCellViewModel(title: "4", btnBackgroundColor: .systemGray4, type: 0),
        CalcCollectionViewCellViewModel(title: "5", btnBackgroundColor: .systemGray4, type: 0),
        CalcCollectionViewCellViewModel(title: "6", btnBackgroundColor: .systemGray4, type: 0),
        CalcCollectionViewCellViewModel(title: "-", btnBackgroundColor: .systemOrange, type: 1),
        CalcCollectionViewCellViewModel(title: "1", btnBackgroundColor: .systemGray4, type: 0),
        CalcCollectionViewCellViewModel(title: "2", btnBackgroundColor: .systemGray4, type: 0),
        CalcCollectionViewCellViewModel(title: "3", btnBackgroundColor: .systemGray4, type: 0),
        CalcCollectionViewCellViewModel(title: "+", btnBackgroundColor: .systemOrange, type: 1),
        CalcCollectionViewCellViewModel(title: "0", btnBackgroundColor: .systemGray4, type: 0),
        CalcCollectionViewCellViewModel(title: ".", btnBackgroundColor: .systemGray4, type: 0),
        CalcCollectionViewCellViewModel(title: "=", btnBackgroundColor: .systemOrange, type: 1),
    ]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        calcView.delegate = self
        calcView.dataSource = self
        calcView.register(CalcCollectionViewCell.self, forCellWithReuseIdentifier: CalcCollectionViewCell.identifier)
        view.addSubview(calcView)
        view.addSubview(resultViewLabel)
        resultViewLabel.font = resultViewLabel.font.withSize(50)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            resultViewLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            resultViewLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            resultViewLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            resultViewLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),

            calcView.topAnchor.constraint(equalTo: resultViewLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            calcView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            calcView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            calcView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant: 5)

        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 25
        if indexPath.item == 16 {
            return CGSize(width: screenWidth / 2,
                          height: screenWidth / 4)
        } else {
            return CGSize(width: screenWidth / 4,
                          height: screenWidth / 4)
        }
     }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = calcView.dequeueReusableCell(withReuseIdentifier: CalcCollectionViewCell.identifier, for: indexPath) as? CalcCollectionViewCell else{
            return UICollectionViewCell()
        }
        let viewModel = viewModels[indexPath.row]
        cell.configure(viewModel: viewModel)
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        let keyType = viewModel.type
        if keyType == 0 {  // number key
            if viewModel.title == "." { return }  // handle decimal point - its not an interger
            lastNumberTapped = Int(viewModel.title)!
            if resultViewLabel.text! == "0" {
                resultViewLabel.text!  =  String(lastNumberTapped)  // show first number
            } else {
                if operationToPerform == 0 {
                    resultViewLabel.text!  +=  String(lastNumberTapped)  // make next number entered
                    lastNumberTapped = Int(resultViewLabel.text!)!
                } else {
                    resultViewLabel.text!  =  String(lastNumberTapped)
                }
            }
            
        } else {   // operation key
            switch indexPath.row {
            case 0:  // AC
                operation = 0
            case 2:  // modulo
                operation = 2
                operationToPerform = 2
            case 3:  // divide
                operation = 3
                operationToPerform = 3
            case 7:    // multiply
                operation = 7
                operationToPerform = 7
            case 11:    // minus
                operation = 11
                operationToPerform = 11
            case 15:    // add
                operation = 15
                operationToPerform = 15
            case 18:    // equal
                operation = 18
            default:
                return
            }
            updateMathOperation(operation: operation)
        }
    }
                
    func updateMathOperation(operation: Int) {
        if operation == 0 {
            clearTapped()
            return
        }

        number1 = lastNumberTapped
        if calcIntermediateResult == 0 {
            calcIntermediateResult = number1
        } else {
            switch operationToPerform {  // operartion 0, 1,2, top gray keys, 3=divide  7=mul, 11=minus, 15=add, 18=equal
            case 18:
                equalTapped()
            
            case 15:
                calcIntermediateResult += lastNumberTapped
            
            case 11:
                calcIntermediateResult -= lastNumberTapped
                
            case 7:
                calcIntermediateResult *= lastNumberTapped
                
            case 3:
                calcIntermediateResult /= lastNumberTapped
                
            case 2:
                calcIntermediateResult %= lastNumberTapped

            default:
                return
            }
            
            resultViewLabel.text!  =  "\(calcIntermediateResult)"
        }
    }
    
   func equalTapped() {
        guard let num = resultViewLabel.text else { return }
        let number = Int(num)!
        lastNumberTapped = 0
        switch operation {   // 2  3 7 11 15  18
        case 15:
            let result = number1 + number
            resultViewLabel.text!  =  "\(result)"
            resetInterimValues()

        case 11: let result = number1 - number
            resultViewLabel.text!  =  "\(result)"
            number1 = 0
            resetInterimValues()
            
        case 7: let result = number1 * number
            resultViewLabel.text!  =  "\(result)"
            number1 = 0
            resetInterimValues()
            
        case 3: let result = number1 / number
            resultViewLabel.text!  =  "\(result)"
            number1 = 0
            resetInterimValues()
            
        case 2: let result = number1 % number
            resultViewLabel.text!  =  "\(result)"
            number1 = 0
            resetInterimValues()
            
        default:
            return
        }
    }
    
   func clearTapped() {
        resultViewLabel.text!  =  "0"
        calcIntermediateResult = 0
        number1 = 0
        number2 = 0
        operation = 0
        calcIntermediateResult = 0
        lastNumberTapped = 0
        operationToPerform = 0
    }
    
    func resetInterimValues() {
        calcIntermediateResult = 0
        lastNumberTapped = 0
        operationToPerform = 0
    }
}
