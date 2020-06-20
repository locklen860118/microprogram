//
//  CalculaterViewController.swift
//  microprogram
//
//  Created by Chris on 2020/6/18.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

//MARK: 加減乘除方法
enum OperationType{
    case add
    case subtract
    case multiply
    case divide
    case none
}

class CalculaterViewController: UIViewController {
    var numberOnScreen: Double = 0
    var previousNumber: Double = 0
    var performingMath = false
    var operation: OperationType = .none
    var newStart = true
    
    @IBOutlet weak var label: UILabel!
    
    //MARK: - 加
    @IBAction func add(_ sender: UIButton) {
        label.text = "+"
        operation = .add
        performingMath = true
        previousNumber = numberOnScreen
    }
    //MARK: - 減
    @IBAction func subtract(_ sender: UIButton) {
        label.text = "-"
        operation = .subtract
        performingMath = true
        previousNumber = numberOnScreen
    }
    //MARK: - 乘
    @IBAction func multiply(_ sender: UIButton) {
        label.text = "X"
        operation = .multiply
        performingMath = true
        previousNumber = numberOnScreen
    }
    //MARK: - 除
    @IBAction func divide(_ sender: UIButton) {
        label.text = "/"
        operation = .divide
        performingMath = true
        previousNumber = numberOnScreen
    }
    //MARK: - 運算
    @IBAction func answer(_ sender: UIButton) {
        if performingMath == true{
            switch operation{
            case .add:
                numberOnScreen = (previousNumber + numberOnScreen)
                correctAnswer(from: numberOnScreen)
            case .subtract:
                numberOnScreen = (previousNumber - numberOnScreen)
                correctAnswer(from: numberOnScreen)
            case .multiply:
                numberOnScreen = (previousNumber * numberOnScreen)
                correctAnswer(from: numberOnScreen)
            case .divide:
                numberOnScreen = (previousNumber / numberOnScreen)
                correctAnswer(from: numberOnScreen)
            case .none:
                label.text = "0"
            }
            performingMath = false
            newStart = true
        }
    }
    //MARK: - 數字按鈕
    @IBAction func numbers(_ sender: Any) {
        let inputNum = (sender as AnyObject).tag - 1
        if label.text != nil{
            if newStart == true{
                label.text = "\(inputNum)"
                newStart = false
            }else{
                if label.text == "0" || label.text == "+" || label.text == "-" || label.text == "X" || label.text == "/"{
                    label.text = "\(inputNum)"
                }else{
                    label.text = label.text! + "\(inputNum)"
                }
            }
            
        }
        numberOnScreen = Double(label.text!) ?? 0
    }
    //MARK: - 清除
    @IBAction func clear(_ sender: Any) {
        label.text = "0"
        numberOnScreen = 0
        previousNumber = 0
        performingMath = false
        operation = .none
        newStart = true
    }
    
    //MARK: - Label數字調整
    func correctAnswer(from number:Double){
        var correctText: String
        
        if floor(number) == number{
            correctText = "\(Int(number))"
        }else{
            correctText = "\(number)"
        }
        if correctText.count >= 10{
            correctText = String(correctText.prefix(6))
        }
        label.text = correctText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
