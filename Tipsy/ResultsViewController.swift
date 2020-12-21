//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Alejandro Vasquez on 21/12/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
// MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
// MARK: - IBActions
    
    @IBAction func recalculateButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - BillInformationDelegate

extension ResultsViewController: BillInformationDelegate{
    
    func didCalculateBill(tip: String, totalPerPerson: Double, split: Int) {
        totalLabel.text = String(format: "%.2f", totalPerPerson)
        settingsLabel.text = "Split between \(split) people, with \(tip) tip."
        
        
    }
}
