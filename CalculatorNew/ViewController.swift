//
//  ViewController.swift
//  CalculatorNew
//
//  Created by Ali Siddiqui on 1/28/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var number1 = 0, number2 = 0, operation = 0 // operartion 1=add, 2=sub, 3=div, 4=mul
    var calcIntermediateResult = 0
    var lastNumbertapped: Int = 0

    let resultViewLabel: UILabel = {
        let resultViewLabel = UILabel()
        resultViewLabel.text = "0"
        resultViewLabel.layer.borderColor = UIColor.red.cgColor
        resultViewLabel.layer.borderWidth = 2
        resultViewLabel.textColor = .black
        resultViewLabel.textAlignment = .right
        resultViewLabel.backgroundColor = .systemGray
        resultViewLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultViewLabel
    }()
    
    let calcView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 3
 //       layout.itemSize = CGSize(width: 90, height: 90)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        let calcView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        calcView.backgroundColor = .black
        calcView.showsHorizontalScrollIndicator = false
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
            calcView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            calcView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            calcView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant: 5)

        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 16 {  // bigger zero key
            return CGSizeMake(195, 90);
        }
        
        return CGSizeMake(90, 90);   // all keys except '0' are same size
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calcView.dequeueReusableCell(withReuseIdentifier: CalcCollectionViewCell.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\n%%%%% \( String(describing: resultViewLabel.text))")
        lastNumbertapped = Int(resultViewLabel.text!)!
        
        switch indexPath.row {
    //** frist top row of keys
        case 0:  // C
            clearTapped()
        case 1:  //  % - not done yet
            print("\n plus / minus - item \(indexPath.row) tapped")
        case 2:  // percentage - not done yet
            print("\n percentage item \(indexPath.row) tapped")
        case 3:  // divde
            divideTapped()
            
    //** second row of keys
        case 4:  // 7
            number7tapped()
        case 5:  // 8
            number8tapped()
        case 6:   // 9
            number9tapped()
        case 7:  // mul
            multiplyTapped()
            
    //** third row of keys
        case 8:
            number4tapped()
        case 9:
            number5tapped()
        case 10:
            number6tapped()
        case 11:
            minusTapped()
            
    //** fourth row of keys
        case 12:
            number1tapped()
        case 13:
            number2tapped()
        case 14:
            number3tapped()
        case 15:
            plusTapped()
            
    //** bottom row of keys
       case 16:
            number0tapped()
        case 17:  // not implemented yet
            print("\n DOT  item \(indexPath.row) tapped")
        case 18:
            equalTapped()

        default:
            return
        }
    }
    
   func number0tapped() {
        lastNumbertapped = 0
        if resultViewLabel.text! == "0" {
            resultViewLabel.text!  =  "0"
        } else {
            resultViewLabel.text!  +=  "0"
        }
    }
   func number1tapped() {
        lastNumbertapped = 1
        if resultViewLabel.text! == "0" {
            resultViewLabel.text!  =  "1"
        } else {
            resultViewLabel.text!  +=  "1"
        }
    }
   func number2tapped() {
        lastNumbertapped = 2
        if resultViewLabel.text! == "0" {
            resultViewLabel.text!  =  "2"
        } else {
            resultViewLabel.text!  +=  "2"
        }
    }
   func number3tapped() {
        lastNumbertapped = 3
        if resultViewLabel.text! == "0" {
            resultViewLabel.text!  =  "3"
        } else {
            resultViewLabel.text!  +=  "3"
        }
    }
   func number4tapped() {
        lastNumbertapped = 4
        if resultViewLabel.text! == "0" {
            resultViewLabel.text!  =  "4"
        } else {
            resultViewLabel.text!  +=  "4"
        }
    }
   func number5tapped() {
        lastNumbertapped = 5
        if resultViewLabel.text! == "0" {
            resultViewLabel.text!  =  "5"
        } else {
            resultViewLabel.text!  +=  "5"
        }
    }
   func number6tapped() {
        lastNumbertapped = 6
        if resultViewLabel.text! == "0" {
            resultViewLabel.text!  =  "6"
        } else {
            resultViewLabel.text!  +=  "6"
        }
    }
   func number7tapped() {
        lastNumbertapped = 7
        if resultViewLabel.text! == "0" {
            resultViewLabel.text!  =  "7"
        } else {
            resultViewLabel.text!  +=  "7"
        }
    }
   func number8tapped() {
        lastNumbertapped = 8
        if resultViewLabel.text! == "0" {
            resultViewLabel.text!  =  "8"
        } else {
            resultViewLabel.text!  +=  "8"
        }
    }
   func number9tapped() {
        lastNumbertapped = 9
        if resultViewLabel.text! == "0" {
            resultViewLabel.text!  =  "9"
        } else {
            resultViewLabel.text!  +=  "9"
        }
    }
    
    // operartion 1=add, 2=minus, 3=div, 4=mul
    
   func multiplyTapped() {
        operation = 4
        updateMathOperation(operation: operation)
    }
   func divideTapped() {
        operation = 3
        updateMathOperation(operation: operation)
    }
    
   func plusTapped() {
        operation = 1
        updateMathOperation(operation: operation)
    }
   func minusTapped() {
        operation = 2
        updateMathOperation(operation: operation)
    }
    
    func updateMathOperation(operation: Int) {
        number1 = lastNumbertapped
        if calcIntermediateResult == 0 {
            calcIntermediateResult = number1
            resultViewLabel.text!  =  "0"
        } else {
            switch operation {  // operartion 1=add, 2=sub, 3=div, 4=mul
            case 1:
                calcIntermediateResult += lastNumbertapped
            //    break
            case 2:
                calcIntermediateResult -= lastNumbertapped
                break
            case 3:
                calcIntermediateResult /= lastNumbertapped
                break
            case 4:
                calcIntermediateResult *= lastNumbertapped
                break
            default:
                return
            }
            
            resultViewLabel.text!  =  "\(calcIntermediateResult)"
        }
    }
    
   func equalTapped() {
        guard let num = resultViewLabel.text else { return }
        let number = Int(num)!

        switch operation {
        case 1:
            let result = number1 + number
            resultViewLabel.text!  =  "\(result)"
            
        case 2: let result = number1 - number
            resultViewLabel.text!  =  "\(result)"
            
        case 3: let result = number1 / number
            resultViewLabel.text!  =  "\(result)"
            
        case 4: let result = number1 * number
            resultViewLabel.text!  =  "\(result)"
            
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
        lastNumbertapped = 0
    }

}

