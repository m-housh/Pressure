//
//  PressureType.swift
//  PressurePackageDescription
//
//  Created by Michael Housh on 10/2/17.
//

enum PressureType {
    case psi, atmosphere, pascals, inchesWaterColumn, bar, torr
    
    var symbol: String {
        switch self {
        case .psi:
            return "psi"
        case .atmosphere:
            return "atm"
        case .pascals:
            return "Pa"
        case .inchesWaterColumn:
            return "inH2O"
        case .bar:
            return "bar"
        case .torr:
            return "Torr"
        }
    }
}


