//
//  FirstViewController.swift
//  Lab6_4
//
//  Created by Admin on 11.04.17.
//  Copyright (c) 2017 Yury Struchkou. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    @IBOutlet weak var trainingsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func calculateTapped(sender: AnyObject) {
        var bmr: Double = 0
        var bmi: Double = 0
        
        if let age: Int = ageTextField.text.toInt()
        {
            if let height: Int = heightTextField.text.toInt()
            {
                if let weight : Int = weightTextField.text.toInt()
                {
                    switch sexSegmentedControl.selectedSegmentIndex
                    {
                    case 0:
                        bmr = 88.362 + 13.397 * Double(weight) + 4.799 *
                            Double(height) - 5.677 * Double(age)
                    case 1:
                        bmr = 88.362 + 13.397 * Double(weight) + 4.799 *
                            Double(height) - 5.677 * Double(age)
                    default:
                        bmr = 0
                    }
                    
                    bmi = Double(weight) / pow(Double(height) / 100, 2)
                }
            }
        }
        
        let factor = [1.375, 1.55, 1.725, 1.9]
        bmr *= factor[trainingsSegmentedControl.selectedSegmentIndex]
        
        resultLabel.text = "You need to consume \(Int(bmr)) kilocalories in order to maintain your weight\nBody mass index = \(Int(bmi))"
        UIApplication.sharedApplication().keyWindow!.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

