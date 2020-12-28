//
//  HistoryViewController.swift
//  Final Project
//
//  Created by Tan Jingsong on 7/28/20.
//  Copyright © 2020 Tan Jingsong. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    // List of history
    var conversionList = [Conversion]()
    
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Fetch data
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            do {
                try conversionList = context.fetch(Conversion.fetchAllDateDescend())
                print("All conversions fetched!")
            } catch {
                fatalError("Conversion list can not be fetched!")
            }
        }
    }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        let conversion = conversionList[indexPath.row]
        
        cell.textLabel?.text = "\(conversion.fromValue)\(conversion.fromUnit!) = \(conversion.toValue)\(conversion.toUnit!)"
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: conversion.createdOn!))"
        
        return cell
    }
    
    
}
