//
//  Converter.swift
//  Final Project
//
//  Created by Tan Jingsong on 7/28/20.
//  Copyright © 2020 Tan Jingsong. All rights reserved.
//

import Foundation

struct Converter {
    let label: String
    let inputUnit: String
    let outputUnit: String
    let convert: ((Double) -> Double)
}
