//
//  CalcCollectionViewViewModel.swift
//  CalculatorNew
//
//  Created by Ali Siddiqui on 2/21/24.
//

import UIKit


protocol UpdateResultDelegate {
    func getResultViewLabel() -> String
    func updateResultViewLabel(result: String)
}

class CalcCollectionViewViewModel  {
    
    var delegate: UpdateResultDelegate?
    var firstNumber = 0, secondNumber = 0, operation = 0
    var calcIntermediateResult = 0
    var lastNumberTapped = 0
    var nextNumberTapped = 0
    var operationToPerform = 0
    
    let cellViewModels = [
        CalcCollectionViewCellViewModel(title: "AC", btnBackgroundColor: .systemGray, type: 1),  // 0 = value key,   1= operfation key
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
    
    func setupViewModelFor(index: Int) {
        
        let viewModel = self.cellViewModels[index]
        
        let keyType = viewModel.type
        if keyType == 0 {  // number key
            if viewModel.title == "." { return }  // handle decimal point - its not an integer
            lastNumberTapped = Int(viewModel.title)!
            
            let resultLabel = delegate?.getResultViewLabel()
            
            if resultLabel == "0" {
                let text = delegate?.getResultViewLabel()
                if text == "0" {
                    delegate?.updateResultViewLabel(result: String(lastNumberTapped) )
                }
            } else {
                if operationToPerform == 0 {
                    let text = delegate?.getResultViewLabel()
                    let multiDigitNumber = text! + String(lastNumberTapped)
                    delegate?.updateResultViewLabel(result: multiDigitNumber)
                    lastNumberTapped = Int(multiDigitNumber)!
                }
                else {  // second number after selection math operation
                    if nextNumberTapped == 0 {
                        nextNumberTapped = Int(viewModel.title)!
                        delegate?.updateResultViewLabel(result: String(nextNumberTapped))
                    } else {
                        let text = delegate?.getResultViewLabel()
                        delegate?.updateResultViewLabel(result: text! + String(nextNumberTapped))
                        let multiDigitNumber = text! + String(nextNumberTapped)
                        nextNumberTapped = Int(multiDigitNumber)!
                    }
                    
                }
            }
            
        } else {   // operation key
            if nextNumberTapped == 0 && index == 18 { return } // ignore '=' if no second number
            
            switch index {
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
        
        firstNumber = lastNumberTapped
        print("firstNumber : \(firstNumber ) " )
        if calcIntermediateResult == 0 {
            calcIntermediateResult = firstNumber
            print("calcIntermediateResult:   \(calcIntermediateResult)")
        } else {
            switch operationToPerform {  // operartion 0, 1,2, top gray keys, 3=divide  7=mul, 11=minus, 15=add, 18=equal
            case 18:
                equalTapped()
                
            case 15:
                calcIntermediateResult +=  nextNumberTapped
                
            case 11:
                calcIntermediateResult -= nextNumberTapped
                
            case 7:
                calcIntermediateResult *= nextNumberTapped
                
            case 3:
                calcIntermediateResult /= nextNumberTapped
                
            case 2:
                calcIntermediateResult %= nextNumberTapped
                
            default:
                return
            }
            
            delegate?.updateResultViewLabel(result: String(calcIntermediateResult))
        }
    }
    
    func equalTapped() {
        guard let num = delegate?.getResultViewLabel() else { return }
        let number = Int(num)!
        print("number: \(number)")
        lastNumberTapped = 0
        switch operation {   // 2  3 7 11 15  18
        case 15:
            let result = firstNumber + number
            delegate?.updateResultViewLabel(result: String(result))
            resetInterimValues()
            
        case 11: let result = firstNumber - number
            delegate?.updateResultViewLabel(result: String(result))
            firstNumber = 0
            resetInterimValues()
            
        case 7: let result = firstNumber * number
            delegate?.updateResultViewLabel(result: String(result))
            firstNumber = 0
            resetInterimValues()
            
        case 3: let result = firstNumber / number
            delegate?.updateResultViewLabel(result: String(result))
            firstNumber = 0
            resetInterimValues()
            
        case 2: let result = firstNumber % number
            delegate?.updateResultViewLabel(result: String(result))
            firstNumber = 0
            resetInterimValues()
            
        default:
            return
        }
    }
    
    func clearTapped() {
        delegate?.updateResultViewLabel(result: "0")
        calcIntermediateResult = 0
        firstNumber = 0
        secondNumber = 0
        operation = 0
        calcIntermediateResult = 0
        lastNumberTapped = 0
        nextNumberTapped = 0
        operationToPerform = 0
    }
    
    func resetInterimValues() {
        calcIntermediateResult = 0
        lastNumberTapped = 0
        operationToPerform = 0
    }
    
}
