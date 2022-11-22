//
//  ViewController.swift
//  ModifiedContractorCalculator
//
//  Created by shubham patel on 11/22/22.
//

import UIKit
var subTotal = Double()
var tax = Double()
var total = Double()
let laborCost = Double()
let materialCost = Double()
let defaults = UserDefaults.standard

class ViewController: UIViewController {

    @IBOutlet weak var laborCostText: UITextField!
    @IBOutlet weak var materialsCostText: UITextField!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var currentTaxRateLabel: UILabel!
    
    @IBAction func calculate(_ sender: Any) {
        let laborCost = Double(laborCostText.text!)
        let materialCost = Double(materialsCostText.text!)
        let taxRate = defaults.object(forKey: "currentTaxRate") as? String
        let doubleTaxRate = Double(taxRate!)
        
        subTotal = laborCost! + materialCost!
        tax = subTotal * Double(doubleTaxRate!) / 100.0
        total = subTotal + tax
        
        subTotalLabel.text = "$" + String(format: "%.2f", arguments: [subTotal])
        
        taxLabel.text = "$" + String(format: "%.2f", arguments: [tax])
        
        totalLabel.text = "$" + String(format: "%.2f", arguments: [total])
    }
    
    @IBAction func changeTaxRate(_ sender: Any) {
        let popUpController = UIAlertController(title: "Change Tax Rate", message: nil, preferredStyle: .alert)
        
        popUpController.addTextField{
            (textField) in textField.placeholder = defaults.object(forKey: "currentTaxRate") as? String
        }

        let saveButton = UIAlertAction(title: "Save", style: .default, handler: { (action: UIAlertAction!) in
            let newTaxRate = Double(popUpController.textFields![0].text!)
            defaults.set(popUpController.textFields![0].text!, forKey: "currentTaxRate")
            self.currentTaxRateLabel.text = String(format: "%.1f", arguments: [newTaxRate!]) + "%"
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        popUpController.addAction(saveButton)
        popUpController.addAction(cancelButton)
                present(popUpController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.object(forKey: "currentTaxRate") == nil{
            defaults.set("5.0", forKey: "currentTaxRate")
            print("Default to 5")
        }
        currentTaxRateLabel.text = defaults.object(forKey: "currentTaxRate") as? String
        
        // Do any additional setup after loading the view.
    }


}

