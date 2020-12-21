//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit


protocol BillInformationDelegate{
    func didCalculateBill(tip: String, totalPerPerson: Double, split: Int)
}

class CalculatorViewController: UIViewController {
    
    var delegate: BillInformationDelegate!
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet var pctButtons: [UIButton]!
    @IBOutlet weak var splitNumbreStepper: UIStepper!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var selectedTipButton = UIButton()
    var selectedTip = 1.1
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        selectedTipButton = tenPctButton
        splitNumbreStepper.addTarget(self, action: #selector(changeNumberLabel), for: .valueChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        
        view.endEditing(true)
    }
    
    // MARK: - Utils
   
    func selectButtons(){
        
        for button in pctButtons{
            
            if (selectedTipButton.tag == button.tag){
                
                selectedTipButton.isSelected = true
            }else{
                button.isSelected = false
            }
        }
    }
    
    
    @objc func changeNumberLabel(_ sender: UIStepper){
        dismissKeyboard()
        
        splitNumberLabel.text = Int(sender.value).description
    }
    
    // MARK: - IBActions
    
    @IBAction func pctButtonsPressed(_ sender: UIButton) {
        dismissKeyboard()
        switch sender.tag {
        case 0:
            selectedTip = 1.0
            selectedTipButton = sender
            selectButtons()
        case 10:
            selectedTip = 1.1
            selectedTipButton = sender
            selectButtons()
        case 20:
            selectedTip = 1.2
            selectedTipButton = sender
            selectButtons()
            
        default:
            selectedTip = 0
        }
    }
    
    
    @IBAction func calculateButtonPressed(_ sender: Any) {
        
        let bill = billTextField.text?.doubleValue
        let billWithTip = bill! * selectedTip
        let splitNumber = Double(splitNumberLabel.text!)
        let billSplitted = billWithTip/splitNumber!
        
        let resultVC = storyboard?.instantiateViewController(identifier: "ResultsViewController") as! ResultsViewController
        present(resultVC, animated: true, completion: nil)
        self.delegate = resultVC
        delegate.didCalculateBill(tip: "\(selectedTipButton.tag)%", totalPerPerson: billSplitted, split: Int(splitNumber!))
        
    }
    
}
