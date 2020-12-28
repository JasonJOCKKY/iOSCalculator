//
//  ViewController.swift
//  Final Project
//
//  Created by Tan Jingsong on 7/24/20.
//  Copyright © 2020 Tan Jingsong. All rights reserved.
//

import UIKit
import CoreData

class CalculatorViewController: UIViewController {
    @IBOutlet weak var outputTextField: UITextField!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var convertButton: UIButton!
    
    // List of converters supported by this app
    let converterList = [
        Converter(label: "fahrenheit to celcius", inputUnit: "°F", outputUnit: "°C") {
            inputValue in
            return (inputValue - 32) * 5/9
        },
        Converter(label: "celcius to fahrenheit", inputUnit: "°C", outputUnit: "°F") {
            inputValue in
            return inputValue * 9/5 + 32
        },
        Converter(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km") {
            inputValue in
            return inputValue * 1.60934
        },
        Converter(label: "kilometers to miles", inputUnit: "km", outputUnit: "mi") {
            inputValue in
            return inputValue / 1.60934
        },
    ]
    
    // Variable for text field states
    var inputIsDotted: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }
    
    // Bunton Actions
    @IBAction func convertClick(_ sender: UIButton) {
        // Present actionsheet when convert is clicked
        let actionSheet = UIAlertController(title: "Choose Converter", message: nil, preferredStyle: .actionSheet)
        for converter in converterList {
            actionSheet.addAction(UIAlertAction(title: converter.label, style: .default) {
                _ in
                // Convert and output values
                if let currentString = self.inputTextField.text,
                let currentValue = Double(currentString) {
                    // Convert and Present the data
                    let finalValue = converter.convert(currentValue)
                    self.outputTextField.text = String(finalValue) + " " + converter.outputUnit
                    self.inputTextField.text = currentString + " " + converter.inputUnit
                    
                    // Save the data to persistant storage
                    self.saveNewConversion(converter: converter, from: currentValue, to: finalValue)
               }
            })
        }
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel))
        
        // On iPad, actionsheet is presented as a popover
        actionSheet.popoverPresentationController?.sourceView = convertButton
        
        self.present(actionSheet, animated: true)
    }
    
    @IBAction func clearClick(_ sender: UIButton) {
        reset()
    }
    
    @IBAction func signChangeClick(_ sender: UIButton) {
        checkForReset()
        
        if var currentString = inputTextField.text {
            if !currentString.isEmpty && currentString[currentString.startIndex] == "-" {
                // If current String is Negative
                currentString.removeFirst()
                inputTextField.text = currentString
            } else {
                // If current string is positive
                inputTextField.text = "-" + currentString
            }
        }
    }
    
    @IBAction func numberClick(_ sender: UIButton) {
        checkForReset()
        
        if let currentString = inputTextField.text,
            let numberString = sender.currentTitle {
            inputTextField.text = currentString + numberString
        }
    }
    
    @IBAction func dotClick(_ sender: UIButton) {
        checkForReset()
        
        if !inputIsDotted {
            if let currentString = inputTextField.text {
                inputTextField.text = currentString + "."
                inputIsDotted = true
            }
        }
    }
    
    // Helper functions
    func reset() {
        // Clear all values
        inputTextField.text = ""
        outputTextField.text = ""
        inputIsDotted = false
    }
    
    func checkForReset() {
        // Clear the values after the last conversion
        if let currentOutputString = outputTextField.text {
            if !currentOutputString.isEmpty {
                reset()
            }
        }
    }
    
    func saveNewConversion(converter: Converter, from fromValue: Double, to toValue: Double) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            let newConversion = Conversion(context: context)
            newConversion.createdOn = Date()
            newConversion.fromUnit = converter.inputUnit
            newConversion.toUnit = converter.outputUnit
            newConversion.fromValue = fromValue
            newConversion.toValue = toValue
            
            do {
                // Delete the oldest conversion if exceeds  limit
                if try context.count(for: Conversion.fetchRequest()) > Conversion.MaxNmberOfConversion {
                    let oldestConversion = try context.fetch(Conversion.fetchOldest())
                    context.delete(oldestConversion[0])
                }
                
                // Save the new conversion
                try context.save()
                
                print("new conversion saved!")
            } catch {
                fatalError("Can not save new conversion!")
            }
        }
    }
    
}

