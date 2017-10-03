//
//  PressureConvertible.swift
//  PressurePackageDescription
//
//  Created by Michael Housh on 10/2/17.
//

protocol PressureConvertible {
    var value: Double { get }
    var type: PressureType { get }
    
    func convert(to: PressureType) -> Self
}
